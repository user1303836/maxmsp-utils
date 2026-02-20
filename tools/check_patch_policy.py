#!/usr/bin/env python3
"""CI checker for hard patch evolution policy."""

from __future__ import annotations

import ast
import hashlib
import re
import sys
from pathlib import Path

SCRIPT_PATTERNS = ("build_*.py", "fix_*.py", "migrate_*.py", "migration_*.py")
VALID_STATUSES = {"active", "archived"}
SHA256_RE = re.compile(r"^[0-9a-f]{64}$")


def _sha256_file(path: Path) -> str:
    hasher = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            hasher.update(chunk)
    return hasher.hexdigest()


def _collect_scripts(repo_root: Path) -> list[Path]:
    patches_dir = repo_root / "patches"
    found: set[Path] = set()
    for pattern in SCRIPT_PATTERNS:
        for script_path in patches_dir.rglob(pattern):
            if script_path.is_file():
                found.add(script_path.resolve())
    return sorted(found)


def _collect_constants(tree: ast.AST) -> dict[str, object]:
    constants: dict[str, object] = {}
    for node in getattr(tree, "body", []):
        target_name = None
        value_node = None
        if isinstance(node, ast.Assign) and len(node.targets) == 1 and isinstance(node.targets[0], ast.Name):
            target_name = node.targets[0].id
            value_node = node.value
        elif isinstance(node, ast.AnnAssign) and isinstance(node.target, ast.Name):
            target_name = node.target.id
            value_node = node.value

        if target_name and isinstance(value_node, ast.Constant):
            constants[target_name] = value_node.value
    return constants


def _has_call(tree: ast.AST, function_name: str) -> bool:
    for node in ast.walk(tree):
        if not isinstance(node, ast.Call):
            continue
        callee = node.func
        if isinstance(callee, ast.Name) and callee.id == function_name:
            return True
        if isinstance(callee, ast.Attribute) and callee.attr == function_name:
            return True
    return False


def _expect_string(constants: dict[str, object], key: str, errors: list[str], rel_path: str) -> str | None:
    value = constants.get(key)
    if not isinstance(value, str) or not value.strip():
        errors.append(f"{rel_path}: missing non-empty string constant {key}")
        return None
    return value


def _expect_sha(constants: dict[str, object], key: str, errors: list[str], rel_path: str) -> str | None:
    value = _expect_string(constants, key, errors, rel_path)
    if value is None:
        return None
    if SHA256_RE.fullmatch(value) is None:
        errors.append(f"{rel_path}: {key} must be lowercase 64-char sha256 hex")
        return None
    return value


def _check_fingerprint(
    *,
    script_path: Path,
    rel_path: str,
    file_key: str,
    sha_key: str,
    constants: dict[str, object],
    errors: list[str],
) -> None:
    patch_path_rel = _expect_string(constants, file_key, errors, rel_path)
    expected_sha = _expect_sha(constants, sha_key, errors, rel_path)
    if patch_path_rel is None or expected_sha is None:
        return

    resolved = (script_path.parent / patch_path_rel).resolve()
    if not resolved.exists():
        errors.append(f"{rel_path}: {file_key} points to missing file: {resolved}")
        return

    actual_sha = _sha256_file(resolved)
    if actual_sha != expected_sha:
        errors.append(
            f"{rel_path}: {sha_key} mismatch for {file_key} ({resolved}) "
            f"(expected {expected_sha}, actual {actual_sha})"
        )


def _check_script(script_path: Path, repo_root: Path, errors: list[str]) -> None:
    rel_path = script_path.relative_to(repo_root).as_posix()
    try:
        source = script_path.read_text(encoding="utf-8")
    except UnicodeDecodeError as exc:
        errors.append(f"{rel_path}: cannot read as utf-8: {exc}")
        return

    try:
        tree = ast.parse(source, filename=rel_path)
    except SyntaxError as exc:
        errors.append(f"{rel_path}: syntax error: {exc}")
        return

    constants = _collect_constants(tree)

    _expect_string(constants, "MIGRATION_ID", errors, rel_path)
    source_of_truth = _expect_string(constants, "SOURCE_OF_TRUTH", errors, rel_path)
    if source_of_truth is not None and source_of_truth != "maxpat":
        errors.append(f"{rel_path}: SOURCE_OF_TRUTH must be 'maxpat' (got {source_of_truth!r})")

    status = _expect_string(constants, "MIGRATION_STATUS", errors, rel_path)
    if status is None:
        return
    if status not in VALID_STATUSES:
        errors.append(f"{rel_path}: MIGRATION_STATUS must be one of {sorted(VALID_STATUSES)}")
        return

    if status == "archived":
        _expect_string(constants, "MIGRATION_ARCHIVED_REASON", errors, rel_path)
        if not _has_call(tree, "guard_archived_migration"):
            errors.append(f"{rel_path}: archived migration must call guard_archived_migration(...)")
        return

    # Active migration checks
    if script_path.name.startswith("build_"):
        errors.append(
            f"{rel_path}: active migrations must not use build_* naming "
            "(use migrate_* to emphasize codemod scope)"
        )

    if not _has_call(tree, "enforce_input_patch_fingerprint"):
        errors.append(f"{rel_path}: active migration must call enforce_input_patch_fingerprint(...)")

    _check_fingerprint(
        script_path=script_path,
        rel_path=rel_path,
        file_key="INPUT_PATCH_PATH",
        sha_key="INPUT_PATCH_SHA256",
        constants=constants,
        errors=errors,
    )
    _check_fingerprint(
        script_path=script_path,
        rel_path=rel_path,
        file_key="OUTPUT_PATCH_PATH",
        sha_key="OUTPUT_PATCH_SHA256",
        constants=constants,
        errors=errors,
    )


def main() -> int:
    repo_root = Path(__file__).resolve().parents[1]
    scripts = _collect_scripts(repo_root)

    errors: list[str] = []
    for script_path in scripts:
        _check_script(script_path, repo_root, errors)

    if errors:
        print("Patch policy violations detected:", file=sys.stderr)
        for error in errors:
            print(f"  - {error}", file=sys.stderr)
        return 1

    print(f"Patch policy check passed ({len(scripts)} migration script(s) checked).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())


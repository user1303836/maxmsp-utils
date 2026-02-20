#!/usr/bin/env python3
"""Helpers for enforcing migration-script policy at runtime."""

from __future__ import annotations

import hashlib
import sys
from pathlib import Path
from typing import Sequence

ALLOW_ARCHIVED_FLAG = "--allow-archived-migration"


def _sha256_file(path: Path) -> str:
    hasher = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            hasher.update(chunk)
    return hasher.hexdigest()


def _resolve_script_relative(script_file: str, relative_path: str) -> Path:
    return (Path(script_file).resolve().parent / relative_path).resolve()


def guard_archived_migration(
    *,
    script_file: str,
    migration_id: str,
    migration_status: str,
    archived_reason: str,
    argv: Sequence[str] | None = None,
) -> None:
    """
    Block archived migrations by default.

    Use --allow-archived-migration only for explicit historical reproduction.
    """
    if migration_status != "archived":
        return

    effective_argv = list(sys.argv if argv is None else argv)
    if ALLOW_ARCHIVED_FLAG in effective_argv:
        return

    script_name = Path(script_file).name
    print(f"ERROR: {script_name} is an archived migration ({migration_id}).", file=sys.stderr)
    print(f"Reason: {archived_reason}", file=sys.stderr)
    print(
        "This repository treats .maxpat/.amxd as source-of-truth. "
        "Use direct patch edits plus validation tooling.",
        file=sys.stderr,
    )
    print(
        f"To run this historical migration intentionally, pass {ALLOW_ARCHIVED_FLAG}.",
        file=sys.stderr,
    )
    raise SystemExit(2)


def enforce_input_patch_fingerprint(
    *,
    script_file: str,
    input_patch_path: str,
    expected_sha256: str,
) -> Path:
    """Ensure active migration runs only against its exact expected input patch."""
    resolved = _resolve_script_relative(script_file, input_patch_path)
    if not resolved.exists():
        print(f"ERROR: Input patch not found: {resolved}", file=sys.stderr)
        raise SystemExit(2)

    actual = _sha256_file(resolved)
    if actual != expected_sha256:
        print("ERROR: Input patch fingerprint mismatch.", file=sys.stderr)
        print(f"  path:     {resolved}", file=sys.stderr)
        print(f"  expected: {expected_sha256}", file=sys.stderr)
        print(f"  actual:   {actual}", file=sys.stderr)
        raise SystemExit(2)
    return resolved


def assert_output_patch_fingerprint(
    *,
    script_file: str,
    output_patch_path: str,
    expected_sha256: str,
) -> None:
    """Optional postcondition check for active migration output."""
    resolved = _resolve_script_relative(script_file, output_patch_path)
    if not resolved.exists():
        print(f"ERROR: Output patch not found: {resolved}", file=sys.stderr)
        raise SystemExit(2)

    actual = _sha256_file(resolved)
    if actual != expected_sha256:
        print("ERROR: Output patch fingerprint mismatch.", file=sys.stderr)
        print(f"  path:     {resolved}", file=sys.stderr)
        print(f"  expected: {expected_sha256}", file=sys.stderr)
        print(f"  actual:   {actual}", file=sys.stderr)
        raise SystemExit(2)


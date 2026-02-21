# Contributing to maxmsp-utils

Thanks for contributing.

## Prerequisites

- Python 3.12+
- Familiarity with Max patch JSON (`.maxpat`, `.amxd`)

## Workflow

1. Create a branch (or worktree + branch) for your change.
2. Make focused edits with clear commit messages.
3. Treat patch files as canonical outputs.
4. Treat patch-generation scripts as migrations, not source-of-truth builders.

## Validation

Run these checks before opening a PR:

```bash
python3 tools/check_patch_policy.py
python3 tools/validate_maxpat.py $(find . \( -name '*.maxpat' -o -name '*.amxd' \) | sort)
```

## Pull Request Guidelines

- Keep scope tight and describe the behavioral impact.
- Include validation results in the PR description.
- If patch topology/routing changed, call out key changed objects and paths.
- Prefer additive migrations over editing old archived migrations.

## Reference Docs

- `docs/PATCH_EVOLUTION_POLICY.md`
- `CLAUDE.md`

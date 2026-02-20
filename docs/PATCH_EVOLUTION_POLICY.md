# Patch Evolution Policy

This repository uses a strict patch evolution policy.

## Non-Negotiable Rules

1. `.maxpat` / `.amxd` files are the only source of truth.
2. Python patch scripts are migration utilities, not canonical builders.
3. Active migrations must be narrow codemods, not full-stage rebuild pipelines.
4. Active migrations must pin both input and output patch fingerprints.
5. Historical migrations must be explicitly archived and blocked by default.

## Migration Script Contract

Any script under `patches/**` matching `build_*.py`, `fix_*.py`, `migrate_*.py`, or `migration_*.py` must declare:

- `MIGRATION_ID`
- `MIGRATION_STATUS` (`"active"` or `"archived"`)
- `SOURCE_OF_TRUTH = "maxpat"`

If `MIGRATION_STATUS == "active"`, it must also declare:

- `INPUT_PATCH_PATH`
- `INPUT_PATCH_SHA256`
- `OUTPUT_PATCH_PATH`
- `OUTPUT_PATCH_SHA256`

And it must call runtime precondition guards from `tools/migration_policy.py`:

- `enforce_input_patch_fingerprint(...)` before writing changes

If `MIGRATION_STATUS == "archived"`, it must:

- declare `MIGRATION_ARCHIVED_REASON`
- call `guard_archived_migration(...)` so the script exits unless explicitly run with `--allow-archived-migration`

## CI Enforcement

CI runs `python3 tools/check_patch_policy.py` on every push/PR.  
Policy violations fail CI.

CI also runs `tools/validate_maxpat.py` to prevent structural regressions.

## Recommended Workflow

1. Edit `.maxpat` directly (or through Max UI / targeted codemods).
2. Validate with:
   - `python3 tools/check_patch_policy.py`
   - `python3 tools/validate_maxpat.py <patch.maxpat>`
3. Use `tools/maxpat_query.py semantic-diff` for review clarity.


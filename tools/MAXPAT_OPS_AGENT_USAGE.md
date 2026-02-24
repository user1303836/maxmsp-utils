# maxpat_ops.py (Agent Usage)

`tools/maxpat_ops.py` is the deterministic write/edit companion to `tools/maxpat_query.py`.

Use it for common `.maxpat` JSON edits instead of ad hoc patch-surgery scripts when possible.

## Scope

- Writes `.maxpat` files (currently no `.amxd` write support)
- JSON-only input/output
- Deterministic operations with explicit selectors
- Built-in `validate_maxpat` + `semantic-diff` post-checks (optional)

## Output Contract

- `ok: true/false` always present
- `results[]` includes one record per applied op
- `validation` payload contains full diagnostics when validation is enabled
- `semantic_diff` payload contains semantic graph diff summary/details unless skipped

## Command

Describe the tool contract (machine-readable JSON, useful for agents):

```bash
python3 tools/maxpat_ops.py --pretty describe
```

Apply ops:

```bash
python3 tools/maxpat_ops.py apply path/to/patch.maxpat --ops ops.json
```

Read ops from stdin:

```bash
python3 tools/maxpat_ops.py apply path/to/patch.maxpat --ops - < ops.json
```

Dry-run first (recommended):

```bash
python3 tools/maxpat_ops.py apply path/to/patch.maxpat --ops ops.json --dry-run
```

## Supported Ops

- `set-box-fields`
- `move-box`
- `add-box`
- `remove-box`
- `connect`
- `disconnect`
- `insert-between`
- `place-relative`

## Selectors

Prefer stable selectors:

- `uid` (best)
- `id` + `patcher_uid_path`
- `id` + `patcher_path` (human-readable, less stable)

Examples:

```json
{"uid":"root/obj-110"}
```

```json
{"patcher_uid_path":"root/obj-30","id":"obj-58"}
```

## Example Ops Specs

### 0) Add box with auto ID allocation

```json
{
  "ops": [
    {
      "op": "add-box",
      "patcher": { "patcher_path": "root" },
      "auto_id": true,
      "box": {
        "id": "@auto",
        "maxclass": "newobj",
        "text": "deferlow",
        "numinlets": 1,
        "numoutlets": 1,
        "outlettype": [""],
        "patching_rect": [0, 0, 55, 20]
      }
    }
  ]
}
```

### 1) Move an object (dry-run)

```json
{
  "ops": [
    {
      "op": "move-box",
      "target": { "uid": "root/obj-110" },
      "x": 320,
      "y": 80
    }
  ]
}
```

### 2) Add a box and place it relative to an anchor

```json
{
  "ops": [
    {
      "op": "add-box",
      "patcher": { "patcher_path": "root" },
      "box": {
        "id": "obj-999",
        "maxclass": "newobj",
        "text": "t b i",
        "numinlets": 1,
        "numoutlets": 2,
        "outlettype": ["bang", "int"],
        "patching_rect": [0, 0, 50, 20]
      }
    },
    {
      "op": "place-relative",
      "anchor": { "uid": "root/obj-110" },
      "target": { "uid": "root/obj-999" },
      "relation": "right",
      "gap": 24,
      "align": "center",
      "snap": 8,
      "avoid_overlap": true
    }
  ]
}
```

### 3) Connect two boxes

```json
{
  "ops": [
    {
      "op": "connect",
      "source": { "uid": "root/obj-110", "outlet": 0 },
      "destination": { "uid": "root/obj-999", "inlet": 0 },
      "ensure": true
    }
  ]
}
```

### 5) Insert a box between an existing connection

This removes a matching patchline and replaces it with:
`source -> inserted_box -> destination`

```json
{
  "ops": [
    {
      "op": "insert-between",
      "source": { "uid": "root/obj-110", "outlet": 0 },
      "destination": { "uid": "root/obj-999", "inlet": 0 },
      "target": { "uid": "root/obj-1000", "inlet": 0, "outlet": 0 }
    }
  ]
}
```

Notes:

- `order` can be supplied to disambiguate fanout lines
- by default only one matching line is rewired (`remove_all=false`)
- source-side `order` is preserved on the new `source -> inserted_box` edge

## Safety Defaults

- Port bounds are validated by default for `connect`, `disconnect`, and `insert-between`
  using the target boxes' `numinlets` / `numoutlets`.
- To bypass bounds checks for a specific endpoint (rare), set:
  `\"skip_port_bounds_check\": true` on that endpoint selector.

### 4) Disconnect one patchline

```json
{
  "ops": [
    {
      "op": "disconnect",
      "source": { "uid": "root/obj-110", "outlet": 0 },
      "destination": { "uid": "root/obj-999", "inlet": 0 }
    }
  ]
}
```

## Safe Workflow (Recommended)

1. Use `maxpat_query.py` to find anchors and local context.
2. Create a small `ops.json` with explicit selectors.
3. Run `maxpat_ops.py apply --dry-run`.
4. Inspect `validation` and `semantic_diff`.
5. Run without `--dry-run`.
6. Run `tools/maxpat_query.py semantic-diff` manually if you need separate review output.

## Important Notes

- Patch files remain canonical; this tool is just a deterministic editor.
- `semantic_diff` is semantic, not layout-sensitive. Pure `move-box` edits may still report semantic equality.
- Use `--allow-invalid` only when you intentionally need to stage an intermediate broken state.

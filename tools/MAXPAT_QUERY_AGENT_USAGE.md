# maxpat_query.py (Agent Usage)

`tools/maxpat_query.py` is the primary read/query interface for large `.maxpat` / `.amxd` files.
Use it before reading raw patch JSON.

## Output Contract

- JSON only
- `ok: true/false` always present
- stable `uid` per object node (`patcher_path/id`)
- stable `patcher_uid_path` for subpatch identity (preferred for tool-to-tool references)
- geometry fields on node payloads (`patching_rect`, `presentation_rect`) for spatial workflows

## Self-Describe (Agent Discovery)

If you are not sure which commands/fields/projection flags are available, query the tool contract first:

```bash
python3 tools/maxpat_query.py --pretty describe
```

## Core Commands (Use First)

### 1) Structural summary

```bash
python3 tools/maxpat_query.py summary patches/Metropolix/Metropolix.maxpat
```

### 2) Find anchors

```bash
python3 tools/maxpat_query.py find patches/Metropolix/Metropolix.maxpat 'Track Select'
python3 tools/maxpat_query.py find patches/Metropolix/Metropolix.maxpat 'update_playback_order'
python3 tools/maxpat_query.py find patches/Metropolix/Metropolix.maxpat 'obj-120' --fields id
```

### 3) Trace routing

```bash
python3 tools/maxpat_query.py trace patches/Metropolix/Metropolix.maxpat \
  --from 'Track Select' --to 'v8 config-manager.js'
```

### 4) Local graph context

```bash
python3 tools/maxpat_query.py neighborhood patches/Metropolix/Metropolix.maxpat \
  'update_playback_order' --hops 2
```

## Spatial Commands (Layout Reasoning Without Raw JSON)

### 5) Region query (canvas/presentation area)

```bash
python3 tools/maxpat_query.py region patches/Metropolix/Metropolix.maxpat 0 0 800 400 \
  --patcher-path root
```

```bash
# presentation layout region
python3 tools/maxpat_query.py region device.maxpat 0 0 700 200 \
  --view-mode presentation --mode intersects
```

### 6) Nearest neighbors (layout locality)

```bash
python3 tools/maxpat_query.py nearest patches/Metropolix/Metropolix.maxpat 'Track Select' --k 5
python3 tools/maxpat_query.py nearest device.maxpat 'live.dial' --direction right --seed-limit 1
```

## Efficiency Features (Agent Context Reduction)

### 7) Output projection (`--node-select`, `--edge-select`)

Use projections to reduce token usage.

```bash
python3 tools/maxpat_query.py find patch.maxpat 'Track Select' \
  --node-select uid,patcher_uid_path,id,text,varname
```

```bash
python3 tools/maxpat_query.py trace patch.maxpat --from A --to B \
  --node-select uid,id,text --edge-select src,dst,kind,source_outlet,destination_inlet
```

### 8) Batch mode (one index build, many requests)

```bash
cat > /tmp/query-batch.json <<'JSON'
{
  "requests": [
    {"command": "summary"},
    {"command": "find", "query": "Track Select", "node_select": "uid,id,text"},
    {"command": "region", "x": 0, "y": 0, "w": 800, "h": 400, "patcher_path": "root"}
  ]
}
JSON

python3 tools/maxpat_query.py batch patches/Metropolix/Metropolix.maxpat --spec /tmp/query-batch.json
```

## Review / Validation Support

### 9) Semantic graph diff (before/after)

```bash
python3 tools/maxpat_query.py semantic-diff before.maxpat after.maxpat
```

Useful flags:

```bash
python3 tools/maxpat_query.py semantic-diff old.maxpat new.maxpat --ignore-whitespace
python3 tools/maxpat_query.py semantic-diff old.maxpat new.maxpat --ignore-order
python3 tools/maxpat_query.py semantic-diff old.maxpat new.maxpat --include-ports
```

`semantic-diff` output includes:

- `summary.is_semantically_equal`
- node deltas (`added|removed|modified`)
- edge deltas (`added|removed`)
- bounded detail lists with truncation flags

### 10) Visualizer export bundle

```bash
python3 tools/maxpat_query.py --pretty export-viz patch.maxpat > /tmp/patch.viz.json
```

Use this for the browser visualizer or any tool needing patch-local geometry/hierarchy.

## Agent Workflow (Recommended)

1. `summary`
2. `find`
3. `trace` and/or `neighborhood`
4. `region` / `nearest` for layout questions
5. edit with `tools/maxpat_ops.py` (prefer `--dry-run` first)
6. `semantic-diff` after edits
7. only then inspect raw `.maxpat` lines if still necessary

## Notes

- Tracing crosses subpatch boundaries via synthetic port nodes and boundary edges.
- Prefer `patcher_uid_path` for stable references across subpatch label renames.
- Default `find` fields: `text,varname,id,object_name,maxclass`
- `--fields all` broadens matching and can increase false positives.
- By default, `semantic-diff` compares `patchline`, `boundary_in`, and `boundary_out` edges.
  Use `--include-container-links` only when you explicitly need synthetic container edges.

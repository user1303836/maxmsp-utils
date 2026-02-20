# maxpat_query.py (Agent Usage)

`tools/maxpat_query.py` is built for LLM/agent workflows on large `.maxpat` / `.amxd` files.
It provides deterministic graph queries so agents do not need to parse whole patch JSON in context.

## Output Contract

- Output is JSON only.
- `ok: true/false` is always included.
- Node records include stable `uid`, `patcher_path`, object metadata, and subpatcher linkage.
- Edge records include `src`, `dst`, `kind`, outlet/inlet indices, and `order`.

## Commands

### 1) Structural summary

```bash
python3 tools/maxpat_query.py summary patches/Metropolix/Metropolix.maxpat
```

### 2) Find objects

```bash
python3 tools/maxpat_query.py find patches/Metropolix/Metropolix.maxpat 'Track Select'
python3 tools/maxpat_query.py find patches/Metropolix/Metropolix.maxpat 'update_playback_order'
python3 tools/maxpat_query.py find patches/Metropolix/Metropolix.maxpat 'obj-120' --fields id
python3 tools/maxpat_query.py find patches/Metropolix/Metropolix.maxpat 'root > p Track1Output' --fields patcher_path
```

### 3) Trace signal/message paths

```bash
python3 tools/maxpat_query.py trace patches/Metropolix/Metropolix.maxpat \
  --from 'Track Select' --to 'v8 config-manager.js'
```

### 4) Local context subgraph

```bash
python3 tools/maxpat_query.py neighborhood patches/Metropolix/Metropolix.maxpat \
  'update_playback_order' --hops 2
```

### 5) Full IR dump

```bash
python3 tools/maxpat_query.py dump-index patches/Metropolix/Metropolix.maxpat
```

### 6) Semantic graph diff (before/after)

```bash
python3 tools/maxpat_query.py semantic-diff \
  patches/Metropolix/Metropolix.before.maxpat \
  patches/Metropolix/Metropolix.maxpat
```

Useful flags:

```bash
# Ignore text formatting-only edits in object text/varname
python3 tools/maxpat_query.py semantic-diff old.maxpat new.maxpat --ignore-whitespace

# Ignore patchline order field differences
python3 tools/maxpat_query.py semantic-diff old.maxpat new.maxpat --ignore-order

# Include port-node adds/removes/changes in node-level diff output
python3 tools/maxpat_query.py semantic-diff old.maxpat new.maxpat --include-ports
```

`semantic-diff` output has:

- `summary.is_semantically_equal`
- node deltas: `nodes.added|removed|modified`
- edge deltas: `edges.added|removed`
- bounded detail lists with truncation flags

## Agent Workflow (Recommended)

1. Run `summary` to understand patch scale and subpatcher boundaries.
2. Run `find` for control/parameter/handler anchors.
3. Run `trace` for end-to-end routing questions.
4. Run `neighborhood` around changed objects before editing.
5. After edits, run `semantic-diff old new` to verify intended semantic changes only.
6. Only read raw `.maxpat` lines if query output is insufficient.

## Notes

- Tracing crosses subpatcher boundaries via synthetic port nodes and boundary edges.
- Default `find` fields prioritize precision:
  `text,varname,id,object_name,maxclass`
- Use `--fields all` only when broad semantic matching is desired.
- By default, `semantic-diff` edge comparison includes `patchline`, `boundary_in`, and `boundary_out`.
  Add `--include-container-links` only if you explicitly want synthetic container-link deltas.

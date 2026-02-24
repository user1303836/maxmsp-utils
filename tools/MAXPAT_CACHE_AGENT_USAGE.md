# maxpat_cache.py (Agent Usage, Optional)

`tools/maxpat_cache.py` builds an optional SQLite cache (derived from patch files) for repeated agent sessions.

Use it when you need:

- repeated text lookup across patches (`FTS5`)
- repeated spatial lookups (`RTree`)
- faster warm-start workflows across many queries

Do not treat the cache DB as canonical. `.maxpat` / `.amxd` files remain source of truth.

## Features

- `init` schema creation/update
- `index` patch files into cache
- `status` cache counts + recent files
- `query-text` full-text search over node metadata
- `query-region` spatial search over patching/presentation rects

## Quick Start

```bash
python3 tools/maxpat_cache.py init /tmp/maxpat-cache.sqlite
python3 tools/maxpat_cache.py index /tmp/maxpat-cache.sqlite patches/Metropolix/Metropolix.maxpat
python3 tools/maxpat_cache.py status /tmp/maxpat-cache.sqlite
```

Incremental indexing:

```bash
python3 tools/maxpat_cache.py index /tmp/maxpat-cache.sqlite \
  patches/Metropolix/Metropolix.maxpat \
  patches/LowestNote/LowestNote-codex/LowestNote.maxpat \
  --skip-unchanged
```

## Text Query (FTS5)

```bash
python3 tools/maxpat_cache.py query-text /tmp/maxpat-cache.sqlite 'Track'
python3 tools/maxpat_cache.py query-text /tmp/maxpat-cache.sqlite 'Track*' --limit 20
python3 tools/maxpat_cache.py query-text /tmp/maxpat-cache.sqlite '\"Track Select\"'
```

Optional file filter:

```bash
python3 tools/maxpat_cache.py query-text /tmp/maxpat-cache.sqlite 'ratchet*' \
  --file patches/Metropolix/Metropolix.maxpat
```

## Spatial Query (RTree)

Patching view region:

```bash
python3 tools/maxpat_cache.py query-region /tmp/maxpat-cache.sqlite \
  patches/Metropolix/Metropolix.maxpat 0 0 800 400 --patcher-path root
```

Presentation view region:

```bash
python3 tools/maxpat_cache.py query-region /tmp/maxpat-cache.sqlite \
  device.maxpat 0 0 700 200 --view-mode presentation
```

Prefer stable patcher scope when available:

```bash
python3 tools/maxpat_cache.py query-region /tmp/maxpat-cache.sqlite \
  patch.maxpat 0 0 500 300 --patcher-uid-path root/obj-30
```

## Recommended Agent Workflow

1. Use `maxpat_query.py` directly for one-off tasks.
2. Use `maxpat_cache.py` when doing repeated searches across the same files/session.
3. Re-index after patch edits (or use `--skip-unchanged` for a mixed batch).
4. Perform actual edits with `maxpat_ops.py` or Max itself.

## Notes

- Cache stores graph metadata and geometry derived from `maxpat_query` output/indexing.
- Cache schema can evolve; re-run `init` safely.
- If cache output looks stale, re-run `index` for the affected files.

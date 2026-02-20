# Max Patch Visualizer

`tools/maxpat_visualizer` is a lightweight, non-executing patch client for exploring Max patch topology and layout.

It is meant for inspection only (no patch execution), with:

- object placement rendered from `patching_rect`
- patchline rendering (including `midpoints` when present)
- subpatch navigation
- cross-patcher search
- object inspector

## Run

From repo root:

```bash
python3 -m http.server 8765
```

Open:

```text
http://localhost:8765/tools/maxpat_visualizer/index.html
```

## Data Sources

You can load either format from the UI:

1. Raw `.maxpat` JSON file
2. `export-viz` JSON from `tools/maxpat_query.py`

For `.amxd`, export first:

```bash
python3 tools/maxpat_query.py --pretty export-viz path/to/device.amxd > /tmp/device.viz.json
```

Then load `/tmp/device.viz.json` through the file picker or serve it over HTTP and use URL load.

## Optional URL Param

Preload data with query param:

```text
http://localhost:8765/tools/maxpat_visualizer/index.html?data=/path/to/served.viz.json
```

## Notes

- This is an inspection surface, not a runtime.
- It is intentionally modular so it can be split into a standalone repo later if needed.

# Max Patch Visualizer

`tools/maxpat_visualizer` is a lightweight, non-executing patch client for exploring Max patch topology and layout.

It is meant for inspection only (no patch execution), with:

- object placement rendered from `patching_rect`
- patchline rendering (including `midpoints` when present)
- subpatch navigation
- cross-patcher search
- object inspector
- hover highlighting for quick visual scanning
- interactive slider/dial widgets for UI-object inspection
- inlet/outlet glyphs with hover tooltips
- cable hover highlighting
- patching/presentation layout toggle
- route filtering (trace path or selection neighborhood)
- minimap overlay with current viewport
- optional semantic-diff overlay (base vs target)
- local directed route tracing (source -> target inside current patcher)

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

## Diff Overlay Workflow (Optional)

The overlay is intentionally opt-in for normal patch viewing.

1. Load target patch via `Open Target`
2. Load baseline patch via `Open Base (Diff)`
3. Enable `Show Semantic Diff Overlay`

Overlay semantics:

- green: added objects/lines
- amber: modified objects
- red: removed objects/lines (ghost overlays)

You can leave overlay off for plain patch inspection and toggle it on only when needed.

## Trace Workflow

1. Click an object and press `Set Source`
2. Click an object and press `Set Target`
3. Press `Run Trace`

The visualizer computes a directed shortest path inside the current patcher and highlights path nodes/edges.

## Interaction Notes

- double-click a subpatch object to enter it
- hover inlets/outlets to view quick port info
- hover cables to spotlight their route and endpoints
- hover objects to get a docs link (with reachability validation status when available)
- toggle `Presentation Layout` to inspect `presentation_rect` placement only
- use `Route Filter` to isolate trace-only or selection-neighborhood wiring
- use minimap (bottom-right) to orient quickly in large patchers

Keyboard shortcuts:

- `F`: fit current patcher in view
- `Enter`: enter selected subpatcher
- `Esc`: clear hover highlight

## Optional URL Param

Preload data with query param:

```text
http://localhost:8765/tools/maxpat_visualizer/index.html?data=/path/to/served.viz.json
```

You can also preload both:

```text
http://localhost:8765/tools/maxpat_visualizer/index.html?data=/path/to/target.viz.json&base=/path/to/base.viz.json
```

## Notes

- This is an inspection surface, not a runtime.
- It is intentionally modular so it can be split into a standalone repo later if needed.
- Three.js runtime files are vendored locally in `tools/maxpat_visualizer/vendor`, so opening the visualizer does not require CDN access.

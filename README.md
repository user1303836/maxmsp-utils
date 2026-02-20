# maxmsp-utils

This is a library of utility patches for max/msp and max4live. It is a work in progress and will be strictly comprised of ai agent created patches.

## Current Hurdles

There is no native equivalent to a test runner, and there's no native way to "run" "end to end" or "component" tests for max patches. Max requires an active license to run standalone, I can't just install and run it like I would with Node or Python in a CI environment.

I need a machine bound license accessible to a GHA runner to have real CI. Max also does not run on Linux, so I'd need a mac mini with a virtual or possibly real display. (Max has a "headless" mode but still wants a display server).

For now, static validation via a script is the best we can do.

## Visualizer

There is a lightweight patch visualizer at `tools/maxpat_visualizer/`.

Run:

```bash
python3 -m http.server 8765
```

Then open:

```text
http://localhost:8765/tools/maxpat_visualizer/index.html
```

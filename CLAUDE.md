# CLAUDE.md - MaxMSP & Max4Live Development Guide

## Project Overview

This repository contains MaxMSP and Max4Live utility patches. Patches are stored as `.maxpat` files (JSON format) and Max4Live devices as `.amxd` files (JSON with binary header/footer).

### Git Workflow

**Always create a worktree when starting work on any new feature or task.** This keeps the main directory clean on `main` branch and allows multiple agents to work simultaneously.

**All work occurs in the worktree directory.** Run commands, edit files and commit from within the worktree path.

**Pre-Push Verification (CRITICAL)**

This repo has git hooks that enforce CI checks locally. Always run the `tools/validate_maxpat.py` script before pushing. All tests must pass.

**Large patch analysis (agent-first)**

Before reading large `.maxpat` files directly, use `tools/maxpat_query.py`:

- `summary` for patch/subpatch scope
- `find` for object/parameter anchors
- `trace` for routing between controls and processors
- `neighborhood` for local edit context
- `semantic-diff <old> <new>` after edits to confirm actual semantic deltas
- `export-viz` to generate patch-local geometry/hierarchy JSON for visual inspection tools

This keeps context small and avoids full-file JSON parsing when a graph query is enough.

**Cleanup rules:**

- Only remove a worktree after its branch has been merged to main
- To check if merged: `git branch --merged main | grep <branch-name>`
- Or if explicitly told to clean up by the user

NEVER Add yourself (claude) as a co-committer.

### Version Targeting

Patches in this repo target **Max 9** unless otherwise noted. This means:

- Use `v8` over `js` for JavaScript in patches (ES6+, faster, native types)
- Use `array.*` objects over `zl` for array/list operations where the `array.*` equivalent is clearer or more capable
- Use top-level `gen.codebox~` / `v8.codebox` when inline code is appropriate
- Use `string.*` objects for text manipulation instead of symbol-based workarounds
- If a patch must maintain **Max 8 compatibility**, note this explicitly in a comment at the top of the patch and avoid Max 9 features (v8, `array.*`, `string.*`, codeboxes outside gen~, ABL objects, schedule, Parameter Connect)
- **Max4Live devices require Live 12** when authored in Max 9. Devices targeting Live 11 must be authored in Max 8.

## .maxpat File Format Reference

There is no official schema from Cycling '74. The format is JSON, reverse-engineered by the community.

### Top-Level Structure

Every `.maxpat` is a JSON object with a single root key `"patcher"`:

```json
{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 8, "minor": 5, "revision": 5, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [85.0, 104.0, 640.0, 480.0],
    "openinpresentation": 0,
    "default_fontsize": 12.0,
    "default_fontname": "Arial",
    "gridsize": [15.0, 15.0],
    "devicewidth": 0.0,
    "description": "",
    "boxes": [],
    "lines": [],
    "dependency_cache": [],
    "autosave": 0
  }
}
```

Many additional fields (toolbar pins, scroll settings, grid snap, etc.) are included by Max but have standard defaults.

Key fields:

- `fileversion`: Always `1`
- `classnamespace`: `"box"` for normal patches, `"dsp.gen"` for gen~ subpatchers, `"rnbo"` for RNBO
- `rect`: `[x, y, width, height]` of patcher window
- `boxes`: Array of all objects in the patch
- `lines`: Array of all patch cords (connections)
- `parameters`: Parameter registry for automatable params (Max4Live)
- `dependency_cache`: External file dependencies
- `gridsize`: Use `[8.0, 8.0]` for root patches, `[15.0, 15.0]` for subpatchers (per Ableton standards)

### Box Types

Every element in the `boxes` array is wrapped: `{ "box": { ... } }`.

#### Standard object (`newobj`) and message box

```json
{ "box": { "id": "obj-1", "maxclass": "newobj", "text": "cycle~ 440",
    "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"],
    "patching_rect": [100.0, 100.0, 72.0, 22.0] } }
```

Message boxes use `"maxclass": "message"` with the same structure. The `text` field contains the message content.

#### Inlet / Outlet (inside subpatchers)

```json
{ "box": { "id": "obj-5", "maxclass": "inlet", "index": 1,
    "numinlets": 0, "numoutlets": 1, "outlettype": [""],
    "patching_rect": [50.0, 40.0, 30.0, 30.0], "comment": "" } }
```

The `index` field determines inlet/outlet ordering on the parent box (1-based). All other maxclass types (`comment`, `flonum`, `toggle`, etc.) follow the same wrapper pattern. UI objects may add `parameter_enable`, `presentation`, and `presentation_rect`.

### Common Box Fields

- `id`: Unique string identifier (`"obj-N"`)
- `maxclass`: UI class name (see reference table below)
- `numinlets` / `numoutlets`: Connection port counts
- `outlettype`: Array describing each outlet's type (`""` = any, `"signal"` = audio, `"int"`, `"bang"`, `"float"`, `"dictionary"`)
- `patching_rect`: `[x, y, width, height]` position on canvas
- `text`: Object text as typed in Max (for `newobj` and `message`)
- `presentation`: `1` if visible in presentation mode
- `presentation_rect`: Position in presentation view
- `varname`: Scripting name for parameter access

### maxclass Reference Table

| maxclass   | Purpose          | in | out | Notes                                         |
| ---------- | ---------------- | -- | --- | --------------------------------------------- |
| `newobj`   | Text objects     | varies | varies | Most MSP/Max/Jitter objects              |
| `message`  | Message box      | 2  | 1   | Right inlet sets stored message               |
| `comment`  | Text comment     | 1  | 0   |                                               |
| `number`   | Integer box      | 1  | 2   | Out 2: bang on unchanged value                |
| `flonum`   | Float box        | 1  | 2   | Out 2: bang on unchanged value                |
| `button`   | Bang button      | 1  | 1   |                                               |
| `toggle`   | On/off toggle    | 1  | 1   |                                               |
| `slider`   | Slider           | 1  | 1   |                                               |
| `dial`     | Dial knob        | 1  | 1   |                                               |
| `inlet`    | Subpatcher inlet | 0  | 1   | Has `index` field (1-based)                   |
| `outlet`   | Subpatcher outlet| 1  | 0   | Has `index` field (1-based)                   |
| `ezdac~`   | Audio output     | 2  | 0   |                                               |
| `ezadc~`   | Audio input      | 0  | 2   |                                               |
| `bpatcher` | Embedded patch   | varies | varies | Has `name` field for .maxpat file        |

### Patch Cords / Connections (`lines`)

Every connection in `lines` is wrapped: `{ "patchline": { ... } }`.

```json
{
  "patchline": {
    "source": ["obj-1", 0],
    "destination": ["obj-2", 0]
  }
}
```

Format: `"source": ["object-id", outlet_index]`, `"destination": ["object-id", inlet_index]`

When one outlet fans out to multiple inlets, `"order"` determines execution order (Max evaluates right-to-left, `order: 0` executes last):

```json
{
  "patchline": {
    "source": ["obj-1", 0],
    "destination": ["obj-10", 0],
    "order": 0
  }
}
```

Optional `"midpoints"` array controls visual routing of patch cords.

### Message Ordering

Max evaluates **right-to-left, depth-first**. Never rely on implicit connection order — reconnecting cords or editing JSON can silently change it. Use `trigger` (or `t`) to enforce sequencing. It fires outlets right-to-left in a guaranteed order.

Most objects have one "hot" inlet (leftmost, inlet 0) that triggers output and "cold" inlets that store silently. Set cold inlets first, then trigger via hot inlet.

`pipe`, `delay`, and `deferlow` break synchronous flow — they schedule messages for later execution.

### Subpatchers

A `newobj` with text `"p subname"` contains a nested `"patcher"` key with the full patcher structure. Uses `inlet`/`outlet` objects with `index` fields inside.

```json
{
  "box": {
    "id": "obj-6", "maxclass": "newobj", "text": "p mysub",
    "numinlets": 1, "numoutlets": 1, "outlettype": [""],
    "patching_rect": [100.0, 200.0, 60.0, 22.0],
    "patcher": {
      "fileversion": 1, "classnamespace": "box",
      "rect": [348.0, 204.0, 640.0, 480.0],
      "boxes": [
        { "box": { "maxclass": "inlet", "id": "obj-1", "index": 1, ... } },
        { "box": { "maxclass": "outlet", "id": "obj-2", "index": 1, ... } }
      ],
      "lines": [ ... ]
    },
    "saved_object_attributes": { "globalpatchername": "" }
  }
}
```

### poly~ JSON

`poly~` references subpatchers by filename (not embedded inline like `p`):

```json
{
  "box": {
    "id": "obj-10",
    "maxclass": "newobj",
    "text": "poly~ voicepatch 8 @steal 1",
    "numinlets": 2,
    "numoutlets": 2,
    "outlettype": ["signal", ""]
  }
}
```

Key concepts: `thispoly~` inside subpatcher for mute/busy control (`mute 1` = zero CPU). `target N` outside to direct messages to specific voice (0 = all). See [Polyphony tutorials](https://docs.cycling74.com/userguide/polyphony/).

### gen~ Subpatchers

gen~ uses `"classnamespace": "dsp.gen"` and `in N`/`out N` instead of `inlet`/`outlet`:

```json
{
  "box": {
    "id": "obj-7", "maxclass": "newobj", "text": "gen~",
    "numinlets": 1, "numoutlets": 2, "outlettype": ["signal", "signal"],
    "patcher": {
      "fileversion": 1, "classnamespace": "dsp.gen",
      "boxes": [
        { "box": { "id": "obj-1", "maxclass": "newobj", "text": "in 1", ... } },
        { "box": { "id": "obj-2", "maxclass": "newobj", "text": "param cutoff 1000 @min 1 @max 20000", ... } },
        { "box": { "id": "obj-3", "maxclass": "newobj", "text": "history", ... } },
        { "box": { "id": "obj-4", "maxclass": "newobj", "text": "out 1", ... } }
      ],
      "lines": [ ... ]
    }
  }
}
```

gen~ operators: `*`, `+`, `-`, `history`, `param`, `expr`, `in`, `out`, `delay`, `phasor`, `cycle`, `noise`, `samplerate`, etc.

**When to use gen~** (not just optimization — often the correct architecture):

- Per-sample math, conditional logic, or bitwise operations on audio
- Feedback loops via `history` (single-sample delay impossible in MSP)
- Custom oscillators/waveshapers (phase accumulator + waveshaping)
- Stateful per-sample processing (envelope followers, slew limiters, S&H)

Stay in MSP for high-level objects (`biquad~`, `pfft~`, `groove~`, `poly~`) and straightforward processing. See [Gen Overview](https://docs.cycling74.com/userguide/gen/_gen_overview/).

## Signal Flow: Message Rate vs Signal Rate

Mixing these domains is a **correctness** issue, not just performance.

|                   | Message Rate (Max)                         | Signal Rate (MSP)                          |
| ----------------- | ------------------------------------------ | ------------------------------------------ |
| **Object suffix** | No tilde: `*`, `+`, `random`, `metro`      | Tilde: `*~`, `+~`, `noise~`, `cycle~`      |
| **Timing**        | Event-driven, scheduled, non-deterministic | Continuous, every sample, deterministic    |
| **Data**          | Ints, floats, symbols, lists, bangs        | Continuous audio signal (float per sample) |
| **When it runs**  | When a message arrives                     | Every sample, always (while DSP is on)     |

Never substitute `*` for `*~` — they are fundamentally different. Signal objects must be in a DSP chain connected to audio output. Once in the signal domain, stay there.

**Bridges**: Signal→Message: `snapshot~` (use 30ms+ interval), `peakamp~`. Message→Signal: `sig~` (constant), `line~` (ramp — primary smoothing tool), `slide~` (logarithmic). Always smooth message-rate values with `line~` before feeding signal-rate objects to prevent clicks.

## Delay Lines

Use `tapin~`/`tapout~` for echo/reverb (must be directly connected, max delay set at creation). Use `delay~` for short modulated delays (<100ms, in samples). Use gen~ `history` for single-sample feedback (IIR filters, comb filters, physical modeling — impossible in MSP). Always attenuate feedback paths.

## Buffer Management

Buffers are **shared by name** — any object referencing the same name accesses the same audio data. No connections needed. Core objects: `buffer~` (declare), `groove~` (playback with looping), `play~` (position-driven), `wave~` (wavetable lookup via 0-1 phase), `index~` (non-interpolated lookup), `record~`, `peek~` (message-rate read/write), `poke~` (signal-rate write), `info~` (properties). MC variants: `mc.groove~`, `mc.play~`, `mc.wave~`.

## MIDI in MaxMSP

Core objects: `notein` (3 outlets: pitch, vel, chan), `noteout` (3 inlets), `ctlin`/`ctlout` (CC), `bendin`/`bendout`, `midiin`/`midiout` (raw bytes), `midiparse` (raw → 7 components), `midiformat` (7 components → raw).

**Note-on vs note-off**: `notein` outputs both — check velocity (>0 = on, 0 = off). Use `[stripnote]` or `[sel 0]` on velocity.

**In Max4Live**: Always use `midiin`/`midiout` (not `notein`/`noteout`). Parse with `midiparse`, rebuild with `midiformat`. All MIDI must be forwarded via `midiout` unless intentionally filtered.

MIDI is serial — "simultaneous" notes arrive as rapid bursts. Use `thresh`, `borax`, or `delay` timing windows for chord detection.

## Control Flow

`sel N` = exact match → bang (pass-through for non-matches). `route sym` = match first element, **strips prefix**. `if $i1 > 64 then $i1` = C-like conditional. `gate N` = 1 input → N outlets. `switch N` = N inputs → 1 output. Signal-rate: `selector~` / `gate~`.

## List Manipulation (zl)

`zl` operates in modes set by its first argument. All have 2 inlets (`["",""]`) and 2 outlets (`["",""]`).

Common modes: `zl group N` (collect N items into list), `zl slice N` (split at index), `zl join` (concatenate), `zl len` (length), `zl nth N` (get Nth, 1-indexed), `zl reg` (store, output on bang), `zl rev` (reverse), `zl iter N` (output N at a time), `zl stream N` (sliding window), `zl sort`, `zl unique`, `zl filter`, `zl rot N`, `zl lookup`, `zl ecils N`, `zl sect` (intersection), `zl union`, `zl scramble`.

In Max 9, prefer `array.*` for complex operations (see Max 9 Features).

## MC (Multichannel) Objects

Almost any MSP object has an MC counterpart via the `mc.` prefix: `mc.cycle~`, `mc.*~`, `mc.biquad~`, `mc.gen~`, etc. Key utilities: `mc.pack~`/`mc.unpack~` (bundle/split), `mc.mix~` (stereo mixdown with pan), `mc.sig~` (per-channel signal from messages), `mc.target` (direct messages to specific channel), `mc.voiceallocator~` (MIDI voice allocation). Key attributes: `@chans N` sets channel count, `@automanage 0` disables auto propagation.

### When to Use MC vs poly~

| Use MC when...                                      | Use poly~ when...                                                |
| --------------------------------------------------- | ---------------------------------------------------------------- |
| All voices run the same fixed signal chain          | Voices need different internal patching or logic                 |
| Channel count is known and fixed                    | Dynamic voice count or voice stealing needed                     |
| Simple synthesis / effects (additive, unison, etc.) | Complex per-voice state (envelopes, note tracking via thispoly~) |
| Spatial audio / surround work                       | Subpatcher needs message-rate objects like `coll`, `counter`     |

See [MC documentation](https://docs.cycling74.com/userguide/mc/).

## Patching Style and Conventions

Follow the [Ableton Patch Code Standard](https://github.com/Ableton/maxdevtools/blob/main/patch-code-standard/patch-code-standard.md) for grid, fonts, and canvas conventions. Key points:

- Root patches: `[8.0, 8.0]` grid, Arial 10 Bold. Subpatchers: `[15.0, 15.0]` grid, Arial 12 Regular.
- Canvas under 1400 x 807 pixels. Signal flow top-to-bottom.
- Extract subpatchers for logic clusters >10-15 objects. Name descriptively: `[p MIDINoteFilter]` not `[p sub1]`.

### Naming

- **send/receive**: Descriptive names. `[s filterCutoff]` not `[s x]`. In M4L: `[s ---filterCutoff]`.
- **Scripting names (varname)**: CamelCase. `FilterCutoff`, `LFORate`.
- **Subpatcher/abstraction names**: CamelCase. `[p NoteTracker]`, `NoteFilter.maxpat`.

## Max4Live Specifics

### Device Types

| Type                 | Audio I/O              | MIDI I/O             | Required Objects                             |
| -------------------- | ---------------------- | -------------------- | -------------------------------------------- |
| Audio Effect         | `plugin~` / `plugout~` | N/A                  | `plugin~`, `plugout~`                        |
| MIDI Effect          | N/A                    | `midiin` / `midiout` | `midiin`, `midiout`                          |
| Instrument           | N/A / `plugout~`       | `midiin` / N/A       | `midiin`, `plugout~`                         |
| MIDI Tool (Live 12+) | N/A                    | Clip data            | Operates on clip data, not real-time streams |

### .amxd File Format

`.amxd` = 32-byte binary header + JSON body (same as .maxpat) + binary footer. The header's last 4 bytes are a little-endian uint32 of the JSON length. For version control, store unfrozen devices and never commit frozen `.amxd` files.

### live.\* UI Objects

All have `numinlets: 1`, `numoutlets: 2`, `outlettype: ["", "float"]` (or `["", ""]` for int-only types).

Objects: `live.dial` (knob), `live.slider`, `live.toggle` (0/1), `live.menu` (index), `live.numbox`, `live.tab` (index), `live.button` (bang), `live.text` (button/toggle with text).

### live.\* Object JSON Structure

All `live.*` UI objects require `parameter_enable: 1` and store parameter config under `saved_attribute_attributes.valueof`:

```json
{
  "box": {
    "id": "obj-8", "maxclass": "live.dial",
    "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"],
    "parameter_enable": 1,
    "patching_rect": [233.0, 103.0, 44.0, 48.0],
    "presentation": 1, "presentation_rect": [6.0, 69.0, 44.0, 48.0],
    "saved_attribute_attributes": {
      "valueof": {
        "parameter_longname": "Cutoff", "parameter_shortname": "Cut",
        "parameter_type": 0, "parameter_mmax": 20000.0, "parameter_mmin": 20.0,
        "parameter_initial_enable": 1, "parameter_initial": [1000.0],
        "parameter_unitstyle": 3, "parameter_exponent": 3.33, "parameter_linknames": 1
      }
    },
    "varname": "Cutoff"
  }
}
```

### Parameter Attributes (JSON field names in `valueof`)

| Attribute                           | Description                                                                    |
| ----------------------------------- | ------------------------------------------------------------------------------ |
| `parameter_longname`                | Unique ID for automation & MIDI mapping. **Must be unique within the device.** |
| `parameter_shortname`               | Display label on the UI object                                                 |
| `parameter_type`                    | `0` = Float, `1` = Int, `2` = Enum, `3` = Blob                                 |
| `parameter_mmax` / `parameter_mmin` | Max/min values                                                                 |
| `parameter_initial_enable`          | `1` to activate initial value recall on device load                            |
| `parameter_initial`                 | Default value (array, e.g. `[0.5]`)                                            |
| `parameter_unitstyle`               | `0`=Int, `1`=Float, `2`=Time, `3`=Hz, `4`=dB, `5`=%, `9`=MIDI                  |
| `parameter_exponent`                | Curve exponent for parameter scaling                                           |
| `parameter_enum`                    | Array of enum strings (type 2 only)                                            |
| `parameter_linknames`               | `1` = longname follows varname                                                 |
| `parameter_visibility`              | "Automated and Stored" (default), "Stored Only" (no automation), "Hidden" (transient) |
| `parameter_modmode`                 | Unipolar, Bipolar, Additive, or Absolute                                       |
| `parameter_annotation_name`         | Category label for Info View tooltip                                           |
| `parameter_annotation`              | Description text for Live's Info View                                          |

### Parameters Section (Device-Level Registry)

```json
{
  "parameters": {
    "obj-8": ["Cutoff", "Cut", 0],
    "obj-9": ["Resonance", "Res", 0],
    "parameterbanks": {}
  }
}
```

Format: `"object-id": ["longname", "shortname", order]`

### Live API (Live Object Model)

Root objects: `live_app`, `live_set`, `control_surfaces N`, `this_device`. Path syntax is space-separated, zero-indexed: `live_set tracks 2 clip_slots 0 clip`.

Four essential objects: `live.path` (navigate LOM, outputs `id N`), `live.object` (get/set properties), `live.observer` (monitor changes), `live.remote~` (signal-rate parameter control).

**Critical rule**: Always place `deferlow` between `live.observer` output and any `live.object` set/call operations.

### Initialization and Essentials

- `loadbang` for general init (NOT Live API). `live.thisdevice` for Live API init. Use ONE `loadbang` with `trigger` (multiple loadbang order is undefined).
- Send/receive: prefix with `---` for instance isolation: `[s ---Cutoff]`.
- Set `"openinpresentation": 1`. Use integer pixel coordinates. Use `live.banks` for Push (banks of 8, convention: `[p PushBanks]`).
- See [M4L Production Guidelines](https://github.com/Ableton/maxdevtools/blob/main/m4l-production-guidelines/m4l-production-guidelines.md).

## Patch Creation Rules

When generating or editing `.maxpat` files:

1. **Object IDs must be unique** within a patcher. Use format `"obj-N"` with incrementing integers.
2. **patching_rect coordinates** are `[x, y, width, height]`. Use integer values for clean grid alignment.
3. **Outlet/inlet indices are zero-based**. First outlet is `0`.
4. **numinlets/numoutlets must match** the actual object. Look up the correct counts for each object type.
5. **outlettype array length must equal numoutlets**. Common types: `""` (any), `"signal"` (audio), `"int"`, `"bang"`, `"float"`.
6. **Fan-out connections** from the same outlet should include `"order"` fields. Max evaluates right-to-left.
7. **Subpatcher inlet/outlet `index` fields** determine ordering on the parent box. They are 1-based.
8. **parameter_longname must be unique** within a Max4Live device.
9. **Grid alignment**: Use `[8.0, 8.0]` gridsize for root patches, `[15.0, 15.0]` for subpatchers.
10. **Canvas size**: Keep patcher windows under 1400 x 807 pixels.
11. **Validate before done**: After generating or editing a `.maxpat`, run `python3 tools/validate_maxpat.py <file.maxpat>` and fix all errors and warnings before considering the patch complete. Info-level findings are advisory. Exit code 0 = pass (no errors), exit code 1 = errors found.

### Common Object numinlets/numoutlets Reference

**Patterns**: Signal math (`*~`, `+~`, `-~`, `/~`, `cycle~`): 2 in, 1 out `["signal"]`. `noise~`: 1 in, 1 out. `send`/`s`: 1 in, 0 out. `receive`/`r`: 0 in, 1 out `[""]`. `send~`/`receive~`: same but `["signal"]`. All `zl` modes: 2 in, 2 out `["",""]` (except `zl len`: `["int",""]`).

| Object text            | in | out | outlettype                                                | Notes                                          |
| ---------------------- | -- | --- | --------------------------------------------------------- | ---------------------------------------------- |
| `line~`                | 2  | 2   | `["signal", "bang"]`                                      |                                                |
| `adsr~`                | 5  | 2   | `["signal", "signal"]`                                    |                                                |
| `biquad~`              | 6  | 1   | `["signal"]`                                              |                                                |
| `filtercoeff~`         | 5  | 6   | `["signal",..."signal"]` (6x)                             |                                                |
| `gain~`                | 2  | 2   | `["signal", ""]`                                          |                                                |
| `plugin~`              | 1  | 2   | `["signal", "signal"]`                                    |                                                |
| `plugout~`             | 2  | 0   |                                                           |                                                |
| `snapshot~`            | 2  | 1   | `["float"]`                                               |                                                |
| `sig~`                 | 1  | 1   | `["signal"]`                                              |                                                |
| `midiin`               | 1  | 1   | `["int"]`                                                 |                                                |
| `midiout`              | 1  | 0   |                                                           |                                                |
| `midiparse`            | 1  | 7   | `["","","","","","",""]`                                  |                                                |
| `midiformat`           | 7  | 1   | `["int"]`                                                 |                                                |
| `notein`               | 1  | 3   | `["int","int","int"]`                                     | pitch, vel, chan                                |
| `noteout`              | 3  | 0   |                                                           |                                                |
| `ctlin`                | 1  | 3   | `["int","int","int"]`                                     | val, CC#, chan                                  |
| `bendin`               | 1  | 2   | `["int","int"]`                                           |                                                |
| `borax`                | 3  | 7   | `["int"x7]`                                               | delta,voice,pitch,vel,notecount,voicecount,steal|
| `flush`                | 1  | 2   | `["int","int"]`                                           |                                                |
| `metro`                | 2  | 1   | `["bang"]`                                                |                                                |
| `counter 0 16`         | 5  | 4   | `["int","","","int"]`                                     |                                                |
| `trigger b i`          | 1  | 2   | `["bang", "int"]`                                         | Outlets match arg types                        |
| `route 0 1 2`          | 1  | 4   | `["","","",""]`                                           | N args + 1 pass-through                        |
| `sel 0 1 2`            | 1  | 4   | `["bang","bang","bang",""]`                               | N bangs + 1 pass-through                       |
| `gate 2`               | 2  | 2   | `["", ""]`                                                | In 0: control, In 1: input                     |
| `switch 2`             | 3  | 1   | `[""]`                                                    | In 0: control, In 1-N: sources                 |
| `selector~ 2`          | 3  | 1   | `["signal"]`                                              |                                                |
| `if $i1 > 0 then bang` | 1  | 2   | `["bang","bang"]`                                         | Left: true, Right: false                       |
| `pack 0 0`             | 2  | 1   | `[""]`                                                    |                                                |
| `unpack 0 0`           | 1  | 2   | `["int", "int"]`                                          |                                                |
| `scale`                | 6  | 1   | `[""]`                                                    |                                                |
| `loadbang`             | 0  | 1   | `["bang"]`                                                |                                                |
| `deferlow`             | 1  | 1   | `[""]`                                                    |                                                |
| `change`               | 1  | 2   | `["", "int"]`                                             |                                                |
| `speedlim`             | 2  | 1   | `[""]`                                                    |                                                |
| `coll`                 | 1  | 4   | `["","","",""]`                                           |                                                |
| `dict`                 | 2  | 2   | `["",""]`                                                 |                                                |
| `buffer~`              | 1  | 2   | `["float","bang"]`                                        | length, done-loading                           |
| `groove~`              | 4  | 3   | `["signal","signal","signal"]`                            | audio, sync, sync                              |
| `play~`                | 2  | 1   | `["signal"]`                                              |                                                |
| `wave~`                | 3  | 1   | `["signal"]`                                              |                                                |
| `record~`              | 3  | 1   | `["signal"]`                                              |                                                |
| `info~`                | 1  | 4   | `["float","int","int",""]`                                | ms, chans, sr, name                            |
| `tapin~`               | 1  | 1   | `["signal"]`                                              |                                                |
| `tapout~`              | 1  | 1   | `["signal"]`                                              |                                                |
| `poly~`                | varies | varies | varies                                               |                                                |

## Performance Best Practices

- **Signal vs control rate**: Once in signal domain, stay there. High data speed at control rate is much more CPU-expensive.
- **Scheduler in M4L**: Updates happen per audio buffer. `metro 1` or `snapshot~ 1` floods the scheduler. Use `[snapshot~ 30]` minimum.
- **gen~**: Combines multiple operations efficiently. Zero CPU when muted in poly~. More operators per gen~ is better than many small gen~ instances.
- **poly~**: Keep only per-voice calculations inside. Mute unused voices (zero CPU when muted).
- **Prevent clicks**: Use `[$1 5] → [line~]` to smooth parameter changes. Never set signal-rate values directly from messages.
- **MC vs parallel chains**: Prefer MC objects. Cleaner patches, often better CPU from internal SIMD.
- **Minimize live.observer instances**: Each adds overhead from Live integration.

## Max 9 Features

### V8 JavaScript Engine

| Object       | Purpose                                                                    |
| ------------ | -------------------------------------------------------------------------- |
| `v8`         | JavaScript processor (ES6+, async/await, typed arrays, classes)            |
| `v8ui`       | JavaScript with custom UI drawing (replaces `jsui`)                        |
| `v8.codebox` | Inline JavaScript editor in patcher (no external file needed)              |

V8 advantages over legacy `js`: full ES6+, V8 JIT speed, native Array/String/Dictionary I/O, XMLHttpRequest, SQLite, Buffer APIs. Use `js` only for Max 8 compatibility.

### Codeboxes (Top-Level in Max 9)

Max 9 adds top-level codeboxes: `v8.codebox` (JS), `node.codebox` (Node.js), `dict.codebox`, `coll.codebox`, `text.codebox`, `gen.codebox` (control-rate GenExpr), `gen.codebox~` (signal-rate GenExpr — DSP directly in the patcher without a gen~ subpatcher).

### array.\* Object Family

~42+ objects for a proper array data type. **Prefer over `zl` in Max 9.** Arrays are nested (can contain arrays and dicts).

**zl equivalents**: `array.sort`, `array.reverse`, `array.slice`, `array.concat`, `array.unique`, `array.iter`, `array.length`, `array.stream`, `array.sect`/`array.union` map to their `zl` counterparts.

**Unique to array.\*** (no zl equivalent): `array` (declare/store), `array.min`/`array.max`, `array.mean`/`array.median`/`array.stddev`, `array.filter` (by condition), `array.map`, `array.reduce`, `array.push`/`array.pop`, `array.indexof`, `array.every`/`array.some`, `array.group`, `array.expr` (expression per element), `array.frombuffer`/`array.tobuffer`.

### string.\* Object Family

~34 objects for native strings **independent of Max's Symbol Table** (avoids symbol memory bloat). Includes `string.concat`, `string.split`, `string.replace`, `string.regexp`, `string.sprintf`, `string.trim`, `string.indexOf`, etc. Convert to symbol (`string.tosymbol`) only when interfacing with symbol-based objects.

### Thread Scheduling

| Object                  | Direction                         | Use Case                                 |
| ----------------------- | --------------------------------- | ---------------------------------------- |
| `defer`                 | Any thread → main/low-priority    | UI updates from audio thread             |
| `deferlow`              | Any thread → low-priority queue   | After `live.observer`, non-urgent tasks  |
| `schedule`              | Any thread → scheduler thread     | Precise timing, sequenced MIDI events    |
| `schedule` (with delay) | Any thread → scheduler after N ms | Timed events with scheduler precision    |

### ABL Objects (Ableton DSP Library)

Two tiers: **high-level** (`abl.device.autofilter~`, `abl.device.compressor~`, `abl.device.echo~`, `abl.device.saturator~`, `abl.device.drift~`, etc.) and **low-level** (55+ building blocks: `abl.dsp.meldfilter~` with 14 filter modes, `abl.dsp.meldosc~` with 24 oscillator modes, `abl.dsp.compressor~`, etc.). **Do not build a compressor, saturator, or filter from scratch** if an ABL object does what you need. All support `@ins` for assigning float-type attributes to inlets.

### Parameter Connect

UI objects can connect to ABL, jit.fx, and Gen object attributes **without patch cords** via the inspector. Programmatically, these are stored as JSON attributes, not in `"lines"`.

### Other Max 9 Notes

- **`.maxpat` JSON change**: Attributes with default values are no longer saved. Patch generators should not assume all attributes are present when reading Max 9 patches. `patching_rect` is always saved.
- **Breaking changes**: `poly~ @local` removed. `regexp` output order corrected (use `@legacyoutputorder` for old behavior).
- **Notable objects**: `sfizz~` (SFZ loader), `stepfun~`/`stepdiv~`/`stepcounter~` (step sequencer phasor primitives), `live.modulate~` (M4L parameter modulation), `loudness~` (EBU R 128 LUFS metering).

## Common Pitfalls

- **loadbang vs live.thisdevice**: Using `loadbang` for Live API calls before API is initialized causes errors
- **Missing deferlow**: Connecting `live.observer` directly to `live.object` without `deferlow` causes crashes
- **Non-unique Long Names**: Duplicate parameter names break automation mapping
- **send~/receive~ between M4L devices**: Not supported, causes no output
- **Using noteout in M4L**: Must use `midiout` instead
- **Forgetting to freeze**: Distributing unfrozen devices means missing dependencies
- **Multiple loadbangs**: Execution order is undefined. Use one `loadbang` with `trigger` objects.

## Project Structure

```
DeviceName/
  DeviceName.amxd          # Main device file (or .maxpat for non-M4L)
  code/                    # JavaScript files
  data/                    # Data files (JSON, text)
  media/                   # Audio files, images
  patchers/                # Abstractions and subpatchers
  externals/               # Third-party external objects (.mxo/.mxe)
```

## Programmatic .maxpat Generation Tools

- **py2max** (Python): `pip install py2max` - Most comprehensive library for offline .maxpat generation
- **MaxPyLang** (Python): `pip install maxpylang` - Simpler API for patch generation
- **MaxMSP-MCP-Server**: MCP server enabling LLMs to create/modify patches via running Max instance

## Version Control

- `.maxpat` files are JSON and diff well in git
- `.amxd` files have binary headers and are treated as binary by git
- Use Ableton's **maxdiff** tool for readable `.amxd` diffs: `python3 maxdiff/amxd_textconv.py <path>`
- Store unfrozen devices in the repo; never commit frozen `.amxd` files
- Install maxdevtools: https://github.com/Ableton/maxdevtools

## Key Documentation Links

- Cycling '74 Max Documentation: https://docs.cycling74.com
- Live Object Model API Reference: https://docs.cycling74.com/apiref/lom/
- Max4Live Overview: https://docs.cycling74.com/userguide/m4l/_m4l_overview/
- Ableton M4L Production Guidelines: https://github.com/Ableton/maxdevtools/blob/main/m4l-production-guidelines/m4l-production-guidelines.md
- Ableton Patch Code Standard: https://github.com/Ableton/maxdevtools/blob/main/patch-code-standard/patch-code-standard.md
- Gen Overview: https://docs.cycling74.com/userguide/gen/_gen_overview/
- MC Documentation: https://docs.cycling74.com/userguide/mc/
- Polyphony Tutorials: https://docs.cycling74.com/userguide/polyphony/

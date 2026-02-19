# CLAUDE.md - MaxMSP & Max4Live Development Guide

## Project Overview

This repository contains MaxMSP and Max4Live utility patches. Patches are stored as `.maxpat` files (JSON format) and Max4Live devices as `.amxd` files (JSON with binary header/footer).

### Version Targeting

Patches in this repo target **Max 9** unless otherwise noted. This means:
- Use `v8` over `js` for JavaScript in patches (ES6+, faster, native types)
- Use `array.*` objects over `zl` for array/list operations where the `array.*` equivalent is clearer or more capable
- Use top-level `gen.codebox~` / `v8.codebox` when inline code is appropriate
- Use `string.*` objects for text manipulation instead of symbol-based workarounds
- If a patch must maintain **Max 8 compatibility**, note this explicitly in a comment at the top of the patch and avoid Max 9 features (v8, array.*, string.*, codeboxes outside gen~, ABL objects, schedule, Parameter Connect)
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
    "bglocked": 0,
    "openinpresentation": 0,
    "default_fontsize": 12.0,
    "default_fontface": 0,
    "default_fontname": "Arial",
    "gridonopen": 1,
    "gridsize": [15.0, 15.0],
    "gridsnaponopen": 1,
    "objectsnaponopen": 1,
    "statusbarvisible": 2,
    "toolbarvisible": 1,
    "lefttoolbarpinned": 0,
    "toptoolbarpinned": 0,
    "righttoolbarpinned": 0,
    "bottomtoolbarpinned": 0,
    "toolbars_unpinned_last_save": 0,
    "tallnewobj": 0,
    "boxanimatetime": 200,
    "enablehscroll": 1,
    "enablevscroll": 1,
    "devicewidth": 0.0,
    "description": "",
    "digest": "",
    "tags": "",
    "style": "",
    "subpatcher_template": "",
    "assistshowspatchername": 0,
    "boxes": [],
    "lines": [],
    "dependency_cache": [],
    "autosave": 0
  }
}
```

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

#### Standard object (`newobj`)
```json
{
  "box": {
    "id": "obj-1",
    "maxclass": "newobj",
    "text": "cycle~ 440",
    "numinlets": 2,
    "numoutlets": 1,
    "outlettype": ["signal"],
    "patching_rect": [100.0, 100.0, 72.0, 22.0]
  }
}
```

#### Message box
```json
{
  "box": {
    "id": "obj-2",
    "maxclass": "message",
    "text": "49",
    "numinlets": 2,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [166.0, 223.0, 32.5, 21.0]
  }
}
```

#### Comment
```json
{
  "box": {
    "id": "obj-3",
    "maxclass": "comment",
    "text": "This is a comment",
    "numinlets": 1,
    "numoutlets": 0,
    "patching_rect": [231.0, 219.0, 150.0, 20.0]
  }
}
```

#### UI objects
```json
{
  "box": {
    "id": "obj-4",
    "maxclass": "flonum",
    "numinlets": 1,
    "numoutlets": 2,
    "outlettype": ["", "bang"],
    "parameter_enable": 0,
    "patching_rect": [271.0, 118.0, 50.0, 22.0]
  }
}
```

#### Inlet / Outlet (inside subpatchers)
```json
{
  "box": {
    "id": "obj-5",
    "maxclass": "inlet",
    "index": 1,
    "numinlets": 0,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [50.0, 40.0, 30.0, 30.0],
    "comment": ""
  }
}
```

The `index` field determines inlet/outlet ordering on the parent box.

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

| maxclass | Purpose | numinlets | numoutlets | Notes |
|----------|---------|-----------|------------|-------|
| `newobj` | Text-based objects | varies | varies | Most MSP/Max/Jitter objects |
| `message` | Message box | 2 | 1 | Right inlet sets stored message |
| `comment` | Text comment | 1 | 0 | Not connected to signal flow |
| `number` | Integer box | 1 | 2 | Outlet 1: value. Outlet 2: bang when value is set to its current value (unchanged). |
| `flonum` | Float box | 1 | 2 | Outlet 1: value. Outlet 2: bang when value is set to its current value (unchanged). |
| `button` | Bang button | 1 | 1 | Outlet: [bang] |
| `toggle` | On/off toggle | 1 | 1 | Outlet: [int] |
| `slider` | Slider | 1 | 1 | |
| `dial` | Dial knob | 1 | 1 | |
| `inlet` | Subpatcher inlet | 0 | 1 | Has `index` field |
| `outlet` | Subpatcher outlet | 1 | 0 | Has `index` field |
| `ezdac~` | Audio output | 2 | 0 | |
| `ezadc~` | Audio input | 0 | 2 | |
| `gain~` | Gain slider | 2 | 2 | |
| `spectroscope~` | Spectrum display | 2 | 1 | |
| `scope~` | Waveform display | 2 | 1 | |
| `bpatcher` | Embedded patch | varies | varies | Has `name` field for .maxpat file |

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

### Message Ordering and Execution Model

Max is **not** a concurrent system. Messages flow one at a time through the patch graph. Understanding execution order is essential for correctness.

**Right-to-left, depth-first**: When an object has multiple outlets, or when one outlet connects to multiple destinations, Max evaluates **right-to-left**. The rightmost connection fires first, and each message propagates fully to its destination (depth-first) before the next connection fires. This means downstream processing from the rightmost cord completes entirely before the next cord to the left begins.

**Never rely on implicit connection order for correctness.** The visual order of patch cords in the `.maxpat` file does not guarantee execution order. Reconnecting cords, copy-pasting, or editing the JSON can silently change the order. The only safe way to enforce sequencing is with `trigger` (or `t`).

**`trigger` (t) is the primary tool for enforcing order.** It fires its outlets right-to-left in a guaranteed, deterministic sequence. Always use `trigger` to sequence operations that must happen in a specific order.

```
Example: Set a value THEN bang to use it
[trigger b i]  — sends int from right outlet first, then bang from left outlet
                 This guarantees the int arrives at its destination before the bang fires.

Common patterns:
  [t b b]     — two bangs in guaranteed order (right fires first)
  [t b i]     — store int, then trigger action
  [t b f s]   — three outputs in right-to-left order: symbol, float, bang
  [t l b]     — bang first (right), then forward the list (left)
```

**Hot and cold inlets**: Most Max objects have one "hot" inlet (leftmost, inlet 0) that triggers output, and one or more "cold" inlets that store values silently. To set up an operation, send values to cold inlets first, then trigger via the hot inlet. `trigger` makes this pattern explicit and safe.

**`pipe`, `delay`, `deferlow`**: These break the synchronous message flow. `pipe` and `delay` schedule messages for later (after the current message chain completes). `deferlow` defers execution to the low-priority queue (useful after `live.observer` output).

### Subpatchers

A `newobj` with text `"p subname"` contains a nested `"patcher"` key with the full patcher structure:

```json
{
  "box": {
    "id": "obj-6",
    "maxclass": "newobj",
    "text": "p mysub",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [100.0, 200.0, 60.0, 22.0],
    "patcher": {
      "fileversion": 1,
      "classnamespace": "box",
      "rect": [348.0, 204.0, 640.0, 480.0],
      "boxes": [
        { "box": { "maxclass": "inlet", "id": "obj-1", "index": 1, ... } },
        { "box": { "maxclass": "outlet", "id": "obj-2", "index": 1, ... } }
      ],
      "lines": [ ... ]
    },
    "saved_object_attributes": {
      "globalpatchername": ""
    }
  }
}
```

### poly~ (Polyphonic Voice Management)

`poly~` loads multiple instances of a subpatcher for polyphonic processing or parallel computation.

```
[poly~ voicepatch 8]  — loads 8 instances of voicepatch.maxpat
[poly~ voicepatch 8 @steal 1]  — with voice stealing
[poly~ voicepatch 8 @target 0]  — messages go to all voices
```

**Voice allocation**: When `poly~` receives a MIDI note (pitch + velocity pair in its first inlet), it automatically assigns the note to an available voice. Voice stealing (`@steal 1`) reassigns the oldest voice when all are busy.

**`thispoly~`** is used **inside** the poly~ subpatcher. It serves two purposes:
1. **Muting**: Send `mute 1` to `thispoly~` to silence an idle voice (zero CPU when muted). Send `mute 0` to reactivate. This is the primary mechanism for efficient polyphony — only active voices consume CPU.
2. **Voice index**: The right outlet of `thispoly~` reports the voice number (1-based). Use this when voices need to know their own identity.
3. **Busy state**: Send `bang` to `thispoly~` when the voice is active (e.g., note-on received) and the voice will be marked busy. The voice is marked available again when you send `mute 1`. This helps poly~'s voice allocator avoid assigning notes to busy voices.

**`target`** is used **outside** the poly~ subpatcher (in the parent patch) to direct messages to a specific voice instance:
```
[target 3]  — subsequent messages to poly~ go to voice 3 only
[target 0]  — subsequent messages to poly~ go to ALL voices (broadcast)
```

This is essential for per-voice parameter control, e.g., sending a filter cutoff value to a specific voice.

**JSON representation**: `poly~` uses `text` like any `newobj`, and the loaded subpatcher is referenced by filename (not embedded inline like `p`):
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

The voice subpatcher (`voicepatch.maxpat`) is a separate file containing `in 1`/`out 1` (for signal) or `inlet`/`outlet` (for messages), plus `thispoly~` for mute/busy control.

### gen~ Subpatchers

gen~ uses `"classnamespace": "dsp.gen"` and `in N`/`out N` instead of `inlet`/`outlet`:

```json
{
  "box": {
    "id": "obj-7",
    "maxclass": "newobj",
    "text": "gen~",
    "numinlets": 1,
    "numoutlets": 2,
    "outlettype": ["signal", "signal"],
    "patcher": {
      "fileversion": 1,
      "classnamespace": "dsp.gen",
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

### When to Use gen~ (Architecture, Not Just Optimization)

gen~ is not just a performance tool — it is often the **correct architectural choice** for audio work. Inside gen~, every operation runs at sample rate with single-sample access, which is impossible in regular MSP.

**Reach for gen~ when:**
- **Per-sample math**: Any DSP algorithm that needs to operate on individual samples (custom waveshaping, sample-by-sample logic, bitwise operations on audio)
- **Feedback loops**: gen~'s `history` operator provides single-sample delay, enabling feedback paths that are impossible in MSP (where feedback requires at least one signal vector of delay). This is essential for custom filters, physical modeling, and recursive algorithms.
- **Custom oscillators / waveshapers**: Building oscillators from scratch (phase accumulator + waveshaping) is natural in gen~ and awkward in MSP.
- **Stateful per-sample processing**: Anything that needs to remember and update state every sample (envelope followers, slew limiters, sample-and-hold, comparators with hysteresis).
- **Conditional per-sample logic**: gen~ supports `if`/`else`, `switch`, `?` (ternary) at sample rate. MSP has no equivalent — you cannot branch per-sample in regular Max.
- **Compact DSP algorithms**: A filter, oscillator, or effect that would be 15+ MSP objects often becomes 5-8 gen~ operators with clearer signal flow.

**Stay in MSP when:**
- Using well-supported high-level objects (`biquad~`, `pfft~`, `groove~`, `poly~`) that already do what you need
- The processing is straightforward (gain, mixing, simple routing) and doesn't benefit from sample-level access
- You need objects that don't exist in gen~ (buffer access patterns like `groove~`'s loop/scrub behavior, FFT via `pfft~`)

**gen~ key concepts:**
- `history` — single-sample delay with feedback. This is the building block for filters, integrators, and any recursive algorithm. `[history 0]` stores one sample, outputs the previous value, and accepts the new value.
- `param` — named parameters controllable from the parent MSP patch. `[param cutoff 1000 @min 20 @max 20000]` creates an inlet on the gen~ object.
- `codebox` — write gen~ DSP in text (GenExpr language) instead of visual patching. Useful for complex math or porting algorithms from code.
- `data` / `peek` / `poke` — internal sample buffers for delay lines, lookup tables, and wavetables within gen~.
- `delay` — multi-sample delay with interpolation (unlike `history` which is exactly 1 sample).

## Signal Flow: Message Rate vs Signal Rate

This is not just a performance distinction — it is a **correctness** issue. Mixing up the two domains produces patches that appear to work but behave incorrectly, glitch, or fail silently.

### The Two Worlds

| | Message Rate (Max) | Signal Rate (MSP) |
|-|-------------------|-------------------|
| **Object suffix** | No tilde: `*`, `+`, `random`, `metro` | Tilde: `*~`, `+~`, `noise~`, `cycle~` |
| **Timing** | Event-driven, scheduled, non-deterministic | Continuous, every sample, deterministic |
| **Data** | Ints, floats, symbols, lists, bangs | Continuous audio signal (float per sample) |
| **When it runs** | When a message arrives | Every sample, always (while DSP is on) |

### Critical Rules

1. **You cannot freely substitute `*` for `*~` or vice versa.** `[* 0.5]` multiplies a single number when it receives a message. `[*~ 0.5]` multiplies every audio sample continuously. They are fundamentally different operations. Connecting a signal outlet to a message inlet (or vice versa) either fails silently or produces garbage.

2. **Signal objects must be in a DSP chain.** MSP objects only process audio when they are connected (directly or indirectly) to an audio output (`dac~`, `ezdac~`, `plugout~`, or a `poly~` / `pfft~` host). An unconnected `cycle~` sitting in a patch does nothing — it is not "running in the background."

3. **Signal connections are type-checked.** In the `.maxpat` JSON, signal outlets have `"outlettype": ["signal"]`. You can connect a signal outlet to a message inlet (Max will just ignore it or sample the signal at control rate), but this is almost always a bug.

### Bridges Between the Two Worlds

| Direction | Object | What It Does |
|-----------|--------|-------------|
| Signal → Message | `snapshot~` | Samples the signal at a specified interval and outputs a float. Use `[snapshot~ 30]` (30ms) or slower. |
| Signal → Message | `number~` | Like `snapshot~` but with a built-in display. Useful for debugging. |
| Signal → Message | `peakamp~` | Reports the peak amplitude of a signal over an interval. |
| Signal → Message | `average~` | Reports the average value of a signal over an interval. |
| Message → Signal | `sig~` | Converts a number to a constant signal. `[sig~ 440]` outputs 440.0 every sample. |
| Message → Signal | `line~` | Ramps from current value to target over time. `[$1 20]` = ramp to $1 in 20ms. The primary tool for smoothing parameter changes into the signal domain. |
| Message → Signal | `slide~` | Logarithmic smoothing of a signal (can also smooth message-to-signal transitions). |

### Common Mistake Patterns

**Wrong**: Using `[metro 10] → [random 100] → [*~ ]` to "modulate" a signal parameter.
This sends a new random number every 10ms, which arrives at `*~` as a message. The signal jumps discontinuously between values, causing clicks and zipper noise.

**Right**: Use `[line~]` to smooth the transition: `[metro 10] → [random 100] → [scale 0 100 0. 1.] → [$1 10] → [line~] → [*~]`. Or better yet, use `[noise~]` for signal-rate randomness and `[lores~]` to shape its spectrum.

**Wrong**: `[cycle~ 2] → [> 0]` trying to use an oscillator as a message-rate gate.
`[> 0]` is a message object. It will not process every sample of the oscillator.

**Right**: `[cycle~ 2] → [>~ 0]` (signal-rate comparison), then use the resulting signal to control signal-rate gating.

**General principle**: Once you are in the signal domain, stay in the signal domain until you have a specific reason to leave. Every signal→message→signal conversion introduces timing imprecision, potential clicks, and unnecessary CPU overhead.

## Feedback and Delay Lines

Delay-based effects are central to audio utilities (reverb, echo, chorus, flanging, comb filtering, physical modeling). Max has distinct tools for different delay scenarios, each with important constraints.

### tapin~ / tapout~ (Long Delays, Effects)

The primary delay line for echo, reverb, and multi-tap delays.

```
[tapin~ 5000]        — creates a delay line buffer of 5000ms maximum
     |
[tapout~ 250 500]    — reads from the buffer at 250ms and 500ms (one outlet per tap)
```

**Rules:**
- `tapin~` and `tapout~` **must be directly connected** — no objects in between. The patch cord itself carries the buffer reference, not audio.
- `tapout~` can have multiple delay time arguments, creating multiple tap outlets.
- Delay times can be modulated by sending float messages to `tapout~` inlets. Modulating delay time produces pitch-shifting (chorus/flange).
- Maximum delay time is set by `tapin~`'s argument and **cannot be changed** at runtime. Allocate enough at creation time.
- Feedback: route `tapout~` output back through processing and into `tapin~`'s inlet. Always attenuate the feedback path (`[*~ 0.7]`) to prevent runaway gain.

```
Feedback delay pattern:
[input~] → [+~] → [tapin~ 2000]
              ↑          |
         [*~ 0.6] ← [tapout~ 500]
```

### delay~ (Short Delays, Signal-Rate Control)

For delays under ~100ms where you need precise signal-rate control of delay time.

```
[delay~ 100 4]  — up to 100 samples delay, 4-point interpolation
```

- Delay time is in **samples**, not milliseconds (convert: `samples = ms * samplerate / 1000`).
- The second argument sets interpolation quality (1 = none, 2 = linear, 4 = cubic). Use 4 for modulated delays, 1 for fixed.
- Delay time can be controlled by a signal inlet — useful for chorus/flange where an LFO modulates the delay.
- **Minimum delay**: 1 sample. Unlike gen~'s `history`, `delay~` cannot do zero-sample (single-sample feedback) loops in MSP.

### gen~'s history and delay Operators (Sample-Accurate)

For feedback loops and sample-accurate delay, gen~ is the right tool.

- **`history`**: Exactly 1 sample of delay with direct feedback. This is the fundamental building block for IIR filters, integrators, and any recursive per-sample algorithm.
```
  [in 1] → [+ ] → [out 1]
              ↑
         [* 0.995] ← [history 0]
                         ↑
                    (feedback from [+] output)
```
This creates a simple one-pole lowpass / leaky integrator.

- **`delay N`**: Multi-sample delay inside gen~, with interpolation. `[delay 4410]` provides up to 4410 samples of delay. Delay time can be signal-controlled for modulated effects.
- **`data` + `peek`/`poke`**: For custom delay line implementations (circular buffers, granular delays, etc.) inside gen~.

### When to Use Which

| Scenario | Tool |
|----------|------|
| Echo / reverb / multi-tap delay (>10ms) | `tapin~` / `tapout~` |
| Chorus / flange (modulated short delay) | `delay~` or `tapin~`/`tapout~` |
| Comb filter / Karplus-Strong / physical model | gen~ `history` and `delay` |
| Single-sample feedback (IIR filters, integrators) | gen~ `history` (MSP cannot do this) |
| Allpass / nested allpass networks | gen~ (for precision) or `biquad~` (for standard topologies) |

## Buffer Management (Sample Playback and Wavetables)

Any work with audio files, wavetables, or recorded audio in Max goes through the `buffer~` system. Multiple objects can share access to a single named buffer.

### Core Buffer Objects

| Object | Purpose |
|--------|---------|
| `buffer~ name` | **Declares** a named audio buffer in memory. This is the storage — it does not play or record by itself. |
| `groove~ name` | **Plays** from a named buffer with loop points, speed control, and scrubbing. The primary playback object. |
| `play~ name` | Simple playback from a buffer (position-driven, no built-in looping). |
| `wave~ name` | **Wavetable lookup** — reads from a buffer using a signal-rate index (0-1 phase). For wavetable synthesis. |
| `index~ name` | Like `wave~` but with **no interpolation** — reads the nearest sample. For lookup tables and quantized access. |
| `record~ name` | **Records** audio into a named buffer. |
| `peek~ name` | **Read/write** individual samples by index (message rate). For offline buffer manipulation. |
| `poke~ name` | **Write** individual samples at signal rate. For granular and real-time buffer writing. |
| `info~ name` | Reports buffer properties: length (ms), sample rate, channels. |

### The Named Buffer Reference System

Buffers are **shared by name**. Any object that references the same name accesses the same audio data:

```
[buffer~ myloop]             — declares the buffer
[groove~ myloop]             — plays from it
[record~ myloop]             — records into it
[wave~ myloop]               — uses it as a wavetable
[waveform~ myloop]           — displays it (UI object)
```

No explicit connections are needed between the `buffer~` and its readers/writers — the name string is the link. This means `buffer~` can be in a completely different part of the patch (or even a different subpatcher) from the objects that use it.

**Loading audio**: Send `read filename.wav` to `buffer~` to load a file. Send `read` (no argument) to open a file dialog. `buffer~ myloop file.wav` loads automatically on patch open.

**Buffer size**: `buffer~ myloop 2000` creates a 2-second buffer. For `record~`, pre-allocate enough space. `buffer~` with a file argument sizes automatically to fit the file.

### groove~ (Primary Playback)

```
[groove~ myloop]
  Inlets:  0 = signal: playback speed (1.0 = normal, 0.5 = half, -1.0 = reverse)
           1 = message: loop on/off (1/0)
           2 = message: loop start (ms)
           3 = message: loop end (ms)
  Outlets: 0 = signal: audio output
           1 = signal: sync output (0-1 ramp showing position within loop)
           2 = signal: sync output (0-1 ramp showing position within entire buffer)
```

The sync outlets are essential for syncing visuals, triggering events at loop points, or driving `wave~` for complex wavetable playback.

### wave~ (Wavetable Synthesis)

`wave~` treats the buffer as a lookup table indexed by a 0-1 phase signal:

```
[phasor~ 440] → [wave~ mytable] → [*~ 0.5] → [dac~]
```

This reads through the buffer 440 times per second, producing a wavetable oscillator. The buffer content defines the waveform shape. Multiple `wave~` objects can read the same buffer at different rates for additive/unison synthesis.

### MC and Buffers

MC buffer objects follow the `mc.` prefix pattern:
- `mc.groove~` — multichannel playback (one instance per MC channel, or multi-channel buffer access)
- `mc.play~` — multichannel position-driven playback
- `mc.wave~` — per-channel wavetable lookup (each MC channel can read at a different phase/rate)

This is particularly powerful for granular synthesis: `mc.groove~` with per-channel start positions creates a granular cloud from a single object.

## MIDI in MaxMSP

### Core MIDI Objects

| Object | Purpose | Outlets |
|--------|---------|---------|
| `notein` | Receive MIDI notes | 3: pitch, velocity, channel |
| `noteout` | Send MIDI notes | 0 (in standalone Max; use `midiout` in M4L) |
| `ctlin` | Receive MIDI CC | 3: value, controller#, channel |
| `ctlout` | Send MIDI CC | 0 |
| `bendin` | Receive pitch bend | 2: value, channel |
| `bendout` | Send pitch bend | 0 |
| `pgmin` | Receive program change | 2: value, channel |
| `pgmout` | Send program change | 0 |
| `midiin` | Receive raw MIDI bytes | 1: raw byte stream |
| `midiout` | Send raw MIDI bytes | 0 |
| `midiparse` | Split raw MIDI into components | 7: note, CC, program, bend, aftertouch, polyAT, other |
| `midiformat` | Reassemble parsed MIDI into raw bytes | 1: raw MIDI |
| `midiselect` | Filter specific MIDI message types | varies |

### Note-On vs Note-Off Disambiguation

In MIDI, a note-off can be represented two ways:
1. **Status byte 0x80** (explicit note-off): pitch + release velocity
2. **Status byte 0x90 with velocity 0** (note-on with velocity 0): This is treated as note-off by convention and is extremely common

`notein` outputs **both** note-on and note-off messages through the same outlets. You **must** check the velocity value to distinguish them:
- Velocity > 0 = note-on
- Velocity == 0 = note-off

**Standard disambiguation pattern:**
```
[notein]
|       |        |
pitch  velocity  channel
       |
    [sel 0]      — left outlet: bang on velocity 0 (note-off)
                 — right outlet: non-zero velocity (note-on)
```

Or equivalently:
```
[notein]
|       |
pitch  velocity
       |
    [> 0]       — 1 for note-on, 0 for note-off
       |
    [gate]      — pass pitch only on note-on
```

### The "Simultaneous" MIDI Problem

MIDI is a serial protocol. There is no true simultaneity. When a chord is played, notes arrive one at a time in rapid succession. Max processes each note-on as a separate message event. This has critical implications:

**Polyphonic input timing**: When building anything that responds to chords or multiple simultaneous notes (e.g., a chord detector, arpeggiator, or note distributor), you must account for the fact that "simultaneous" notes arrive as a rapid burst of sequential messages within a timing window of ~1-3ms.

**Common approaches for chord/group detection:**
- **`flush` + timing window**: Collect notes for a short `delay` (1-5ms) period, then process the collected group. If no new notes arrive within the window, treat the collection as complete.
- **`bag` or `coll` accumulation**: Store incoming notes, use a `delay` to trigger processing after the burst settles.
- **`zl group`**: Collect a known number of MIDI events, then output as a list.
- **`thresh`**: Outputs accumulated values after a specified quiet period (useful as a "chord complete" detector).

**Polyphonic note tracking**: To track which notes are currently held:
- Use `borax` (built-in object that tracks note on/off pairs, voice numbers, and note counts)
- Or maintain a manual note list using `bag` or `coll`, adding on note-on and removing on note-off
- Always handle the edge case where a note-off might be missed (sustain pedal, USB disconnect, etc.)

### MIDI Routing Patterns

**Channel filtering:**
```
[notein]           — receives from all channels
[notein 1]         — receives only from channel 1
```

**Velocity-to-parameter mapping:**
```
[notein] → [trigger i i] → velocity to [scale 0 127 0. 1.] → parameter
                          → pitch to destination
```

**In Max4Live**: Always use `midiin`/`midiout` for raw MIDI (not `notein`/`noteout`). Parse with `midiparse`, rebuild with `midiformat`. All MIDI received by `midiin` must be forwarded via `midiout` unless intentionally filtered — otherwise downstream devices receive nothing.

## Control Flow Objects

### `sel` (select)

Compares input against one or more values. Outputs a bang from the matching outlet, or passes the input through the rightmost outlet if no match.

```
[sel 0 1 2]  — 4 outlets: bang if 0, bang if 1, bang if 2, pass-through for non-matches
[sel 60]     — 2 outlets: bang if input is 60, pass-through otherwise
```

Use cases: Detecting specific MIDI notes, routing by state value, matching specific messages.

### `route`

Routes messages based on their first element. Strips the matching prefix and sends the remainder out the corresponding outlet. Non-matching messages pass through the rightmost outlet.

```
[route pitch velocity channel]
  — input "pitch 60" → first outlet outputs 60
  — input "velocity 100" → second outlet outputs 100
  — input "unknown data" → rightmost outlet passes it through
```

Unlike `sel`, `route` strips the matched symbol/value from the output. This is critical for parsing structured messages like OSC-style paths or named parameters.

```
[route foo bar]
  — input: "foo 42" → outlet 0 outputs: 42
  — input: "bar hello world" → outlet 1 outputs: "hello world"
```

### `if`

Conditional logic with C-like syntax. Evaluates an expression and routes the input accordingly.

```
[if $i1 > 64 then $i1 else 0]  — passes values > 64 through, outputs 0 otherwise
[if $i1 > 0 then bang]         — outputs bang from left outlet when true, from right when false
[if $i1 >= $i2 then $i1]       — compares two inlets
```

`$i1`, `$i2` refer to integer inputs (inlets 1, 2). `$f1`, `$f2` for floats.

**When to use what:**
- `sel`: Matching exact known values, especially for bang-triggering
- `route`: Parsing structured messages where you need to strip the prefix
- `if`: Numeric comparisons, range checking, conditional math
- `gate`: Simple on/off routing controlled by a separate toggle
- `switch` / `selector~`: Audio-rate signal routing

### `gate` and `switch`

`gate N` creates N **outlets** and 2 inlets. Inlet 0 is the control inlet (int: which outlet to open, 1-N; send 0 to close all). Inlet 1 receives the message to route. The message passes through to whichever outlet is currently selected. Only one outlet is open at a time.

`switch N` is the opposite: N **inputs** routed to 1 output. Inlet 0 is the control (which input to listen to), inlets 1-N are sources.

For audio-rate signal routing, use `selector~` (multiple inputs to one output) or `gate~` (one input to multiple outputs).

## The zl Object Family

`zl` is a Swiss-army-knife for list and message manipulation. It operates in different modes specified by its first argument. This is one of the most frequently used objects in Max.

### Essential zl Modes

| Mode | Purpose | Example |
|------|---------|---------|
| `zl group N` | Collect N items, then output as a list | `[zl group 3]`: input 1, 2, 3 → output "1 2 3" |
| `zl slice N` | Split a list at index N | `[zl slice 2]` on "a b c d" → left: "a b", right: "c d" |
| `zl join` | Concatenate two lists (from left + right inlets) | Left "a b" + right "c d" → "a b c d" |
| `zl len` | Output the length of a list | "a b c" → 3 |
| `zl nth N` | Get the Nth element (1-indexed) | `[zl nth 2]` on "a b c" → "b" |
| `zl reg` | Store a list (cold inlet), output on bang | Like a message box but for lists |
| `zl rev` | Reverse a list | "1 2 3" → "3 2 1" |
| `zl rot N` | Rotate a list by N positions | `[zl rot 1]` on "a b c" → "b c a" |
| `zl sort` | Sort a list | "3 1 2" → "1 2 3" |
| `zl unique` | Remove duplicate elements | "1 2 2 3 1" → "1 2 3" |
| `zl lookup` | Use input as index into stored list | Store "a b c", input 1 → "b" |
| `zl filter` | Remove elements matching right inlet value | Filter "b" from "a b c" → "a c" |
| `zl iter N` | Output list elements N at a time | `[zl iter 1]` on "a b c" → outputs "a", then "b", then "c" |
| `zl stream N` | Sliding window of N elements | `[zl stream 3]`: input 1,2,3,4 → after 3rd: "1 2 3", after 4th: "2 3 4" |
| `zl ecils N` | Split list keeping last N items on right | `[zl ecils 2]` on "a b c d" → left: "a b", right: "c d" |
| `zl sub` | Find a sublist within a list | Returns index of match |
| `zl union` | Set union of two lists | |
| `zl sect` | Set intersection of two lists | |
| `zl scramble` | Randomize list order | |

### Common zl Patterns

**Collecting MIDI events into chords:**
```
[notein] → [zl group 6]  — collect 6 values (3 notes x pitch+velocity)
```

**Building parameter lists:**
```
[zl join] — combine partial messages into complete ones
```

**Processing lists element by element:**
```
[zl iter 1] — output each element one at a time (like a for-each loop)
```

**Circular buffers:**
```
[zl stream N] — maintains a sliding window, useful for moving averages
```

## MC (Multichannel) Objects

MC is a single-cable multichannel signal system introduced in Max 8. It replaces the need for parallel duplicated signal chains with a clean, unified approach.

### Core Concept

An **MC cable** (visually a thicker/striped patch cord) carries N audio channels in a single connection. This is the primary way to handle polyphony, spatial audio, additive synthesis, or any scenario with multiple parallel signal paths.

```
[mc.pack~ 4]     — bundles 4 individual signals into one MC cable
[mc.unpack~ 4]   — splits one MC cable back into 4 individual signals
```

### The mc. Prefix Pattern

**Almost any MSP (signal) object has an MC counterpart via the `mc.` prefix.** This is not a separate object library — it is a naming convention. If you know an MSP object, its MC version is `mc.<objectname>`. Examples:

| MSP Object | MC Counterpart | Notes |
|------------|---------------|-------|
| `cycle~` | `mc.cycle~` | N oscillators in one object |
| `gain~` | `mc.gain~` | Gain applied per-channel or to all |
| `*~` | `mc.*~` | Per-channel multiplication |
| `+~` | `mc.+~` | Per-channel addition |
| `biquad~` | `mc.biquad~` | Per-channel filtering |
| `filtercoeff~` | `mc.filtercoeff~` | Per-channel filter coefficients |
| `line~` | `mc.line~` | Per-channel line ramps |
| `selector~` | `mc.selector~` | Route multichannel signals |
| `send~`/`receive~` | `mc.send~`/`mc.receive~` | Wireless multichannel routing |
| `adsr~` | `mc.adsr~` | Per-channel envelopes |
| `lores~` | `mc.lores~` | Per-channel resonant lowpass |
| `noise~` | `mc.noise~` | Independent noise per channel |
| `gen~` | `mc.gen~` | Gen patcher runs per-channel |

When an agent needs multichannel behavior, **check for the mc. version first** before building parallel signal chains or poly~ workarounds.

### Key MC Utility Objects

| Object | Purpose |
|--------|---------|
| `mc.pack~` | Combine individual signals into MC |
| `mc.unpack~` | Split MC into individual signals |
| `mc.mix~` | Mix all MC channels down to stereo (with pan) |
| `mc.stereo~` | Quick stereo mixdown from MC |
| `mc.target` | Send messages to a specific channel instance |
| `mc.voiceallocator~` | MIDI-driven voice allocation for MC synths |
| `mc.sig~` | Per-channel signal from control messages |
| `mc.assign~` | Route channels between MC cables |
| `mc.channelcount` | Report the number of channels in an MC cable |

### When to Use MC vs poly~

| Use MC when... | Use poly~ when... |
|---------------|-------------------|
| All voices run the same fixed signal chain | Voices need different internal patching or logic |
| You want visual clarity (one cable, not N) | You need per-voice message/control logic with `thispoly~` |
| Channel count is known and fixed | Dynamic voice count is needed |
| Simple synthesis / effects (additive, unison, etc.) | Complex voice state (envelopes triggered by MIDI, note stealing) |
| Spatial audio / surround work | The subpatcher needs non-signal objects like `coll`, `counter`, etc. |

For many synthesis use cases, MC gives cleaner patches with less visual clutter. A 64-voice unison oscillator is one `mc.cycle~ @chans 64` object instead of a poly~ setup.

### MC for Audio Processing

MC is especially powerful for audio work where you need parallel signal processing:

**Unison / supersaw oscillators:**
```
[mc.cycle~ @chans 8]    — 8 oscillators
     |
[mc.lores~ 2000 0.5]    — per-channel filtering
     |
[mc.mix~ 2]             — mix down to stereo with per-channel panning
```

This replaces what would be 8 parallel `cycle~` → `lores~` chains plus manual summing.

**Per-channel parameter control with `mc.sig~`:**
```
[mc.sig~ @chans 8]  — converts a list of 8 values into an 8-channel MC signal
```
Send a list of 8 frequencies to `mc.sig~`, connect to `mc.cycle~`'s frequency inlet — each channel gets its own frequency. This is how you detune unison voices or set individual partials.

**Channel-aware processing:**
- `mc.target N` — direct messages to a specific channel (like `target` for `poly~`)
- `@chans N` attribute — sets channel count on MC source objects
- `@automanage 0` — disables automatic channel count propagation (for manually controlling topology)

**Key MC audio objects not in the prefix table:**
| Object | Purpose |
|--------|---------|
| `mc.midiin` | MIDI-to-MC voice allocation |
| `mc.plateau~` | Per-channel reverb |
| `mc.mixdown~` | Sum all MC channels to a single signal |
| `mc.separate` | Split MC cable into individual named channels for routing |
| `mc.combine` | Join individually named channels back into MC |
| `mc.op~` | Apply arithmetic between MC cables (add, multiply, etc.) |

## Patching Style and Conventions

### Subpatcher Organization

- **Extract subpatchers** for any logic cluster exceeding ~10-15 objects. If you have to scroll to follow the signal flow, it should be a subpatcher.
- **Name subpatchers descriptively**: `[p MIDINoteFilter]`, `[p EnvelopeGenerator]`, `[p VoiceAllocator]` — not `[p sub1]` or `[p stuff]`.
- Use `[p ...]` for subpatchers that are specific to this patch. Use separate `.maxpat` files (abstractions) for reusable logic shared across patches.
- **bpatcher** for subpatchers that have their own UI exposed in the parent.

### Commenting

- **Comment liberally.** Add comments explaining intent, not just what an object does. "Filter out note-offs" is better than "check if velocity > 0".
- Place comments **above or to the left** of the logic they describe.
- Use comments to label sections of a patch: "--- MIDI Input ---", "--- Voice Allocation ---", etc.
- Comment non-obvious parameter values: why is this delay 5ms? Why is this scale range 0.01 to 0.99?

### Layout

- Signal flow should generally run **top to bottom** (inputs at top, outputs at bottom).
- Keep related objects grouped visually. White space between groups improves readability.
- Avoid crossing patch cords where possible. Use `send`/`receive` for long-distance connections that would create spaghetti.
- Align objects to the grid. Use integer coordinates.
- Root patches: `[8.0, 8.0]` grid, Arial 10 Bold. Subpatchers: `[15.0, 15.0]` grid, Arial 12 Regular.

### Naming

- **send/receive**: Use descriptive names. `[s filterCutoff]` not `[s x]`. In M4L, prefix with `---` for instance isolation: `[s ---filterCutoff]`.
- **Scripting names (varname)**: Use CamelCase. `FilterCutoff`, `LFORate`, `OutputGain`.
- **Subpatcher names**: CamelCase. `[p NoteTracker]`, `[p StereoDelay]`.
- **Abstractions**: CamelCase filenames. `NoteFilter.maxpat`, `ClockDivider.maxpat`.

### Cleanup Before Distribution

- Remove all `print` objects (or disable them)
- Remove `dac~` / `adc~` (use `plugin~`/`plugout~` in M4L)
- Resolve all TODO comments
- Ensure every commit leaves the patch in a working state

## Max4Live Specifics

### Device Types

| Type | Audio I/O | MIDI I/O | Required Objects |
|------|-----------|----------|------------------|
| Audio Effect | `plugin~` / `plugout~` | N/A | `plugin~`, `plugout~` |
| MIDI Effect | N/A | `midiin` / `midiout` | `midiin`, `midiout` |
| Instrument | N/A / `plugout~` | `midiin` / N/A | `midiin`, `plugout~` |
| MIDI Tool (Live 12+) | N/A | Clip data | Operates on clip data, not real-time streams |

### .amxd File Format

`.amxd` = 32-byte binary header + JSON body (same as .maxpat) + binary footer. The header's last 4 bytes are a little-endian uint32 of the JSON length. For version control, store unfrozen devices and never commit frozen `.amxd` files.

### live.* UI Objects

| Object | Purpose | Output Type |
|--------|---------|-------------|
| `live.dial` | Rotary knob | Float or Int |
| `live.slider` | Linear slider | Float or Int |
| `live.toggle` | On/off toggle | Int (0/1) |
| `live.menu` | Dropdown menu | Int (index) |
| `live.numbox` | Number box | Float or Int |
| `live.tab` | Multi-tab selector | Int (index) |
| `live.button` | Momentary button | Bang |
| `live.text` | Button/toggle with text | Int (0/1) |

### live.* Object JSON Structure

```json
{
  "box": {
    "id": "obj-8",
    "maxclass": "live.dial",
    "numinlets": 1,
    "numoutlets": 2,
    "outlettype": ["", "float"],
    "parameter_enable": 1,
    "patching_rect": [233.0, 103.0, 44.0, 48.0],
    "presentation": 1,
    "presentation_rect": [6.0, 69.0, 44.0, 48.0],
    "saved_attribute_attributes": {
      "valueof": {
        "parameter_longname": "Cutoff",
        "parameter_shortname": "Cut",
        "parameter_type": 0,
        "parameter_mmax": 20000.0,
        "parameter_mmin": 20.0,
        "parameter_initial_enable": 1,
        "parameter_initial": [1000.0],
        "parameter_unitstyle": 3,
        "parameter_exponent": 3.33,
        "parameter_linknames": 1
      }
    },
    "varname": "Cutoff"
  }
}
```

### Parameter Attributes

| Attribute | Description |
|-----------|-------------|
| `parameter_longname` | Unique ID for automation & MIDI mapping. **Must be unique within the device.** |
| `parameter_shortname` | Display label on the UI object |
| `parameter_type` | `0` = Float, `1` = Int, `2` = Enum, `3` = Blob |
| `parameter_mmax` / `parameter_mmin` | Max/min values |
| `parameter_initial_enable` | `1` to activate initial value recall on device load |
| `parameter_initial` | Default value (array, e.g. `[0.5]`) |
| `parameter_unitstyle` | `0`=Int, `1`=Float, `2`=Time, `3`=Hz, `4`=dB, `5`=%, `9`=MIDI |
| `parameter_exponent` | Curve exponent for parameter scaling |
| `parameter_enum` | Array of enum strings (type 2 only) |
| `parameter_linknames` | `1` = longname follows varname |
| `parameter_visibility` | Controls automation and storage behavior |
| `parameter_modmode` | Unipolar, Bipolar, Additive, or Absolute |
| `parameter_annotation_name` | Category label for Info View tooltip |
| `parameter_annotation` | Description text for Live's Info View |

### Parameter Visibility Options

| Setting | Stored in Set? | Automatable? | Use Case |
|---------|---------------|-------------|----------|
| Automated and Stored | Yes | Yes | Primary user-facing controls |
| Stored Only | Yes | No | Internal state, mode switches |
| Hidden | No | No | Transient state |

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

The LOM is a hierarchical tree of everything in Ableton Live accessible via Max4Live.

**Root objects**: `live_app`, `live_set`, `control_surfaces N`, `this_device`

**Path syntax**: Space-separated, zero-indexed. Example: `live_set tracks 2 clip_slots 0 clip`

**Four essential objects**:

| Object | Purpose |
|--------|---------|
| `live.path` | Navigates the LOM hierarchy. Outlet sends `id N` |
| `live.object` | Gets/sets properties, calls functions on Live objects |
| `live.observer` | Monitors property changes (spontaneous output) |
| `live.remote~` | Controls DeviceParameter objects at signal rate |

**Critical rule**: Always place `deferlow` between `live.observer` output and any `live.object` set/call operations.

### Initialization

- `loadbang`: General init that does NOT depend on the Live API
- `live.thisdevice`: Init that REQUIRES the Live API to be ready (left outlet bangs when connected)
- Use ONE `loadbang` connected to `trigger` objects (multiple `loadbang` order is undefined)

### Send/Receive Naming

Use three dashes prefix for send/receive names: `[s ---Cutoff]`. Max replaces `---` with unique device instance numbers, preventing namespace collisions between instances.

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

| Object text | numinlets | numoutlets | outlettype |
|-------------|-----------|------------|------------|
| `cycle~ 440` | 2 | 1 | `["signal"]` |
| `noise~` | 1 | 1 | `["signal"]` |
| `*~ 0.5` | 2 | 1 | `["signal"]` |
| `+~ 0` | 2 | 1 | `["signal"]` |
| `line~` | 2 | 2 | `["signal", "bang"]` |
| `adsr~ 10 100 0.7 200` | 5 | 2 | `["signal", "signal"]` |
| `biquad~` | 6 | 1 | `["signal"]` |
| `filtercoeff~` | 5 | 6 | `["signal","signal","signal","signal","signal","signal"]` |
| `gain~` | 2 | 2 | `["signal", ""]` |
| `plugin~` | 1 | 2 | `["signal", "signal"]` |
| `plugout~` | 2 | 0 | |
| `midiin` | 1 | 1 | `["int"]` |
| `midiout` | 1 | 0 | |
| `midiparse` | 1 | 7 | `["","","","","","",""]` |
| `midiformat` | 7 | 1 | `["int"]` |
| `metro 500` | 2 | 1 | `["bang"]` |
| `counter 0 16` | 5 | 4 | `["int","","","int"]` |
| `trigger b i` | 1 | 2 | `["bang", "int"]` |
| `route 0 1 2` | 1 | 4 | `["","","",""]` |
| `notein` | 1 | 3 | `["int","int","int"]` | pitch, velocity, channel |
| `noteout` | 3 | 0 | | pitch, velocity, channel inlets |
| `ctlin` | 1 | 3 | `["int","int","int"]` | value, CC#, channel |
| `bendin` | 1 | 2 | `["int","int"]` | value, channel |
| `borax` | 3 | 7 | `["int","int","int","int","int","int","int"]` | Note tracking: delta, voice, pitch, vel, notecount, voicecount, steal |
| `flush` | 1 | 2 | `["int","int"]` | Sends note-offs for all held notes |
| `bag` | 1 | 2 | `["int","bang"]` | Unordered collection (add/remove ints) |
| `thresh N` | 1 | 2 | `["",""]` | Outputs after N ms of silence |
| `gate 2` | 2 | 2 | `["", ""]` | Inlet 0: control (which outlet, 0=closed). Inlet 1: input to route. |
| `switch 2` | 3 | 1 | `[""]` | Inlet 0: control. Inlets 1-2: sources. Opposite of gate. |
| `selector~ 2` | 3 | 1 | `["signal"]` |
| `pack 0 0` | 2 | 1 | `[""]` |
| `unpack 0 0` | 1 | 2 | `["int", "int"]` |
| `scale 0. 1. 20. 20000.` | 6 | 1 | `[""]` |
| `loadbang` | 0 | 1 | `["bang"]` |
| `deferlow` | 1 | 1 | `[""]` |
| `change` | 1 | 2 | `["", "int"]` |
| `speedlim 30` | 2 | 1 | `[""]` |
| `snapshot~ 30` | 2 | 1 | `["float"]` |
| `poly~ voice 8` | varies | varies | varies |
| `send name` / `s name` | 1 | 0 | |
| `receive name` / `r name` | 0 | 1 | `[""]` |
| `send~ name` | 1 | 0 | |
| `receive~ name` | 0 | 1 | `["signal"]` |
| `sel 0 1 2` | 1 | 4 | `["bang","bang","bang",""]` | Last outlet: non-matching pass-through |
| `if $i1 > 0 then bang` | 1 | 2 | `["bang","bang"]` | Left: true, Right: false |
| `zl group 4` | 2 | 2 | `["",""]` | Collect N items into list |
| `zl slice 2` | 2 | 2 | `["",""]` | Split list at index |
| `zl join` | 2 | 2 | `["",""]` | Concatenate two lists |
| `zl iter 1` | 2 | 2 | `["",""]` | Output elements one at a time |
| `zl len` | 2 | 2 | `["int",""]` | Output list length |
| `zl reg` | 2 | 2 | `["",""]` | Store list, output on bang |
| `zl rev` | 2 | 2 | `["",""]` | Reverse a list |
| `zl sort` | 2 | 2 | `["",""]` | Sort a list |
| `coll` | 1 | 4 | `["","","",""]` | Keyed data storage |
| `dict` | 2 | 2 | `["",""]` | Dictionary (JSON-like) storage |
| `buffer~ name` | 1 | 2 | `["float","bang"]` | Audio buffer declaration (length, done-loading) |
| `groove~ name` | 4 | 3 | `["signal","signal","signal"]` | Buffer playback (audio, sync, sync) |
| `play~ name` | 2 | 1 | `["signal"]` | Position-driven buffer playback |
| `wave~ name` | 3 | 1 | `["signal"]` | Wavetable lookup from buffer |
| `index~ name` | 2 | 1 | `["signal"]` | Non-interpolated buffer lookup |
| `record~ name` | 3 | 1 | `["signal"]` | Record into buffer |
| `info~ name` | 1 | 4 | `["float","int","int",""]` | Buffer info (ms, chans, sr, name) |
| `tapin~ 5000` | 1 | 1 | `["signal"]` | Delay line write (arg = max ms) |
| `tapout~ 250` | 1 | 1 | `["signal"]` | Delay line read (arg = delay ms) |
| `delay~ 100` | 2 | 1 | `["signal"]` | Short sample-level delay |
| `sig~ 440` | 1 | 1 | `["signal"]` | Message to constant signal |
| `number~` | 2 | 2 | `["signal","float"]` | Signal monitor (debug) |
| `peakamp~ 100` | 2 | 1 | `["float"]` | Peak amplitude over interval |

## Performance Best Practices

- **Signal rate vs control rate**: Not just performance — it's a correctness issue. See the "Signal Flow: Message Rate vs Signal Rate" section. High data speed at control rate is much more CPU-expensive than at signal rate. Once in the signal domain, stay there.
- **Scheduler in M4L**: The 1ms scheduler is not used. Updates happen per audio buffer. `metro 1` or `snapshot~ 1` will flood the scheduler.
- **snapshot~**: Use `[snapshot~ 30]` or wider. Never `[snapshot~ 1]`.
- **gen~**: Not just an optimization — often the right architecture. Combines multiple operations efficiently. Zero CPU when muted in poly~. Per-instance overhead means more operators per gen~ is better than many small gen~ instances. See "When to Use gen~" section.
- **poly~**: Keep only per-voice calculations inside. Mute unused voices (zero CPU when muted).
- **Prevent clicks**: Use `[$1 5] → [line~]` fade techniques when changing parameters. Never set signal-rate values directly from message rate without smoothing.
- **Minimize live.observer instances**: Each one adds overhead from the Live integration layer.
- **MC vs parallel chains**: Prefer MC objects over manually duplicated signal chains. Cleaner patches, often better CPU performance due to internal SIMD optimization.

## Max4Live UI Best Practices

- Enable `"openinpresentation": 1` so devices open in presentation mode
- Use integer pixel coordinates (no decimals like `4.356`)
- Test with multiple Live themes (dark/light) - `live.*` objects follow theme colors
- Use LCD display mode for `live.tab`, `live.numbox`, `live.text`
- `live.text`: Set Output Mode to "Mouse Up" for button behavior
- Pop-out windows via `pcontrol`: Set to floating mode
- Compare device width against similar native Ableton devices
- Add `parameter_annotation_name` and `parameter_annotation` for Info View tooltips

## Push Integration

Use `live.banks` to organize parameters into banks of 8 (matching Push encoders). Without `live.banks`, devices show an error on Push. Convention: name the Push banks subpatcher `[p PushBanks]`.

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

## Max 9 Features

Max 9 (released 2024) introduces significant new features. This section covers what matters for patch authoring.

### V8 JavaScript Engine

Max 9 replaces the legacy SpiderMonkey-based `js` object with a new V8-based engine. **Default to `v8` for new patches.**

| Object | Purpose |
|--------|---------|
| `v8` | JavaScript processor (ES6+, async/await, typed arrays, arrow functions, classes) |
| `v8ui` | JavaScript with custom UI drawing (replaces `jsui`) |
| `v8.codebox` | Inline JavaScript editor directly in the patcher (no external file needed) |

**Why v8 over js:**
- Full ES6+ support (arrow functions, `let`/`const`, template literals, destructuring, `async`/`await`, `Map`/`Set`, typed arrays)
- Significantly faster execution (V8 JIT compilation)
- Native I/O for JavaScript Array, String, and Dictionary types — no conversion overhead at object boundaries
- XMLHttpRequest for HTTP requests, SQLite for database access, Buffer manipulation APIs
- Inline error reporting in the codebox editor

**The legacy `js` object still exists** for Max 8 backward compatibility. Use it only when targeting Max 8.

**v8 in .maxpat JSON:**
```json
{
  "box": {
    "id": "obj-1",
    "maxclass": "newobj",
    "text": "v8 myscript.js",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""]
  }
}
```

### Codeboxes Everywhere

In Max 8, `codebox` only existed inside gen~/RNBO subpatchers. Max 9 adds codeboxes as **top-level patcher objects** across multiple domains:

| Codebox | Domain | Language | Use Case |
|---------|--------|----------|----------|
| `v8.codebox` | Event/message | JavaScript (ES6+) | Complex message logic, data transformation |
| `node.codebox` | Event/message | Node.js | Server-side logic, file I/O, network |
| `dict.codebox` | Event/message | Dict expressions | Dictionary manipulation |
| `coll.codebox` | Event/message | Coll expressions | Collection queries and transforms |
| `text.codebox` | Event/message | String expressions | String construction/transformation |
| `gen.codebox` | Event (control rate) | GenExpr | Sample-accurate control-rate math |
| `gen.codebox~` | Signal (audio rate) | GenExpr | **DSP code directly in the patcher** — no gen~ subpatcher needed |

**`gen.codebox~` is a major workflow change.** You can now write GenExpr DSP code as a top-level object instead of opening a gen~ subpatcher window. For simple DSP algorithms (waveshapers, one-pole filters, custom oscillators), this is often cleaner than a full gen~ subpatcher.

### array.* Object Family

A proper array data type with ~42+ objects. Arrays are nested (can contain other arrays and dicts). **Prefer over `zl` for array operations in Max 9** — these are more readable and more capable.

Key objects:

| Object | Purpose | zl equivalent |
|--------|---------|---------------|
| `array` | Declare/store an array | — |
| `array.min` / `array.max` | Min/max of an array | — (no direct zl equivalent) |
| `array.mean` / `array.median` | Statistical operations | — |
| `array.sort` | Sort an array | `zl sort` |
| `array.reverse` | Reverse an array | `zl rev` |
| `array.slice` | Extract sub-array by index range | `zl slice` |
| `array.filter` | Filter elements by condition | — |
| `array.map` | Transform each element | — |
| `array.reduce` | Reduce to single value | — |
| `array.push` / `array.pop` | Stack operations | — |
| `array.concat` | Join arrays | `zl join` |
| `array.unique` | Remove duplicates | `zl unique` |
| `array.scramble` | Randomize order | `zl scramble` |
| `array.iter` | Output elements one at a time | `zl iter` |
| `array.length` | Get array length | `zl len` |
| `array.indexof` | Find element position | — |
| `array.every` / `array.some` | Boolean tests across elements | — |
| `array.group` | Group elements | — |
| `array.expr` | Evaluate expression per element | — |
| `array.frombuffer` / `array.tobuffer` | Convert between array and buffer~ data | — |
| `array.tolist` / `array.tostring` | Convert to Max list or string | — |
| `array.stddev` | Standard deviation | — |
| `array.stream` | Sliding window | `zl stream` |
| `array.sect` / `array.union` | Set intersection / union | `zl sect` / `zl union` |

`zl` still works and remains useful for quick inline list operations and Max 8 compatibility. But `array.*` is more expressive for complex data manipulation.

### string.* Object Family

A native string data type (~34 objects) that is **independent of Max's Symbol Table**. This matters because every unique symbol in Max persists in memory forever. Heavy string manipulation via symbols causes memory bloat; `string.*` avoids this.

Key objects: `string`, `string.append`, `string.concat`, `string.contains`, `string.replace`, `string.replaceall`, `string.split`, `string.slice`, `string.regexp`, `string.sprintf`, `string.tolower`, `string.toupper`, `string.trim`, `string.length`, `string.indexOf`, `string.startswith`, `string.endswith`, `string.tolist`, `string.tosymbol`, `string.iter`.

Use `string.*` for any text processing, formatting, or parsing. Only convert to symbol (`string.tosymbol`) when you need to interface with symbol-based objects.

### schedule Object

Moves messages to the scheduler thread, optionally with a delay. Complements the existing `defer`/`deferlow` pattern:

| Object | Direction | Use Case |
|--------|-----------|----------|
| `defer` | Any thread → main/low-priority | UI updates from audio thread |
| `deferlow` | Any thread → low-priority queue | After `live.observer`, non-urgent tasks |
| `schedule` | Any thread → scheduler thread | **Precise timing**, sequenced operations |
| `schedule` (with delay) | Any thread → scheduler after N ms | Timed events with scheduler-thread precision |

`schedule` is the right choice when you need a message to execute with scheduler-thread timing precision — for example, sequencing MIDI events or synchronizing operations that must happen on the scheduler clock.

### Parameter Connect

UI objects can now connect to supported object attributes **without patch cords**. Currently supported by ABL, jit.fx, and Gen objects. The connection is made via the object inspector.

This means a `live.dial` can control a `gen.codebox~` parameter or an `abl.dsp.meldfilter~` attribute by name, without a visible cord. When generating patches programmatically, be aware that parameter connections are stored as attributes in the JSON, not as entries in `"lines"`.

### ABL Objects (Ableton DSP Library)

Max 9 includes Ableton's internal DSP components as Max objects. Two tiers:

**High-level device objects** (complete processors):
`abl.device.autofilter~`, `abl.device.chorus~`, `abl.device.compressor~`, `abl.device.drumbuss~`, `abl.device.drumsampler~`, `abl.device.echo~`, `abl.device.erosion~`, `abl.device.roar~`, `abl.device.saturator~`, `abl.device.drift~`

**Low-level DSP components** (55+ building blocks):
`abl.dsp.meldfilter~` (14 filter modes), `abl.dsp.meldosc~` (24 oscillator modes), `abl.dsp.pitchestimator~` (pitch detection), `abl.dsp.compressor~`, `abl.dsp.stereolfo~`, `abl.dsp.transform~`, and many more.

**Do not build a compressor, saturator, or filter from scratch** if an ABL object already does what you need. Check the `abl.device.*` and `abl.dsp.*` families first.

All ABL objects support `@ins` for assigning float-type attributes to inlets.

### loudness~

Reports loudness per the EBU R 128 standard in LUFS. Useful for metering utilities.

```
[audio signal] → [loudness~] → outlets: momentary LUFS, short-term LUFS, integrated LUFS, loudness range
```

### Additional Max 9 Objects Worth Knowing

| Object | Purpose |
|--------|---------|
| `sfizz~` | SFZ instrument loader — plays SFZ sampler formats with MIDI. MC variant: `mc.sfizz~` |
| `threadcheck` | Reports which thread (scheduler, main, audio) a message is on. Debugging tool. |
| `hid` | Modern HID (human interface device) input, replaces legacy `hi` object |
| `repl` | REPL in the Max Console — send messages to named objects, evaluate JS, read/write attributes |
| `stepfun~` / `stepdiv~` / `stepcounter~` | Step sequencer primitives driven by phasors |
| `live.modulate~` | Parameter modulation object for Max4Live |

### Illustration Mode (Debugging)

Max 9 added a debugging mode that executes patches in slow motion — messages visually travel down patch cords so you can watch execution order and data flow. Speed is configurable (1-10). Enable per-patcher or globally.

This is valuable for debugging message ordering issues (see "Message Ordering and Execution Model" section) and understanding `trigger` evaluation order.

### Preset Interpolation

The `preset` object now supports float recall for interpolation between slots:
- `1.5` interpolates halfway between slots 1 and 2
- `recallmulti 1.5 4.5 7.5` does weighted multi-preset interpolation
- Integrates with the `nodes` object for visual multi-preset morphing

### .maxpat JSON Changes in Max 9

**Attributes with default values are no longer saved** in the .maxpat JSON. Patches saved in Max 9 are leaner — objects only include non-default attributes. `patching_rect` is always saved regardless. This does not break the format (Max 8 patches still open fine in Max 9 and vice versa), but programmatic patch generators should not assume all attributes will be present when reading Max 9 patches.

### Breaking Changes from Max 8

- `poly~ @local` attribute has been removed entirely
- `regexp` output order was corrected — use `@legacyoutputorder` for old behavior
- Max 9 M4L devices **require Live 12** — they will not work in Live 11

## Common Pitfalls

- **loadbang vs live.thisdevice**: Using `loadbang` for Live API calls before the API is initialized causes errors
- **Missing deferlow**: Connecting `live.observer` directly to `live.object` without `deferlow` causes crashes
- **Non-unique Long Names**: Duplicate parameter names break automation mapping
- **send~/receive~ between M4L devices**: Not supported, causes no output
- **Using noteout in M4L**: Must use `midiout` instead
- **Forgetting to freeze**: Distributing unfrozen devices means missing dependencies
- **Multiple loadbangs**: Execution order is undefined. Use one `loadbang` with `trigger` objects.

## Programmatic .maxpat Generation Tools

- **py2max** (Python): `pip install py2max` - Most comprehensive library for offline .maxpat generation
- **MaxPyLang** (Python): `pip install maxpylang` - Simpler API for patch generation
- **MaxMSP-MCP-Server**: MCP server enabling LLMs to create/modify patches via running Max instance
- **eslint-plugin-maxpat**: ESLint validation rules for .maxpat files (useful schema reference)

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

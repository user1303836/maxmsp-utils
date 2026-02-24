# midi.notepriority

Monophonic note-priority filter for MIDI note pairs. When multiple notes are held simultaneously, only one note sounds based on the selected priority mode: lowest pitch, highest pitch, or most recently pressed.

When the active note is released while other notes are still held, the abstraction automatically switches to the next priority winner, emitting a note-off for the old note and a note-on for the new one.

## Inlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | list (int int) | Note pairs: pitch velocity. Velocity > 0 is note-on, velocity 0 is note-off. Typically connected to `midiparse` outlet 0 or `unpack` from `notein`. |
| 2 | symbol (message) | Control messages: `mode`, `reset`, `panic`, `bypass`. |

## Outlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | list (int int) | Filtered note pairs: pitch velocity. Only the priority-winning note is output. When the active note changes due to a new note-on or a note-off with switchover, both a note-off for the old pitch and a note-on for the new pitch are emitted. |
| 2 | symbol | State messages: `active <pitch>` (current sounding note) or `none` (no notes held). |

## Arguments

| Argument | Type | Default | Description |
|----------|------|---------|-------------|
| 1 | symbol | low | Initial priority mode: `low`, `high`, or `last`. |

```
midi.notepriority          --> low mode (default)
midi.notepriority low      --> lowest note priority
midi.notepriority high     --> highest note priority
midi.notepriority last     --> most recent note priority
```

## Messages (Right Inlet)

### mode *low|high|last*

Set the priority mode. Takes effect on the next note event.

- **low**: The lowest-pitched held note is always the active note. Playing a lower note triggers a switchover; releasing it switches back to the next lowest.
- **high**: The highest-pitched held note is always the active note.
- **last**: The most recently pressed held note is always the active note. This is the most common behavior for monophonic synthesizers.

```
mode low    --> lowest note wins
mode high   --> highest note wins
mode last   --> most recent note wins
```

### panic

Emit a note-off (velocity 0) for the currently active note, clear all held-note state, and reset the sequence counter. Outlet 2 outputs `none`.

### reset

Identical to `panic`: clears all state and emits note-off for the active note.

### bypass *0|1*

Enable or disable bypass mode. When bypassed, all note pairs pass directly from inlet 1 to outlet 1 without filtering. Enabling bypass (`bypass 1`) also triggers a panic, clearing all held-note state and emitting a note-off for the active note. This prevents stale internal state from producing incorrect output when bypass is later disabled.

```
bypass 1    --> panic + pass all notes through unfiltered
bypass 0    --> resume note-priority filtering (default)
```

## Defaults

| Parameter | Default |
|-----------|---------|
| mode | low (or creation argument) |
| bypass | 0 (off) |

## Priority Modes

| Mode | Behavior | Use Case |
|------|----------|----------|
| last | Most recently pressed note wins | Classic mono synth, lead playing |
| low | Lowest held note wins | Bass lines, left-hand priority |
| high | Highest held note wins | Melody priority, right-hand lead |

## Example Usage

### Monophonic synth voice from polyphonic keyboard

```
[midiin]
|
[midiparse]
|
[midi.notepriority]
|
[unpack i i]
|         |
[mtof]    [/ 127.]
|         |
[cycle~]  [*~]
          |
          [ezdac~]
```

### Low-note priority for bass

```
[midiin]
|
[midiparse]
|
[midi.notepriority low]
|
[your-bass-synth]
```

### Switch modes dynamically

```
[midiin]                [umenu: low high last]
|                       |
[midiparse]             [prepend mode]
|                       |
[midi.notepriority ------]
|
[your-synth]
```

### Panic on transport stop

```
[midiin]             [live.thisdevice]
|                    |
[midiparse]          [t b]
|                    |
|                    [message: panic]
|                    |
[midi.notepriority --]
|
[your-synth]
```

## Implementation Notes

- Uses `#0`-scoped internal state (`v`, `table` objects) for instance isolation. Multiple instances in the same patch do not interfere.
- Note-on/off detection uses velocity > 0 / == 0 convention.
- Priority scanning uses `uzi 128` to iterate all MIDI pitches (0-127). This is acceptable for the event-driven nature of MIDI note messages.
- Deterministic message ordering is enforced via `trigger` objects throughout.
- The `last` mode tracks note ordering via a monotonically incrementing sequence counter stored in `table #0_order`.

## See Also

- **stripnote** -- filter note-offs from note stream
- **borax** -- MIDI note analysis (delta time, voice count, etc.)
- **flush** -- send note-offs for all held notes
- **poly** -- voice allocation for polyphonic note management
- **notein** / **midiparse** -- MIDI input sources

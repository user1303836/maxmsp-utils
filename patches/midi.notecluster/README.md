# midi.notecluster

Group note-ons arriving within a short time window and emit chord cluster metadata.

## Description

`midi.notecluster` collects MIDI note-on events that arrive within a configurable time window and outputs them as a single cluster list with metadata. Note-offs pass through a separate outlet unchanged.

This packages a common chord-detection pattern into a reusable abstraction.

## Inlets

| Inlet | Type | Description |
|-------|------|-------------|
| 1 | note pairs (pitch velocity) | MIDI note pairs from `midiparse` note outlet or similar |
| 2 | control messages | `window`, `sort`, `unique`, `flush`, `reset`, `bypass` |

## Outlets

| Outlet | Type | Description |
|--------|------|-------------|
| 1 | list | `cluster <p1> <p2> ...` - sorted/deduped pitch list |
| 2 | messages | Metadata: `count <n>`, `lowest <p>`, `highest <p>`, `single`, `done` |
| 3 | list | Note-off passthrough: `<pitch> 0` |

## Messages

### Inlet 1

- **pitch velocity** (list of two ints): Note-on if velocity > 0 (accumulated into cluster), note-off if velocity == 0 (passed through outlet 3).

### Inlet 2 (Control)

| Message | Default | Description |
|---------|---------|-------------|
| `window <ms>` | 5 | Cluster window duration in milliseconds |
| `sort <0\|1>` | 1 | Sort pitches low-to-high before output |
| `unique <0\|1>` | 1 | Remove duplicate pitches within a cluster |
| `flush` | - | Emit pending cluster immediately |
| `reset` | - | Clear pending cluster and stop timer |
| `bypass <0\|1>` | 0 | Route all input directly to outlet 3 |

## Behavior

1. The first note-on starts the cluster window timer.
2. Additional note-ons arriving within the window join the current cluster.
3. When the window closes (or `flush` is received), the accumulated pitches are optionally sorted and deduplicated, then emitted as `cluster p1 p2 ...` on outlet 1.
4. Metadata follows on outlet 2: `highest`, `lowest`, `count`, `single` (if cluster size is 1), and `done`.
5. The cluster buffer is cleared after emission, ready for the next cluster.
6. Note-offs always pass through outlet 3 immediately, regardless of cluster state.

## Metadata Output Sequence

After each cluster emission, outlet 2 outputs (in order):

1. `highest <pitch>` - highest pitch in cluster
2. `lowest <pitch>` - lowest pitch in cluster (same as first element when sorted)
3. `count <n>` - number of notes in cluster
4. `single` - only emitted if cluster contains exactly one note
5. `done` - signals completion

## Examples

```
; Two notes within 5ms window -> one cluster
60 100, 64 100  ->  outlet 1: cluster 60 64
                    outlet 2: highest 64, lowest 60, count 2, done

; Note-off passes through
60 0            ->  outlet 3: 60 0

; Single note
72 100          ->  outlet 1: cluster 72
                    outlet 2: highest 72, lowest 72, count 1, single, done
```

## Instance Isolation

All internal state uses `#0`-scoped names (`#0_window`, `#0_sort`, `#0_unique`, etc.), ensuring multiple instances do not interfere with each other.

## Requirements

- Max 9 (uses standard `zl` objects, `delay`, `gate`, `trigger`)
- No external dependencies

# sig.schmitt.edge~

Signal-rate threshold detector with hysteresis and edge bang outputs. Wraps a common `thresh~`/`edge~` patch pattern into one reusable abstraction. The internal hysteresis is implemented as a gen~ codebox operating per-sample, ensuring no edge events are missed even at high frequencies.

State goes to `1.` when the input signal rises above the high threshold. State goes to `0.` when the input falls below the low threshold. While the signal is between the two thresholds, the previous state is held. This eliminates chatter from noisy signals that hover near a single threshold.

## Inlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | signal | Signal input to threshold. |
| 2 | float | Low threshold. Values arriving here update the low threshold immediately. |
| 3 | float | High threshold. Values arriving here update the high threshold immediately. |
| 4 | symbol (message) | Control messages: `low`, `high`, `init`, `reset`, `bypass`. |

## Outlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | signal | State signal: `0.` (below) or `1.` (above). Continuous signal-rate output. |
| 2 | bang | Rising-edge bang. Fires once each time the state transitions from `0` to `1`. |
| 3 | bang | Falling-edge bang. Fires once each time the state transitions from `1` to `0`. |
| 4 | any | Status messages: `state 0`, `state 1`, `thresholds <low> <high>`, `swapped`. |

## Arguments

| Argument | Type | Default | Description |
|----------|------|---------|-------------|
| 1 | float | 0.4 | Initial low threshold. |
| 2 | float | 0.6 | Initial high threshold. |

```
sig.schmitt.edge~            --> thresholds 0.4 / 0.6 (default)
sig.schmitt.edge~ 0.2 0.8    --> thresholds 0.2 / 0.8
sig.schmitt.edge~ -0.5 0.5   --> thresholds -0.5 / 0.5
```

## Messages (Inlet 4)

### low *float*

Set the low threshold at runtime. Takes effect on the next audio vector.

```
low 0.3    --> set low threshold to 0.3
```

### high *float*

Set the high threshold at runtime. Takes effect on the next audio vector.

```
high 0.7   --> set high threshold to 0.7
```

### init *0|1*

Set the internal state variable without producing edge bangs. Useful for starting in a known state before audio begins.

```
init 1     --> start in high state
init 0     --> start in low state (default)
```

### reset

Restore state to `0`, thresholds to creation-arg defaults (or `0.4`/`0.6`), and bypass to off.

### bypass *0|1*

Enable or disable bypass mode. When bypassed, the hysteresis logic is replaced with a simple `>~ 0.5` comparator. Edge bangs still fire on transitions.

```
bypass 1   --> simple comparator mode (no hysteresis)
bypass 0   --> normal Schmitt trigger (default)
```

## Threshold Validation

If the low threshold is greater than the high threshold, the gen~ codebox internally clamps them using `min`/`max`, ensuring correct hysteresis behavior regardless of input order. A `swapped` status message is emitted on the status outlet when this condition is detected at the message-rate threshold-reporting level.

## Implementation Notes

- Per-sample Schmitt trigger logic runs inside a `gen~` codebox using `History` for state feedback.
- `edge~` detects transitions in the state signal and produces rising/falling bangs at block boundaries.
- `selector~ 2` switches between normal (gen~) and bypass (`>~ 0.5`) paths.
- `sig~` converts message-rate threshold floats to signal-rate inputs for gen~.
- All internal state uses `#0`-scoped names (`v`, `s`, `r`) for instance isolation.
- Deterministic message ordering enforced via `trigger` objects.
- `snapshot~` is not used in the signal path; diagnostics are message-rate only.

## Example Usage

### Basic threshold detection

```
[cycle~ 0.5]
|
[sig.schmitt.edge~]
|          |      |
[state]  [rise] [fall]
```

### Noise gate with wide hysteresis

```
[noise~]
|
[sig.schmitt.edge~ 0.2 0.8]
|          |      |
[*~]     [bang] [bang]
```

### Dynamic thresholds from UI

```
[audio-source~]
|
[sig.schmitt.edge~]
|    |    |    |
     |    |    [print status]
     |    |
     [rise] [fall]

[flonum]  [flonum]
|         |
[sig.schmitt.edge~ inlet 2]  [sig.schmitt.edge~ inlet 3]
```

## See Also

- **thresh~** -- signal threshold with hysteresis (bangs only, no state signal)
- **edge~** -- detect zero-to-nonzero and nonzero-to-zero transitions
- **change~** -- output signal only when it changes
- **snapshot~** -- sample signal values at message rate
- **gen~** -- per-sample signal processing
- **util.state.latch** -- control-rate Schmitt latch with dwell time (message domain)

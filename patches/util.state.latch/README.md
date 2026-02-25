# util.state.latch

Control-rate Schmitt-style latch with dwell time. Suppresses jitter and chatter in noisy control streams by requiring input to remain in a threshold region for a specified dwell period before changing state. Useful for sensors, threshold crossings, and noisy controller data.

## Inlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | int/float | Numeric input value. Compared against high and low thresholds to determine target state. |
| 2 | symbol (message) | Control messages: `low`, `high`, `dwell`, `init`, `reset`, `bypass`. |

## Outlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | int | Latched state: `0` or `1`. Output only on state change (duplicates suppressed). |
| 2 | symbol | Events: `rise` (state changed to 1), `fall` (state changed to 0), `pending N` (transition to N requested, awaiting dwell). |
| 3 | symbol | Diagnostics: `value <x>` echoes each input value. |

## Arguments

| Argument | Type | Default | Description |
|----------|------|---------|-------------|
| 1 | float | 0.4 | Low threshold. Input at or below this value requests state 0. |
| 2 | float | 0.6 | High threshold. Input at or above this value requests state 1. |

```
util.state.latch          --> low=0.4 high=0.6 (default)
util.state.latch 0.3 0.7  --> low=0.3 high=0.7 (wider band)
util.state.latch 0.1 0.9  --> low=0.1 high=0.9 (maximum noise rejection)
```

## Messages (Right Inlet)

### low *float*

Set the low threshold. Input values at or below this trigger a transition to state 0 (after dwell).

```
low 0.2    --> state 0 when input <= 0.2
```

### high *float*

Set the high threshold. Input values at or above this trigger a transition to state 1 (after dwell).

```
high 0.8   --> state 1 when input >= 0.8
```

### dwell *ms*

Set the dwell time in milliseconds. The input must remain in the threshold region for this duration before the state transition commits. `dwell 0` switches immediately with hysteresis (no timer delay).

```
dwell 50   --> require 50ms sustained crossing
dwell 0    --> immediate switching with hysteresis
```

### init *0|1*

Set the internal state without emitting any transition event. Useful for initializing state at patch load.

```
init 1     --> set state to 1 silently
```

### reset

Cancel any pending transition, stop the dwell timer, and restore state to 0.

### bypass *0|1*

Enable or disable bypass mode. When bypassed, the latch uses a simple `>= high` threshold with no dwell timer and no hysteresis band. Useful for debugging or when clean thresholding without dwell is sufficient.

```
bypass 1   --> simple threshold, no dwell
bypass 0   --> normal Schmitt latch behavior (default)
```

## Defaults

| Parameter | Default |
|-----------|---------|
| low | 0.4 (or first creation argument) |
| high | 0.6 (or second creation argument) |
| dwell | 20 ms |
| state | 0 |
| bypass | 0 (off) |

## Behavior

### Hysteresis Band

Values between `low` and `high` are in the neutral (hysteresis) band and do not trigger any state change. This prevents rapid toggling when a noisy signal hovers near a single threshold.

```
        low=0.4          high=0.6
   --------+----------------+--------
   state 0 |  neutral band  | state 1
   request |  (keep current)| request
```

### Dwell Timer

When input crosses into a threshold region (above high or below low) and the requested state differs from the current state, a dwell timer starts. If the input remains in the threshold region for the full dwell period, the state commits. If the input returns to the neutral band before dwell completes, the pending transition is canceled.

### Duplicate Suppression

The latch only outputs on actual state changes. Repeated inputs in the same threshold region do not produce duplicate outputs.

### State Machine

1. Input arrives, region detected: above high, below low, or in band
2. Above high -> request state 1; Below low -> request state 0; In band -> cancel pending
3. If requested state differs from current state, store pending and start dwell timer
4. On dwell expiry, read pending value and commit if state still differs
5. Commit: update state, output on outlet 1, emit rise/fall on outlet 2

## Example Usage

### Sensor threshold with noise rejection

```
[analog-sensor-input]
|
[util.state.latch 0.3 0.7]
|
[sel 1]
|
[trigger-action]
```

### Dynamic threshold adjustment

```
[sensor-input]      [number: low]   [number: high]  [number: dwell]
|                   |               |               |
|                   [prepend low]   [prepend high]  [prepend dwell]
|                   |               |               |
[util.state.latch 0.4 0.6 ---------=----------------]
|
[gate]
```

### Immediate mode (dwell 0)

For hysteresis without dwell delay. State changes immediately when crossing thresholds but still uses the band to reject noise.

```
[noisy-controller]
|                   [message: dwell 0]
|                   |
[util.state.latch --]
|
[toggle]
```

## Implementation Notes

- Uses `#0`-scoped internal state (`v`, `s`, `r` objects) for instance isolation. Multiple instances in the same patch do not interfere.
- All message ordering is enforced via `trigger` objects throughout.
- The dwell timer uses Max's `delay` object. Sending `stop` to the delay cancels a pending transition.
- Region detection uses a comparator chain: `>=high * 2 + <=low` encodes region as 0 (band), 1 (below low), or 2 (above high).
- Pending state is stored as -1 (no pending), 0, or 1.

## See Also

- **change** -- suppress repeated identical values (not threshold-based)
- **thresh~** -- signal-rate hysteresis threshold detector
- **edge~** -- detect signal-rate rising/falling edges
- **sig.schmitt.edge~** -- signal-rate Schmitt trigger with edge bangs (companion utility)
- **onebang** -- pass one bang then block until reset
- **delay** -- schedule a bang after N ms

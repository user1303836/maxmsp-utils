# util.debounce

Delay output until input has been quiet for a specified number of milliseconds. When messages arrive in rapid succession, only the final message is output after the burst ends. Optionally emit the first message immediately (leading edge) in addition to or instead of the last (trailing edge).

## Inlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | any (int, float, list, symbol) | Message to debounce. Each incoming message resets the internal timer and buffers the message. |
| 2 | symbol (message) | Control messages: `time`, `leading`, `trailing`, `flush`, `cancel`, `bypass`, `reset`. |

## Outlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | any | Debounced output. Outputs the buffered message when the timer expires (trailing edge) or immediately on first input (leading edge), depending on mode. |
| 2 | symbol | Status messages: `scheduled` (timer started), `flushed` (message emitted by timer or flush), `canceled` (pending message dropped). |

## Arguments

| Argument | Type | Default | Description |
|----------|------|---------|-------------|
| 1 | int/float | 50 | Initial debounce time in milliseconds. |

```
util.debounce        --> 50ms debounce (default)
util.debounce 200    --> 200ms debounce
util.debounce 1000   --> 1 second debounce
```

## Messages (Right Inlet)

### time *ms*

Set the debounce delay in milliseconds. Takes effect on the next incoming message.

```
time 100    --> set debounce window to 100ms
time 500    --> set debounce window to 500ms
```

### leading *0|1*

Enable or disable leading-edge output. When enabled, the first message in a burst passes through immediately. Subsequent messages within the debounce window are suppressed (unless trailing is also enabled, in which case the last message is emitted after the window).

```
leading 1   --> emit first message immediately
leading 0   --> suppress leading edge (default)
```

### trailing *0|1*

Enable or disable trailing-edge output. When enabled, the most recent message is emitted after the debounce window expires with no new input.

```
trailing 1  --> emit last message after quiet period (default)
trailing 0  --> suppress trailing edge
```

### flush

Immediately emit the pending buffered message and stop the timer. If nothing is pending, flush has no effect.

### cancel

Drop the pending buffered message and stop the timer without emitting anything. Outputs `canceled` from outlet 2.

### bypass *0|1*

Enable or disable bypass mode. When bypassed, all input messages pass directly to outlet 1 without debouncing. Enabling bypass (`bypass 1`) also cancels any pending debounce timer, preventing stale buffered messages from leaking through after bypass is enabled.

```
bypass 1    --> cancel pending timer, pass all messages through immediately
bypass 0    --> resume debouncing (default)
```

### reset

Stop the timer, clear pending state, and restore default parameter values (`leading 0`, `trailing 1`). The debounce time is not changed by reset.

## Defaults

| Parameter | Default |
|-----------|---------|
| time | 50 ms (or creation argument) |
| leading | 0 (off) |
| trailing | 1 (on) |
| bypass | 0 (off) |

## Mode Combinations

| leading | trailing | Behavior |
|---------|----------|----------|
| 0 | 1 | **Trailing only** (default). Waits for quiet, then emits last message. |
| 1 | 0 | **Leading only**. Emits first message immediately, suppresses the rest. |
| 1 | 1 | **Both edges**. Emits first message immediately, then also emits last message after quiet. |
| 0 | 0 | **Silent**. No output (timer runs but nothing is emitted). |

## Example Usage

### Debounce rapid UI changes

A number box or slider sending values as the user drags. Only the final resting value is output.

```
[number]
|
[util.debounce 200]
|
[print settled-value]
```

### Leading-edge mode for instant response

React to the first event in a burst (e.g., a button press), then ignore follow-up triggers for 500ms.

```
[button]
|
[util.debounce 500]
|                 [message: leading 1]
[do-something]    |
                  [message: trailing 0]
                  |
                  [util.debounce] (right inlet)
```

### Debounce MIDI CC with flush on note-on

Smooth out noisy CC input, but immediately flush the latest value when a note arrives.

```
[ctlin]
|
[util.debounce 30]
|                   [notein]
[your-synth-param]  |
                    [message: flush]
                    |
                    [util.debounce] (right inlet)
```

### Dynamic time adjustment

Change the debounce window on the fly based on context.

```
[number]            [number]
|                   |
|                   [prepend time]
|                   |
[util.debounce 50 ----]
|
[print result]
```

## Implementation Notes

- Uses `#0`-scoped internal state (`v`, `s`, `r` objects) for instance isolation. Multiple instances in the same patch do not interfere.
- All message types (int, float, list, symbol) are preserved through the debounce buffer (`zl reg`).
- Deterministic message ordering is enforced via `trigger` objects throughout.
- The timer uses Max's `delay` object. Sending `stop` to the delay cancels a pending bang.

## See Also

- **delay** -- schedule a bang after N ms
- **pipe** -- delay any message by N ms (does not suppress duplicates)
- **speedlim** -- rate-limit output to at most one message per N ms (throttle, not debounce)
- **change** -- suppress repeated identical values (not time-based)
- **onebang** -- pass one bang then block until reset
- **defer** / **deferlow** -- reschedule messages to low-priority thread

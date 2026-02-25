# util.throttle

Rate-limit arbitrary messages: pass at most one message per interval. When messages arrive faster than the interval allows, a configurable policy determines what happens to messages received during cooldown. Three policies are available: **drop** (discard silently), **latest** (keep only the newest, emit when interval expires), and **queue** (buffer messages, emit one per interval).

## Inlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | any (int, float, list, symbol) | Message to throttle. The first message passes immediately; subsequent messages during cooldown are handled according to the active policy. |
| 2 | symbol (message) | Control messages: `interval`, `policy`, `capacity`, `flush`, `reset`, `bypass`. |

## Outlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | any | Throttled output. Messages that pass through the throttle (immediately or after cooldown). |
| 2 | symbol | Status messages: `passed` (message output immediately), `dropped` (message discarded), `queued` (message buffered), `flushed` (pending messages emitted via flush), `canceled` (pending messages cleared). |

## Arguments

| Argument | Type | Default | Description |
|----------|------|---------|-------------|
| 1 | int/float | 100 | Initial throttle interval in milliseconds. |

```
util.throttle        --> 100ms interval (default)
util.throttle 200    --> 200ms interval
util.throttle 50     --> 50ms interval
```

## Messages (Right Inlet)

### interval *ms*

Set the minimum time between outputs in milliseconds. Takes effect on the next cooldown cycle.

```
interval 100    --> 100ms between outputs
interval 500    --> 500ms between outputs
```

### policy *name*

Set the throttle policy. Determines what happens to messages received during cooldown.

```
policy drop     --> discard messages during cooldown (default)
policy latest   --> keep only the newest, emit when interval expires
policy queue    --> buffer messages, emit one per interval
```

### capacity *N*

Set the maximum queue size for `queue` policy. When the queue is full, new messages are silently dropped. Has no effect on `drop` or `latest` policies.

```
capacity 4      --> max 4 queued messages
capacity 16     --> max 16 queued messages (default: 8)
```

### flush

Immediately emit all pending messages (latest buffer and/or queued messages) and clear the cooldown timer. If nothing is pending, flush has no effect. Outputs `flushed` from outlet 2.

### reset

Clear all pending/queued messages, stop the timer, and restore default parameter values (`policy drop`, `capacity 8`). The interval is not changed by reset.

### bypass *0|1*

Enable or disable bypass mode. When bypassed, all input messages pass directly to outlet 1 without throttling. Enabling bypass (`bypass 1`) also cancels any pending messages and stops the cooldown timer.

```
bypass 1    --> cancel pending, pass all messages through immediately
bypass 0    --> resume throttling (default)
```

## Defaults

| Parameter | Default |
|-----------|---------|
| interval | 100 ms (or creation argument) |
| policy | drop |
| capacity | 8 |
| bypass | 0 (off) |

## Policies

| Policy | During Cooldown | On Timer Expire |
|--------|----------------|-----------------|
| `drop` | Message discarded, status `dropped` | Cooldown cleared, ready for next message |
| `latest` | Message stored (replaces previous), status `queued` | Stored message emitted, timer restarts if new data arrived |
| `queue` | Message appended to queue (up to capacity), status `queued` | Next queued message emitted, timer restarts until queue empty |

## Example Usage

### Rate-limit rapid UI changes

A number box sending values as the user drags. At most one value passes per 100ms.

```
[number]
|
[util.throttle 100]
|
[print throttled-value]
```

### Latest policy for smooth parameter control

Keep only the most recent value during cooldown. Ensures the final resting value is always output.

```
[slider]
|
[util.throttle 50]
|                    [message: policy latest]
[your-synth-param]   |
                     [util.throttle] (right inlet)
```

### Queue policy for ordered event processing

Process events one at a time with guaranteed ordering and no data loss.

```
[metro 10]
|
[counter 0 100]
|
[util.throttle 200]
|                    [message: policy queue]
[print event]        |
                     [util.throttle] (right inlet)
```

### Flush pending on demand

Use a long interval, accumulate with latest policy, then flush when needed.

```
[number]            [button]
|                   |
|                   [message: flush]
|                   |
[util.throttle 2000 ----]
|
[print result]
```

### Dynamic interval adjustment

Change the throttle interval on the fly based on context.

```
[number]            [number]
|                   |
|                   [prepend interval]
|                   |
[util.throttle 100 ----]
|
[print result]
```

## Implementation Notes

- Uses `#0`-scoped internal state (`v`, `s`, `r`, `coll` objects) for instance isolation. Multiple instances in the same patch do not interfere.
- All message types (int, float, list, symbol) are preserved through the throttle buffer (`zl reg` for latest, `coll` for queue).
- Deterministic message ordering is enforced via `trigger` objects throughout.
- The cooldown timer uses Max's `delay` object. Sending `stop` cancels a pending bang.
- Queue overflow (when queue reaches capacity) silently drops new messages. The queue uses FIFO ordering with `coll` renumbering.

## See Also

- **speedlim** -- built-in rate limiter (drop policy only, no queue or latest)
- **util.debounce** -- delay output until input quiet for N ms (complementary to throttle)
- **delay** -- schedule a bang after N ms
- **pipe** -- delay any message by N ms (does not rate-limit)
- **change** -- suppress repeated identical values (not time-based)
- **onebang** -- pass one bang then block until reset

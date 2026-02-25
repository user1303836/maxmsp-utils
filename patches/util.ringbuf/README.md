# util.ringbuf

Bounded ring buffer for messages with random access and dump. Stores up to N items in a circular history. When the buffer is full, the oldest item is overwritten. Supports integer, float, list, and symbol input. Retrieve items by index (0 = most recent) or dump the entire contents from oldest to newest.

## Inlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | any (int, float, list, symbol) | Message to store in the buffer (hot). |
| 2 | symbol (message) | Control messages: `get`, `dump`, `clear`, `capacity`, `size`, `reset`, `bypass`. |

## Outlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | any | Retrieved values (from get or dump). |
| 2 | symbol | Status messages: `full` (buffer reached capacity), `cleared` (buffer emptied), `size N` (current fill count). |

## Arguments

| Argument | Type | Default | Description |
|----------|------|---------|-------------|
| 1 | int | 16 | Initial buffer capacity (maximum number of stored items). |

```
util.ringbuf       --> 16-slot buffer (default)
util.ringbuf 4     --> 4-slot buffer
util.ringbuf 64    --> 64-slot buffer
```

## Messages (Right Inlet)

### get *index*

Retrieve the item at the given index. Index 0 is the most recently stored item, 1 is one before that, and so on. Out-of-range indices produce no output.

```
get         --> get most recent (index 0)
get 0       --> get most recent
get 3       --> get 4th most recent
```

### dump

Output all stored items from oldest to newest through outlet 1. Each item is output as a separate message.

### clear

Remove all stored items and reset the write pointer. Outputs `cleared` from outlet 2.

### capacity *N*

Set a new buffer capacity. If the new capacity differs from the current one, the buffer is cleared and resized. Minimum capacity is 1.

```
capacity 4      --> 4-slot buffer
capacity 32     --> 32-slot buffer
```

### size

Query the current number of stored items. Outputs `size N` from outlet 2.

### reset

Clear the buffer and restore the default capacity (16). Outputs `cleared` from outlet 2.

### bypass *0|1*

Enable or disable bypass mode. When bypassed, input messages pass directly to outlet 1 without being stored in the buffer.

```
bypass 1    --> pass messages through without storing
bypass 0    --> resume storing (default)
```

## Defaults

| Parameter | Default |
|-----------|---------|
| capacity | 16 (or creation argument) |
| bypass | 0 (off) |

## Behavior

- **Circular overwrite**: When the buffer is full, new items overwrite the oldest. The `full` status is output from outlet 2 when the buffer first reaches capacity.
- **Random access**: `get N` retrieves by recency index (0 = newest). Invalid indices are silently ignored.
- **Dump order**: `dump` outputs items from oldest to newest, each as a separate message.
- **Message preservation**: Integers, floats, lists, and symbols are all stored and retrieved faithfully. Single-element results are output as single values (not lists).
- **Capacity change**: Setting a new capacity clears the buffer. Setting the same capacity has no effect.

## Example Usage

### Store and recall recent values

```
[number]
|
[util.ringbuf 8]
|               |
[print value]   [print status]
```

Send `get 0` to the right inlet to retrieve the most recent value.

### MIDI note history

Keep a history of the last 16 MIDI notes played.

```
[notein]
|
[stripnote]
|
[util.ringbuf 16]
|
[print note-history]
```

### Undo buffer for parameter changes

Store parameter snapshots and recall previous states.

```
[your-param-value]
|
[util.ringbuf 32]
|                    [message: get 1]
[recall-previous]    |
                     [util.ringbuf] (right inlet)
```

## Implementation Notes

- Uses a `v8.codebox` (Max 9 V8 JavaScript engine) for the ring buffer logic. Modular arithmetic handles circular indexing efficiently.
- The `anything()` handler dispatches named control messages (get, dump, clear, capacity, size, reset) internally.
- Instance isolation is achieved through the V8 object's own state scope and `#0`-scoped `v` objects for bypass state.
- Supports all Max message types: int, float, list, and symbol.

## See Also

- **coll** -- indexed collection (persistent, file-backed, not circular)
- **zl reg** -- store and recall a single list
- **zl group** -- collect N items into a list
- **zl stream** -- sliding window over incoming items
- **buffer~** -- audio sample buffer (signal-rate, not message-rate)

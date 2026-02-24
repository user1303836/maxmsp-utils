# util.cache.ttl

Key-value cache with time-to-live expiration. Stores values under symbol keys and automatically expires them after a configurable TTL. Expired entries are lazily removed on access (get, has) or eagerly removed via sweep.

## Inlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | any (symbol, list) | Commands: `set`, `get`, `has`, `invalidate`, `clear`. |
| 2 | symbol (message) | Control messages: `ttl`, `bypass`, `sweep`, `reset`. |

## Outlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | list | Cache hits: `hit key value`. Output when `get` finds a valid (non-expired) entry. |
| 2 | any | Status/misses: `miss key` (entry not found or expired), `ok` (set succeeded), `invalidated key`, `cleared`, or `1`/`0` (has result). |
| 3 | list | Diagnostics: `size N` (number of entries remaining after sweep). |

## Arguments

| Argument | Type | Default | Description |
|----------|------|---------|-------------|
| 1 | int/float | 1000 | Initial TTL in milliseconds. |

```
util.cache.ttl          --> 1000ms TTL (default)
util.cache.ttl 5000     --> 5 second TTL
util.cache.ttl 60000    --> 1 minute TTL
```

## Commands (Left Inlet)

### set *key value*

Store a value under a symbol key. The entry expires after the current TTL elapses. Outputs `ok` from outlet 2.

```
set foo 42          --> store integer
set bar hello       --> store symbol
```

### get *key*

Retrieve a cached value. If the key exists and has not expired, outputs `hit key value` from outlet 1. If the key does not exist or has expired, outputs `miss key` from outlet 2. Expired entries are lazily deleted on access.

```
get foo             --> hit foo 42 (if valid)
get unknown         --> miss unknown
```

### has *key*

Check whether a key exists and is still valid. Outputs `1` from outlet 2 if the key exists and has not expired, `0` otherwise. Expired entries are lazily deleted on access.

```
has foo             --> 1 (exists and valid)
has unknown         --> 0 (not found)
```

### invalidate *key*

Remove a specific key from the cache immediately, regardless of its TTL. Outputs `invalidated key` from outlet 2.

```
invalidate foo      --> invalidated foo
```

### clear

Remove all entries from the cache. Outputs `cleared` from outlet 2.

## Messages (Right Inlet)

### ttl *ms*

Set the TTL in milliseconds. Applies to subsequent `set` commands; does not retroactively change existing entries.

```
ttl 500             --> 500ms expiry for new entries
ttl 30000           --> 30 second expiry for new entries
```

### sweep

Iterate all cached entries and remove any that have expired. After sweeping, outputs `size N` from outlet 3 with the number of remaining (valid) entries. Use this for periodic garbage collection or diagnostics.

### reset

Clear all entries and restore the TTL to the creation argument value.

### bypass *0|1*

Enable or disable bypass mode. When bypassed, the cache stores the bypass flag but behavior is otherwise unchanged in this version.

```
bypass 1            --> enable bypass
bypass 0            --> disable bypass (default)
```

## Defaults

| Parameter | Default |
|-----------|---------|
| ttl | 1000 ms (or creation argument) |
| bypass | 0 (off) |

## Example Usage

### Simple key-value store

```
[message: set name Max]
|
[util.cache.ttl 10000]
|                   \
[route hit]          [print status]
|
[print cached-value]
```

### Short-lived sensor cache

```
[your-sensor-data]
|
[prepend set sensor1]
|
[util.cache.ttl 200]
```

### Periodic sweep for diagnostics

```
[metro 5000]                        [your-commands]
|                                   |
[message: sweep]                    |
|                                   |
[util.cache.ttl 3000 ----------------]
|               |               |
[route hit]     [print status]  [print size]
```

## Implementation Notes

- Uses `#0`-scoped internal state (`v`, `dict` objects) for instance isolation. Multiple instances in the same patch do not interfere.
- Two parallel `dict` objects store values (`#0_values`) and expiry timestamps (`#0_expiry`). Keys are shared between both dicts.
- Timestamps are sourced from `cpuclock` (milliseconds since Max started). Expiry is computed as `cpuclock + ttl` at the time of `set`.
- Lazy expiry: `get` and `has` check the expiry timestamp before returning. If expired, the entry is deleted via internal `s #0_invalidate` and a miss is reported.
- Eager expiry: `sweep` iterates all keys in the expiry dict, compares each against the current time, and invalidates expired entries.
- Deterministic message ordering is enforced via `trigger` objects throughout.

## See Also

- **dict** -- key-value dictionary storage
- **coll** -- indexed collection (ordered, file-backed)
- **table** -- integer-indexed array storage
- **util.debounce** -- debounce rapid input (companion utility)

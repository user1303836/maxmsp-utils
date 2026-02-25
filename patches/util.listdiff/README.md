# util.listdiff

Compare an incoming list against the previously received list and output the differences. Produces three result lists: items added (present in new but not previous), items removed (present in previous but not new), and items common to both. Duplicate occurrences are tracked independently, so `1 1 2` compared against `1 2 2` correctly reports one `2` added and one `1` removed.

## Inlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | list (int, float, symbol) | List to compare. Triggers comparison against the stored previous list and then becomes the new previous list. |
| 2 | symbol (message) | Control messages: `reset`, `bypass`, `sorted`. |

## Outlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | list | Added items: elements in the new list that were not in the previous list. |
| 2 | list | Removed items: elements in the previous list that are not in the new list. |
| 3 | list | Common items: elements present in both lists. |
| 4 | bang | Bang when no changes are detected (added and removed are both empty). |

## Arguments

None. No creation arguments.

```
util.listdiff    --> compare incoming lists
```

## Messages (Right Inlet)

### reset

Clear the stored previous list. The next incoming list will be treated as the first list (all items reported as added, nothing removed).

### bypass *0|1*

Enable or disable bypass mode. When bypassed, the incoming list passes directly to outlet 1 without comparison. The stored previous list is not updated during bypass.

```
bypass 1    --> pass lists through outlet 1 unchanged
bypass 0    --> resume comparing (default)
```

### sorted *0|1*

Enable or disable sorted comparison mode. When enabled, both lists are sorted before comparison, making the diff order-independent. The original (unsorted) list is stored as the previous list.

```
sorted 1    --> sort before comparing (order-independent)
sorted 0    --> compare in original order (default)
```

## Defaults

| Parameter | Default |
|-----------|---------|
| bypass | 0 (off) |
| sorted | 0 (off) |

## Behavior

- **First list**: When no previous list is stored (after init or reset), all items in the incoming list are reported as "added" and nothing is "removed".
- **Duplicate handling**: Each occurrence is tracked independently using a bag (multiset) comparison. For example, `[1 1 2]` vs `[1 2 2]` reports added: `[2]`, removed: `[1]`, common: `[1 2]`.
- **Empty diff**: When the new list is identical to the previous (same elements, same counts), outlet 4 emits a bang and no output appears on outlets 1-3.
- **Storage**: After each comparison, the new list replaces the stored previous list.
- **Output order**: Results are output right-to-left (bang first, then common, removed, added) following Max convention.
- **Single items**: When a result contains exactly one item, it is output as a single value (not a list).

## Example Usage

### Track MIDI note changes

Compare the set of currently held notes against the previous set to detect note-ons and note-offs.

```
[your-note-collector]
|
[util.listdiff]
|         |         |
[added]   [removed] [still-held]
```

### Detect list changes with sorted mode

When order does not matter, enable sorted mode to ignore element ordering.

```
[message: 3 1 2]  [message: 1 2 3]
|                  |
[util.listdiff]    |
|                  [message: sorted 1]
|                  |
[print added]      [util.listdiff] (right inlet)
```

With `sorted 1`, sending `3 1 2` then `1 2 3` produces a bang on outlet 4 (no changes).

### Monitor parameter changes

Compare snapshots of parameter lists to find which parameters changed.

```
[your-param-snapshot]
|
[util.listdiff]
|              |
[changed]      [unchanged]
```

## Implementation Notes

- Uses a `v8.codebox` (Max 9 V8 JavaScript engine) for the duplicate-aware bag comparison algorithm. This ensures correct handling of duplicates without requiring complex `zl` chain logic.
- The previous list is stored internally in the V8 runtime. The `reset` message clears it.
- Instance isolation is achieved through the V8 object's own state scope and `#0`-scoped `v` objects for bypass state.
- Supports numeric values, floats, and symbols. Comparison uses string coercion for bag keys.

## See Also

- **zl sect** -- list intersection (set-based, no duplicate awareness)
- **zl union** -- list union
- **zl filter** -- filter elements from a list
- **array.sect** / **array.union** -- Max 9 array set operations
- **change** -- suppress repeated identical single values
- **== / !=** -- element-wise comparison of equal-length lists

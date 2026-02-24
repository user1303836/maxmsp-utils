# util.dict.defaults

Merge defaults into incoming dictionaries and validate required keys. Reduces repetitive dict merge/validation wiring in Max and Max4Live patches.

## Inlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | dictionary | Input dictionaries to process (via `dictionary <name>` messages). |
| 2 | symbol (message) | Control messages: `defaults`, `required`, `addrequired`, `clearrequired`, `force`, `reset`. |

## Outlets

| Index | Type | Description |
|-------|------|-------------|
| 1 | dictionary | Merged dictionary (`dictionary <name>`). Output always emits, even if required keys are missing. |
| 2 | any | Validation/status: `ok` (all required keys present), `missing <key1> <key2> ...` (missing required keys), `configured`, `reset`. |
| 3 | list | Diagnostics: `applied <n>` (defaults applied), `preserved <n>` (input keys preserved over defaults). |

## Arguments

| Argument | Type | Default | Description |
|----------|------|---------|-------------|
| 1 | int | 0 | Initial force mode. `0` = input wins, `1` = defaults overwrite. |

```
util.dict.defaults          --> force 0 (default, input wins)
util.dict.defaults 1        --> force 1 (defaults overwrite)
```

## Commands (Left Inlet)

### dictionary *name*

Process an input dictionary. The input dict is cloned into an internal working dict, defaults are merged according to the current force mode, required key validation runs, and the merged result is emitted from outlet 1.

```
dictionary my_input     --> merge defaults, validate, emit merged dict
```

## Messages (Right Inlet)

### defaults *dictname*

Set the defaults source dictionary. The contents of the named dict are imported into internal storage. Outputs `configured` from outlet 2.

```
defaults my_defaults    --> import defaults from dict named my_defaults
```

### required *key1 key2 ...*

Replace the required key list. All previously required keys are cleared first. Outputs `configured` from outlet 2.

```
required name color size    --> these keys must exist after merge
```

### addrequired *key1 ...*

Append keys to the required list without clearing existing entries. Outputs `configured` from outlet 2.

```
addrequired weight          --> add weight to required keys
```

### clearrequired

Remove all required keys. After this, validation always outputs `ok`. Outputs `configured` from outlet 2.

### force *0|1*

Set the merge mode.

- `force 0` (default): Input keys win. Defaults only fill missing keys.
- `force 1`: Defaults overwrite all matching input keys.

```
force 1                     --> defaults overwrite input keys
force 0                     --> input wins, defaults fill gaps only
```

### reset

Clear all internal state: defaults dict, required key list, and force flag (reset to 0). Outputs `reset` from outlet 2.

## Processing Semantics

1. Input dict is cloned into an internal working dict.
2. Default keys are iterated:
   - **force 0**: Each default key is checked against the working dict. If the key is missing, the default value is applied (`applied` count increments). If the key exists, it is preserved (`preserved` count increments).
   - **force 1**: All default key/value pairs are written into the working dict (`applied` count increments for each).
3. Required key validation runs against the merged working dict. Each required key is checked for presence. Missing keys are collected.
4. Output order (deterministic, enforced by `trigger`):
   - Outlet 2: validation status (`ok` or `missing <keys>`)
   - Outlet 3: diagnostics (`applied N`, `preserved N`)
   - Outlet 1: merged dictionary

The merged dictionary is always emitted, even if required keys are missing. This allows downstream logic to handle partial data if desired.

## Defaults

| Parameter | Default |
|-----------|---------|
| force | 0 (input wins) |
| required keys | (none) |
| defaults | (empty) |

## Example Usage

### Fill missing keys

```
[message: clear, set color blue, set size 10]
|
[dict my_defaults]

[message: defaults my_defaults]         [message: dictionary my_input]
|                                       |
[util.dict.defaults   -------------------]
|                     |               |
[dict.print]          [print status]  [print diagnostics]
```

Input `{color: red, name: test}` with defaults `{color: blue, size: 10}` produces:
- Merged: `{color: red, name: test, size: 10}` (color preserved, size applied)
- Status: `ok` (no required keys configured)
- Diagnostics: `applied 1`, `preserved 1`

### Validate required keys

```
[message: required color size weight]
|
[util.dict.defaults]
|               |
[dict.print]    [route ok missing]
                |           |
                [print ok]  [print missing-keys]
```

If merged dict has `color` and `size` but not `weight`:
- Status: `missing weight`

### Force mode

With `force 1`, defaults overwrite input keys:
- Input: `{color: red}`, Defaults: `{color: blue, size: 10}`
- Merged: `{color: blue, size: 10}` (color overwritten, size applied)
- Diagnostics: `applied 2`, `preserved 0`

## Implementation Notes

- Uses `#0`-scoped internal state (`v`, `dict`, `coll` objects) for instance isolation. Multiple instances in the same patch do not interfere.
- Internal dicts: `#0_defaults` (stores default key/value pairs), `#0_work` (working copy for merge operations).
- Required keys stored in `coll #0_required` (symbol keys, iterated via `dump`).
- Force flag stored in `v #0_force`.
- Merge counters stored in `v #0_applied` and `v #0_preserved`, reset to 0 before each merge operation.
- Deterministic message ordering enforced via `trigger` objects throughout.
- Top-level keys only; nested dict paths are not supported.

## See Also

- **dict** -- key-value dictionary storage
- **dict.iter** -- iterate dictionary keys and values
- **util.cache.ttl** -- key-value cache with time-to-live expiration
- **util.debounce** -- debounce rapid input (companion utility)

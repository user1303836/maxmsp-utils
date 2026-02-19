#!/usr/bin/env python3
"""Static validator for MaxMSP .maxpat files.

Catches structural errors, graph topology issues, signal/message mismatches,
M4L-specific problems, layout issues, and naming conflicts.

Usage:
    python3 tools/validate_maxpat.py [-v] path/to/patch.maxpat [more_patches...]

Exit codes: 0 = no errors, 1 = errors found, 2 = usage error.

Severity levels:
    ERROR   — patch will definitely not work correctly
    WARNING — likely a bug but could be intentional
    INFO    — convention violation that won't break anything
"""

import argparse
import json
import os
import struct
import sys
import time
from collections import Counter, defaultdict
from typing import Dict, List, NamedTuple, Optional, Tuple


# ---------------------------------------------------------------------------
# Verbose logging
# ---------------------------------------------------------------------------

_verbose = False


def vlog(message: str) -> None:
    """Print a verbose log message to stderr when verbose mode is enabled."""
    if _verbose:
        print(f"  [VERBOSE] {message}", file=sys.stderr)

# ---------------------------------------------------------------------------
# Data types
# ---------------------------------------------------------------------------

class Diagnostic(NamedTuple):
    level: str  # "error", "warning", or "info"
    patcher_path: str
    object_id: str
    message: str


ObjectInfo = Tuple[int, int, List[str]]

# ---------------------------------------------------------------------------
# Known object signatures (fixed inlet/outlet counts)
# ---------------------------------------------------------------------------

KNOWN_OBJECTS: Dict[str, Optional[ObjectInfo]] = {
    # MSP objects
    "cycle~":        (2, 1, ["signal"]),
    "noise~":        (1, 1, ["signal"]),
    "*~":            (2, 1, ["signal"]),
    "+~":            (2, 1, ["signal"]),
    "-~":            (2, 1, ["signal"]),
    "/~":            (2, 1, ["signal"]),
    "line~":         (2, 2, ["signal", "bang"]),
    "adsr~":         (5, 2, ["signal", "signal"]),
    "biquad~":       (6, 1, ["signal"]),
    "filtercoeff~":  (5, 6, ["signal"] * 6),
    "gain~":         (2, 2, ["signal", ""]),
    "plugin~":       (1, 2, ["signal", "signal"]),
    "plugout~":      (2, 0, []),
    "snapshot~":     (2, 1, ["float"]),
    "number~":       (2, 2, ["signal", "float"]),
    "peakamp~":      (2, 1, ["float"]),
    "sig~":          (1, 1, ["signal"]),
    "tapin~":        (1, 1, ["signal"]),
    "delay~":        (2, 1, ["signal"]),
    "lores~":        (3, 1, ["signal"]),
    "reson~":        (4, 1, ["signal"]),
    "svf~":          (3, 4, ["signal", "signal", "signal", "signal"]),
    "phasor~":       (2, 1, ["signal"]),
    "rect~":         (2, 1, ["signal"]),
    "saw~":          (2, 1, ["signal"]),
    "tri~":          (2, 1, ["signal"]),
    "clip~":         (3, 1, ["signal"]),
    "avg~":          (2, 1, ["signal"]),
    "abs~":          (1, 1, ["signal"]),
    "sqrt~":         (1, 1, ["signal"]),
    "pow~":          (2, 1, ["signal"]),
    "log~":          (2, 1, ["signal"]),
    "exp~":          (1, 1, ["signal"]),
    "dac~":          (2, 0, []),
    "adc~":          (0, 2, ["signal", "signal"]),
    "groove~":       (4, 3, ["signal", "signal", "signal"]),
    "play~":         (2, 1, ["signal"]),
    "wave~":         (3, 1, ["signal"]),
    "index~":        (2, 1, ["signal"]),
    "record~":       (3, 1, ["signal"]),
    "buffer~":       (1, 2, ["float", "bang"]),
    "info~":         (1, 4, ["float", "int", "int", ""]),
    "slide~":        (3, 1, ["signal"]),
    "average~":      (2, 1, [""]),
    "loudness~":     (1, 4, ["float", "float", "float", "float"]),

    # Max message objects
    "midiin":        (1, 1, ["int"]),
    "midiout":       (1, 0, []),
    "midiparse":     (1, 7, [""] * 7),
    "midiformat":    (7, 1, ["int"]),
    "metro":         (2, 1, ["bang"]),
    "counter":       (5, 4, ["int", "", "", "int"]),
    "notein":        (1, 3, ["int", "int", "int"]),
    "noteout":       (3, 0, []),
    "ctlin":         (1, 3, ["int", "int", "int"]),
    "ctlout":        (3, 0, []),
    "bendin":        (1, 2, ["int", "int"]),
    "bendout":       (2, 0, []),
    "pgmin":         (1, 2, ["int", "int"]),
    "pgmout":        (2, 0, []),
    "borax":         (3, 7, ["int"] * 7),
    "flush":         (1, 2, ["int", "int"]),
    "bag":           (1, 2, ["int", "bang"]),
    "thresh":        (1, 2, ["", ""]),
    "scale":         (6, 1, [""]),
    "loadbang":      (0, 1, ["bang"]),
    "deferlow":      (1, 1, [""]),
    "defer":         (1, 1, [""]),
    "change":        (1, 2, ["", "int"]),
    "speedlim":      (2, 1, [""]),
    "coll":          (1, 4, ["", "", "", ""]),
    "dict":          (2, 2, ["", ""]),
    "print":         (1, 0, []),
    "prepend":       (2, 1, [""]),
    "append":        (2, 1, [""]),
    "stripnote":     (2, 2, ["int", "int"]),
    "makenote":      (3, 2, ["int", "int"]),
    "pipe":          None,
    "delay":         (2, 1, ["bang"]),
    "random":        (2, 1, ["int"]),
    "drunk":         (3, 1, ["int"]),
    "urn":           (2, 2, ["int", "bang"]),
    "decide":        (1, 1, ["int"]),
    "maximum":       (2, 2, ["int", "int"]),
    "minimum":       (2, 2, ["int", "int"]),
    "split":         (2, 2, ["int", "int"]),
    "swap":          (2, 2, ["int", "int"]),
    "buddy":         None,
    "spray":         None,
    "funnel":        None,
    "iter":          (1, 1, [""]),
    "join":          None,
    "togedge":       (1, 2, ["bang", "bang"]),
    "onebang":       (2, 1, ["bang"]),
    "past":          (2, 1, ["bang"]),
    "accum":         (3, 1, [""]),
    "sprintf":       None,
    "regexp":        (2, 5, ["", "", "", "", ""]),
    "pcontrol":      (1, 1, [""]),
    "v8":            None,
    "js":            None,
    "gen~":          None,
    "mc.cycle~":     None,
    "mc.noise~":     None,
    "mc.gain~":      None,
    "mc.mix~":       None,
    "poly~":         None,
    "if":            None,

    # send/receive
    "send":          (1, 0, []),
    "s":             (1, 0, []),
    "receive":       (0, 1, [""]),
    "r":             (0, 1, [""]),
    "send~":         (1, 0, []),
    "receive~":      (0, 1, ["signal"]),
    "r~":            (0, 1, ["signal"]),
    "s~":            (1, 0, []),

    # zl family
    "zl":            (2, 2, ["", ""]),

    # live API
    "live.thisdevice": (1, 2, ["", "int"]),
    "live.path":     (1, 3, ["", "", ""]),
    "live.object":   (2, 2, ["", ""]),
    "live.observer": (2, 3, ["", "", ""]),
    "live.remote~":  (3, 1, [""]),

    # pattr family
    "pattr":         (1, 2, ["", ""]),
    "autopattr":     (1, 0, []),
    "pattrstorage":  (1, 2, ["", ""]),

    # value
    "value":         (1, 1, [""]),
    "v":             (1, 1, [""]),

    # forward
    "forward":       (1, 0, []),
}

MAXCLASS_DEFAULTS: Dict[str, Optional[ObjectInfo]] = {
    "message":       (2, 1, [""]),
    "comment":       (1, 0, []),
    "number":        (1, 2, ["", "bang"]),
    "flonum":        (1, 2, ["", "bang"]),
    "button":        (1, 1, ["bang"]),
    "toggle":        (1, 1, ["int"]),
    "slider":        (1, 1, [""]),
    "dial":          (1, 1, [""]),
    "inlet":         (0, 1, [""]),
    "outlet":        (1, 0, []),
    "ezdac~":        (2, 0, []),
    "ezadc~":        (0, 2, ["signal", "signal"]),
    "gain~":         (2, 2, ["signal", ""]),
    "spectroscope~": (2, 1, [""]),
    "scope~":        (2, 1, [""]),
    "bpatcher":      None,
    "live.dial":     (1, 2, ["", "float"]),
    "live.slider":   (1, 2, ["", "float"]),
    "live.toggle":   (1, 1, ["int"]),
    "live.menu":     (1, 1, ["int"]),
    "live.numbox":   (1, 2, ["", "float"]),
    "live.tab":      (1, 1, ["int"]),
    "live.button":   (1, 1, ["bang"]),
    "live.text":     (1, 1, ["int"]),
    "live.thisdevice": (1, 2, ["", "int"]),
    "multislider":   (2, 2, ["", ""]),
    "preset":        (1, 1, [""]),
    "kslider":       (2, 2, ["int", "int"]),
    "nslider":       (1, 2, ["int", ""]),
    "matrixctrl":    (2, 2, ["", ""]),
    "panel":         (1, 0, []),
    "textedit":      (1, 4, ["", "", "", ""]),
    "umenu":         (1, 4, ["int", "", "", ""]),
    "waveform~":     (5, 3, ["float", "float", "float"]),
    "nodes":         (1, 4, ["", "", "", ""]),
    "attrui":        (1, 1, [""]),
    "fpic":          (1, 0, []),
    "live.banks":    (1, 0, []),
}

# ---------------------------------------------------------------------------
# Constants for new checks
# ---------------------------------------------------------------------------

# Objects whose outputs are asynchronous (break synchronous message flow)
ASYNC_BREAK_OBJECTS = frozenset({
    "pipe", "delay", "deferlow", "defer", "schedule",
    "metro", "clocker", "line",
})

# Objects that are natural endpoints (no outgoing connections expected)
TERMINAL_OBJECTS = frozenset({
    "print", "midiout", "send", "s", "send~", "s~",
    "dac~", "ezdac~", "plugout~", "outlet",
    "noteout", "ctlout", "bendout", "pgmout",
    "forward", "pcontrol",
})

# Maxclasses that are passive/decorative (ok to be orphaned)
PASSIVE_MAXCLASSES = frozenset({
    "comment", "panel", "fpic", "live.banks",
})

# Objects that connect wirelessly (ok to have no patch cord connections)
WIRELESS_OBJECTS = frozenset({
    "send", "s", "receive", "r", "send~", "s~", "receive~", "r~",
    "forward", "pattr", "autopattr", "pattrstorage",
    "value", "v",
})

# Known prefixes for object families (not flagged as unknown)
KNOWN_PREFIXES = frozenset({
    "mc.", "abl.", "array.", "string.", "jit.",
    "dict.", "coll.", "text.", "node.", "v8.",
    "gen.", "live.", "sfizz",
})

# ---------------------------------------------------------------------------
# Dynamic resolvers for argument-dependent objects
# ---------------------------------------------------------------------------

def _resolve_trigger(args: List[str]) -> ObjectInfo:
    if not args:
        args = ["b", "b"]
    type_map = {"b": "bang", "i": "int", "f": "float", "s": "", "l": ""}
    outlettypes = [type_map.get(a, "") for a in args]
    return (1, len(args), outlettypes)


def _resolve_route(args: List[str]) -> ObjectInfo:
    n = max(len(args), 1)
    return (1, n + 1, [""] * (n + 1))


def _resolve_sel(args: List[str]) -> ObjectInfo:
    n = max(len(args), 1)
    return (1, n + 1, ["bang"] * n + [""])


def _resolve_gate(args: List[str]) -> ObjectInfo:
    n = int(args[0]) if args and args[0].isdigit() else 1
    return (2, n, [""] * n)


def _resolve_gate_signal(args: List[str]) -> ObjectInfo:
    n = int(args[0]) if args and args[0].isdigit() else 1
    return (2, n, ["signal"] * n)


def _resolve_switch(args: List[str]) -> ObjectInfo:
    n = int(args[0]) if args and args[0].isdigit() else 2
    return (n + 1, 1, [""])


def _resolve_selector_signal(args: List[str]) -> ObjectInfo:
    n = int(args[0]) if args and args[0].isdigit() else 2
    return (n + 1, 1, ["signal"])


def _resolve_pack(args: List[str]) -> ObjectInfo:
    n = max(len(args), 2)
    return (n, 1, [""])


def _resolve_unpack(args: List[str]) -> ObjectInfo:
    n = max(len(args), 2)
    type_map = {"i": "int", "f": "float", "s": ""}
    outlettypes = []
    for a in args:
        if a in type_map:
            outlettypes.append(type_map[a])
        else:
            try:
                float(a)
                outlettypes.append("int" if "." not in a else "float")
            except ValueError:
                outlettypes.append("")
    while len(outlettypes) < n:
        outlettypes.append("int")
    return (1, n, outlettypes)


def _resolve_tapout(args: List[str]) -> ObjectInfo:
    n = 0
    for a in args:
        try:
            float(a)
            n += 1
        except ValueError:
            break
    n = max(n, 1)
    return (1, n, ["signal"] * n)


def _resolve_bangbang(args: List[str]) -> ObjectInfo:
    n = int(args[0]) if args and args[0].isdigit() else 2
    return (1, n, ["bang"] * n)


DYNAMIC_RESOLVERS = {
    "trigger":    _resolve_trigger,
    "t":          _resolve_trigger,
    "route":      _resolve_route,
    "sel":        _resolve_sel,
    "select":     _resolve_sel,
    "gate":       _resolve_gate,
    "gate~":      _resolve_gate_signal,
    "switch":     _resolve_switch,
    "selector~":  _resolve_selector_signal,
    "pack":       _resolve_pack,
    "unpack":     _resolve_unpack,
    "tapout~":    _resolve_tapout,
    "bangbang":   _resolve_bangbang,
    "b":          _resolve_bangbang,
}

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def get_object_name(box: dict) -> str:
    maxclass = box.get("maxclass", "")
    if maxclass == "newobj":
        text = box.get("text", "")
        if text:
            return text.split()[0]
        return ""
    return maxclass


def get_object_args(box: dict) -> List[str]:
    text = box.get("text", "")
    if not text:
        return []
    parts = text.split()
    if len(parts) <= 1:
        return []
    args = []
    for p in parts[1:]:
        if p.startswith("@"):
            break
        args.append(p)
    return args


def resolve_object_info(box: dict) -> Optional[ObjectInfo]:
    maxclass = box.get("maxclass", "")
    if maxclass != "newobj":
        return MAXCLASS_DEFAULTS.get(maxclass)
    name = get_object_name(box)
    if not name:
        return None
    if name in DYNAMIC_RESOLVERS:
        args = get_object_args(box)
        return DYNAMIC_RESOLVERS[name](args)
    info = KNOWN_OBJECTS.get(name)
    return info


def _detect_m4l(patcher: dict, filepath: str = "") -> bool:
    """Check if this looks like a Max4Live device."""
    if filepath.endswith(".amxd"):
        return True
    indicators = {"plugin~", "plugout~", "live.thisdevice"}
    for item in patcher.get("boxes", []):
        box = item.get("box", {})
        name = get_object_name(box)
        maxclass = box.get("maxclass", "")
        if name in indicators or maxclass.startswith("live."):
            return True
    return False


def _unwrap_boxes(patcher: dict) -> List[dict]:
    raw = patcher.get("boxes", [])
    return [item["box"] for item in raw if isinstance(item, dict) and "box" in item]


def _unwrap_lines(patcher: dict) -> List[dict]:
    raw = patcher.get("lines", [])
    return [item["patchline"] for item in raw
            if isinstance(item, dict) and "patchline" in item]


# ---------------------------------------------------------------------------
# Validation checks: Structural (original)
# ---------------------------------------------------------------------------

def check_required_fields(boxes: List[dict], patcher_path: str) -> List[Diagnostic]:
    diags: List[Diagnostic] = []
    required = ["id", "maxclass", "numinlets", "numoutlets", "patching_rect"]
    for box in boxes:
        box_id = box.get("id", "<no id>")
        for field in required:
            if field not in box:
                diags.append(Diagnostic(
                    "error", patcher_path, box_id,
                    f"missing required field '{field}'"
                ))
    return diags


def check_duplicate_ids(boxes: List[dict], patcher_path: str) -> List[Diagnostic]:
    diags: List[Diagnostic] = []
    counts = Counter(box.get("id", "") for box in boxes)
    for obj_id, count in counts.items():
        if count > 1:
            diags.append(Diagnostic(
                "error", patcher_path, "",
                f"duplicate object ID '{obj_id}' (appears {count} times)"
            ))
    return diags


def check_outlettype_length(boxes: List[dict], patcher_path: str) -> List[Diagnostic]:
    diags: List[Diagnostic] = []
    for box in boxes:
        outlettype = box.get("outlettype")
        if outlettype is None:
            continue
        numoutlets = box.get("numoutlets", 0)
        if len(outlettype) != numoutlets:
            diags.append(Diagnostic(
                "warning", patcher_path, box.get("id", "<no id>"),
                f"outlettype has {len(outlettype)} entries but numoutlets is {numoutlets}"
            ))
    return diags


def check_patchline_refs(
    boxes: List[dict], lines: List[dict], patcher_path: str
) -> List[Diagnostic]:
    diags: List[Diagnostic] = []
    valid_ids = {box.get("id") for box in boxes}
    for line in lines:
        src = line.get("source", [])
        dst = line.get("destination", [])
        if len(src) >= 1 and src[0] not in valid_ids:
            diags.append(Diagnostic(
                "error", patcher_path, "",
                f"patchline source '{src[0]}' not found in boxes"
            ))
        if len(dst) >= 1 and dst[0] not in valid_ids:
            diags.append(Diagnostic(
                "error", patcher_path, "",
                f"patchline destination '{dst[0]}' not found in boxes"
            ))
    return diags


def check_index_bounds(
    boxes: List[dict], lines: List[dict], patcher_path: str
) -> List[Diagnostic]:
    diags: List[Diagnostic] = []
    box_map = {box.get("id"): box for box in boxes}
    for line in lines:
        src = line.get("source", [])
        dst = line.get("destination", [])
        if len(src) >= 2:
            src_box = box_map.get(src[0])
            if src_box is not None:
                numoutlets = src_box.get("numoutlets", 0)
                if src[1] >= numoutlets:
                    diags.append(Diagnostic(
                        "error", patcher_path, src[0],
                        f"outlet index {src[1]} out of bounds "
                        f"(numoutlets={numoutlets})"
                    ))
        if len(dst) >= 2:
            dst_box = box_map.get(dst[0])
            if dst_box is not None:
                numinlets = dst_box.get("numinlets", 0)
                if dst[1] >= numinlets:
                    diags.append(Diagnostic(
                        "error", patcher_path, dst[0],
                        f"inlet index {dst[1]} out of bounds "
                        f"(numinlets={numinlets})"
                    ))
    return diags


def check_signal_compat(
    boxes: List[dict], lines: List[dict], patcher_path: str
) -> List[Diagnostic]:
    diags: List[Diagnostic] = []
    box_map = {box.get("id"): box for box in boxes}
    signal_accepting = {"gain~", "ezdac~", "spectroscope~", "scope~", "waveform~"}
    transparent = {"inlet", "outlet"}
    for line in lines:
        src = line.get("source", [])
        dst = line.get("destination", [])
        if len(src) < 2 or len(dst) < 2:
            continue
        src_box = box_map.get(src[0])
        dst_box = box_map.get(dst[0])
        if src_box is None or dst_box is None:
            continue
        outlettype = src_box.get("outlettype", [])
        outlet_idx = src[1]
        if outlet_idx >= len(outlettype):
            continue
        if outlettype[outlet_idx] != "signal":
            continue
        dst_name = get_object_name(dst_box)
        if "~" in dst_name:
            continue
        dst_outlettype = dst_box.get("outlettype", [])
        if "signal" in dst_outlettype:
            continue
        dst_maxclass = dst_box.get("maxclass", "")
        if dst_maxclass in signal_accepting or dst_maxclass in transparent:
            continue
        diags.append(Diagnostic(
            "warning", patcher_path, "",
            f"signal outlet {src[0]}[{outlet_idx}] \u2192 message-rate object "
            f"'{dst_name}' ({dst[0]})"
        ))
    return diags


def check_declared_vs_expected(
    boxes: List[dict], patcher_path: str
) -> List[Diagnostic]:
    diags: List[Diagnostic] = []
    for box in boxes:
        info = resolve_object_info(box)
        if info is None:
            continue
        expected_in, expected_out, _ = info
        actual_in = box.get("numinlets", 0)
        actual_out = box.get("numoutlets", 0)
        box_id = box.get("id", "<no id>")
        name = get_object_name(box)
        if actual_in != expected_in:
            diags.append(Diagnostic(
                "warning", patcher_path, box_id,
                f"'{name}' has numinlets={actual_in} but expected {expected_in}"
            ))
        if actual_out != expected_out:
            diags.append(Diagnostic(
                "warning", patcher_path, box_id,
                f"'{name}' has numoutlets={actual_out} but expected {expected_out}"
            ))
    return diags


# ---------------------------------------------------------------------------
# Validation checks: Graph topology
# ---------------------------------------------------------------------------

def check_message_domain_cycles(
    boxes: List[dict], lines: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Detect cycles in the message-rate connection graph."""
    diags: List[Diagnostic] = []
    box_map = {box.get("id"): box for box in boxes}

    # Build adjacency list for message-domain connections only
    adj: Dict[str, set] = defaultdict(set)
    for line in lines:
        src = line.get("source", [])
        dst = line.get("destination", [])
        if len(src) < 2 or len(dst) < 2:
            continue
        src_id, outlet_idx = src[0], src[1]
        dst_id = dst[0]
        src_box = box_map.get(src_id)
        if src_box is None:
            continue
        # Skip signal-rate connections
        outlettype = src_box.get("outlettype", [])
        if outlet_idx < len(outlettype) and outlettype[outlet_idx] == "signal":
            continue
        # Skip outgoing edges from async-break objects
        src_name = get_object_name(src_box)
        if src_name in ASYNC_BREAK_OBJECTS:
            continue
        adj[src_id].add(dst_id)

    # Collect all nodes
    all_nodes = set(adj.keys())
    for targets in adj.values():
        all_nodes.update(targets)

    # Iterative DFS for back-edge (cycle) detection
    WHITE, GRAY, BLACK = 0, 1, 2
    color: Dict[str, int] = {}
    reported: set = set()

    for start in sorted(all_nodes):
        if color.get(start, WHITE) != WHITE:
            continue
        stack = [(start, iter(sorted(adj.get(start, set()))))]
        path = [start]
        color[start] = GRAY

        while stack:
            _node, children_iter = stack[-1]
            advanced = False
            for child in children_iter:
                if color.get(child, WHITE) == GRAY:
                    idx = path.index(child)
                    cycle_key = tuple(sorted(path[idx:]))
                    if cycle_key not in reported:
                        reported.add(cycle_key)
                        cycle_str = " \u2192 ".join(path[idx:] + [child])
                        diags.append(Diagnostic(
                            "warning", patcher_path, "",
                            f"message-domain cycle: {cycle_str}"
                        ))
                elif color.get(child, WHITE) == WHITE:
                    color[child] = GRAY
                    path.append(child)
                    stack.append(
                        (child, iter(sorted(adj.get(child, set()))))
                    )
                    advanced = True
                    break
            if not advanced:
                color[stack[-1][0]] = BLACK
                path.pop()
                stack.pop()

    return diags


def check_orphaned_objects(
    boxes: List[dict], lines: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Warn about functional objects with zero connections."""
    diags: List[Diagnostic] = []
    connected_ids: set = set()
    for line in lines:
        src = line.get("source", [])
        dst = line.get("destination", [])
        if src:
            connected_ids.add(src[0])
        if dst:
            connected_ids.add(dst[0])

    for box in boxes:
        box_id = box.get("id", "")
        if box_id in connected_ids:
            continue
        maxclass = box.get("maxclass", "")
        if maxclass in PASSIVE_MAXCLASSES:
            continue
        numinlets = box.get("numinlets", 0)
        numoutlets = box.get("numoutlets", 0)
        if numinlets == 0 and numoutlets == 0:
            continue
        name = get_object_name(box)
        if name in WIRELESS_OBJECTS:
            continue
        diags.append(Diagnostic(
            "warning", patcher_path, box_id,
            f"orphaned object '{name}' has no connections"
        ))
    return diags


def check_multiple_inlet_connections(
    boxes: List[dict], lines: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Warn when multiple connections feed the same inlet."""
    diags: List[Diagnostic] = []
    box_map = {box.get("id"): box for box in boxes}
    inlet_counts: Counter = Counter()
    for line in lines:
        dst = line.get("destination", [])
        if len(dst) >= 2:
            inlet_counts[(dst[0], dst[1])] += 1

    for (obj_id, inlet_idx), count in inlet_counts.items():
        if count <= 1:
            continue
        box = box_map.get(obj_id)
        name = get_object_name(box) if box else obj_id
        diags.append(Diagnostic(
            "warning", patcher_path, obj_id,
            f"inlet {inlet_idx} of '{name}' has {count} incoming connections"
        ))
    return diags


def check_fanout_missing_order(
    boxes: List[dict], lines: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Warn when fan-out connections lack order fields."""
    diags: List[Diagnostic] = []
    box_map = {box.get("id"): box for box in boxes}
    fanouts: Dict[tuple, list] = defaultdict(list)
    for line in lines:
        src = line.get("source", [])
        if len(src) >= 2:
            fanouts[(src[0], src[1])].append(line)

    for (obj_id, outlet_idx), conns in fanouts.items():
        if len(conns) <= 1:
            continue
        missing = [c for c in conns if "order" not in c]
        if not missing:
            continue
        box = box_map.get(obj_id)
        name = get_object_name(box) if box else obj_id
        diags.append(Diagnostic(
            "warning", patcher_path, obj_id,
            f"fan-out from '{name}' outlet {outlet_idx}: "
            f"{len(missing)} of {len(conns)} connections missing 'order' "
            f"(ambiguous execution order)"
        ))
    return diags


# ---------------------------------------------------------------------------
# Validation checks: Subpatcher integrity
# ---------------------------------------------------------------------------

def check_subpatcher_port_indices(
    child_boxes: List[dict], child_path: str, classnamespace: str
) -> List[Diagnostic]:
    """Check inlet/outlet indices are contiguous 1-based with no gaps."""
    diags: List[Diagnostic] = []

    if classnamespace == "dsp.gen":
        in_indices: List[int] = []
        out_indices: List[int] = []
        for box in child_boxes:
            if box.get("maxclass") != "newobj":
                continue
            parts = box.get("text", "").split()
            if len(parts) >= 2:
                try:
                    idx = int(parts[1])
                except ValueError:
                    continue
                if parts[0] == "in":
                    in_indices.append(idx)
                elif parts[0] == "out":
                    out_indices.append(idx)
    else:
        in_indices = []
        out_indices = []
        for box in child_boxes:
            mc = box.get("maxclass", "")
            idx = box.get("index")
            if idx is None:
                continue
            if mc == "inlet":
                in_indices.append(idx)
            elif mc == "outlet":
                out_indices.append(idx)

    for label, indices in [("inlet", in_indices), ("outlet", out_indices)]:
        if not indices:
            continue
        sorted_idx = sorted(indices)
        expected = list(range(1, max(sorted_idx) + 1))
        if sorted_idx != expected:
            missing = sorted(set(expected) - set(sorted_idx))
            dupes = sorted(i for i, c in Counter(sorted_idx).items() if c > 1)
            parts = []
            if missing:
                parts.append(f"missing: {missing}")
            if dupes:
                parts.append(f"duplicates: {dupes}")
            diags.append(Diagnostic(
                "error", child_path, "",
                f"{label} index gap ({'; '.join(parts)})"
            ))
    return diags


def check_subpatcher_port_count(
    parent_box: dict, child_boxes: List[dict],
    child_path: str, classnamespace: str
) -> List[Diagnostic]:
    """Check parent numinlets/numoutlets matches child port object count."""
    diags: List[Diagnostic] = []
    parent_text = parent_box.get("text", "")
    # Skip poly~/pfft~ — complex parent-child port relationship
    first_word = parent_text.split()[0] if parent_text else ""
    if first_word in ("poly~", "pfft~"):
        return diags

    if classnamespace == "dsp.gen":
        child_in = sum(
            1 for b in child_boxes
            if b.get("maxclass") == "newobj"
            and b.get("text", "").split()[0] == "in"
        )
        child_out = sum(
            1 for b in child_boxes
            if b.get("maxclass") == "newobj"
            and b.get("text", "").split()[0] == "out"
        )
    else:
        child_in = sum(1 for b in child_boxes if b.get("maxclass") == "inlet")
        child_out = sum(
            1 for b in child_boxes if b.get("maxclass") == "outlet"
        )

    parent_in = parent_box.get("numinlets", 0)
    parent_out = parent_box.get("numoutlets", 0)

    if child_in != parent_in:
        diags.append(Diagnostic(
            "error", child_path, "",
            f"parent declares {parent_in} inlets but subpatcher has "
            f"{child_in} inlet objects"
        ))
    if child_out != parent_out:
        diags.append(Diagnostic(
            "error", child_path, "",
            f"parent declares {parent_out} outlets but subpatcher has "
            f"{child_out} outlet objects"
        ))
    return diags


def check_recursion_depth(depth: int, patcher_path: str) -> List[Diagnostic]:
    """Flag subpatchers nested beyond 5 levels."""
    if depth > 5:
        return [Diagnostic(
            "warning", patcher_path, "",
            f"subpatcher nested {depth} levels deep "
            f"(likely a generation artifact)"
        )]
    return []


# ---------------------------------------------------------------------------
# Validation checks: M4L-specific
# ---------------------------------------------------------------------------

def check_loadbang_count(
    boxes: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Warn if multiple loadbangs exist at the same patcher level."""
    count = sum(1 for b in boxes if get_object_name(b) == "loadbang")
    if count > 1:
        return [Diagnostic(
            "warning", patcher_path, "",
            f"{count} loadbang objects at same patcher level "
            f"(execution order between them is undefined)"
        )]
    return []


def check_observer_deferlow(
    boxes: List[dict], lines: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Warn if live.observer connects directly to live.object."""
    diags: List[Diagnostic] = []
    box_map = {box.get("id"): box for box in boxes}
    observer_ids = {
        box.get("id") for box in boxes
        if get_object_name(box) == "live.observer"
    }
    object_ids = {
        box.get("id") for box in boxes
        if get_object_name(box) == "live.object"
    }
    if not observer_ids or not object_ids:
        return diags

    for line in lines:
        src = line.get("source", [])
        dst = line.get("destination", [])
        if len(src) >= 1 and len(dst) >= 1:
            if src[0] in observer_ids and dst[0] in object_ids:
                diags.append(Diagnostic(
                    "warning", patcher_path, "",
                    f"live.observer ({src[0]}) connected directly to "
                    f"live.object ({dst[0]}) without deferlow"
                ))
    return diags


def check_send_receive_prefix(
    boxes: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Info: send/receive names missing --- prefix in M4L."""
    diags: List[Diagnostic] = []
    sr_names = {"send", "s", "receive", "r"}
    for box in boxes:
        name = get_object_name(box)
        if name not in sr_names:
            continue
        args = get_object_args(box)
        if not args:
            continue
        sr_name = args[0]
        if not sr_name.startswith("---"):
            diags.append(Diagnostic(
                "info", patcher_path, box.get("id", ""),
                f"send/receive name '{sr_name}' missing '---' prefix "
                f"(needed for M4L instance isolation)"
            ))
    return diags


def check_noteout_in_m4l(
    boxes: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Warn: noteout should be midiout in M4L."""
    diags: List[Diagnostic] = []
    for box in boxes:
        if get_object_name(box) == "noteout":
            diags.append(Diagnostic(
                "warning", patcher_path, box.get("id", ""),
                "'noteout' should be 'midiout' in Max4Live devices"
            ))
    return diags


def check_parameter_registry(
    root_data: dict, root_boxes: List[dict]
) -> List[Diagnostic]:
    """Cross-reference parameter_enable boxes with parameters registry."""
    diags: List[Diagnostic] = []
    parameters = root_data.get("patcher", {}).get("parameters", {})
    if not parameters:
        return diags

    param_entries = {k: v for k, v in parameters.items() if k.startswith("obj-")}
    box_ids = {box.get("id") for box in root_boxes}
    param_enabled_ids = {
        box.get("id") for box in root_boxes
        if box.get("parameter_enable") == 1
    }

    # Entries must reference existing boxes
    for obj_id in param_entries:
        if obj_id not in box_ids:
            diags.append(Diagnostic(
                "error", "root", "",
                f"parameters registry references '{obj_id}' "
                f"which doesn't exist in boxes"
            ))

    # Boxes with parameter_enable must have registry entry
    for obj_id in param_enabled_ids:
        if obj_id not in param_entries:
            diags.append(Diagnostic(
                "error", "root", obj_id,
                "has parameter_enable=1 but no entry in parameters registry"
            ))

    # Parameter longnames must be unique
    longnames: Dict[str, str] = {}
    for obj_id, entry in param_entries.items():
        if isinstance(entry, list) and len(entry) >= 1:
            longname = entry[0]
            if longname in longnames:
                diags.append(Diagnostic(
                    "error", "root", obj_id,
                    f"duplicate parameter longname '{longname}' "
                    f"(also used by {longnames[longname]})"
                ))
            else:
                longnames[longname] = obj_id

    return diags


def check_openinpresentation(root_patcher: dict) -> List[Diagnostic]:
    """Info: M4L devices should open in presentation mode."""
    if root_patcher.get("openinpresentation", 0) != 1:
        return [Diagnostic(
            "info", "root", "",
            "openinpresentation is not enabled "
            "(M4L devices should open in presentation mode)"
        )]
    return []


# ---------------------------------------------------------------------------
# Validation checks: Layout / coordinates
# ---------------------------------------------------------------------------

def check_overlapping_rects(
    boxes: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Info: objects at the exact same position (copy-paste artifact)."""
    diags: List[Diagnostic] = []
    positions: Dict[tuple, list] = defaultdict(list)
    for box in boxes:
        rect = box.get("patching_rect", [])
        if len(rect) >= 2:
            positions[(rect[0], rect[1])].append(box.get("id", "?"))

    for (x, y), ids in positions.items():
        if len(ids) > 1:
            diags.append(Diagnostic(
                "info", patcher_path, "",
                f"objects at same position ({x}, {y}): {', '.join(ids)}"
            ))
    return diags


def check_non_integer_coords(
    boxes: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Info: non-integer coordinates in patching_rect."""
    diags: List[Diagnostic] = []
    labels = ["x", "y", "width", "height"]
    for box in boxes:
        rect = box.get("patching_rect", [])
        box_id = box.get("id", "?")
        non_int = []
        for i, val in enumerate(rect):
            if isinstance(val, float) and val != int(val):
                label = labels[i] if i < len(labels) else f"[{i}]"
                non_int.append(f"{label}={val}")
        if non_int:
            diags.append(Diagnostic(
                "info", patcher_path, box_id,
                f"non-integer coordinates: {', '.join(non_int)}"
            ))
    return diags


# ---------------------------------------------------------------------------
# Validation checks: Naming
# ---------------------------------------------------------------------------

def check_varname_uniqueness(
    boxes: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Error: duplicate varnames within a patcher scope."""
    diags: List[Diagnostic] = []
    varnames: Dict[str, list] = defaultdict(list)
    for box in boxes:
        vn = box.get("varname")
        if vn:
            varnames[vn].append(box.get("id", "?"))

    for name, ids in varnames.items():
        if len(ids) > 1:
            diags.append(Diagnostic(
                "error", patcher_path, "",
                f"duplicate varname '{name}' used by: {', '.join(ids)}"
            ))
    return diags


def check_send_receive_matching(file_context: dict) -> List[Diagnostic]:
    """Check send~/receive~ names have matching pairs within the file."""
    diags: List[Diagnostic] = []
    is_m4l = file_context.get("is_m4l", False)
    s_sig = file_context.get("send_signal_names", set())
    r_sig = file_context.get("receive_signal_names", set())

    level = "warning" if is_m4l else "info"

    for name in sorted(s_sig - r_sig):
        diags.append(Diagnostic(
            level, "file", "",
            f"send~ '{name}' has no matching receive~ in this file"
        ))
    for name in sorted(r_sig - s_sig):
        diags.append(Diagnostic(
            level, "file", "",
            f"receive~ '{name}' has no matching send~ in this file"
        ))
    return diags


def check_unknown_objects(
    boxes: List[dict], patcher_path: str
) -> List[Diagnostic]:
    """Detect likely typos via case-insensitive matching to known objects."""
    all_known = set(KNOWN_OBJECTS.keys()) | set(DYNAMIC_RESOLVERS.keys())
    known_lower: Dict[str, str] = {}
    for name in all_known:
        lower = name.lower()
        if lower not in known_lower:
            known_lower[lower] = name

    diags: List[Diagnostic] = []
    for box in boxes:
        if box.get("maxclass") != "newobj":
            continue
        name = get_object_name(box)
        if not name:
            continue
        if name in all_known:
            continue
        # Skip known prefixes
        if any(name.startswith(p) for p in KNOWN_PREFIXES):
            continue
        # Skip subpatcher/bpatcher references
        if name in ("p", "bpatcher", "pfft~"):
            continue
        # Check case-insensitive match
        lower = name.lower()
        if lower in known_lower and name != known_lower[lower]:
            correct = known_lower[lower]
            diags.append(Diagnostic(
                "warning", patcher_path, box.get("id", ""),
                f"'{name}' may be a typo for '{correct}' (case mismatch)"
            ))
    return diags


# ---------------------------------------------------------------------------
# Orchestration
# ---------------------------------------------------------------------------

def _run_check(
    name: str, check_fn, diagnostics: List[Diagnostic], *args, **kwargs
) -> None:
    """Run a single check function, log its name and findings in verbose mode."""
    before = len(diagnostics)
    diagnostics.extend(check_fn(*args, **kwargs))
    found = len(diagnostics) - before
    if found:
        vlog(f"    {name}: {found} finding(s)")


def validate_patcher(
    patcher: dict,
    patcher_path: str,
    diagnostics: List[Diagnostic],
    depth: int = 0,
    parent_box: Optional[dict] = None,
    file_context: Optional[dict] = None,
) -> None:
    """Validate a single patcher dict and recurse into subpatchers."""
    if file_context is None:
        file_context = {}

    classnamespace = patcher.get("classnamespace", "box")
    is_gen = classnamespace == "dsp.gen"
    is_m4l = file_context.get("is_m4l", False)

    boxes = _unwrap_boxes(patcher)
    lines = _unwrap_lines(patcher)

    indent = "  " + "  " * depth
    domain = "gen~" if is_gen else "box"
    vlog(f"{indent}Checking patcher '{patcher_path}' "
         f"({len(boxes)} objects, {len(lines)} connections, "
         f"namespace={domain})")

    # --- Structural checks (always run) ---
    _run_check("required_fields", check_required_fields, diagnostics,
               boxes, patcher_path)
    _run_check("duplicate_ids", check_duplicate_ids, diagnostics,
               boxes, patcher_path)
    _run_check("outlettype_length", check_outlettype_length, diagnostics,
               boxes, patcher_path)
    _run_check("patchline_refs", check_patchline_refs, diagnostics,
               boxes, lines, patcher_path)
    _run_check("index_bounds", check_index_bounds, diagnostics,
               boxes, lines, patcher_path)
    _run_check("declared_vs_expected", check_declared_vs_expected, diagnostics,
               boxes, patcher_path)
    _run_check("varname_uniqueness", check_varname_uniqueness, diagnostics,
               boxes, patcher_path)

    # --- Layout checks (always run) ---
    _run_check("overlapping_rects", check_overlapping_rects, diagnostics,
               boxes, patcher_path)
    _run_check("non_integer_coords", check_non_integer_coords, diagnostics,
               boxes, patcher_path)

    # --- Checks that only apply outside gen~ ---
    if not is_gen:
        _run_check("signal_compat", check_signal_compat, diagnostics,
                   boxes, lines, patcher_path)
        _run_check("message_domain_cycles", check_message_domain_cycles,
                   diagnostics, boxes, lines, patcher_path)
        _run_check("orphaned_objects", check_orphaned_objects, diagnostics,
                   boxes, lines, patcher_path)
        _run_check("multiple_inlet_connections",
                   check_multiple_inlet_connections, diagnostics,
                   boxes, lines, patcher_path)
        _run_check("fanout_missing_order", check_fanout_missing_order,
                   diagnostics, boxes, lines, patcher_path)
        _run_check("loadbang_count", check_loadbang_count, diagnostics,
                   boxes, patcher_path)
        _run_check("unknown_objects", check_unknown_objects, diagnostics,
                   boxes, patcher_path)

        # M4L-specific checks
        if is_m4l:
            _run_check("observer_deferlow", check_observer_deferlow,
                       diagnostics, boxes, lines, patcher_path)
            _run_check("send_receive_prefix", check_send_receive_prefix,
                       diagnostics, boxes, patcher_path)
            _run_check("noteout_in_m4l", check_noteout_in_m4l, diagnostics,
                       boxes, patcher_path)

        # Collect send~/receive~ names for file-level matching check
        for box in boxes:
            name = get_object_name(box)
            args = get_object_args(box)
            if args:
                if name in ("send~", "s~"):
                    file_context.setdefault(
                        "send_signal_names", set()
                    ).add(args[0])
                elif name in ("receive~", "r~"):
                    file_context.setdefault(
                        "receive_signal_names", set()
                    ).add(args[0])

    # --- Recursion depth check ---
    _run_check("recursion_depth", check_recursion_depth, diagnostics,
               depth, patcher_path)

    # --- Subpatcher port checks (when inside a subpatcher) ---
    if parent_box is not None:
        _run_check("subpatcher_port_indices", check_subpatcher_port_indices,
                   diagnostics, boxes, patcher_path, classnamespace)
        _run_check("subpatcher_port_count", check_subpatcher_port_count,
                   diagnostics, parent_box, boxes, patcher_path,
                   classnamespace)

    # --- Recurse into nested subpatchers ---
    for box in boxes:
        if "patcher" not in box:
            continue
        text = box.get("text", "")
        if text:
            parts = text.split()
            if len(parts) > 1 and parts[0] == "p":
                child_label = f"p {parts[1]}"
            else:
                child_label = parts[0]
        else:
            child_label = box.get("maxclass", "subpatcher")
        child_path = f"{patcher_path} > {child_label}"
        validate_patcher(
            box["patcher"], child_path, diagnostics,
            depth=depth + 1, parent_box=box, file_context=file_context,
        )


def _count_patchers(patcher: dict) -> Tuple[int, int, int]:
    """Count total boxes, lines, and subpatchers recursively."""
    boxes = _unwrap_boxes(patcher)
    lines = _unwrap_lines(patcher)
    total_boxes = len(boxes)
    total_lines = len(lines)
    total_subpatchers = 0
    for box in boxes:
        if "patcher" in box:
            total_subpatchers += 1
            sb, sl, ss = _count_patchers(box["patcher"])
            total_boxes += sb
            total_lines += sl
            total_subpatchers += ss
    return total_boxes, total_lines, total_subpatchers


def validate_file(filepath: str) -> List[Diagnostic]:
    """Validate a .maxpat or .amxd file. Returns list of diagnostics."""
    diagnostics: List[Diagnostic] = []
    file_size = 0
    try:
        file_size = os.path.getsize(filepath)
    except OSError:
        pass
    ext = os.path.splitext(filepath)[1]
    vlog(f"Parsing {filepath} ({file_size:,} bytes, format: {ext})")

    # --- Read and parse ---
    if filepath.endswith(".amxd"):
        try:
            with open(filepath, "rb") as f:
                header = f.read(32)
                if len(header) < 32:
                    diagnostics.append(Diagnostic(
                        "error", "file", "",
                        "file too short for .amxd header"
                    ))
                    return diagnostics
                json_length = struct.unpack("<I", header[28:32])[0]
                vlog(f"  .amxd header: 32-byte header, JSON payload: "
                     f"{json_length:,} bytes")
                json_bytes = f.read(json_length)
                data = json.loads(json_bytes.decode("utf-8"))
        except (json.JSONDecodeError, UnicodeDecodeError) as e:
            diagnostics.append(Diagnostic(
                "error", "file", "",
                f"JSON parse error in .amxd: {e}"
            ))
            return diagnostics
        except OSError as e:
            diagnostics.append(Diagnostic(
                "error", "file", "", f"cannot read file: {e}"
            ))
            return diagnostics
    else:
        try:
            with open(filepath, "r", encoding="utf-8") as f:
                data = json.load(f)
        except json.JSONDecodeError as e:
            diagnostics.append(Diagnostic(
                "error", "file", "", f"JSON parse error: {e}"
            ))
            return diagnostics
        except OSError as e:
            diagnostics.append(Diagnostic(
                "error", "file", "", f"cannot read file: {e}"
            ))
            return diagnostics

    vlog("  JSON parsed successfully")

    # --- Top-level structure ---
    if not isinstance(data, dict) or "patcher" not in data:
        diagnostics.append(Diagnostic(
            "error", "file", "",
            "missing top-level 'patcher' key"
        ))
        return diagnostics

    root_patcher = data["patcher"]

    # --- Detect M4L ---
    is_m4l = _detect_m4l(root_patcher, filepath)
    vlog(f"  Max4Live device: {is_m4l}")

    # --- Log patch statistics ---
    total_boxes, total_lines, total_subpatchers = _count_patchers(root_patcher)
    appversion = root_patcher.get("appversion", {})
    max_ver = (f"Max {appversion.get('major', '?')}"
               f".{appversion.get('minor', '?')}"
               f".{appversion.get('revision', '?')}"
               if appversion else "unknown")
    vlog(f"  Target: {max_ver}")
    vlog(f"  Patch stats: {total_boxes} objects, {total_lines} connections, "
         f"{total_subpatchers} subpatcher(s)")

    desc = root_patcher.get("description", "")
    if desc:
        vlog(f"  Description: {desc}")

    file_context = {
        "is_m4l": is_m4l,
        "send_signal_names": set(),
        "receive_signal_names": set(),
    }

    # --- Main recursive validation ---
    vlog("  Running validation checks...")
    validate_patcher(
        root_patcher, "root", diagnostics,
        depth=0, parent_box=None, file_context=file_context,
    )

    # --- File-level checks ---
    if is_m4l:
        vlog("  Running M4L file-level checks (parameter registry, "
             "presentation mode)...")
        root_boxes = _unwrap_boxes(root_patcher)
        diagnostics.extend(check_parameter_registry(data, root_boxes))
        diagnostics.extend(check_openinpresentation(root_patcher))

    vlog("  Checking send~/receive~ matching...")
    diagnostics.extend(check_send_receive_matching(file_context))

    errors = sum(1 for d in diagnostics if d.level == "error")
    warnings = sum(1 for d in diagnostics if d.level == "warning")
    infos = sum(1 for d in diagnostics if d.level == "info")
    vlog(f"  Validation complete: {errors} error(s), {warnings} warning(s), "
         f"{infos} info(s)")

    return diagnostics


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def format_diagnostics(filepath: str, diagnostics: List[Diagnostic]) -> str:
    """Format diagnostics for a single file."""
    if not diagnostics:
        return f"  {filepath}: OK"

    out = []
    out.append("=" * 60)
    out.append(f"  {filepath}")
    out.append("=" * 60)

    errors = warnings = infos = 0
    for d in diagnostics:
        if d.level == "error":
            errors += 1
            tag = "ERROR  "
        elif d.level == "warning":
            warnings += 1
            tag = "WARNING"
        else:
            infos += 1
            tag = "INFO   "
        loc = d.patcher_path
        if d.object_id:
            loc = f"{loc} > {d.object_id}"
        out.append(f"  {tag} {loc}: {d.message}")

    out.append("")
    parts = []
    if errors:
        parts.append(f"{errors} error(s)")
    if warnings:
        parts.append(f"{warnings} warning(s)")
    if infos:
        parts.append(f"{infos} info(s)")
    out.append(f"  {', '.join(parts)}")
    return "\n".join(out)


def main() -> int:
    global _verbose

    parser = argparse.ArgumentParser(
        description="Static validator for MaxMSP .maxpat and .amxd files."
    )
    parser.add_argument(
        "-v", "--verbose", action="store_true",
        help="enable verbose logging to stderr"
    )
    parser.add_argument(
        "files", nargs="+", metavar="FILE",
        help=".maxpat or .amxd file(s) to validate"
    )
    args = parser.parse_args()
    _verbose = args.verbose

    vlog(f"validate_maxpat.py starting")
    vlog(f"Files to validate: {len(args.files)}")
    run_start = time.monotonic()

    has_errors = False
    results = []
    total_errors = total_warnings = total_infos = 0

    for filepath in args.files:
        vlog("")
        file_start = time.monotonic()
        diagnostics = validate_file(filepath)
        elapsed = time.monotonic() - file_start
        vlog(f"  File completed in {elapsed:.3f}s")

        results.append(format_diagnostics(filepath, diagnostics))
        for d in diagnostics:
            if d.level == "error":
                total_errors += 1
                has_errors = True
            elif d.level == "warning":
                total_warnings += 1
            else:
                total_infos += 1

    print("\n".join(results))

    # --- Final summary ---
    total_elapsed = time.monotonic() - run_start
    vlog("")
    vlog(f"{'=' * 50}")
    vlog(f"Validated {len(args.files)} file(s) in {total_elapsed:.3f}s")
    vlog(f"Total: {total_errors} error(s), {total_warnings} warning(s), "
         f"{total_infos} info(s)")
    vlog(f"Result: {'FAIL' if has_errors else 'PASS'}")

    return 1 if has_errors else 0


if __name__ == "__main__":
    sys.exit(main())

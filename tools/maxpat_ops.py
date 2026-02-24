#!/usr/bin/env python3
"""Deterministic write operations for Max patch files (.maxpat), optimized for agents.

JSON-only output contract:
- `ok: true/false` always present
- `command`, `file`, and operation results are structured JSON
- no human prose printed to stdout

This tool intentionally treats `.maxpat` as canonical and focuses on narrow,
deterministic patch edits. It integrates with:
- `tools/validate_maxpat.py` for structural validation
- `tools/maxpat_query.py semantic-diff` for post-edit semantic review
"""

from __future__ import annotations

import argparse
import copy
import json
import os
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple


REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from tools import maxpat_query  # type: ignore
from tools import validate_maxpat  # type: ignore


SUPPORTED_WRITE_EXTS = {".maxpat"}


@dataclass
class PatcherRef:
    patcher: dict
    path: str
    uid_path: str
    parent_object_uid: str = ""


def _print_json(payload: dict, pretty: bool) -> None:
    if pretty:
        print(json.dumps(payload, indent=2, sort_keys=False))
    else:
        print(json.dumps(payload, separators=(",", ":"), sort_keys=False))


def _read_ops_spec(spec_path: str) -> dict:
    if spec_path == "-":
        raw = sys.stdin.read()
    else:
        raw = Path(spec_path).read_text(encoding="utf-8")
    if not raw.strip():
        raise ValueError("empty ops spec")
    data = json.loads(raw)
    if not isinstance(data, dict):
        raise ValueError("ops spec must be a JSON object")
    if not isinstance(data.get("ops"), list):
        raise ValueError("ops spec must include an 'ops' array")
    return data


def _read_patch(filepath: str) -> dict:
    data = maxpat_query._read_patch_file(filepath)  # pylint: disable=protected-access
    if not isinstance(data, dict) or "patcher" not in data:
        raise ValueError("missing top-level 'patcher' key")
    return data


def _write_patch(filepath: str, data: dict) -> None:
    ext = Path(filepath).suffix.lower()
    if ext not in SUPPORTED_WRITE_EXTS:
        raise ValueError(
            f"writing {ext or '<no-ext>'} is not supported yet; write support is .maxpat only"
        )
    with open(filepath, "w", encoding="utf-8") as handle:
        json.dump(data, handle, indent=2)
        handle.write("\n")


def _unwrap_boxes(patcher: dict) -> List[dict]:
    raw = patcher.get("boxes", [])
    return [item["box"] for item in raw if isinstance(item, dict) and "box" in item]


def _unwrap_lines(patcher: dict) -> List[dict]:
    raw = patcher.get("lines", [])
    return [item["patchline"] for item in raw if isinstance(item, dict) and "patchline" in item]


def _ensure_boxes_lines_arrays(patcher: dict) -> None:
    if not isinstance(patcher.get("boxes"), list):
        patcher["boxes"] = []
    if not isinstance(patcher.get("lines"), list):
        patcher["lines"] = []


def _to_float_rect(value: Any) -> List[float]:
    if not isinstance(value, list) or len(value) < 4:
        raise ValueError("rect must be a 4-element array")
    out: List[float] = []
    for i in range(4):
        try:
            out.append(float(value[i]))
        except (TypeError, ValueError) as exc:
            raise ValueError(f"rect[{i}] must be numeric") from exc
    return out


def _rects_intersect(a: List[float], b: List[float]) -> bool:
    if len(a) < 4 or len(b) < 4:
        return False
    ax1, ay1, aw, ah = [float(v) for v in a[:4]]
    bx1, by1, bw, bh = [float(v) for v in b[:4]]
    ax2 = ax1 + aw
    ay2 = ay1 + ah
    bx2 = bx1 + bw
    by2 = by1 + bh
    return not (ax2 < bx1 or bx2 < ax1 or ay2 < by1 or by2 < ay1)


def _walk_patchers(patcher: dict, path: str, uid_path: str, parent_object_uid: str = "") -> List[PatcherRef]:
    refs = [PatcherRef(patcher=patcher, path=path, uid_path=uid_path, parent_object_uid=parent_object_uid)]
    for box in _unwrap_boxes(patcher):
        child = box.get("patcher")
        if not isinstance(child, dict):
            continue
        child_path = maxpat_query._child_patcher_path(path, box)  # pylint: disable=protected-access
        child_uid_path = maxpat_query._child_patcher_uid_path(uid_path, box)  # pylint: disable=protected-access
        parent_uid = maxpat_query._box_uid(path, str(box.get("id", "")))  # pylint: disable=protected-access
        refs.extend(_walk_patchers(child, child_path, child_uid_path, parent_object_uid=parent_uid))
    return refs


class PatchWorkspace:
    def __init__(self, data: dict) -> None:
        self.data = data
        self.root = data["patcher"]
        self.patchers_by_path: Dict[str, PatcherRef] = {}
        self.patchers_by_uid_path: Dict[str, PatcherRef] = {}
        self.box_wrappers_by_uid: Dict[str, dict] = {}
        self.boxes_by_uid: Dict[str, dict] = {}
        self.saved_refs: Dict[str, dict] = {}
        self.reindex()

    def reindex(self) -> None:
        self.patchers_by_path.clear()
        self.patchers_by_uid_path.clear()
        self.box_wrappers_by_uid.clear()
        self.boxes_by_uid.clear()
        for pref in _walk_patchers(self.root, "root", "root"):
            self.patchers_by_path[pref.path] = pref
            self.patchers_by_uid_path[pref.uid_path] = pref
            patcher = pref.patcher
            _ensure_boxes_lines_arrays(patcher)
            for wrapper in patcher.get("boxes", []):
                if not isinstance(wrapper, dict) or "box" not in wrapper:
                    continue
                box = wrapper["box"]
                if not isinstance(box, dict):
                    continue
                box_id = str(box.get("id", ""))
                if not box_id:
                    continue
                uid = maxpat_query._box_uid(pref.path, box_id)  # pylint: disable=protected-access
                self.box_wrappers_by_uid[uid] = wrapper
                self.boxes_by_uid[uid] = box

    def resolve_patcher(self, selector: Optional[dict]) -> PatcherRef:
        if not selector:
            pref = self.patchers_by_path.get("root")
            if pref is None:
                raise ValueError("root patcher not found")
            return pref
        if not isinstance(selector, dict):
            raise ValueError("patcher selector must be an object")
        uid_path = str(selector.get("patcher_uid_path", "")).strip() or str(selector.get("uid_path", "")).strip()
        if uid_path:
            pref = self.patchers_by_uid_path.get(uid_path)
            if pref is None:
                raise ValueError(f"patcher_uid_path not found: {uid_path}")
            return pref
        path = str(selector.get("patcher_path", "")).strip() or str(selector.get("path", "")).strip()
        if path:
            pref = self.patchers_by_path.get(path)
            if pref is None:
                raise ValueError(f"patcher_path not found: {path}")
            return pref
        if selector.get("root") is True:
            pref = self.patchers_by_path.get("root")
            if pref is None:
                raise ValueError("root patcher not found")
            return pref
        raise ValueError("patcher selector requires patcher_path or patcher_uid_path")

    def resolve_box_uid(self, selector: dict) -> str:
        if not isinstance(selector, dict):
            raise ValueError("box selector must be an object")
        ref_name = str(selector.get("ref", "")).strip()
        if ref_name:
            ref_payload = self.saved_refs.get(ref_name)
            if ref_payload is None:
                raise ValueError(f"unknown selector ref: {ref_name}")
            explicit_field = str(selector.get("ref_field", "")).strip()
            candidate_fields = (
                [explicit_field]
                if explicit_field
                else ["added_uid", "target_uid", "removed_uid", "insert_box_uid", "uid"]
            )
            for field in candidate_fields:
                value = ref_payload.get(field)
                if isinstance(value, str) and value in self.boxes_by_uid:
                    return value
            raise ValueError(
                f"selector ref {ref_name!r} does not contain a resolvable box uid "
                f"(tried fields: {candidate_fields})"
            )
        uid = str(selector.get("uid", "")).strip()
        if uid:
            if uid not in self.boxes_by_uid:
                raise ValueError(f"box uid not found: {uid}")
            return uid

        box_id = str(selector.get("id", "")).strip()
        if not box_id:
            raise ValueError("box selector requires uid or id")

        # Resolve via explicit patcher selector if provided.
        if any(k in selector for k in ("patcher_path", "patcher_uid_path", "path", "uid_path")):
            pref = self.resolve_patcher(selector)
            candidate = maxpat_query._box_uid(pref.path, box_id)  # pylint: disable=protected-access
            if candidate not in self.boxes_by_uid:
                raise ValueError(f"box not found in patcher {pref.path}: {box_id}")
            return candidate

        # Global fallback by id (must be unique across all patchers).
        candidates = [box_uid for box_uid, box in self.boxes_by_uid.items() if str(box.get("id", "")) == box_id]
        if not candidates:
            raise ValueError(f"box id not found: {box_id}")
        if len(candidates) > 1:
            raise ValueError(
                f"box id is ambiguous across patchers ({box_id}); specify patcher_path or patcher_uid_path"
            )
        return candidates[0]

    def resolve_box(self, selector: dict) -> Tuple[str, dict, dict, PatcherRef]:
        uid = self.resolve_box_uid(selector)
        box = self.boxes_by_uid[uid]
        wrapper = self.box_wrappers_by_uid[uid]
        patcher_path = uid.rsplit("/", 1)[0]
        pref = self.patchers_by_path.get(patcher_path)
        if pref is None:
            raise ValueError(f"internal error: patcher not found for {uid}")
        return uid, wrapper, box, pref

    def _next_box_id(self, pref: PatcherRef, prefix: str = "obj-") -> str:
        max_n = 0
        for box in _unwrap_boxes(pref.patcher):
            box_id = str(box.get("id", ""))
            if not box_id.startswith(prefix):
                continue
            suffix = box_id[len(prefix) :]
            if suffix.isdigit():
                max_n = max(max_n, int(suffix))
        candidate = f"{prefix}{max_n + 1}"
        while maxpat_query._box_uid(pref.path, candidate) in self.boxes_by_uid:  # pylint: disable=protected-access
            max_n += 1
            candidate = f"{prefix}{max_n + 1}"
        return candidate

    def _validate_port_index(self, box: dict, port_index: int, endpoint_name: str) -> None:
        if port_index < 0:
            raise ValueError(f"{endpoint_name} port index must be >= 0")
        if endpoint_name == "source":
            count_key = "numoutlets"
            port_key = "outlet"
        else:
            count_key = "numinlets"
            port_key = "inlet"
        try:
            count = int(box.get(count_key, 0))
        except (TypeError, ValueError):
            count = 0
        if count <= 0:
            raise ValueError(
                f"{endpoint_name}.{port_key}={port_index} is invalid; target box reports {count_key}={count}"
            )
        if port_index >= count:
            raise ValueError(
                f"{endpoint_name}.{port_key}={port_index} out of range for box ({count_key}={count})"
            )

    def _line_wrapper_matches(
        self,
        wrapper: dict,
        *,
        src_id: Optional[str],
        src_outlet: Optional[int],
        dst_id: Optional[str],
        dst_inlet: Optional[int],
        order: Optional[int],
    ) -> bool:
        if not isinstance(wrapper, dict) or "patchline" not in wrapper:
            return False
        line = wrapper["patchline"]
        if not isinstance(line, dict):
            return False
        src = line.get("source")
        dst = line.get("destination")
        if not isinstance(src, list) or len(src) < 2 or not isinstance(dst, list) or len(dst) < 2:
            return False
        if src_id is not None and str(src[0]) != src_id:
            return False
        if dst_id is not None and str(dst[0]) != dst_id:
            return False
        if src_outlet is not None and int(src[1]) != src_outlet:
            return False
        if dst_inlet is not None and int(dst[1]) != dst_inlet:
            return False
        if order is not None:
            existing_order = line.get("order")
            if existing_order is None or int(existing_order) != order:
                return False
        return True

    def apply_op(self, op: dict) -> dict:
        if not isinstance(op, dict):
            raise ValueError("operation must be an object")
        kind = str(op.get("op", "")).strip()
        if not kind:
            raise ValueError("operation is missing 'op'")

        if kind == "set-box-fields":
            return self._op_set_box_fields(op)
        if kind == "move-box":
            return self._op_move_box(op)
        if kind == "add-box":
            return self._op_add_box(op)
        if kind == "remove-box":
            return self._op_remove_box(op)
        if kind == "connect":
            return self._op_connect(op)
        if kind == "disconnect":
            return self._op_disconnect(op)
        if kind == "insert-between":
            return self._op_insert_between(op)
        if kind == "place-relative":
            return self._op_place_relative(op)
        raise ValueError(f"unsupported op: {kind}")

    def save_ref(self, name: str, payload: dict) -> None:
        key = name.strip()
        if not key:
            raise ValueError("save_as must be a non-empty string")
        self.saved_refs[key] = copy.deepcopy(payload)

    def _op_set_box_fields(self, op: dict) -> dict:
        uid, _, box, _ = self.resolve_box(op.get("target", {}))
        fields = op.get("fields")
        if not isinstance(fields, dict):
            raise ValueError("set-box-fields requires fields object")
        if "id" in fields and fields["id"] != box.get("id"):
            raise ValueError("changing box id is not supported by set-box-fields")
        before = {k: copy.deepcopy(box.get(k)) for k in fields.keys()}
        for key, value in fields.items():
            box[key] = value
        self.reindex()
        return {
            "op": "set-box-fields",
            "target_uid": uid,
            "changed_fields": sorted(fields.keys()),
            "before": before,
        }

    def _op_move_box(self, op: dict) -> dict:
        uid, _, box, _ = self.resolve_box(op.get("target", {}))
        view = str(op.get("view", "patching")).strip().lower()
        if view not in {"patching", "presentation"}:
            raise ValueError("move-box view must be patching or presentation")
        rect_key = "patching_rect" if view == "patching" else "presentation_rect"
        if "rect" in op:
            rect = _to_float_rect(op["rect"])
        else:
            base = box.get(rect_key)
            if not isinstance(base, list) or len(base) < 4:
                base = [0.0, 0.0, 60.0, 22.0]
            rect = [float(base[0]), float(base[1]), float(base[2]), float(base[3])]
            if "x" in op:
                rect[0] = float(op["x"])
            if "y" in op:
                rect[1] = float(op["y"])
            if "w" in op:
                rect[2] = float(op["w"])
            if "h" in op:
                rect[3] = float(op["h"])

        before = copy.deepcopy(box.get(rect_key))
        box[rect_key] = rect
        if view == "presentation":
            box["presentation"] = 1
        self.reindex()
        return {
            "op": "move-box",
            "target_uid": uid,
            "view": view,
            "rect_key": rect_key,
            "before": before,
            "after": rect,
        }

    def _op_add_box(self, op: dict) -> dict:
        pref = self.resolve_patcher(op.get("patcher"))
        box = op.get("box")
        if not isinstance(box, dict):
            raise ValueError("add-box requires box object")
        box_copy = copy.deepcopy(box)
        box_id = str(box_copy.get("id", "")).strip()
        auto_id = bool(op.get("auto_id", False))
        if not box_id or box_id.lower() in {"auto", "@auto"}:
            auto_id = True
        if auto_id:
            box_id = self._next_box_id(pref)
            box_copy["id"] = box_id
        if not box_id:
            raise ValueError("add-box.box.id is required (or set auto_id=true)")
        candidate_uid = maxpat_query._box_uid(pref.path, box_id)  # pylint: disable=protected-access
        if candidate_uid in self.boxes_by_uid:
            raise ValueError(f"box id already exists in patcher {pref.path}: {box_id}")
        _ensure_boxes_lines_arrays(pref.patcher)
        pref.patcher["boxes"].append({"box": box_copy})
        self.reindex()
        return {
            "op": "add-box",
            "patcher_path": pref.path,
            "patcher_uid_path": pref.uid_path,
            "added_uid": candidate_uid,
            "id": box_id,
            "auto_id": auto_id,
        }

    def _op_remove_box(self, op: dict) -> dict:
        uid, wrapper, box, pref = self.resolve_box(op.get("target", {}))
        remove_connections = bool(op.get("remove_connections", True))
        box_id = str(box.get("id", ""))
        removed_line_count = 0
        if remove_connections:
            before_lines = list(pref.patcher.get("lines", []))
            kept_lines = []
            for line_wrapper in before_lines:
                if not isinstance(line_wrapper, dict) or "patchline" not in line_wrapper:
                    kept_lines.append(line_wrapper)
                    continue
                patchline = line_wrapper["patchline"]
                if not isinstance(patchline, dict):
                    kept_lines.append(line_wrapper)
                    continue
                src = patchline.get("source")
                dst = patchline.get("destination")
                src_id = str(src[0]) if isinstance(src, list) and len(src) >= 1 else ""
                dst_id = str(dst[0]) if isinstance(dst, list) and len(dst) >= 1 else ""
                if src_id == box_id or dst_id == box_id:
                    removed_line_count += 1
                    continue
                kept_lines.append(line_wrapper)
            pref.patcher["lines"] = kept_lines
        else:
            for line_wrapper in pref.patcher.get("lines", []):
                if not isinstance(line_wrapper, dict) or "patchline" not in line_wrapper:
                    continue
                patchline = line_wrapper["patchline"]
                src = patchline.get("source") if isinstance(patchline, dict) else None
                dst = patchline.get("destination") if isinstance(patchline, dict) else None
                src_id = str(src[0]) if isinstance(src, list) and len(src) >= 1 else ""
                dst_id = str(dst[0]) if isinstance(dst, list) and len(dst) >= 1 else ""
                if src_id == box_id or dst_id == box_id:
                    raise ValueError("remove-box target has patchlines; set remove_connections=true")

        boxes = pref.patcher.get("boxes", [])
        pref.patcher["boxes"] = [item for item in boxes if item is not wrapper]
        self.reindex()
        return {
            "op": "remove-box",
            "removed_uid": uid,
            "patcher_path": pref.path,
            "patcher_uid_path": pref.uid_path,
            "removed_connections": removed_line_count,
        }

    def _resolve_endpoint(
        self,
        endpoint: dict,
        *,
        endpoint_name: str,
        validate_port_bounds: bool = True,
    ) -> Tuple[PatcherRef, dict, str, int]:
        if not isinstance(endpoint, dict):
            raise ValueError(f"{endpoint_name} must be an object")
        uid, _, box, pref = self.resolve_box(endpoint)
        port_key = "outlet" if endpoint_name == "source" else "inlet"
        if port_key not in endpoint:
            raise ValueError(f"{endpoint_name}.{port_key} is required")
        port_index = int(endpoint[port_key])
        if validate_port_bounds and not bool(endpoint.get("skip_port_bounds_check", False)):
            self._validate_port_index(box, port_index, endpoint_name)
        return pref, box, uid, port_index

    def _op_connect(self, op: dict) -> dict:
        src_pref, src_box, src_uid, src_outlet = self._resolve_endpoint(op.get("source", {}), endpoint_name="source")
        dst_pref, dst_box, dst_uid, dst_inlet = self._resolve_endpoint(op.get("destination", {}), endpoint_name="destination")
        if src_pref.path != dst_pref.path:
            raise ValueError("connect requires source and destination in the same patcher")
        pref = src_pref
        patchline = {
            "source": [str(src_box.get("id", "")), src_outlet],
            "destination": [str(dst_box.get("id", "")), dst_inlet],
        }
        if "order" in op and op["order"] is not None:
            patchline["order"] = int(op["order"])
        if "midpoints" in op:
            mids = op["midpoints"]
            if not isinstance(mids, list):
                raise ValueError("midpoints must be an array")
            patchline["midpoints"] = [float(v) for v in mids]

        ensure = bool(op.get("ensure", False))
        for line_wrapper in pref.patcher.get("lines", []):
            if self._line_wrapper_matches(
                line_wrapper,
                src_id=str(src_box.get("id", "")),
                src_outlet=src_outlet,
                dst_id=str(dst_box.get("id", "")),
                dst_inlet=dst_inlet,
                order=int(op["order"]) if ("order" in op and op["order"] is not None) else None,
            ):
                if ensure:
                    return {
                        "op": "connect",
                        "status": "already_present",
                        "patcher_path": pref.path,
                        "patcher_uid_path": pref.uid_path,
                        "src": src_uid,
                        "dst": dst_uid,
                        "source_outlet": src_outlet,
                        "destination_inlet": dst_inlet,
                    }
                raise ValueError("matching patchline already exists")

        pref.patcher["lines"].append({"patchline": patchline})
        self.reindex()
        return {
            "op": "connect",
            "status": "added",
            "patcher_path": pref.path,
            "patcher_uid_path": pref.uid_path,
            "src": src_uid,
            "dst": dst_uid,
            "source_outlet": src_outlet,
            "destination_inlet": dst_inlet,
            "order": patchline.get("order"),
        }

    def _op_disconnect(self, op: dict) -> dict:
        patcher_selector = op.get("patcher")
        pref = self.resolve_patcher(patcher_selector) if patcher_selector else None

        src_id = None
        src_outlet = None
        dst_id = None
        dst_inlet = None

        if "source" in op and op["source"] is not None:
            src_ep = op["source"]
            if not isinstance(src_ep, dict):
                raise ValueError("disconnect.source must be an object")
            src_pref, src_box, _, src_outlet_val = self._resolve_endpoint(
                src_ep, endpoint_name="source"
            )
            src_id = str(src_box.get("id", ""))
            src_outlet = src_outlet_val
            if pref is None:
                pref = src_pref

        if "destination" in op and op["destination"] is not None:
            dst_ep = op["destination"]
            if not isinstance(dst_ep, dict):
                raise ValueError("disconnect.destination must be an object")
            dst_pref, dst_box, _, dst_inlet_val = self._resolve_endpoint(
                dst_ep, endpoint_name="destination"
            )
            dst_id = str(dst_box.get("id", ""))
            dst_inlet = dst_inlet_val
            if pref is None:
                pref = dst_pref
            elif pref.path != dst_pref.path:
                raise ValueError("disconnect source and destination selectors must resolve to the same patcher")

        if pref is None:
            raise ValueError("disconnect requires patcher selector and/or endpoint selectors")
        if patcher_selector and pref.path != self.resolve_patcher(patcher_selector).path:
            raise ValueError("disconnect patcher selector does not match endpoint patcher")
        if src_id is None and dst_id is None:
            raise ValueError("disconnect requires source and/or destination endpoint filters")

        order = int(op["order"]) if ("order" in op and op["order"] is not None) else None
        removed = 0
        keep: List[dict] = []
        remove_all = bool(op.get("remove_all", True))
        lines = list(pref.patcher.get("lines", []))
        for idx, line_wrapper in enumerate(lines):
            if self._line_wrapper_matches(
                line_wrapper,
                src_id=src_id,
                src_outlet=src_outlet,
                dst_id=dst_id,
                dst_inlet=dst_inlet,
                order=order,
            ):
                removed += 1
                if not remove_all:
                    keep.extend(lines[idx + 1 :])
                    break
                continue
            keep.append(line_wrapper)

        pref.patcher["lines"] = keep
        self.reindex()
        return {
            "op": "disconnect",
            "patcher_path": pref.path,
            "patcher_uid_path": pref.uid_path,
            "removed": removed,
        }

    def _op_insert_between(self, op: dict) -> dict:
        src_pref, src_box, src_uid, src_outlet = self._resolve_endpoint(
            op.get("source", {}), endpoint_name="source"
        )
        dst_pref, dst_box, dst_uid, dst_inlet = self._resolve_endpoint(
            op.get("destination", {}), endpoint_name="destination"
        )
        if src_pref.path != dst_pref.path:
            raise ValueError("insert-between requires source and destination in the same patcher")

        target = op.get("target")
        if not isinstance(target, dict):
            raise ValueError("insert-between requires target object selector")
        insert_pref, insert_box, insert_uid, insert_inlet = self._resolve_endpoint(
            {**target, "inlet": target.get("inlet", 0)},
            endpoint_name="destination",
        )
        _, _, _, insert_outlet = self._resolve_endpoint(
            {**target, "outlet": target.get("outlet", 0)},
            endpoint_name="source",
        )
        if insert_pref.path != src_pref.path:
            raise ValueError("insert-between target must be in the same patcher")

        pref = src_pref
        order_filter = int(op["order"]) if ("order" in op and op["order"] is not None) else None
        remove_all = bool(op.get("remove_all", False))
        preserve_order = bool(op.get("preserve_order", True))
        preserve_midpoints = bool(op.get("preserve_midpoints", False))

        lines = list(pref.patcher.get("lines", []))
        matched_indices: List[int] = []
        matched_wrappers: List[dict] = []
        for idx, line_wrapper in enumerate(lines):
            if self._line_wrapper_matches(
                line_wrapper,
                src_id=str(src_box.get("id", "")),
                src_outlet=src_outlet,
                dst_id=str(dst_box.get("id", "")),
                dst_inlet=dst_inlet,
                order=order_filter,
            ):
                matched_indices.append(idx)
                matched_wrappers.append(line_wrapper)
                if not remove_all:
                    break
        if not matched_wrappers:
            raise ValueError("insert-between could not find matching patchline")

        kept_lines = [line for idx, line in enumerate(lines) if idx not in set(matched_indices)]
        pref.patcher["lines"] = kept_lines

        inserted_segments: List[dict] = []
        for wrapper in matched_wrappers:
            patchline = wrapper.get("patchline", {}) if isinstance(wrapper, dict) else {}
            if not isinstance(patchline, dict):
                continue
            src_to_insert = {
                "source": [str(src_box.get("id", "")), src_outlet],
                "destination": [str(insert_box.get("id", "")), insert_inlet],
            }
            if preserve_order and "order" in patchline:
                src_to_insert["order"] = patchline["order"]
            if preserve_midpoints and "midpoints" in patchline:
                src_to_insert["midpoints"] = copy.deepcopy(patchline["midpoints"])

            insert_to_dst = {
                "source": [str(insert_box.get("id", "")), insert_outlet],
                "destination": [str(dst_box.get("id", "")), dst_inlet],
            }
            pref.patcher["lines"].append({"patchline": src_to_insert})
            pref.patcher["lines"].append({"patchline": insert_to_dst})
            inserted_segments.append(
                {
                    "from": [src_uid, src_outlet],
                    "to": [insert_uid, insert_inlet],
                    "from2": [insert_uid, insert_outlet],
                    "to2": [dst_uid, dst_inlet],
                    "preserved_order": src_to_insert.get("order"),
                }
            )

        self.reindex()
        return {
            "op": "insert-between",
            "patcher_path": pref.path,
            "patcher_uid_path": pref.uid_path,
            "matched_lines": len(matched_wrappers),
            "insert_box_uid": insert_uid,
            "source_uid": src_uid,
            "destination_uid": dst_uid,
            "insert_inlet": insert_inlet,
            "insert_outlet": insert_outlet,
            "segments": inserted_segments,
        }

    def _op_place_relative(self, op: dict) -> dict:
        anchor_uid, _, anchor_box, anchor_pref = self.resolve_box(op.get("anchor", {}))
        target_uid, _, target_box, target_pref = self.resolve_box(op.get("target", {}))
        if anchor_pref.path != target_pref.path:
            raise ValueError("place-relative requires anchor and target in same patcher")

        anchor_rect = anchor_box.get("patching_rect")
        target_rect = target_box.get("patching_rect")
        if not isinstance(anchor_rect, list) or len(anchor_rect) < 4:
            raise ValueError("anchor box has no patching_rect")
        if not isinstance(target_rect, list) or len(target_rect) < 4:
            target_rect = [0.0, 0.0, 60.0, 22.0]

        a = [float(anchor_rect[0]), float(anchor_rect[1]), float(anchor_rect[2]), float(anchor_rect[3])]
        t = [float(target_rect[0]), float(target_rect[1]), float(target_rect[2]), float(target_rect[3])]

        relation = str(op.get("relation", "right")).strip().lower()
        if relation not in {"right", "left", "below", "above"}:
            raise ValueError("relation must be right|left|below|above")
        gap_x = float(op.get("gap_x", op.get("gap", 24)))
        gap_y = float(op.get("gap_y", op.get("gap", 24)))
        align = str(op.get("align", "start")).strip().lower()
        if align not in {"start", "center", "end"}:
            raise ValueError("align must be start|center|end")
        snap = op.get("snap")
        snap_size = float(snap) if snap is not None else 0.0

        new_x = t[0]
        new_y = t[1]
        if relation == "right":
            new_x = a[0] + a[2] + gap_x
            if align == "start":
                new_y = a[1]
            elif align == "center":
                new_y = a[1] + (a[3] - t[3]) / 2.0
            else:
                new_y = a[1] + a[3] - t[3]
        elif relation == "left":
            new_x = a[0] - gap_x - t[2]
            if align == "start":
                new_y = a[1]
            elif align == "center":
                new_y = a[1] + (a[3] - t[3]) / 2.0
            else:
                new_y = a[1] + a[3] - t[3]
        elif relation == "below":
            new_y = a[1] + a[3] + gap_y
            if align == "start":
                new_x = a[0]
            elif align == "center":
                new_x = a[0] + (a[2] - t[2]) / 2.0
            else:
                new_x = a[0] + a[2] - t[2]
        elif relation == "above":
            new_y = a[1] - gap_y - t[3]
            if align == "start":
                new_x = a[0]
            elif align == "center":
                new_x = a[0] + (a[2] - t[2]) / 2.0
            else:
                new_x = a[0] + a[2] - t[2]

        if snap_size > 0:
            new_x = round(new_x / snap_size) * snap_size
            new_y = round(new_y / snap_size) * snap_size

        avoid_overlap = bool(op.get("avoid_overlap", False))
        overlap_nudges = 0
        if avoid_overlap:
            step = float(op.get("scan_step", snap_size if snap_size > 0 else 8.0))
            if step <= 0:
                step = 8.0
            max_steps = max(int(op.get("max_steps", 32)), 0)

            def _nudge(rect: List[float]) -> None:
                nonlocal new_x, new_y
                if relation == "right":
                    new_x += step
                elif relation == "left":
                    new_x -= step
                elif relation == "below":
                    new_y += step
                elif relation == "above":
                    new_y -= step
                if snap_size > 0:
                    new_x = round(new_x / snap_size) * snap_size
                    new_y = round(new_y / snap_size) * snap_size

            for _ in range(max_steps + 1):
                candidate = [new_x, new_y, t[2], t[3]]
                collided = False
                for wrapper in target_pref.patcher.get("boxes", []):
                    if not isinstance(wrapper, dict) or "box" not in wrapper:
                        continue
                    other_box = wrapper["box"]
                    if not isinstance(other_box, dict):
                        continue
                    other_id = str(other_box.get("id", ""))
                    if other_id in {str(anchor_box.get("id", "")), str(target_box.get("id", ""))}:
                        continue
                    other_rect_raw = other_box.get("patching_rect")
                    if not isinstance(other_rect_raw, list) or len(other_rect_raw) < 4:
                        continue
                    other_rect = [float(other_rect_raw[0]), float(other_rect_raw[1]), float(other_rect_raw[2]), float(other_rect_raw[3])]
                    if _rects_intersect(candidate, other_rect):
                        collided = True
                        break
                if not collided:
                    break
                overlap_nudges += 1
                _nudge(candidate)

        before = copy.deepcopy(target_box.get("patching_rect"))
        target_box["patching_rect"] = [new_x, new_y, t[2], t[3]]
        self.reindex()
        return {
            "op": "place-relative",
            "anchor_uid": anchor_uid,
            "target_uid": target_uid,
            "relation": relation,
            "align": align,
            "avoid_overlap": avoid_overlap,
            "overlap_nudges": overlap_nudges,
            "before": before,
            "after": target_box["patching_rect"],
        }


def _diagnostic_to_payload(diag: validate_maxpat.Diagnostic) -> dict:
    return {
        "level": diag.level,
        "patcher_path": diag.patcher_path,
        "object_id": diag.object_id,
        "message": diag.message,
    }


def _summarize_diagnostics(diags: List[validate_maxpat.Diagnostic]) -> dict:
    counts = {"error": 0, "warning": 0, "info": 0}
    for diag in diags:
        counts[diag.level] = counts.get(diag.level, 0) + 1
    return {
        "total": len(diags),
        "counts": counts,
    }


def _semantic_diff_for_files(
    base_file: str,
    target_file: str,
    *,
    ignore_whitespace: bool,
    ignore_order: bool,
    include_ports: bool = False,
    include_container_links: bool = False,
    max_node_details: int = 200,
    max_edge_details: int = 400,
) -> dict:
    base_index = maxpat_query.IndexBuilder().build(base_file)
    target_index = maxpat_query.IndexBuilder().build(target_file)
    return maxpat_query.cmd_semantic_diff(  # pylint: disable=protected-access
        base_index=base_index,
        target_index=target_index,
        include_ports=include_ports,
        ignore_whitespace=ignore_whitespace,
        compare_order=not ignore_order,
        include_container_links=include_container_links,
        max_node_details=max_node_details,
        max_edge_details=max_edge_details,
    )


def _write_temp_patch(data: dict, suffix: str = ".maxpat") -> str:
    fd, path = tempfile.mkstemp(prefix="maxpat_ops_", suffix=suffix)
    os.close(fd)
    with open(path, "w", encoding="utf-8") as handle:
        json.dump(data, handle, indent=2)
        handle.write("\n")
    return path


def apply_ops(
    filepath: str,
    ops_spec: dict,
    *,
    dry_run: bool,
    run_validate: bool,
    allow_invalid: bool,
    run_semantic_diff: bool,
    diff_ignore_whitespace: bool,
    diff_ignore_order: bool,
) -> dict:
    original_data = _read_patch(filepath)
    original_copy = copy.deepcopy(original_data)
    workspace = PatchWorkspace(copy.deepcopy(original_data))

    ops = ops_spec.get("ops", [])
    if not isinstance(ops, list):
        raise ValueError("ops must be a list")

    op_results: List[dict] = []
    for i, op in enumerate(ops):
        result = workspace.apply_op(op)
        save_as = str(op.get("save_as", "")).strip() if isinstance(op, dict) else ""
        if save_as:
            workspace.save_ref(save_as, result)
            result["saved_as"] = save_as
        result["op_index"] = i
        op_results.append(result)

    target_data = workspace.data

    validation_payload: Optional[dict] = None
    diagnostics: List[validate_maxpat.Diagnostic] = []
    semantic_diff_payload: Optional[dict] = None

    ext = Path(filepath).suffix.lower()
    if ext not in SUPPORTED_WRITE_EXTS:
        raise ValueError(
            f"apply-ops currently supports writing .maxpat only (got {ext or '<no-ext>'})"
        )

    base_tmp = _write_temp_patch(original_copy, suffix=ext)
    target_tmp = _write_temp_patch(target_data, suffix=ext)
    try:
        if run_validate:
            diagnostics = validate_maxpat.validate_file(target_tmp)
            validation_payload = {
                "summary": _summarize_diagnostics(diagnostics),
                "diagnostics": [_diagnostic_to_payload(d) for d in diagnostics],
            }
            if not allow_invalid and any(d.level == "error" for d in diagnostics):
                return {
                    "file": filepath,
                    "command": "apply",
                    "dry_run": dry_run,
                    "applied_ops": len(op_results),
                    "results": op_results,
                    "validation": validation_payload,
                    "write_performed": False,
                    "ok": False,
                    "error": "ValidationError: target patch has validation errors",
                }

        if run_semantic_diff:
            semantic_diff_payload = _semantic_diff_for_files(
                base_tmp,
                target_tmp,
                ignore_whitespace=diff_ignore_whitespace,
                ignore_order=diff_ignore_order,
            )
            semantic_diff_payload["ok"] = True

        if not dry_run:
            _write_patch(filepath, target_data)

        return {
            "file": filepath,
            "command": "apply",
            "dry_run": dry_run,
            "applied_ops": len(op_results),
            "results": op_results,
            "validation": validation_payload,
            "semantic_diff": semantic_diff_payload,
            "write_performed": not dry_run,
            "ok": True,
        }
    finally:
        for tmp in (base_tmp, target_tmp):
            try:
                os.remove(tmp)
            except OSError:
                pass


def _supported_op_names() -> List[str]:
    return sorted(
        [
            "set-box-fields",
            "move-box",
            "add-box",
            "remove-box",
            "connect",
            "disconnect",
            "insert-between",
            "place-relative",
        ]
    )


def cmd_describe() -> dict:
    return {
        "command": "describe",
        "tool": "maxpat_ops.py",
        "scope": {
            "reads": [".maxpat", ".amxd"],
            "writes": [".maxpat"],
            "json_only_output": True,
        },
        "selectors": {
            "patcher": {
                "preferred": ["patcher_uid_path"],
                "also_supported": ["patcher_path", "uid_path", "path", "root=true"],
            },
            "box": {
                "preferred": ["uid"],
                "also_supported": [
                    "ref (+ optional ref_field)",
                    "id + patcher_uid_path",
                    "id + patcher_path",
                    "unique id (global fallback)",
                ],
            },
        },
        "op_result_refs": {
            "save_as": "Any op may include save_as to store its result payload under a name",
            "selector_ref": "Later box selectors can use {\"ref\": \"name\"} to resolve a uid from saved results",
            "default_ref_fields": ["added_uid", "target_uid", "removed_uid", "insert_box_uid", "uid"],
        },
        "endpoint_rules": {
            "source_requires": ["outlet"],
            "destination_requires": ["inlet"],
            "port_bounds_validation": "enabled by default using numinlets/numoutlets",
            "skip_port_bounds_check_flag": "skip_port_bounds_check",
        },
        "commands": [
            {"name": "describe", "purpose": "Machine-readable contract for agents"},
            {
                "name": "validate-spec",
                "purpose": "Static ops-spec validation and optional contextual dry-run preflight",
                "flags": ["--ops", "--file", "--contextual"],
            },
            {
                "name": "apply",
                "purpose": "Apply deterministic write ops to a patch",
                "flags": [
                    "--ops",
                    "--dry-run",
                    "--skip-validate",
                    "--allow-invalid",
                    "--skip-semantic-diff",
                    "--diff-ignore-whitespace",
                    "--diff-ignore-order",
                ],
            },
        ],
        "ops": [
            {
                "op": "set-box-fields",
                "required": ["target", "fields"],
                "notes": ["Cannot change box id"],
            },
            {
                "op": "move-box",
                "required": ["target"],
                "optional": ["rect", "x", "y", "w", "h", "view=patching|presentation"],
            },
            {
                "op": "add-box",
                "required": ["patcher", "box"],
                "optional": ["auto_id=true"],
                "notes": ["If box.id is missing or 'auto'/'@auto', auto_id can allocate next obj-N"],
            },
            {
                "op": "remove-box",
                "required": ["target"],
                "optional": ["remove_connections=true|false"],
            },
            {
                "op": "connect",
                "required": ["source", "destination"],
                "optional": ["order", "midpoints", "ensure=true|false"],
            },
            {
                "op": "disconnect",
                "required_any": ["source", "destination"],
                "optional": ["patcher", "order", "remove_all=true|false"],
            },
            {
                "op": "insert-between",
                "required": ["source", "destination", "target"],
                "optional": ["order", "remove_all", "preserve_order", "preserve_midpoints"],
                "notes": ["Replaces source->destination line(s) with source->target and target->destination"],
            },
            {
                "op": "place-relative",
                "required": ["anchor", "target"],
                "optional": [
                    "relation=right|left|below|above",
                    "align=start|center|end",
                    "gap / gap_x / gap_y",
                    "snap",
                    "avoid_overlap",
                    "scan_step",
                    "max_steps",
                ],
            },
        ],
        "apply_flags": {
            "dry_run": "--dry-run",
            "validate": "enabled by default; disable with --skip-validate",
            "semantic_diff": "enabled by default; disable with --skip-semantic-diff",
            "allow_invalid": "--allow-invalid",
        },
        "examples": {
            "describe": "python3 tools/maxpat_ops.py --pretty describe",
            "validate_spec": "python3 tools/maxpat_ops.py validate-spec --ops ops.json --contextual --file patch.maxpat",
            "dry_run_apply": "python3 tools/maxpat_ops.py apply patch.maxpat --ops ops.json --dry-run",
        },
    }


def cmd_validate_spec(
    *,
    ops_spec: dict,
    file: str = "",
    contextual: bool = False,
) -> dict:
    ops = ops_spec.get("ops")
    if not isinstance(ops, list):
        raise ValueError("ops spec must include an 'ops' array")

    supported = set(_supported_op_names())
    static_errors: List[dict] = []
    op_summaries: List[dict] = []
    for idx, op in enumerate(ops):
        summary = {"op_index": idx}
        if not isinstance(op, dict):
            static_errors.append({"op_index": idx, "error": "operation must be an object"})
            op_summaries.append({**summary, "ok": False, "op": ""})
            continue
        op_name = str(op.get("op", "")).strip()
        summary["op"] = op_name
        if not op_name:
            static_errors.append({"op_index": idx, "error": "missing 'op'"})
            op_summaries.append({**summary, "ok": False})
            continue
        if op_name not in supported:
            static_errors.append(
                {
                    "op_index": idx,
                    "op": op_name,
                    "error": f"unsupported op: {op_name}",
                    "supported_ops": sorted(supported),
                }
            )
            op_summaries.append({**summary, "ok": False})
            continue
        op_summaries.append({**summary, "ok": True})

    payload: dict = {
        "command": "validate-spec",
        "contextual": contextual,
        "file": file,
        "summary": {
            "op_count": len(ops),
            "static_error_count": len(static_errors),
        },
        "supported_ops": sorted(supported),
        "ops": op_summaries,
        "static_errors": static_errors,
    }

    if static_errors:
        payload["ok"] = False
        return payload

    if contextual:
        if not file:
            raise ValueError("contextual validation requires --file")
        # Dry-run preflight: no validate_maxpat and no semantic-diff (faster, focused on selectors/op execution)
        preflight = apply_ops(
            filepath=file,
            ops_spec=ops_spec,
            dry_run=True,
            run_validate=False,
            allow_invalid=True,
            run_semantic_diff=False,
            diff_ignore_whitespace=False,
            diff_ignore_order=False,
        )
        payload["preflight"] = preflight
        payload["summary"]["preflight_ok"] = bool(preflight.get("ok"))
        payload["ok"] = bool(preflight.get("ok"))
        return payload

    payload["ok"] = True
    return payload


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Deterministic write operations for Max patch files (.maxpat)"
    )
    parser.add_argument("--pretty", action="store_true", help="pretty-print JSON output")
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("describe", help="emit machine-readable op/selector contract")

    p_validate_spec = sub.add_parser(
        "validate-spec",
        help="validate an ops spec (static) and optionally preflight against a patch",
    )
    p_validate_spec.add_argument(
        "--ops",
        default="-",
        help="JSON ops spec file (default: stdin). Shape: {\"ops\":[...]}",
    )
    p_validate_spec.add_argument(
        "--file",
        default="",
        help="optional patch file for contextual dry-run preflight",
    )
    p_validate_spec.add_argument(
        "--contextual",
        action="store_true",
        help="execute a dry-run preflight against --file (selectors, ports, op execution)",
    )

    p_apply = sub.add_parser("apply", help="apply an ops spec to a patch file")
    p_apply.add_argument("file", help=".maxpat patch file")
    p_apply.add_argument(
        "--ops",
        default="-",
        help="JSON ops spec file (default: stdin). Shape: {\"ops\":[...]}",
    )
    p_apply.add_argument("--dry-run", action="store_true", help="apply in memory only")
    p_apply.add_argument(
        "--skip-validate",
        action="store_true",
        help="skip validate_maxpat check after applying ops",
    )
    p_apply.add_argument(
        "--allow-invalid",
        action="store_true",
        help="write even if validate_maxpat reports errors",
    )
    p_apply.add_argument(
        "--skip-semantic-diff",
        action="store_true",
        help="skip semantic-diff post-check payload",
    )
    p_apply.add_argument(
        "--diff-ignore-whitespace",
        action="store_true",
        help="ignore whitespace-only text/varname diffs in semantic diff",
    )
    p_apply.add_argument(
        "--diff-ignore-order",
        action="store_true",
        help="ignore patchline order differences in semantic diff",
    )
    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    try:
        if args.command == "describe":
            payload = cmd_describe()
        elif args.command == "validate-spec":
            payload = cmd_validate_spec(
                ops_spec=_read_ops_spec(args.ops),
                file=args.file,
                contextual=bool(args.contextual),
            )
        elif args.command == "apply":
            payload = apply_ops(
                filepath=args.file,
                ops_spec=_read_ops_spec(args.ops),
                dry_run=bool(args.dry_run),
                run_validate=not bool(args.skip_validate),
                allow_invalid=bool(args.allow_invalid),
                run_semantic_diff=not bool(args.skip_semantic_diff),
                diff_ignore_whitespace=bool(args.diff_ignore_whitespace),
                diff_ignore_order=bool(args.diff_ignore_order),
            )
        else:
            raise ValueError(f"unsupported command: {args.command}")
    except Exception as exc:  # pylint: disable=broad-except
        _print_json(
            {
                "ok": False,
                "command": getattr(args, "command", ""),
                "file": getattr(args, "file", ""),
                "error": f"{type(exc).__name__}: {exc}",
            },
            pretty=True,
        )
        return 1

    payload.setdefault("ok", True)
    _print_json(payload, pretty=args.pretty)
    return 0 if bool(payload.get("ok")) else 1


if __name__ == "__main__":
    raise SystemExit(main())

#!/usr/bin/env python3
"""Agent-oriented query tool for Max/MSP patch files (.maxpat/.amxd).

The tool builds a graph index from patch JSON and exposes deterministic
queries that are cheaper for agents than reading raw patch JSON repeatedly.

Subcommands:
  summary      High-level structural summary
  find         Find nodes by text/field match
  trace        Shortest-path traces between query matches
  neighborhood Local subgraph around query matches
  dump-index   Emit the full indexed IR (nodes + edges + patchers)
  semantic-diff Compare semantic graph deltas between two patch files
  export-viz   Export patch-local geometry/hierarchy for visualization
"""

from __future__ import annotations

import argparse
import json
import os
import re
import struct
import sys
from collections import Counter, defaultdict, deque
from dataclasses import dataclass
from typing import Dict, Iterable, List, Optional, Set, Tuple


# ---------------------------------------------------------------------------
# Data model
# ---------------------------------------------------------------------------


@dataclass
class Node:
    uid: str
    node_kind: str  # object | port
    patcher_path: str
    id: str
    maxclass: str
    object_name: str
    text: str
    varname: str
    numinlets: int
    numoutlets: int
    outlettype: List[str]
    has_child_patcher: bool = False
    child_patcher_path: str = ""
    parent_object_uid: str = ""
    port_dir: str = ""  # in | out
    port_index: int = -1  # 0-based for port nodes
    classnamespace: str = "box"


@dataclass
class Edge:
    src: str
    dst: str
    kind: str  # patchline | boundary_in | boundary_out | container_link
    patcher_path: str
    source_outlet: int = -1
    destination_inlet: int = -1
    order: Optional[int] = None


@dataclass
class PatcherInfo:
    path: str
    classnamespace: str
    box_count: int
    line_count: int


@dataclass
class PatchIndex:
    filepath: str
    is_m4l: bool
    nodes: Dict[str, Node]
    edges: List[Edge]
    adjacency: Dict[str, List[int]]
    reverse_adjacency: Dict[str, List[int]]
    patchers: List[PatcherInfo]


# ---------------------------------------------------------------------------
# Parsing helpers
# ---------------------------------------------------------------------------


def _read_patch_file(filepath: str) -> dict:
    ext = os.path.splitext(filepath)[1].lower()
    if ext == ".amxd":
        with open(filepath, "rb") as f:
            header = f.read(32)
            if len(header) < 32:
                raise ValueError("file too short for .amxd header")
            json_length = struct.unpack("<I", header[28:32])[0]
            body = f.read(json_length)
            return json.loads(body.decode("utf-8"))
    with open(filepath, "r", encoding="utf-8") as f:
        return json.load(f)


def _unwrap_boxes(patcher: dict) -> List[dict]:
    raw = patcher.get("boxes", [])
    return [item["box"] for item in raw if isinstance(item, dict) and "box" in item]


def _unwrap_lines(patcher: dict) -> List[dict]:
    raw = patcher.get("lines", [])
    return [item["patchline"] for item in raw if isinstance(item, dict) and "patchline" in item]


def _get_object_name(box: dict) -> str:
    if box.get("maxclass", "") == "newobj":
        text = str(box.get("text", "")).strip()
        if text:
            return text.split()[0]
        return ""
    return str(box.get("maxclass", ""))


def _get_object_args(box: dict) -> List[str]:
    text = str(box.get("text", "")).strip()
    if not text:
        return []
    parts = text.split()
    if len(parts) <= 1:
        return []
    args: List[str] = []
    for token in parts[1:]:
        if token.startswith("@"):
            break
        args.append(token)
    return args


def _looks_like_m4l(root_patcher: dict, filepath: str) -> bool:
    if filepath.lower().endswith(".amxd"):
        return True
    indicators = {"plugin~", "plugout~", "live.thisdevice"}
    for box in _unwrap_boxes(root_patcher):
        name = _get_object_name(box)
        maxclass = box.get("maxclass", "")
        if name in indicators or str(maxclass).startswith("live."):
            return True
    return False


def _box_uid(patcher_path: str, box_id: str) -> str:
    return f"{patcher_path}/{box_id}"


def _child_patcher_path(parent_path: str, box: dict) -> str:
    label = str(box.get("text", "")).strip() or str(box.get("maxclass", "subpatcher"))
    return f"{parent_path} > {label} ({box.get('id', '<no-id>')})"


def _safe_int(value: object, default: int) -> int:
    try:
        return int(value)  # type: ignore[arg-type]
    except (TypeError, ValueError):
        return default


# ---------------------------------------------------------------------------
# Index builder
# ---------------------------------------------------------------------------


class IndexBuilder:
    def __init__(self) -> None:
        self.nodes: Dict[str, Node] = {}
        self.edges: List[Edge] = []
        self.adjacency: Dict[str, List[int]] = defaultdict(list)
        self.reverse_adjacency: Dict[str, List[int]] = defaultdict(list)
        self.patchers: List[PatcherInfo] = []

    def _add_node(self, node: Node) -> str:
        uid = node.uid
        if uid not in self.nodes:
            self.nodes[uid] = node
            return uid
        suffix = 2
        while f"{uid}#{suffix}" in self.nodes:
            suffix += 1
        node.uid = f"{uid}#{suffix}"
        self.nodes[node.uid] = node
        return node.uid

    def _ensure_port_node(
        self,
        parent_uid: str,
        patcher_path: str,
        direction: str,
        index: int,
    ) -> str:
        port_uid = f"{parent_uid}::{direction}{index}"
        if port_uid in self.nodes:
            return port_uid
        parent = self.nodes.get(parent_uid)
        port = Node(
            uid=port_uid,
            node_kind="port",
            patcher_path=patcher_path,
            id=f"{parent.id if parent else parent_uid}:{direction}{index}",
            maxclass="port",
            object_name="port",
            text="",
            varname="",
            numinlets=1 if direction == "out" else 0,
            numoutlets=1 if direction == "in" else 0,
            outlettype=[],
            parent_object_uid=parent_uid,
            port_dir=direction,
            port_index=index,
            classnamespace="box",
        )
        self.nodes[port_uid] = port
        # Link container <-> port so queries targeting subpatch container objects
        # can still traverse through resolved port edges.
        if parent is not None:
            self._add_edge(
                Edge(
                    src=parent_uid,
                    dst=port_uid,
                    kind="container_link",
                    patcher_path=patcher_path,
                )
            )
            self._add_edge(
                Edge(
                    src=port_uid,
                    dst=parent_uid,
                    kind="container_link",
                    patcher_path=patcher_path,
                )
            )
        return port_uid

    def _add_edge(self, edge: Edge) -> int:
        idx = len(self.edges)
        self.edges.append(edge)
        self.adjacency[edge.src].append(idx)
        self.reverse_adjacency[edge.dst].append(idx)
        return idx

    def _collect_boundary_nodes(
        self,
        boxes: List[dict],
        classnamespace: str,
        local_uid_by_id: Dict[str, str],
    ) -> Tuple[Dict[int, str], Dict[int, str]]:
        inlet_uids: Dict[int, str] = {}
        outlet_uids: Dict[int, str] = {}

        if classnamespace == "dsp.gen":
            for box in boxes:
                uid = local_uid_by_id.get(box.get("id", ""))
                if not uid:
                    continue
                if box.get("maxclass") != "newobj":
                    continue
                name = _get_object_name(box)
                args = _get_object_args(box)
                if not args:
                    continue
                if not args[0].isdigit():
                    continue
                idx = int(args[0])
                if name == "in":
                    inlet_uids[idx] = uid
                elif name == "out":
                    outlet_uids[idx] = uid
            return inlet_uids, outlet_uids

        for box in boxes:
            uid = local_uid_by_id.get(box.get("id", ""))
            if not uid:
                continue
            maxclass = box.get("maxclass", "")
            idx = _safe_int(box.get("index"), 0)
            if idx <= 0:
                continue
            if maxclass == "inlet":
                inlet_uids[idx] = uid
            elif maxclass == "outlet":
                outlet_uids[idx] = uid
        return inlet_uids, outlet_uids

    def _index_patcher(
        self,
        patcher: dict,
        patcher_path: str,
        parent_object_uid: str = "",
    ) -> Dict[str, Dict[int, str]]:
        classnamespace = str(patcher.get("classnamespace", "box"))
        boxes = _unwrap_boxes(patcher)
        lines = _unwrap_lines(patcher)

        self.patchers.append(
            PatcherInfo(
                path=patcher_path,
                classnamespace=classnamespace,
                box_count=len(boxes),
                line_count=len(lines),
            )
        )

        local_uid_by_id: Dict[str, str] = {}
        subpatch_uids: Set[str] = set()

        # Object nodes at this patcher level.
        for box in boxes:
            box_id = str(box.get("id", ""))
            if not box_id:
                continue
            uid = _box_uid(patcher_path, box_id)
            node = Node(
                uid=uid,
                node_kind="object",
                patcher_path=patcher_path,
                id=box_id,
                maxclass=str(box.get("maxclass", "")),
                object_name=_get_object_name(box),
                text=str(box.get("text", "")),
                varname=str(box.get("varname", "")),
                numinlets=_safe_int(box.get("numinlets"), 0),
                numoutlets=_safe_int(box.get("numoutlets"), 0),
                outlettype=list(box.get("outlettype", [])) if isinstance(box.get("outlettype"), list) else [],
                parent_object_uid=parent_object_uid,
                classnamespace=classnamespace,
            )
            uid = self._add_node(node)
            local_uid_by_id[box_id] = uid
            if "patcher" in box and isinstance(box["patcher"], dict):
                subpatch_uids.add(uid)

        # Recurse into child patchers and wire boundary edges.
        for box in boxes:
            if "patcher" not in box or not isinstance(box["patcher"], dict):
                continue
            box_id = str(box.get("id", ""))
            parent_uid = local_uid_by_id.get(box_id)
            if not parent_uid:
                continue

            child_path = _child_patcher_path(patcher_path, box)
            if parent_uid in self.nodes:
                self.nodes[parent_uid].has_child_patcher = True
                self.nodes[parent_uid].child_patcher_path = child_path

            child_boundary = self._index_patcher(
                box["patcher"], child_path, parent_object_uid=parent_uid
            )

            parent_inlets = max(_safe_int(box.get("numinlets"), 0), 0)
            parent_outlets = max(_safe_int(box.get("numoutlets"), 0), 0)

            for inlet_idx in range(parent_inlets):
                port_uid = self._ensure_port_node(parent_uid, patcher_path, "in", inlet_idx)
                child_in_uid = child_boundary["inlets"].get(inlet_idx + 1)
                if child_in_uid:
                    self._add_edge(
                        Edge(
                            src=port_uid,
                            dst=child_in_uid,
                            kind="boundary_in",
                            patcher_path=patcher_path,
                            source_outlet=0,
                            destination_inlet=0,
                        )
                    )

            for outlet_idx in range(parent_outlets):
                port_uid = self._ensure_port_node(parent_uid, patcher_path, "out", outlet_idx)
                child_out_uid = child_boundary["outlets"].get(outlet_idx + 1)
                if child_out_uid:
                    self._add_edge(
                        Edge(
                            src=child_out_uid,
                            dst=port_uid,
                            kind="boundary_out",
                            patcher_path=patcher_path,
                            source_outlet=0,
                            destination_inlet=0,
                        )
                    )

        # Resolved patchline edges.
        for line in lines:
            src = line.get("source", [])
            dst = line.get("destination", [])
            if not isinstance(src, list) or not isinstance(dst, list):
                continue
            if len(src) < 2 or len(dst) < 2:
                continue

            src_id = str(src[0])
            dst_id = str(dst[0])
            src_outlet = _safe_int(src[1], -1)
            dst_inlet = _safe_int(dst[1], -1)

            src_uid = local_uid_by_id.get(src_id)
            dst_uid = local_uid_by_id.get(dst_id)
            if not src_uid or not dst_uid:
                continue

            resolved_src = src_uid
            resolved_dst = dst_uid

            if src_uid in subpatch_uids:
                resolved_src = self._ensure_port_node(src_uid, patcher_path, "out", src_outlet)
            if dst_uid in subpatch_uids:
                resolved_dst = self._ensure_port_node(dst_uid, patcher_path, "in", dst_inlet)

            self._add_edge(
                Edge(
                    src=resolved_src,
                    dst=resolved_dst,
                    kind="patchline",
                    patcher_path=patcher_path,
                    source_outlet=src_outlet,
                    destination_inlet=dst_inlet,
                    order=_safe_int(line.get("order"), -1) if "order" in line else None,
                )
            )

        inlet_uids, outlet_uids = self._collect_boundary_nodes(
            boxes, classnamespace, local_uid_by_id
        )
        return {"inlets": inlet_uids, "outlets": outlet_uids}

    def build(self, filepath: str) -> PatchIndex:
        data = _read_patch_file(filepath)
        if not isinstance(data, dict) or "patcher" not in data:
            raise ValueError("missing top-level 'patcher' key")
        root = data["patcher"]
        self._index_patcher(root, "root")
        return PatchIndex(
            filepath=filepath,
            is_m4l=_looks_like_m4l(root, filepath),
            nodes=self.nodes,
            edges=self.edges,
            adjacency=self.adjacency,
            reverse_adjacency=self.reverse_adjacency,
            patchers=self.patchers,
        )


# ---------------------------------------------------------------------------
# Query helpers
# ---------------------------------------------------------------------------


FIND_FIELDS = {
    "uid",
    "node_kind",
    "patcher_path",
    "id",
    "maxclass",
    "object_name",
    "text",
    "varname",
    "parent_object_uid",
}


def _node_to_payload(node: Node) -> dict:
    return {
        "uid": node.uid,
        "node_kind": node.node_kind,
        "patcher_path": node.patcher_path,
        "id": node.id,
        "maxclass": node.maxclass,
        "object_name": node.object_name,
        "text": node.text,
        "varname": node.varname,
        "numinlets": node.numinlets,
        "numoutlets": node.numoutlets,
        "outlettype": node.outlettype,
        "has_child_patcher": node.has_child_patcher,
        "child_patcher_path": node.child_patcher_path,
        "parent_object_uid": node.parent_object_uid,
        "port_dir": node.port_dir,
        "port_index": node.port_index,
        "classnamespace": node.classnamespace,
    }


def _edge_to_payload(idx: int, edge: Edge) -> dict:
    return {
        "edge_index": idx,
        "src": edge.src,
        "dst": edge.dst,
        "kind": edge.kind,
        "patcher_path": edge.patcher_path,
        "source_outlet": edge.source_outlet,
        "destination_inlet": edge.destination_inlet,
        "order": edge.order,
    }


def _normalize_fields(raw_fields: str) -> List[str]:
    if raw_fields.strip().lower() in ("all", "*"):
        return sorted(FIND_FIELDS)
    fields = [f.strip() for f in raw_fields.split(",") if f.strip()]
    invalid = [f for f in fields if f not in FIND_FIELDS]
    if invalid:
        raise ValueError(f"invalid field(s): {', '.join(invalid)}")
    if not fields:
        raise ValueError("no find fields specified")
    return fields


def _field_value(node: Node, field: str) -> str:
    value = getattr(node, field, "")
    if value is None:
        return ""
    return str(value)


def _node_matches(
    node: Node,
    query: str,
    fields: List[str],
    use_regex: bool,
    case_sensitive: bool,
) -> bool:
    if use_regex:
        flags = 0 if case_sensitive else re.IGNORECASE
        pattern = re.compile(query, flags)
        return any(pattern.search(_field_value(node, field) or "") for field in fields)
    if case_sensitive:
        return any(query in _field_value(node, field) for field in fields)
    q = query.lower()
    return any(q in _field_value(node, field).lower() for field in fields)


def find_nodes(
    index: PatchIndex,
    query: str,
    fields: List[str],
    use_regex: bool,
    case_sensitive: bool,
    include_ports: bool,
    limit: int,
) -> List[Node]:
    nodes = []
    for node in index.nodes.values():
        if not include_ports and node.node_kind == "port":
            continue
        if _node_matches(node, query, fields, use_regex, case_sensitive):
            nodes.append(node)
    nodes.sort(key=lambda n: (n.patcher_path, n.id, n.uid))
    if limit > 0:
        nodes = nodes[:limit]
    return nodes


def _shortest_paths_to_targets(
    index: PatchIndex,
    src_uid: str,
    target_uids: Set[str],
    max_depth: int,
) -> List[Tuple[str, List[str], List[int]]]:
    if src_uid in target_uids:
        return [(src_uid, [src_uid], [])]

    queue: deque[str] = deque([src_uid])
    depth: Dict[str, int] = {src_uid: 0}
    prev: Dict[str, Tuple[str, int]] = {}
    found: List[str] = []

    while queue:
        uid = queue.popleft()
        d = depth[uid]
        if d >= max_depth:
            continue
        for edge_idx in index.adjacency.get(uid, []):
            edge = index.edges[edge_idx]
            nxt = edge.dst
            if nxt in depth:
                continue
            depth[nxt] = d + 1
            prev[nxt] = (uid, edge_idx)
            if nxt in target_uids:
                found.append(nxt)
            queue.append(nxt)

    results: List[Tuple[str, List[str], List[int]]] = []
    for target in sorted(found, key=lambda uid: depth[uid]):
        path_nodes = [target]
        path_edges: List[int] = []
        current = target
        while current != src_uid:
            pnode, pedge = prev[current]
            path_nodes.append(pnode)
            path_edges.append(pedge)
            current = pnode
        path_nodes.reverse()
        path_edges.reverse()
        results.append((target, path_nodes, path_edges))
    return results


def _node_label(node: Node) -> str:
    if node.varname:
        return node.varname
    if node.text:
        return node.text
    if node.object_name:
        return node.object_name
    return node.maxclass


# ---------------------------------------------------------------------------
# Commands
# ---------------------------------------------------------------------------


def cmd_summary(index: PatchIndex) -> dict:
    object_nodes = [n for n in index.nodes.values() if n.node_kind == "object"]
    port_nodes = [n for n in index.nodes.values() if n.node_kind == "port"]
    subpatch_nodes = [n for n in object_nodes if n.has_child_patcher]

    maxclass_counter = Counter(n.maxclass for n in object_nodes)
    object_name_counter = Counter(n.object_name for n in object_nodes if n.object_name)

    return {
        "file": index.filepath,
        "is_m4l": index.is_m4l,
        "counts": {
            "patchers": len(index.patchers),
            "nodes_total": len(index.nodes),
            "object_nodes": len(object_nodes),
            "port_nodes": len(port_nodes),
            "edges_total": len(index.edges),
            "subpatcher_objects": len(subpatch_nodes),
        },
        "top_maxclasses": maxclass_counter.most_common(25),
        "top_object_names": object_name_counter.most_common(25),
        "patchers": [
            {
                "path": p.path,
                "classnamespace": p.classnamespace,
                "box_count": p.box_count,
                "line_count": p.line_count,
            }
            for p in index.patchers
        ],
        "subpatchers": [
            {
                "uid": n.uid,
                "patcher_path": n.patcher_path,
                "id": n.id,
                "label": _node_label(n),
                "child_patcher_path": n.child_patcher_path,
                "numinlets": n.numinlets,
                "numoutlets": n.numoutlets,
            }
            for n in subpatch_nodes
        ],
    }


def cmd_find(
    index: PatchIndex,
    query: str,
    fields: List[str],
    regex: bool,
    case_sensitive: bool,
    include_ports: bool,
    limit: int,
) -> dict:
    matches = find_nodes(
        index=index,
        query=query,
        fields=fields,
        use_regex=regex,
        case_sensitive=case_sensitive,
        include_ports=include_ports,
        limit=limit,
    )
    return {
        "file": index.filepath,
        "query": query,
        "fields": fields,
        "regex": regex,
        "case_sensitive": case_sensitive,
        "include_ports": include_ports,
        "count": len(matches),
        "matches": [_node_to_payload(node) for node in matches],
    }


def cmd_trace(
    index: PatchIndex,
    from_query: str,
    to_query: str,
    fields: List[str],
    regex: bool,
    case_sensitive: bool,
    include_ports: bool,
    max_depth: int,
    max_paths: int,
    from_limit: int,
    to_limit: int,
) -> dict:
    sources = find_nodes(
        index, from_query, fields, regex, case_sensitive, include_ports, from_limit
    )
    targets = find_nodes(
        index, to_query, fields, regex, case_sensitive, include_ports, to_limit
    )
    target_uids = {node.uid for node in targets}

    paths = []
    for src in sources:
        if len(paths) >= max_paths:
            break
        candidates = _shortest_paths_to_targets(index, src.uid, target_uids, max_depth)
        for target_uid, node_uids, edge_indices in candidates:
            paths.append(
                {
                    "source_uid": src.uid,
                    "target_uid": target_uid,
                    "hops": len(edge_indices),
                    "nodes": [_node_to_payload(index.nodes[uid]) for uid in node_uids],
                    "edges": [_edge_to_payload(i, index.edges[i]) for i in edge_indices],
                }
            )
            if len(paths) >= max_paths:
                break

    paths.sort(key=lambda item: item["hops"])
    return {
        "file": index.filepath,
        "from_query": from_query,
        "to_query": to_query,
        "fields": fields,
        "regex": regex,
        "case_sensitive": case_sensitive,
        "include_ports": include_ports,
        "max_depth": max_depth,
        "source_count": len(sources),
        "target_count": len(targets),
        "path_count": len(paths),
        "paths": paths,
        "sources": [_node_to_payload(node) for node in sources],
        "targets": [_node_to_payload(node) for node in targets],
    }


def cmd_neighborhood(
    index: PatchIndex,
    query: str,
    fields: List[str],
    regex: bool,
    case_sensitive: bool,
    include_ports: bool,
    hops: int,
    seed_limit: int,
    max_nodes: int,
) -> dict:
    seeds = find_nodes(
        index, query, fields, regex, case_sensitive, include_ports, seed_limit
    )
    seed_uids = [node.uid for node in seeds]

    visited: Set[str] = set(seed_uids)
    queue: deque[Tuple[str, int]] = deque((uid, 0) for uid in seed_uids)

    while queue and len(visited) < max_nodes:
        uid, depth = queue.popleft()
        if depth >= hops:
            continue

        for edge_idx in index.adjacency.get(uid, []):
            nxt = index.edges[edge_idx].dst
            if nxt not in visited:
                visited.add(nxt)
                queue.append((nxt, depth + 1))
                if len(visited) >= max_nodes:
                    break

        if len(visited) >= max_nodes:
            break

        for edge_idx in index.reverse_adjacency.get(uid, []):
            prev = index.edges[edge_idx].src
            if prev not in visited:
                visited.add(prev)
                queue.append((prev, depth + 1))
                if len(visited) >= max_nodes:
                    break

    edge_payloads = []
    for idx, edge in enumerate(index.edges):
        if edge.src in visited and edge.dst in visited:
            edge_payloads.append(_edge_to_payload(idx, edge))

    node_payloads = [_node_to_payload(index.nodes[uid]) for uid in sorted(visited)]
    return {
        "file": index.filepath,
        "query": query,
        "fields": fields,
        "regex": regex,
        "case_sensitive": case_sensitive,
        "include_ports": include_ports,
        "hops": hops,
        "seed_count": len(seeds),
        "node_count": len(node_payloads),
        "edge_count": len(edge_payloads),
        "seeds": [_node_to_payload(node) for node in seeds],
        "nodes": node_payloads,
        "edges": edge_payloads,
    }


def cmd_dump_index(index: PatchIndex) -> dict:
    return {
        "file": index.filepath,
        "is_m4l": index.is_m4l,
        "patchers": [
            {
                "path": p.path,
                "classnamespace": p.classnamespace,
                "box_count": p.box_count,
                "line_count": p.line_count,
            }
            for p in index.patchers
        ],
        "nodes": [_node_to_payload(node) for node in index.nodes.values()],
        "edges": [_edge_to_payload(i, edge) for i, edge in enumerate(index.edges)],
    }


def _to_float_list(value: object, length: int) -> List[float]:
    if not isinstance(value, list) or len(value) < length:
        return []
    out: List[float] = []
    for idx in range(length):
        try:
            out.append(float(value[idx]))
        except (TypeError, ValueError):
            return []
    return out


def _to_midpoints(value: object) -> List[float]:
    if not isinstance(value, list):
        return []
    out: List[float] = []
    for item in value:
        try:
            out.append(float(item))
        except (TypeError, ValueError):
            return []
    return out


def _box_to_viz_payload(box: dict, patcher_path: str, parent_object_uid: str) -> dict:
    box_id = str(box.get("id", ""))
    has_child_patcher = isinstance(box.get("patcher"), dict)
    child_path = _child_patcher_path(patcher_path, box) if has_child_patcher else ""
    return {
        "uid": _box_uid(patcher_path, box_id),
        "patcher_path": patcher_path,
        "id": box_id,
        "maxclass": str(box.get("maxclass", "")),
        "object_name": _get_object_name(box),
        "text": str(box.get("text", "")),
        "varname": str(box.get("varname", "")),
        "numinlets": _safe_int(box.get("numinlets"), 0),
        "numoutlets": _safe_int(box.get("numoutlets"), 0),
        "outlettype": list(box.get("outlettype", []))
        if isinstance(box.get("outlettype"), list)
        else [],
        "patching_rect": _to_float_list(box.get("patching_rect"), 4),
        "presentation": bool(_safe_int(box.get("presentation"), 0)),
        "presentation_rect": _to_float_list(box.get("presentation_rect"), 4),
        "has_child_patcher": has_child_patcher,
        "child_patcher_path": child_path,
        "parent_object_uid": parent_object_uid,
    }


def _patcher_rect(patcher: dict, boxes: List[dict]) -> List[float]:
    rect = _to_float_list(patcher.get("rect"), 4)
    if rect:
        return rect
    x_min = 0.0
    y_min = 0.0
    x_max = 1200.0
    y_max = 800.0
    if boxes:
        coords: List[Tuple[float, float, float, float]] = []
        for box in boxes:
            r = _to_float_list(box.get("patching_rect"), 4)
            if r:
                coords.append((r[0], r[1], r[2], r[3]))
        if coords:
            x_min = min(item[0] for item in coords) - 120.0
            y_min = min(item[1] for item in coords) - 120.0
            x_max = max(item[0] + item[2] for item in coords) + 120.0
            y_max = max(item[1] + item[3] for item in coords) + 120.0
    return [x_min, y_min, max(200.0, x_max - x_min), max(200.0, y_max - y_min)]


def cmd_export_viz(filepath: str) -> dict:
    data = _read_patch_file(filepath)
    if not isinstance(data, dict) or "patcher" not in data:
        raise ValueError("missing top-level 'patcher' key")
    root = data["patcher"]

    patchers: List[dict] = []
    total_boxes = 0
    total_lines = 0

    def walk(patcher: dict, patcher_path: str, parent_object_uid: str = "") -> None:
        nonlocal total_boxes
        nonlocal total_lines
        classnamespace = str(patcher.get("classnamespace", "box"))
        boxes = _unwrap_boxes(patcher)
        lines = _unwrap_lines(patcher)

        box_payloads: List[dict] = []
        uid_by_id: Dict[str, str] = {}
        for box in boxes:
            payload = _box_to_viz_payload(box, patcher_path, parent_object_uid)
            if not payload["id"]:
                continue
            box_payloads.append(payload)
            uid_by_id[payload["id"]] = payload["uid"]

        line_payloads: List[dict] = []
        for line in lines:
            src = line.get("source", [])
            dst = line.get("destination", [])
            if not isinstance(src, list) or not isinstance(dst, list):
                continue
            if len(src) < 2 or len(dst) < 2:
                continue

            source_id = str(src[0])
            destination_id = str(dst[0])
            source_outlet = _safe_int(src[1], -1)
            destination_inlet = _safe_int(dst[1], -1)
            line_payloads.append(
                {
                    "patcher_path": patcher_path,
                    "source_id": source_id,
                    "destination_id": destination_id,
                    "source_uid": uid_by_id.get(source_id, _box_uid(patcher_path, source_id)),
                    "destination_uid": uid_by_id.get(
                        destination_id, _box_uid(patcher_path, destination_id)
                    ),
                    "source_outlet": source_outlet,
                    "destination_inlet": destination_inlet,
                    "order": _safe_int(line.get("order"), -1) if "order" in line else None,
                    "midpoints": _to_midpoints(line.get("midpoints")),
                }
            )

        patcher_payload = {
            "path": patcher_path,
            "parent_object_uid": parent_object_uid,
            "classnamespace": classnamespace,
            "rect": _patcher_rect(patcher, boxes),
            "boxes": box_payloads,
            "lines": line_payloads,
            "box_count": len(box_payloads),
            "line_count": len(line_payloads),
        }
        patchers.append(patcher_payload)
        total_boxes += len(box_payloads)
        total_lines += len(line_payloads)

        for box in boxes:
            if not isinstance(box.get("patcher"), dict):
                continue
            box_id = str(box.get("id", ""))
            if not box_id:
                continue
            child_parent_uid = uid_by_id.get(box_id, _box_uid(patcher_path, box_id))
            walk(
                box["patcher"],
                _child_patcher_path(patcher_path, box),
                parent_object_uid=child_parent_uid,
            )

    walk(root, "root")

    return {
        "file": filepath,
        "is_m4l": _looks_like_m4l(root, filepath),
        "root_patcher_path": "root",
        "counts": {
            "patchers": len(patchers),
            "boxes": total_boxes,
            "lines": total_lines,
        },
        "patchers": patchers,
    }


def _normalize_text_for_diff(value: str, ignore_whitespace: bool) -> str:
    if not ignore_whitespace:
        return value
    return " ".join(value.split())


def _node_identity_key(node: Node) -> Tuple[str, str, str]:
    return (node.node_kind, node.patcher_path, node.id)


def _node_semantic_signature(node: Node, ignore_whitespace: bool) -> dict:
    return {
        "maxclass": node.maxclass,
        "object_name": node.object_name,
        "text": _normalize_text_for_diff(node.text, ignore_whitespace),
        "varname": _normalize_text_for_diff(node.varname, ignore_whitespace),
        "numinlets": node.numinlets,
        "numoutlets": node.numoutlets,
        "outlettype": tuple(node.outlettype),
        "has_child_patcher": node.has_child_patcher,
        "child_patcher_path": node.child_patcher_path,
        "parent_object_uid": node.parent_object_uid,
        "port_dir": node.port_dir,
        "port_index": node.port_index,
        "classnamespace": node.classnamespace,
    }


def _edge_semantic_key(
    edge: Edge, compare_order: bool
) -> Tuple[str, str, str, str, int, int, Optional[int]]:
    return (
        edge.kind,
        edge.patcher_path,
        edge.src,
        edge.dst,
        edge.source_outlet,
        edge.destination_inlet,
        edge.order if compare_order else None,
    )


def _edge_payload_with_labels(edge: Edge, index: PatchIndex, instances: int) -> dict:
    src_node = index.nodes.get(edge.src)
    dst_node = index.nodes.get(edge.dst)
    return {
        "instances": instances,
        "src": edge.src,
        "dst": edge.dst,
        "kind": edge.kind,
        "patcher_path": edge.patcher_path,
        "source_outlet": edge.source_outlet,
        "destination_inlet": edge.destination_inlet,
        "order": edge.order,
        "src_node_kind": src_node.node_kind if src_node else "",
        "dst_node_kind": dst_node.node_kind if dst_node else "",
        "src_label": _node_label(src_node) if src_node else "",
        "dst_label": _node_label(dst_node) if dst_node else "",
    }


def _truncate_payload(items: List[dict], max_items: int) -> Tuple[List[dict], bool]:
    if max_items < 0:
        max_items = 0
    if len(items) <= max_items:
        return items, False
    return items[:max_items], True


def cmd_semantic_diff(
    base_index: PatchIndex,
    target_index: PatchIndex,
    include_ports: bool,
    ignore_whitespace: bool,
    compare_order: bool,
    include_container_links: bool,
    max_node_details: int,
    max_edge_details: int,
) -> dict:
    base_nodes: Dict[Tuple[str, str, str], Node] = {}
    target_nodes: Dict[Tuple[str, str, str], Node] = {}

    def _include_node(node: Node) -> bool:
        return include_ports or node.node_kind != "port"

    def _collect_nodes(src_index: PatchIndex) -> Dict[Tuple[str, str, str], Node]:
        node_map: Dict[Tuple[str, str, str], Node] = {}
        for node in src_index.nodes.values():
            if not _include_node(node):
                continue
            key = _node_identity_key(node)
            prev = node_map.get(key)
            if prev is None or node.uid < prev.uid:
                node_map[key] = node
        return node_map

    base_nodes = _collect_nodes(base_index)
    target_nodes = _collect_nodes(target_index)

    base_node_keys = set(base_nodes.keys())
    target_node_keys = set(target_nodes.keys())
    node_added_keys = sorted(target_node_keys - base_node_keys)
    node_removed_keys = sorted(base_node_keys - target_node_keys)
    node_common_keys = sorted(base_node_keys & target_node_keys)

    nodes_added = [_node_to_payload(target_nodes[key]) for key in node_added_keys]
    nodes_removed = [_node_to_payload(base_nodes[key]) for key in node_removed_keys]

    nodes_modified: List[dict] = []
    for key in node_common_keys:
        before_node = base_nodes[key]
        after_node = target_nodes[key]
        before_sig = _node_semantic_signature(before_node, ignore_whitespace)
        after_sig = _node_semantic_signature(after_node, ignore_whitespace)
        if before_sig == after_sig:
            continue
        field_diffs = []
        for field in sorted(set(before_sig.keys()) | set(after_sig.keys())):
            before_val = before_sig.get(field)
            after_val = after_sig.get(field)
            if before_val != after_val:
                field_diffs.append(
                    {
                        "field": field,
                        "before": before_val,
                        "after": after_val,
                    }
                )
        nodes_modified.append(
            {
                "identity": {
                    "node_kind": key[0],
                    "patcher_path": key[1],
                    "id": key[2],
                },
                "changed_fields": [item["field"] for item in field_diffs],
                "field_diffs": field_diffs,
                "before": _node_to_payload(before_node),
                "after": _node_to_payload(after_node),
            }
        )

    nodes_added.sort(key=lambda item: (item["patcher_path"], item["id"], item["uid"]))
    nodes_removed.sort(key=lambda item: (item["patcher_path"], item["id"], item["uid"]))
    nodes_modified.sort(
        key=lambda item: (
            item["identity"]["patcher_path"],
            item["identity"]["id"],
            item["identity"]["node_kind"],
        )
    )

    allowed_edge_kinds = {"patchline", "boundary_in", "boundary_out"}
    if include_container_links:
        allowed_edge_kinds.add("container_link")

    def _collect_edges(src_index: PatchIndex) -> Tuple[Counter, Dict[tuple, Edge]]:
        counts: Counter = Counter()
        exemplar_by_key: Dict[tuple, Edge] = {}
        for edge in src_index.edges:
            if edge.kind not in allowed_edge_kinds:
                continue
            key = _edge_semantic_key(edge, compare_order=compare_order)
            counts[key] += 1
            exemplar_by_key.setdefault(key, edge)
        return counts, exemplar_by_key

    base_edge_counts, base_edge_examples = _collect_edges(base_index)
    target_edge_counts, target_edge_examples = _collect_edges(target_index)
    all_edge_keys = sorted(set(base_edge_counts.keys()) | set(target_edge_counts.keys()))

    edges_added: List[dict] = []
    edges_removed: List[dict] = []
    for key in all_edge_keys:
        base_count = base_edge_counts.get(key, 0)
        target_count = target_edge_counts.get(key, 0)
        if target_count > base_count:
            edges_added.append(
                _edge_payload_with_labels(
                    target_edge_examples[key], target_index, target_count - base_count
                )
            )
        elif base_count > target_count:
            edges_removed.append(
                _edge_payload_with_labels(
                    base_edge_examples[key], base_index, base_count - target_count
                )
            )

    edges_added.sort(
        key=lambda item: (
            item["patcher_path"],
            item["kind"],
            item["src"],
            item["dst"],
            item["source_outlet"],
            item["destination_inlet"],
            item["order"] if item["order"] is not None else -1,
        )
    )
    edges_removed.sort(
        key=lambda item: (
            item["patcher_path"],
            item["kind"],
            item["src"],
            item["dst"],
            item["source_outlet"],
            item["destination_inlet"],
            item["order"] if item["order"] is not None else -1,
        )
    )

    nodes_added_shown, nodes_added_truncated = _truncate_payload(
        nodes_added, max_node_details
    )
    nodes_removed_shown, nodes_removed_truncated = _truncate_payload(
        nodes_removed, max_node_details
    )
    nodes_modified_shown, nodes_modified_truncated = _truncate_payload(
        nodes_modified, max_node_details
    )
    edges_added_shown, edges_added_truncated = _truncate_payload(
        edges_added, max_edge_details
    )
    edges_removed_shown, edges_removed_truncated = _truncate_payload(
        edges_removed, max_edge_details
    )

    is_equal = not (
        node_added_keys
        or node_removed_keys
        or nodes_modified
        or edges_added
        or edges_removed
    )

    return {
        "base_file": base_index.filepath,
        "target_file": target_index.filepath,
        "settings": {
            "include_ports_in_node_diff": include_ports,
            "ignore_whitespace": ignore_whitespace,
            "compare_order": compare_order,
            "include_container_links": include_container_links,
            "max_node_details": max_node_details,
            "max_edge_details": max_edge_details,
        },
        "summary": {
            "is_semantically_equal": is_equal,
            "nodes_added": len(nodes_added),
            "nodes_removed": len(nodes_removed),
            "nodes_modified": len(nodes_modified),
            "edges_added": len(edges_added),
            "edges_removed": len(edges_removed),
        },
        "nodes": {
            "added_total": len(nodes_added),
            "added_shown": len(nodes_added_shown),
            "added_truncated": nodes_added_truncated,
            "removed_total": len(nodes_removed),
            "removed_shown": len(nodes_removed_shown),
            "removed_truncated": nodes_removed_truncated,
            "modified_total": len(nodes_modified),
            "modified_shown": len(nodes_modified_shown),
            "modified_truncated": nodes_modified_truncated,
            "added": nodes_added_shown,
            "removed": nodes_removed_shown,
            "modified": nodes_modified_shown,
        },
        "edges": {
            "added_total": len(edges_added),
            "added_shown": len(edges_added_shown),
            "added_truncated": edges_added_truncated,
            "removed_total": len(edges_removed),
            "removed_shown": len(edges_removed_shown),
            "removed_truncated": edges_removed_truncated,
            "added": edges_added_shown,
            "removed": edges_removed_shown,
        },
    }


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------


def _print_json(payload: dict, pretty: bool) -> None:
    if pretty:
        print(json.dumps(payload, indent=2, sort_keys=False))
        return
    print(json.dumps(payload, separators=(",", ":"), sort_keys=False))


def _add_common_find_args(parser: argparse.ArgumentParser) -> None:
    parser.add_argument(
        "--fields",
        default="text,varname,id,object_name,maxclass",
        help=(
            "comma-separated find fields or 'all' "
            "(default: text,varname,id,object_name,maxclass)"
        ),
    )
    parser.add_argument("--regex", action="store_true", help="treat query as regex")
    parser.add_argument(
        "--case-sensitive",
        action="store_true",
        help="case-sensitive match (default: case-insensitive)",
    )
    parser.add_argument(
        "--include-ports",
        action="store_true",
        help="include synthetic port nodes in matching",
    )


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Agent-oriented graph query tool for Max patch files"
    )
    parser.add_argument(
        "--pretty",
        action="store_true",
        help="pretty-print JSON output",
    )

    sub = parser.add_subparsers(dest="command", required=True)

    p_summary = sub.add_parser("summary", help="emit structural summary")
    p_summary.add_argument("file", help=".maxpat or .amxd file")

    p_find = sub.add_parser("find", help="find nodes by query")
    p_find.add_argument("file", help=".maxpat or .amxd file")
    p_find.add_argument("query", help="query string")
    _add_common_find_args(p_find)
    p_find.add_argument("--limit", type=int, default=200, help="max matches (default: 200)")

    p_trace = sub.add_parser("trace", help="trace shortest paths between query matches")
    p_trace.add_argument("file", help=".maxpat or .amxd file")
    p_trace.add_argument("--from", dest="from_query", required=True, help="source query")
    p_trace.add_argument("--to", dest="to_query", required=True, help="target query")
    _add_common_find_args(p_trace)
    p_trace.add_argument("--max-depth", type=int, default=20, help="BFS depth limit")
    p_trace.add_argument("--max-paths", type=int, default=20, help="max returned paths")
    p_trace.add_argument("--from-limit", type=int, default=20, help="max source matches")
    p_trace.add_argument("--to-limit", type=int, default=20, help="max target matches")

    p_nh = sub.add_parser("neighborhood", help="local subgraph around query matches")
    p_nh.add_argument("file", help=".maxpat or .amxd file")
    p_nh.add_argument("query", help="seed query")
    _add_common_find_args(p_nh)
    p_nh.add_argument("--hops", type=int, default=2, help="graph hop radius")
    p_nh.add_argument("--seed-limit", type=int, default=20, help="max seed matches")
    p_nh.add_argument("--max-nodes", type=int, default=300, help="max nodes in subgraph")

    p_dump = sub.add_parser("dump-index", help="emit full index")
    p_dump.add_argument("file", help=".maxpat or .amxd file")

    p_export = sub.add_parser(
        "export-viz", help="export patch-local geometry and hierarchy for visualization"
    )
    p_export.add_argument("file", help=".maxpat or .amxd file")

    p_diff = sub.add_parser(
        "semantic-diff", help="compare semantic graph deltas between two patch files"
    )
    p_diff.add_argument("base_file", help="baseline .maxpat or .amxd file")
    p_diff.add_argument("target_file", help="target .maxpat or .amxd file")
    p_diff.add_argument(
        "--include-ports",
        action="store_true",
        help="include synthetic port nodes in node-level diff",
    )
    p_diff.add_argument(
        "--ignore-whitespace",
        action="store_true",
        help="normalize whitespace in node text/varname before comparing",
    )
    p_diff.add_argument(
        "--ignore-order",
        action="store_true",
        help="ignore patchline order field when comparing edges",
    )
    p_diff.add_argument(
        "--include-container-links",
        action="store_true",
        help="include synthetic container_link edges in edge diff",
    )
    p_diff.add_argument(
        "--max-node-details",
        type=int,
        default=200,
        help="max node records shown per node diff section",
    )
    p_diff.add_argument(
        "--max-edge-details",
        type=int,
        default=400,
        help="max edge records shown per edge diff section",
    )

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    try:
        if args.command == "semantic-diff":
            base_index = IndexBuilder().build(args.base_file)
            target_index = IndexBuilder().build(args.target_file)
            payload = cmd_semantic_diff(
                base_index=base_index,
                target_index=target_index,
                include_ports=args.include_ports,
                ignore_whitespace=args.ignore_whitespace,
                compare_order=not args.ignore_order,
                include_container_links=args.include_container_links,
                max_node_details=max(args.max_node_details, 0),
                max_edge_details=max(args.max_edge_details, 0),
            )
        elif args.command == "export-viz":
            payload = cmd_export_viz(args.file)
        else:
            index = IndexBuilder().build(args.file)

        if args.command == "summary":
            payload = cmd_summary(index)
        elif args.command == "find":
            payload = cmd_find(
                index=index,
                query=args.query,
                fields=_normalize_fields(args.fields),
                regex=args.regex,
                case_sensitive=args.case_sensitive,
                include_ports=args.include_ports,
                limit=args.limit,
            )
        elif args.command == "trace":
            payload = cmd_trace(
                index=index,
                from_query=args.from_query,
                to_query=args.to_query,
                fields=_normalize_fields(args.fields),
                regex=args.regex,
                case_sensitive=args.case_sensitive,
                include_ports=args.include_ports,
                max_depth=max(args.max_depth, 0),
                max_paths=max(args.max_paths, 0),
                from_limit=max(args.from_limit, 0),
                to_limit=max(args.to_limit, 0),
            )
        elif args.command == "neighborhood":
            payload = cmd_neighborhood(
                index=index,
                query=args.query,
                fields=_normalize_fields(args.fields),
                regex=args.regex,
                case_sensitive=args.case_sensitive,
                include_ports=args.include_ports,
                hops=max(args.hops, 0),
                seed_limit=max(args.seed_limit, 0),
                max_nodes=max(args.max_nodes, 1),
            )
        elif args.command == "dump-index":
            payload = cmd_dump_index(index)
        elif args.command == "export-viz":
            pass
        elif args.command == "semantic-diff":
            pass
        else:
            raise ValueError(f"unsupported command: {args.command}")
    except Exception as exc:  # pylint: disable=broad-except
        file_value = ""
        if hasattr(args, "file"):
            file_value = args.file
        elif hasattr(args, "base_file") and hasattr(args, "target_file"):
            file_value = f"{args.base_file} -> {args.target_file}"
        _print_json(
            {
                "ok": False,
                "error": f"{type(exc).__name__}: {exc}",
                "file": file_value,
                "command": args.command,
            },
            pretty=True,
        )
        return 1

    payload["ok"] = True
    _print_json(payload, pretty=args.pretty)
    return 0


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""Optional SQLite cache for agent-friendly Max patch querying.

This cache is DERIVED from `.maxpat` / `.amxd` files and is never canonical.
It provides:
- FTS5 text lookup over indexed nodes
- RTree spatial lookup over patching/presentation geometry
- file metadata to support incremental indexing

JSON-only stdout output.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import sqlite3
import sys
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Tuple


REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from tools import maxpat_query  # type: ignore


def _print_json(payload: dict, pretty: bool) -> None:
    if pretty:
        print(json.dumps(payload, indent=2, sort_keys=False))
    else:
        print(json.dumps(payload, separators=(",", ":"), sort_keys=False))


def _sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def _connect(db_path: str) -> sqlite3.Connection:
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    return conn


SCHEMA_SQL = """
CREATE TABLE IF NOT EXISTS files (
  file_path TEXT PRIMARY KEY,
  file_size INTEGER NOT NULL,
  mtime_ns INTEGER NOT NULL,
  sha256 TEXT NOT NULL,
  indexed_at TEXT NOT NULL DEFAULT (datetime('now')),
  is_m4l INTEGER NOT NULL,
  patcher_count INTEGER NOT NULL,
  node_count INTEGER NOT NULL,
  edge_count INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS patchers (
  file_path TEXT NOT NULL,
  path TEXT NOT NULL,
  uid_path TEXT NOT NULL,
  parent_object_uid TEXT NOT NULL,
  classnamespace TEXT NOT NULL,
  rect_x REAL,
  rect_y REAL,
  rect_w REAL,
  rect_h REAL,
  box_count INTEGER NOT NULL,
  line_count INTEGER NOT NULL,
  PRIMARY KEY (file_path, uid_path)
);

CREATE TABLE IF NOT EXISTS nodes (
  node_pk INTEGER PRIMARY KEY AUTOINCREMENT,
  file_path TEXT NOT NULL,
  uid TEXT NOT NULL,
  node_kind TEXT NOT NULL,
  patcher_path TEXT NOT NULL,
  patcher_uid_path TEXT NOT NULL,
  id TEXT NOT NULL,
  maxclass TEXT NOT NULL,
  object_name TEXT NOT NULL,
  text TEXT NOT NULL,
  varname TEXT NOT NULL,
  numinlets INTEGER NOT NULL,
  numoutlets INTEGER NOT NULL,
  classnamespace TEXT NOT NULL,
  has_child_patcher INTEGER NOT NULL,
  child_patcher_path TEXT NOT NULL,
  child_patcher_uid_path TEXT NOT NULL,
  parent_object_uid TEXT NOT NULL,
  port_dir TEXT NOT NULL,
  port_index INTEGER NOT NULL,
  patching_x REAL,
  patching_y REAL,
  patching_w REAL,
  patching_h REAL,
  presentation INTEGER NOT NULL,
  presentation_x REAL,
  presentation_y REAL,
  presentation_w REAL,
  presentation_h REAL,
  UNIQUE (file_path, uid)
);

CREATE INDEX IF NOT EXISTS idx_nodes_file_patcher ON nodes(file_path, patcher_uid_path);
CREATE INDEX IF NOT EXISTS idx_nodes_file_id ON nodes(file_path, id);
CREATE INDEX IF NOT EXISTS idx_nodes_file_kind ON nodes(file_path, node_kind);
CREATE INDEX IF NOT EXISTS idx_nodes_file_class ON nodes(file_path, maxclass);

CREATE TABLE IF NOT EXISTS edges (
  file_path TEXT NOT NULL,
  edge_index INTEGER NOT NULL,
  src TEXT NOT NULL,
  dst TEXT NOT NULL,
  kind TEXT NOT NULL,
  patcher_path TEXT NOT NULL,
  patcher_uid_path TEXT NOT NULL,
  source_outlet INTEGER NOT NULL,
  destination_inlet INTEGER NOT NULL,
  edge_order INTEGER,
  PRIMARY KEY (file_path, edge_index)
);

CREATE INDEX IF NOT EXISTS idx_edges_file_src ON edges(file_path, src);
CREATE INDEX IF NOT EXISTS idx_edges_file_dst ON edges(file_path, dst);

CREATE VIRTUAL TABLE IF NOT EXISTS nodes_fts USING fts5(
  file_path,
  uid,
  patcher_path,
  patcher_uid_path,
  id,
  maxclass,
  object_name,
  text,
  varname
);

CREATE VIRTUAL TABLE IF NOT EXISTS nodes_patching_rtree USING rtree(
  node_pk,
  min_x,
  max_x,
  min_y,
  max_y
);

CREATE VIRTUAL TABLE IF NOT EXISTS nodes_presentation_rtree USING rtree(
  node_pk,
  min_x,
  max_x,
  min_y,
  max_y
);
"""


def init_db(conn: sqlite3.Connection) -> None:
    conn.executescript(SCHEMA_SQL)
    conn.commit()


def _to_num4(rect: Any) -> Optional[Tuple[float, float, float, float]]:
    if not isinstance(rect, list) or len(rect) < 4:
        return None
    try:
        x = float(rect[0])
        y = float(rect[1])
        w = float(rect[2])
        h = float(rect[3])
    except (TypeError, ValueError):
        return None
    return (x, y, w, h)


def _file_stat_payload(path: Path) -> Tuple[int, int]:
    st = path.stat()
    return (int(st.st_size), int(getattr(st, "st_mtime_ns", int(st.st_mtime * 1_000_000_000))))


def _should_skip_index(conn: sqlite3.Connection, path: Path) -> bool:
    size, mtime_ns = _file_stat_payload(path)
    row = conn.execute(
        "SELECT file_size, mtime_ns FROM files WHERE file_path = ?",
        (str(path),),
    ).fetchone()
    if row is None:
        return False
    return int(row["file_size"]) == size and int(row["mtime_ns"]) == mtime_ns


def _delete_file_rows(conn: sqlite3.Connection, file_path: str) -> None:
    # Clear RTree rows by node_pk mapping before deleting nodes.
    node_pks = [int(r[0]) for r in conn.execute("SELECT node_pk FROM nodes WHERE file_path = ?", (file_path,))]
    if node_pks:
        conn.executemany("DELETE FROM nodes_patching_rtree WHERE node_pk = ?", [(pk,) for pk in node_pks])
        conn.executemany("DELETE FROM nodes_presentation_rtree WHERE node_pk = ?", [(pk,) for pk in node_pks])
    conn.execute("DELETE FROM nodes_fts WHERE file_path = ?", (file_path,))
    conn.execute("DELETE FROM edges WHERE file_path = ?", (file_path,))
    conn.execute("DELETE FROM patchers WHERE file_path = ?", (file_path,))
    conn.execute("DELETE FROM nodes WHERE file_path = ?", (file_path,))
    conn.execute("DELETE FROM files WHERE file_path = ?", (file_path,))


def _insert_patch_index(conn: sqlite3.Connection, file_path: str) -> dict:
    path = Path(file_path).resolve()
    index = maxpat_query.IndexBuilder().build(str(path))
    viz = maxpat_query.cmd_export_viz(str(path))  # pylint: disable=protected-access

    _delete_file_rows(conn, str(path))

    size, mtime_ns = _file_stat_payload(path)
    sha = _sha256_file(path)

    patcher_rect_by_uid: Dict[str, Tuple[float, float, float, float]] = {}
    for p in viz.get("patchers", []):
        if not isinstance(p, dict):
            continue
        uid_path = str(p.get("uid_path", ""))
        rect = _to_num4(p.get("rect"))
        if uid_path and rect is not None:
            patcher_rect_by_uid[uid_path] = rect

    conn.execute(
        """
        INSERT INTO files (
          file_path, file_size, mtime_ns, sha256, indexed_at,
          is_m4l, patcher_count, node_count, edge_count
        ) VALUES (?, ?, ?, ?, datetime('now'), ?, ?, ?, ?)
        """,
        (
            str(path),
            size,
            mtime_ns,
            sha,
            1 if index.is_m4l else 0,
            len(index.patchers),
            len(index.nodes),
            len(index.edges),
        ),
    )

    for p in index.patchers:
        rect = patcher_rect_by_uid.get(p.uid_path)
        conn.execute(
            """
            INSERT INTO patchers (
              file_path, path, uid_path, parent_object_uid, classnamespace,
              rect_x, rect_y, rect_w, rect_h, box_count, line_count
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                str(path),
                p.path,
                p.uid_path,
                p.parent_object_uid,
                p.classnamespace,
                rect[0] if rect else None,
                rect[1] if rect else None,
                rect[2] if rect else None,
                rect[3] if rect else None,
                p.box_count,
                p.line_count,
            ),
        )

    for node in index.nodes.values():
        patch_rect = _to_num4(node.patching_rect)
        pres_rect = _to_num4(node.presentation_rect)
        cur = conn.execute(
            """
            INSERT INTO nodes (
              file_path, uid, node_kind, patcher_path, patcher_uid_path, id,
              maxclass, object_name, text, varname, numinlets, numoutlets,
              classnamespace, has_child_patcher, child_patcher_path, child_patcher_uid_path,
              parent_object_uid, port_dir, port_index,
              patching_x, patching_y, patching_w, patching_h,
              presentation, presentation_x, presentation_y, presentation_w, presentation_h
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                str(path),
                node.uid,
                node.node_kind,
                node.patcher_path,
                node.patcher_uid_path,
                node.id,
                node.maxclass,
                node.object_name,
                node.text,
                node.varname,
                node.numinlets,
                node.numoutlets,
                node.classnamespace,
                1 if node.has_child_patcher else 0,
                node.child_patcher_path,
                node.child_patcher_uid_path,
                node.parent_object_uid,
                node.port_dir,
                node.port_index,
                patch_rect[0] if patch_rect else None,
                patch_rect[1] if patch_rect else None,
                patch_rect[2] if patch_rect else None,
                patch_rect[3] if patch_rect else None,
                1 if node.presentation else 0,
                pres_rect[0] if pres_rect else None,
                pres_rect[1] if pres_rect else None,
                pres_rect[2] if pres_rect else None,
                pres_rect[3] if pres_rect else None,
            ),
        )
        node_pk = int(cur.lastrowid)
        conn.execute(
            """
            INSERT INTO nodes_fts (
              file_path, uid, patcher_path, patcher_uid_path, id, maxclass, object_name, text, varname
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                str(path),
                node.uid,
                node.patcher_path,
                node.patcher_uid_path,
                node.id,
                node.maxclass,
                node.object_name,
                node.text,
                node.varname,
            ),
        )
        if patch_rect is not None:
            x, y, w, h = patch_rect
            conn.execute(
                "INSERT INTO nodes_patching_rtree (node_pk, min_x, max_x, min_y, max_y) VALUES (?, ?, ?, ?, ?)",
                (node_pk, x, x + w, y, y + h),
            )
        if pres_rect is not None:
            x, y, w, h = pres_rect
            conn.execute(
                "INSERT INTO nodes_presentation_rtree (node_pk, min_x, max_x, min_y, max_y) VALUES (?, ?, ?, ?, ?)",
                (node_pk, x, x + w, y, y + h),
            )

    for i, edge in enumerate(index.edges):
        conn.execute(
            """
            INSERT INTO edges (
              file_path, edge_index, src, dst, kind, patcher_path, patcher_uid_path,
              source_outlet, destination_inlet, edge_order
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                str(path),
                i,
                edge.src,
                edge.dst,
                edge.kind,
                edge.patcher_path,
                edge.patcher_uid_path,
                edge.source_outlet,
                edge.destination_inlet,
                edge.order,
            ),
        )

    return {
        "file": str(path),
        "is_m4l": index.is_m4l,
        "counts": {
            "patchers": len(index.patchers),
            "nodes": len(index.nodes),
            "edges": len(index.edges),
        },
        "sha256": sha,
        "file_size": size,
        "mtime_ns": mtime_ns,
    }


def cmd_init(db: str) -> dict:
    conn = _connect(db)
    try:
        init_db(conn)
    finally:
        conn.close()
    return {"command": "init", "db": str(Path(db).resolve())}


def cmd_index(db: str, files: Iterable[str], skip_unchanged: bool) -> dict:
    file_list = [str(Path(f).resolve()) for f in files]
    conn = _connect(db)
    try:
        init_db(conn)
        indexed: List[dict] = []
        skipped: List[str] = []
        for file_path in file_list:
            p = Path(file_path)
            if skip_unchanged and p.exists() and _should_skip_index(conn, p):
                skipped.append(file_path)
                continue
            result = _insert_patch_index(conn, file_path)
            indexed.append(result)
        conn.commit()
        return {
            "command": "index",
            "db": str(Path(db).resolve()),
            "requested": len(file_list),
            "indexed_count": len(indexed),
            "skipped_count": len(skipped),
            "indexed": indexed,
            "skipped": skipped,
        }
    finally:
        conn.close()


def cmd_status(db: str) -> dict:
    conn = _connect(db)
    try:
        init_db(conn)
        files_count = int(conn.execute("SELECT COUNT(*) FROM files").fetchone()[0])
        nodes_count = int(conn.execute("SELECT COUNT(*) FROM nodes").fetchone()[0])
        edges_count = int(conn.execute("SELECT COUNT(*) FROM edges").fetchone()[0])
        patchers_count = int(conn.execute("SELECT COUNT(*) FROM patchers").fetchone()[0])
        recent = [
            dict(row)
            for row in conn.execute(
                """
                SELECT file_path, indexed_at, file_size, mtime_ns, sha256, node_count, edge_count
                FROM files
                ORDER BY indexed_at DESC, file_path ASC
                LIMIT 20
                """
            )
        ]
        return {
            "command": "status",
            "db": str(Path(db).resolve()),
            "counts": {
                "files": files_count,
                "patchers": patchers_count,
                "nodes": nodes_count,
                "edges": edges_count,
            },
            "recent_files": recent,
        }
    finally:
        conn.close()


def cmd_query_text(db: str, query: str, file_filter: str, limit: int) -> dict:
    conn = _connect(db)
    try:
        init_db(conn)
        sql = """
        SELECT
          n.file_path,
          n.uid,
          n.patcher_path,
          n.patcher_uid_path,
          n.id,
          n.node_kind,
          n.maxclass,
          n.object_name,
          n.text,
          n.varname,
          bm25(nodes_fts) AS score
        FROM nodes_fts
        JOIN nodes n
          ON n.file_path = nodes_fts.file_path
         AND n.uid = nodes_fts.uid
        WHERE nodes_fts MATCH ?
        """
        params: List[Any] = [query]
        if file_filter:
            sql += " AND n.file_path = ?"
            params.append(str(Path(file_filter).resolve()))
        sql += " ORDER BY score, n.file_path, n.patcher_path, n.id LIMIT ?"
        params.append(max(limit, 0))
        rows = [dict(row) for row in conn.execute(sql, params)]
        return {
            "command": "query-text",
            "db": str(Path(db).resolve()),
            "query": query,
            "file_filter": str(Path(file_filter).resolve()) if file_filter else "",
            "limit": max(limit, 0),
            "count": len(rows),
            "matches": rows,
        }
    finally:
        conn.close()


def cmd_query_region(
    db: str,
    file_path: str,
    x: float,
    y: float,
    w: float,
    h: float,
    *,
    view_mode: str,
    patcher_uid_path: str,
    patcher_path: str,
    limit: int,
) -> dict:
    if view_mode not in {"patching", "presentation"}:
        raise ValueError("view_mode must be patching or presentation")
    conn = _connect(db)
    try:
        init_db(conn)
        file_abs = str(Path(file_path).resolve())
        x1, y1 = float(x), float(y)
        x2, y2 = float(x + w), float(y + h)
        rtree_table = "nodes_patching_rtree" if view_mode == "patching" else "nodes_presentation_rtree"
        sql = f"""
        SELECT
          n.file_path,
          n.uid,
          n.patcher_path,
          n.patcher_uid_path,
          n.id,
          n.node_kind,
          n.maxclass,
          n.object_name,
          n.text,
          n.varname,
          n.patching_x, n.patching_y, n.patching_w, n.patching_h,
          n.presentation, n.presentation_x, n.presentation_y, n.presentation_w, n.presentation_h
        FROM {rtree_table} r
        JOIN nodes n ON n.node_pk = r.node_pk
        WHERE n.file_path = ?
          AND r.min_x <= ?
          AND r.max_x >= ?
          AND r.min_y <= ?
          AND r.max_y >= ?
        """
        params: List[Any] = [file_abs, x2, x1, y2, y1]
        if patcher_uid_path:
            sql += " AND n.patcher_uid_path = ?"
            params.append(patcher_uid_path)
        elif patcher_path:
            sql += " AND n.patcher_path = ?"
            params.append(patcher_path)
        sql += " ORDER BY n.patcher_path, n.id, n.uid LIMIT ?"
        params.append(max(limit, 0))
        rows = [dict(row) for row in conn.execute(sql, params)]
        return {
            "command": "query-region",
            "db": str(Path(db).resolve()),
            "file": file_abs,
            "view_mode": view_mode,
            "query_rect": [x1, y1, float(w), float(h)],
            "patcher_uid_path": patcher_uid_path,
            "patcher_path": patcher_path,
            "limit": max(limit, 0),
            "count": len(rows),
            "matches": rows,
        }
    finally:
        conn.close()


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Optional SQLite (FTS + RTree) cache for Max patch agent workflows"
    )
    parser.add_argument("--pretty", action="store_true", help="pretty-print JSON output")
    sub = parser.add_subparsers(dest="command", required=True)

    p_init = sub.add_parser("init", help="create/update cache schema")
    p_init.add_argument("db", help="sqlite database path")

    p_index = sub.add_parser("index", help="index one or more patch files")
    p_index.add_argument("db", help="sqlite database path")
    p_index.add_argument("files", nargs="+", help=".maxpat/.amxd files")
    p_index.add_argument(
        "--skip-unchanged",
        action="store_true",
        help="skip files with unchanged size+mtime compared to cache metadata",
    )

    p_status = sub.add_parser("status", help="show cache status/counts")
    p_status.add_argument("db", help="sqlite database path")

    p_qt = sub.add_parser("query-text", help="FTS5 text query over indexed nodes")
    p_qt.add_argument("db", help="sqlite database path")
    p_qt.add_argument("query", help="FTS query string")
    p_qt.add_argument("--file", default="", help="optional file filter")
    p_qt.add_argument("--limit", type=int, default=50, help="max matches")

    p_qr = sub.add_parser("query-region", help="RTree spatial query over cached nodes")
    p_qr.add_argument("db", help="sqlite database path")
    p_qr.add_argument("file", help="indexed patch file path")
    p_qr.add_argument("x", type=float)
    p_qr.add_argument("y", type=float)
    p_qr.add_argument("w", type=float)
    p_qr.add_argument("h", type=float)
    p_qr.add_argument(
        "--view-mode",
        default="patching",
        choices=["patching", "presentation"],
        help="which geometry to query",
    )
    p_qr.add_argument("--patcher-uid-path", default="", help="optional patcher scope")
    p_qr.add_argument("--patcher-path", default="", help="optional patcher scope (display path)")
    p_qr.add_argument("--limit", type=int, default=100, help="max matches")

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    try:
        if args.command == "init":
            payload = cmd_init(args.db)
        elif args.command == "index":
            payload = cmd_index(args.db, args.files, skip_unchanged=bool(args.skip_unchanged))
        elif args.command == "status":
            payload = cmd_status(args.db)
        elif args.command == "query-text":
            payload = cmd_query_text(args.db, args.query, args.file, args.limit)
        elif args.command == "query-region":
            payload = cmd_query_region(
                args.db,
                args.file,
                args.x,
                args.y,
                args.w,
                args.h,
                view_mode=args.view_mode,
                patcher_uid_path=args.patcher_uid_path,
                patcher_path=args.patcher_path,
                limit=args.limit,
            )
        else:
            raise ValueError(f"unsupported command: {args.command}")
        payload["ok"] = True
    except Exception as exc:  # pylint: disable=broad-except
        _print_json(
            {
                "ok": False,
                "command": getattr(args, "command", ""),
                "db": getattr(args, "db", ""),
                "error": f"{type(exc).__name__}: {exc}",
            },
            pretty=True,
        )
        return 1

    _print_json(payload, pretty=args.pretty)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

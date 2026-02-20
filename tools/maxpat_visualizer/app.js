import * as THREE from "https://unpkg.com/three@0.160.0/build/three.module.js";
import { OrbitControls } from "https://unpkg.com/three@0.160.0/examples/jsm/controls/OrbitControls.js";

const dom = {
  viewport: document.getElementById("viewport"),
  status: document.getElementById("statusBar"),
  fileInput: document.getElementById("fileInput"),
  urlInput: document.getElementById("urlInput"),
  loadUrlBtn: document.getElementById("loadUrlBtn"),
  fitViewBtn: document.getElementById("fitViewBtn"),
  goRootBtn: document.getElementById("goRootBtn"),
  patcherMeta: document.getElementById("patcherMeta"),
  breadcrumbs: document.getElementById("breadcrumbs"),
  searchInput: document.getElementById("searchInput"),
  searchStats: document.getElementById("searchStats"),
  searchResults: document.getElementById("searchResults"),
  selectionMeta: document.getElementById("selectionMeta"),
  enterSubpatchBtn: document.getElementById("enterSubpatchBtn"),
  highlightInSearchBtn: document.getElementById("highlightInSearchBtn"),
};

const state = {
  dataset: null,
  patcherByPath: new Map(),
  parentPathByChild: new Map(),
  boxByUid: new Map(),
  searchable: [],
  currentPatcherPath: "",
  selectedUid: "",
  lastSearchResults: [],
};

const renderState = {
  renderer: null,
  scene: null,
  camera: null,
  controls: null,
  raycaster: new THREE.Raycaster(),
  pointer: new THREE.Vector2(),
  renderGroup: null,
  boxMeshByUid: new Map(),
  boxByIdInCurrentPatcher: new Map(),
};

const COLORS = {
  background: 0x0a0f13,
  line: 0x8eaac2,
  lineOrdered: 0xcedfed,
  border: 0x101c24,
  selected: 0xf59e0b,
};

init();

function init() {
  initThree();
  bindEvents();
  animate();
  readUrlParam();
}

function initThree() {
  const rect = dom.viewport.getBoundingClientRect();
  renderState.renderer = new THREE.WebGLRenderer({ antialias: true });
  renderState.renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 2));
  renderState.renderer.setSize(Math.max(rect.width, 1), Math.max(rect.height, 1));
  dom.viewport.appendChild(renderState.renderer.domElement);

  renderState.scene = new THREE.Scene();
  renderState.scene.background = new THREE.Color(COLORS.background);

  renderState.camera = new THREE.OrthographicCamera(-rect.width / 2, rect.width / 2, rect.height / 2, -rect.height / 2, -1000, 1000);
  renderState.camera.position.set(0, 0, 100);
  renderState.camera.lookAt(0, 0, 0);

  renderState.controls = new OrbitControls(renderState.camera, renderState.renderer.domElement);
  renderState.controls.enableRotate = false;
  renderState.controls.enableDamping = true;
  renderState.controls.dampingFactor = 0.12;
  renderState.controls.screenSpacePanning = true;
  renderState.controls.zoomSpeed = 0.9;
  renderState.controls.mouseButtons.LEFT = THREE.MOUSE.PAN;
  renderState.controls.mouseButtons.MIDDLE = THREE.MOUSE.DOLLY;
  renderState.controls.mouseButtons.RIGHT = THREE.MOUSE.PAN;

  renderState.renderGroup = new THREE.Group();
  renderState.scene.add(renderState.renderGroup);
}

function bindEvents() {
  window.addEventListener("resize", handleResize);

  dom.fileInput.addEventListener("change", async (event) => {
    const file = event.target.files?.[0];
    if (!file) return;
    try {
      const text = await file.text();
      const payload = JSON.parse(text);
      loadDataset(payload, file.name);
      setStatus(`Loaded ${file.name}`);
    } catch (error) {
      if (String(file.name).toLowerCase().endsWith(".amxd")) {
        setStatus("AMXD is binary. Use export-viz first: python3 tools/maxpat_query.py export-viz <file.amxd> > patch.viz.json");
      } else {
        setStatus(`Could not parse file: ${error.message}`);
      }
    } finally {
      dom.fileInput.value = "";
    }
  });

  dom.loadUrlBtn.addEventListener("click", () => {
    const url = (dom.urlInput.value || "").trim();
    if (!url) return;
    loadUrl(url);
  });

  dom.urlInput.addEventListener("keydown", (event) => {
    if (event.key === "Enter") {
      event.preventDefault();
      dom.loadUrlBtn.click();
    }
  });

  dom.fitViewBtn.addEventListener("click", () => fitToCurrentPatcher());
  dom.goRootBtn.addEventListener("click", () => goToPatcher("root", true));
  dom.enterSubpatchBtn.addEventListener("click", () => {
    const box = state.boxByUid.get(state.selectedUid);
    if (box?.has_child_patcher) {
      goToPatcher(box.child_patcher_path, true);
    }
  });
  dom.highlightInSearchBtn.addEventListener("click", () => {
    const box = state.boxByUid.get(state.selectedUid);
    if (!box) return;
    dom.searchInput.value = [box.varname, box.text, box.id].filter(Boolean).join(" ");
    runSearch();
  });
  dom.searchInput.addEventListener("input", () => runSearch());

  renderState.renderer.domElement.addEventListener("click", (event) => {
    const uid = pickBoxUidFromEvent(event);
    if (uid) selectUid(uid);
  });
  renderState.renderer.domElement.addEventListener("dblclick", (event) => {
    const uid = pickBoxUidFromEvent(event);
    if (!uid) return;
    const box = state.boxByUid.get(uid);
    if (box?.has_child_patcher) {
      goToPatcher(box.child_patcher_path, true);
    }
  });
}

function animate() {
  requestAnimationFrame(animate);
  if (renderState.controls) renderState.controls.update();
  if (renderState.renderer && renderState.scene && renderState.camera) {
    renderState.renderer.render(renderState.scene, renderState.camera);
  }
}

function handleResize() {
  if (!renderState.renderer || !renderState.camera) return;
  const rect = dom.viewport.getBoundingClientRect();
  renderState.renderer.setSize(Math.max(rect.width, 1), Math.max(rect.height, 1));
  renderState.camera.left = -rect.width / 2;
  renderState.camera.right = rect.width / 2;
  renderState.camera.top = rect.height / 2;
  renderState.camera.bottom = -rect.height / 2;
  renderState.camera.updateProjectionMatrix();
}

function setStatus(text) {
  dom.status.textContent = text;
}

function readUrlParam() {
  const params = new URLSearchParams(window.location.search);
  const dataUrl = params.get("data");
  if (!dataUrl) return;
  dom.urlInput.value = dataUrl;
  loadUrl(dataUrl);
}

async function loadUrl(url) {
  setStatus(`Loading ${url} ...`);
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }
    const payload = await response.json();
    loadDataset(payload, url);
    setStatus(`Loaded ${url}`);
  } catch (error) {
    setStatus(`URL load failed: ${error.message}`);
  }
}

function loadDataset(payload, sourceName) {
  const normalized = normalizeDataset(payload, sourceName);
  state.dataset = normalized;
  state.patcherByPath = new Map();
  state.parentPathByChild = new Map();
  state.boxByUid = new Map();
  state.searchable = [];

  for (const patcher of normalized.patchers || []) {
    state.patcherByPath.set(patcher.path, patcher);
    for (const box of patcher.boxes || []) {
      state.boxByUid.set(box.uid, box);
      state.searchable.push({
        uid: box.uid,
        path: patcher.path,
        box,
        haystack: searchableText(box),
      });
      if (box.has_child_patcher && box.child_patcher_path) {
        state.parentPathByChild.set(box.child_patcher_path, patcher.path);
      }
    }
  }

  const rootPath = normalized.root_patcher_path || "root";
  const initialPath = state.patcherByPath.has(rootPath) ? rootPath : [...state.patcherByPath.keys()][0] || "";
  state.selectedUid = "";
  state.currentPatcherPath = initialPath;

  goToPatcher(initialPath, true);
  runSearch();
}

function normalizeDataset(payload, sourceName) {
  if (payload && typeof payload === "object" && Array.isArray(payload.patchers) && typeof payload.root_patcher_path === "string") {
    return payload;
  }
  if (payload && typeof payload === "object" && payload.patcher) {
    return buildVizFromRawMaxpat(payload, sourceName);
  }
  throw new Error("Unsupported payload format. Load export-viz JSON or raw .maxpat JSON.");
}

function buildVizFromRawMaxpat(raw, sourceName) {
  const root = raw?.patcher;
  if (!root || typeof root !== "object") {
    throw new Error("Invalid raw .maxpat payload");
  }

  const patchers = [];
  let totalBoxes = 0;
  let totalLines = 0;

  const unwrapBoxes = (patcher) => (Array.isArray(patcher?.boxes) ? patcher.boxes : [])
    .map((item) => (item && typeof item === "object" ? item.box : null))
    .filter((item) => item && typeof item === "object");

  const unwrapLines = (patcher) => (Array.isArray(patcher?.lines) ? patcher.lines : [])
    .map((item) => (item && typeof item === "object" ? item.patchline : null))
    .filter((item) => item && typeof item === "object");

  const childPath = (parentPath, box) => {
    const label = String(box?.text || "").trim() || String(box?.maxclass || "subpatcher");
    const id = String(box?.id || "<no-id>");
    return `${parentPath} > ${label} (${id})`;
  };

  const objectName = (box) => {
    if (String(box?.maxclass || "") === "newobj") {
      const text = String(box?.text || "").trim();
      return text ? text.split(/\s+/)[0] : "";
    }
    return String(box?.maxclass || "");
  };

  const safeInt = (value, fallback = 0) => {
    const num = Number.parseInt(value, 10);
    return Number.isFinite(num) ? num : fallback;
  };

  const safeRect = (value) => {
    if (!Array.isArray(value) || value.length < 4) return [];
    const out = value.slice(0, 4).map((item) => Number(item));
    if (out.some((item) => !Number.isFinite(item))) return [];
    return out;
  };

  const safePoints = (value) => {
    if (!Array.isArray(value)) return [];
    const out = value.map((item) => Number(item));
    return out.some((item) => !Number.isFinite(item)) ? [] : out;
  };

  const looksLikeM4L = (patcher) => {
    for (const box of unwrapBoxes(patcher)) {
      const name = objectName(box);
      const maxclass = String(box?.maxclass || "");
      if (name === "plugin~" || name === "plugout~" || name === "live.thisdevice") return true;
      if (maxclass.startsWith("live.")) return true;
    }
    return false;
  };

  const patcherRect = (patcher, boxes) => {
    const rect = safeRect(patcher?.rect);
    if (rect.length === 4) return rect;
    if (!boxes.length) return [0, 0, 1200, 800];
    const coords = [];
    for (const box of boxes) {
      const r = safeRect(box?.patching_rect);
      if (r.length === 4) coords.push(r);
    }
    if (!coords.length) return [0, 0, 1200, 800];
    const xMin = Math.min(...coords.map((r) => r[0])) - 120;
    const yMin = Math.min(...coords.map((r) => r[1])) - 120;
    const xMax = Math.max(...coords.map((r) => r[0] + r[2])) + 120;
    const yMax = Math.max(...coords.map((r) => r[1] + r[3])) + 120;
    return [xMin, yMin, Math.max(200, xMax - xMin), Math.max(200, yMax - yMin)];
  };

  const walk = (patcher, patcherPath, parentObjectUid = "") => {
    const boxes = unwrapBoxes(patcher);
    const lines = unwrapLines(patcher);
    const boxPayloads = [];
    const uidById = new Map();

    for (const box of boxes) {
      const id = String(box?.id || "");
      if (!id) continue;
      const uid = `${patcherPath}/${id}`;
      const hasChild = Boolean(box?.patcher && typeof box.patcher === "object");
      const payload = {
        uid,
        patcher_path: patcherPath,
        id,
        maxclass: String(box?.maxclass || ""),
        object_name: objectName(box),
        text: String(box?.text || ""),
        varname: String(box?.varname || ""),
        numinlets: safeInt(box?.numinlets, 0),
        numoutlets: safeInt(box?.numoutlets, 0),
        outlettype: Array.isArray(box?.outlettype) ? box.outlettype : [],
        patching_rect: safeRect(box?.patching_rect),
        presentation: Boolean(safeInt(box?.presentation, 0)),
        presentation_rect: safeRect(box?.presentation_rect),
        has_child_patcher: hasChild,
        child_patcher_path: hasChild ? childPath(patcherPath, box) : "",
        parent_object_uid: parentObjectUid,
      };
      boxPayloads.push(payload);
      uidById.set(id, uid);
    }

    const linePayloads = [];
    for (const line of lines) {
      const src = Array.isArray(line?.source) ? line.source : [];
      const dst = Array.isArray(line?.destination) ? line.destination : [];
      if (src.length < 2 || dst.length < 2) continue;
      const sourceId = String(src[0] || "");
      const destinationId = String(dst[0] || "");
      if (!sourceId || !destinationId) continue;
      linePayloads.push({
        patcher_path: patcherPath,
        source_id: sourceId,
        destination_id: destinationId,
        source_uid: uidById.get(sourceId) || `${patcherPath}/${sourceId}`,
        destination_uid: uidById.get(destinationId) || `${patcherPath}/${destinationId}`,
        source_outlet: safeInt(src[1], -1),
        destination_inlet: safeInt(dst[1], -1),
        order: Object.prototype.hasOwnProperty.call(line, "order") ? safeInt(line.order, -1) : null,
        midpoints: safePoints(line?.midpoints),
      });
    }

    const payload = {
      path: patcherPath,
      parent_object_uid: parentObjectUid,
      classnamespace: String(patcher?.classnamespace || "box"),
      rect: patcherRect(patcher, boxes),
      boxes: boxPayloads,
      lines: linePayloads,
      box_count: boxPayloads.length,
      line_count: linePayloads.length,
    };
    patchers.push(payload);
    totalBoxes += boxPayloads.length;
    totalLines += linePayloads.length;

    for (const box of boxes) {
      if (!box?.patcher || typeof box.patcher !== "object") continue;
      const id = String(box?.id || "");
      if (!id) continue;
      walk(box.patcher, childPath(patcherPath, box), uidById.get(id) || `${patcherPath}/${id}`);
    }
  };

  walk(root, "root");

  return {
    file: sourceName || "loaded.maxpat",
    is_m4l: looksLikeM4L(root),
    root_patcher_path: "root",
    counts: {
      patchers: patchers.length,
      boxes: totalBoxes,
      lines: totalLines,
    },
    patchers,
  };
}

function goToPatcher(path, fitView) {
  if (!path || !state.patcherByPath.has(path)) return;
  state.currentPatcherPath = path;
  state.selectedUid = "";
  renderCurrentPatcher();
  if (fitView) fitToCurrentPatcher();
}

function renderCurrentPatcher() {
  clearRenderGroup();
  const patcher = state.patcherByPath.get(state.currentPatcherPath);
  if (!patcher) {
    setStatus("No patcher selected.");
    return;
  }

  renderState.boxMeshByUid = new Map();
  renderState.boxByIdInCurrentPatcher = new Map();

  for (const box of patcher.boxes || []) {
    renderState.boxByIdInCurrentPatcher.set(box.id, box);
  }
  for (const line of patcher.lines || []) {
    renderLine(line);
  }
  for (const box of patcher.boxes || []) {
    renderBox(box);
  }

  renderPatcherMeta(patcher);
  renderBreadcrumbs();
  renderSelection();
  setStatus(`${patcher.path} | ${patcher.box_count} boxes | ${patcher.line_count} lines`);
}

function clearRenderGroup() {
  const disposeMaterial = (material) => {
    if (!material) return;
    if (Array.isArray(material)) {
      for (const item of material) disposeMaterial(item);
      return;
    }
    if (material.map) material.map.dispose();
    material.dispose();
  };

  const children = [...renderState.renderGroup.children];
  for (const child of children) {
    renderState.renderGroup.remove(child);
    if (child.geometry) child.geometry.dispose();
    if (child.material) disposeMaterial(child.material);
  }
}

function renderLine(line) {
  const src = renderState.boxByIdInCurrentPatcher.get(line.source_id);
  const dst = renderState.boxByIdInCurrentPatcher.get(line.destination_id);
  if (!src || !dst) return;

  const srcRect = safeRect(src.patching_rect);
  const dstRect = safeRect(dst.patching_rect);
  const start = {
    x: outletX(srcRect, line.source_outlet, src.numoutlets),
    y: srcRect[1] + srcRect[3],
  };
  const end = {
    x: inletX(dstRect, line.destination_inlet, dst.numinlets),
    y: dstRect[1],
  };

  const points = [start];
  if (Array.isArray(line.midpoints) && line.midpoints.length >= 2) {
    for (let idx = 0; idx + 1 < line.midpoints.length; idx += 2) {
      const midX = Number(line.midpoints[idx]);
      const midY = Number(line.midpoints[idx + 1]);
      if (Number.isFinite(midX) && Number.isFinite(midY)) {
        points.push({ x: midX, y: midY });
      }
    }
  }
  points.push(end);

  const vectors = points.map((point) => new THREE.Vector3(point.x, -point.y, 0));
  const geometry = new THREE.BufferGeometry().setFromPoints(vectors);
  const material = new THREE.LineBasicMaterial({
    color: line.order === null ? COLORS.line : COLORS.lineOrdered,
    transparent: true,
    opacity: 0.9,
  });
  const wire = new THREE.Line(geometry, material);
  wire.position.z = 0.02;
  renderState.renderGroup.add(wire);
}

function renderBox(box) {
  const rect = safeRect(box.patching_rect);
  const [x, y, width, height] = rect;
  const color = boxColor(box);

  const geometry = new THREE.PlaneGeometry(Math.max(width, 24), Math.max(height, 14));
  const material = new THREE.MeshBasicMaterial({ color });
  const mesh = new THREE.Mesh(geometry, material);
  mesh.position.set(x + width / 2, -(y + height / 2), 0.25);
  mesh.userData = {
    uid: box.uid,
    box,
    baseColor: color,
  };
  renderState.boxMeshByUid.set(box.uid, mesh);
  renderState.renderGroup.add(mesh);

  const borderGeometry = new THREE.EdgesGeometry(geometry);
  const borderMaterial = new THREE.LineBasicMaterial({ color: COLORS.border });
  const border = new THREE.LineSegments(borderGeometry, borderMaterial);
  border.position.copy(mesh.position);
  border.position.z = 0.3;
  mesh.userData.border = border;
  renderState.renderGroup.add(border);

  const label = boxLabel(box);
  if (label) {
    const sprite = createTextSprite(label, width, height);
    sprite.position.set(mesh.position.x, mesh.position.y, 0.35);
    renderState.renderGroup.add(sprite);
  }
}

function boxColor(box) {
  const maxclass = String(box?.maxclass || "");
  if (maxclass === "inlet" || maxclass === "outlet") return 0x4c5560;
  if (maxclass === "comment" || maxclass === "message") return 0x654833;
  if (maxclass === "toggle" || maxclass === "number" || maxclass === "flonum" || maxclass === "slider" || maxclass === "dial") return 0x2f5b48;
  if (maxclass.startsWith("live.")) return 0x776128;
  if (maxclass === "newobj") return 0x2c436c;
  return 0x3e4a56;
}

function boxLabel(box) {
  const raw = String(box.varname || box.text || box.object_name || box.maxclass || box.id || "").trim();
  if (!raw) return "";
  const compact = raw.replace(/\s+/g, " ");
  return compact.length > 38 ? `${compact.slice(0, 35)}...` : compact;
}

function createTextSprite(text, width, height) {
  const canvas = document.createElement("canvas");
  canvas.width = Math.max(128, Math.min(512, Math.ceil(width * 2.2)));
  canvas.height = Math.max(42, Math.min(126, Math.ceil(height * 2.2)));
  const context = canvas.getContext("2d");
  context.clearRect(0, 0, canvas.width, canvas.height);
  context.fillStyle = "#f1f6fb";
  context.font = `${Math.max(14, Math.min(28, Math.floor(canvas.height * 0.42)))}px "IBM Plex Mono", monospace`;
  context.textAlign = "center";
  context.textBaseline = "middle";
  context.fillText(text, canvas.width / 2, canvas.height / 2);

  const texture = new THREE.CanvasTexture(canvas);
  texture.needsUpdate = true;
  const material = new THREE.SpriteMaterial({
    map: texture,
    transparent: true,
    depthTest: false,
    depthWrite: false,
  });
  const sprite = new THREE.Sprite(material);
  sprite.scale.set(Math.max(width, 20), Math.max(height, 14), 1);
  return sprite;
}

function safeRect(value) {
  if (!Array.isArray(value) || value.length < 4) return [0, 0, 80, 22];
  const out = value.slice(0, 4).map((item) => Number(item));
  if (out.some((item) => !Number.isFinite(item))) return [0, 0, 80, 22];
  return out;
}

function outletX(rect, index, outletCount) {
  const ports = Number(outletCount || 0);
  if (Number.isFinite(index) && index >= 0 && ports > 0) {
    const clamped = Math.max(0, Math.min(index, ports - 1));
    return rect[0] + rect[2] * ((clamped + 1) / (ports + 1));
  }
  return rect[0] + rect[2] * 0.5;
}

function inletX(rect, index, inletCount) {
  const ports = Number(inletCount || 0);
  if (Number.isFinite(index) && index >= 0 && ports > 0) {
    const clamped = Math.max(0, Math.min(index, ports - 1));
    return rect[0] + rect[2] * ((clamped + 1) / (ports + 1));
  }
  return rect[0] + rect[2] * 0.5;
}

function fitToCurrentPatcher() {
  const patcher = state.patcherByPath.get(state.currentPatcherPath);
  if (!patcher) return;
  const rect = safeRect(patcher.rect);
  const viewportRect = dom.viewport.getBoundingClientRect();
  const width = Math.max(viewportRect.width, 1);
  const height = Math.max(viewportRect.height, 1);
  const padding = 120;
  const zoomX = width / (rect[2] + padding * 2);
  const zoomY = height / (rect[3] + padding * 2);
  const zoom = Math.max(0.05, Math.min(zoomX, zoomY));

  renderState.camera.zoom = zoom;
  renderState.camera.position.set(rect[0] + rect[2] / 2, -(rect[1] + rect[3] / 2), 100);
  renderState.controls.target.set(rect[0] + rect[2] / 2, -(rect[1] + rect[3] / 2), 0);
  renderState.camera.updateProjectionMatrix();
  renderState.controls.update();
}

function pickBoxUidFromEvent(event) {
  const canvasRect = renderState.renderer.domElement.getBoundingClientRect();
  renderState.pointer.x = ((event.clientX - canvasRect.left) / canvasRect.width) * 2 - 1;
  renderState.pointer.y = -((event.clientY - canvasRect.top) / canvasRect.height) * 2 + 1;
  renderState.raycaster.setFromCamera(renderState.pointer, renderState.camera);
  const candidates = [...renderState.boxMeshByUid.values()];
  const hits = renderState.raycaster.intersectObjects(candidates, false);
  if (!hits.length) return "";
  return String(hits[0]?.object?.userData?.uid || "");
}

function selectUid(uid) {
  if (!uid || !renderState.boxMeshByUid.has(uid)) return;
  if (state.selectedUid && renderState.boxMeshByUid.has(state.selectedUid)) {
    const prev = renderState.boxMeshByUid.get(state.selectedUid);
    prev.material.color.setHex(prev.userData.baseColor);
    if (prev.userData.border) prev.userData.border.material.color.setHex(COLORS.border);
  }
  state.selectedUid = uid;
  const mesh = renderState.boxMeshByUid.get(uid);
  mesh.material.color.setHex(COLORS.selected);
  if (mesh.userData.border) mesh.userData.border.material.color.setHex(0xfde68a);
  renderSelection();
}

function renderPatcherMeta(patcher) {
  dom.patcherMeta.innerHTML = "";
  addMetaRow(dom.patcherMeta, "Path", patcher.path);
  addMetaRow(dom.patcherMeta, "Namespace", patcher.classnamespace || "");
  addMetaRow(dom.patcherMeta, "Boxes", String(patcher.box_count || 0));
  addMetaRow(dom.patcherMeta, "Lines", String(patcher.line_count || 0));
}

function renderSelection() {
  const box = state.boxByUid.get(state.selectedUid);
  if (!box) {
    dom.selectionMeta.classList.add("empty");
    dom.selectionMeta.textContent = "No object selected";
    dom.enterSubpatchBtn.disabled = true;
    dom.highlightInSearchBtn.disabled = true;
    return;
  }
  dom.selectionMeta.classList.remove("empty");
  dom.selectionMeta.innerHTML = "";
  addMetaRow(dom.selectionMeta, "UID", box.uid);
  addMetaRow(dom.selectionMeta, "ID", box.id || "");
  addMetaRow(dom.selectionMeta, "Class", box.maxclass || "");
  addMetaRow(dom.selectionMeta, "Label", boxLabel(box));
  addMetaRow(dom.selectionMeta, "Inlets", String(box.numinlets ?? ""));
  addMetaRow(dom.selectionMeta, "Outlets", String(box.numoutlets ?? ""));
  addMetaRow(dom.selectionMeta, "Subpatch", box.has_child_patcher ? box.child_patcher_path : "none");
  dom.enterSubpatchBtn.disabled = !box.has_child_patcher;
  dom.highlightInSearchBtn.disabled = false;
}

function renderBreadcrumbs() {
  dom.breadcrumbs.innerHTML = "";
  const chain = patcherChain(state.currentPatcherPath);
  for (const path of chain) {
    const button = document.createElement("button");
    button.type = "button";
    button.className = `crumb${path === state.currentPatcherPath ? " current" : ""}`;
    button.textContent = path === "root" ? "root" : path.split(" > ").slice(-1)[0];
    button.addEventListener("click", () => goToPatcher(path, true));
    dom.breadcrumbs.appendChild(button);
  }
}

function patcherChain(path) {
  const out = [];
  const seen = new Set();
  let current = path;
  while (current && !seen.has(current)) {
    out.unshift(current);
    seen.add(current);
    current = state.parentPathByChild.get(current) || "";
  }
  return out;
}

function addMetaRow(parent, key, value) {
  const row = document.createElement("div");
  row.className = "row";
  const k = document.createElement("div");
  k.className = "k";
  k.textContent = key;
  const v = document.createElement("div");
  v.className = "v";
  v.textContent = String(value ?? "");
  row.appendChild(k);
  row.appendChild(v);
  parent.appendChild(row);
}

function searchableText(box) {
  return [box.id, box.text, box.varname, box.maxclass, box.object_name].filter(Boolean).join(" ").toLowerCase();
}

function runSearch() {
  const query = (dom.searchInput.value || "").trim().toLowerCase();
  if (!query) {
    dom.searchStats.textContent = "Type to search across all patchers.";
    dom.searchResults.innerHTML = "";
    state.lastSearchResults = [];
    return;
  }

  const results = [];
  for (const entry of state.searchable) {
    if (!entry.haystack.includes(query)) continue;
    let score = 0;
    if (entry.path === state.currentPatcherPath) score += 4;
    if ((entry.box.varname || "").toLowerCase().includes(query)) score += 3;
    if ((entry.box.id || "").toLowerCase().includes(query)) score += 2;
    if ((entry.box.text || "").toLowerCase().includes(query)) score += 1;
    results.push({ ...entry, score });
  }

  results.sort((a, b) => b.score - a.score || a.path.localeCompare(b.path) || a.box.id.localeCompare(b.box.id));
  state.lastSearchResults = results.slice(0, 200);
  dom.searchStats.textContent = `${results.length} matches (showing ${state.lastSearchResults.length})`;
  dom.searchResults.innerHTML = "";

  for (const entry of state.lastSearchResults) {
    const item = document.createElement("div");
    item.className = "result-item";
    const label = document.createElement("div");
    label.className = "label";
    label.textContent = boxLabel(entry.box);
    const path = document.createElement("div");
    path.className = "path";
    path.textContent = `${entry.path} :: ${entry.box.id}`;
    item.appendChild(label);
    item.appendChild(path);
    item.addEventListener("click", () => {
      goToPatcher(entry.path, true);
      selectUid(entry.uid);
    });
    dom.searchResults.appendChild(item);
  }
}

import * as THREE from "./vendor/three.module.js";
import { OrbitControls } from "./vendor/OrbitControls.js";

const dom = {
  viewport: document.getElementById("viewport"),
  hoverTooltip: document.getElementById("hoverTooltip"),
  status: document.getElementById("statusBar"),
  fileInput: document.getElementById("fileInput"),
  baseFileInput: document.getElementById("baseFileInput"),
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
  traceMeta: document.getElementById("traceMeta"),
  setTraceSourceBtn: document.getElementById("setTraceSourceBtn"),
  setTraceTargetBtn: document.getElementById("setTraceTargetBtn"),
  runTraceBtn: document.getElementById("runTraceBtn"),
  clearTraceBtn: document.getElementById("clearTraceBtn"),
  diffMeta: document.getElementById("diffMeta"),
  diffOverlayToggle: document.getElementById("diffOverlayToggle"),
  hoverMeta: document.getElementById("hoverMeta"),
  hoverDocsLink: document.getElementById("hoverDocsLink"),
};

const state = {
  dataset: null,
  datasetName: "",
  baseDataset: null,
  baseDatasetName: "",
  patcherByPath: new Map(),
  parentPathByChild: new Map(),
  boxByUid: new Map(),
  searchable: [],
  currentPatcherPath: "",
  selectedUid: "",
  lastSearchResults: [],
  diffModel: null,
  diffOverlayEnabled: false,
  traceSourceUid: "",
  traceTargetUid: "",
  traceNodeUids: new Set(),
  traceEdgeKeys: new Set(),
  traceLastMessage: "",
  traceLastHops: null,
  hoverUid: "",
  hoverPortKey: "",
  hoverLineKey: "",
  hoverLineEndpoints: new Set(),
  hoverInfo: null,
  hoverToken: "",
  controlValues: new Map(),
  activeControlDrag: null,
  ignoreNextClick: false,
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
  targetBoxById: new Map(),
  baseBoxById: new Map(),
  controlHitMeshes: [],
  portHitMeshes: [],
  lineHitMeshes: [],
};

const COLORS = {
  background: 0x0a0f13,
  line: 0x8eaac2,
  lineOrdered: 0xcedfed,
  border: 0x101c24,
  selected: 0xf59e0b,
  trace: 0x2fc6f4,
  traceSource: 0x60a5fa,
  traceTarget: 0xe879f9,
  hoverLine: 0xf8fafc,
  hoverPort: 0x9fd5ff,
  port: 0x9ab4c7,
  diffAdded: 0x10b981,
  diffModified: 0xf59e0b,
  diffRemoved: 0xfb7185,
};

init();

function init() {
  initThree();
  bindEvents();
  animate();
  readUrlParams();
  renderDiffMeta();
  renderTraceMeta();
  renderHoverMeta();
}

function initThree() {
  const rect = dom.viewport.getBoundingClientRect();
  renderState.renderer = new THREE.WebGLRenderer({ antialias: true });
  renderState.renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 2));
  renderState.renderer.setSize(Math.max(rect.width, 1), Math.max(rect.height, 1));
  dom.viewport.appendChild(renderState.renderer.domElement);

  renderState.scene = new THREE.Scene();
  renderState.scene.background = new THREE.Color(COLORS.background);

  renderState.camera = new THREE.OrthographicCamera(
    -rect.width / 2,
    rect.width / 2,
    rect.height / 2,
    -rect.height / 2,
    -1000,
    1000,
  );
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
  renderState.raycaster.params.Line.threshold = 6;

  renderState.renderGroup = new THREE.Group();
  renderState.scene.add(renderState.renderGroup);
  renderState.renderer.domElement.style.cursor = "grab";
}

function bindEvents() {
  window.addEventListener("resize", handleResize);
  window.addEventListener("keydown", (event) => {
    const targetTag = String(event.target?.tagName || "").toLowerCase();
    if (targetTag === "input" || targetTag === "textarea") return;

    if (event.key === "f" || event.key === "F") {
      fitToCurrentPatcher();
      event.preventDefault();
      return;
    }

    if (event.key === "Enter") {
      const box = state.boxByUid.get(state.selectedUid);
      if (box?.has_child_patcher) {
        goToPatcher(box.child_patcher_path, true);
        event.preventDefault();
      }
      return;
    }

    if (event.key === "Escape") {
      hideHoverTooltip();
      if (state.hoverToken) {
        applyHoverState(null);
        renderCurrentPatcher();
      }
    }
  });

  dom.fileInput.addEventListener("change", async (event) => {
    const file = event.target.files?.[0];
    if (!file) return;
    await loadFromFile(file, false);
    dom.fileInput.value = "";
  });

  dom.baseFileInput.addEventListener("change", async (event) => {
    const file = event.target.files?.[0];
    if (!file) return;
    await loadFromFile(file, true);
    dom.baseFileInput.value = "";
  });

  dom.loadUrlBtn.addEventListener("click", () => {
    const url = (dom.urlInput.value || "").trim();
    if (!url) return;
    loadUrl(url, false);
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

  dom.diffOverlayToggle.addEventListener("change", () => {
    state.diffOverlayEnabled = dom.diffOverlayToggle.checked && Boolean(state.diffModel);
    renderDiffMeta();
    renderCurrentPatcher();
  });

  dom.setTraceSourceBtn.addEventListener("click", () => setTraceEndpoint("source"));
  dom.setTraceTargetBtn.addEventListener("click", () => setTraceEndpoint("target"));
  dom.runTraceBtn.addEventListener("click", () => runTrace());
  dom.clearTraceBtn.addEventListener("click", () => clearTrace(true));

  const canvas = renderState.renderer.domElement;

  canvas.addEventListener(
    "pointerdown",
    (event) => {
      if (event.button !== 0) return;
      const control = pickControlFromEvent(event);
      if (!control) return;

      state.activeControlDrag = {
        uid: control.uid,
        kind: control.kind,
      };
      state.ignoreNextClick = true;
      renderState.controls.enabled = false;
      updateControlValueFromPointer(control.uid, control.kind, event);
      selectUid(control.uid, { skipRender: true });
      renderCurrentPatcher();
      event.preventDefault();
      event.stopPropagation();
    },
    { capture: true },
  );

  canvas.addEventListener("pointermove", (event) => {
    if (state.activeControlDrag) {
      updateControlValueFromPointer(
        state.activeControlDrag.uid,
        state.activeControlDrag.kind,
        event,
      );
      renderCurrentPatcher();
      updateHoverTooltip(event, {
        type: "control",
        uid: state.activeControlDrag.uid,
        description: "Adjusting control value",
      });
      return;
    }

    if (event.buttons !== 0) {
      hideHoverTooltip();
      return;
    }

    const hover = pickHoverFromEvent(event);
    const token = hoverToken(hover);
    if (token !== state.hoverToken) {
      applyHoverState(hover);
      renderCurrentPatcher();
    }
    updateHoverTooltip(event, hover);
  });

  window.addEventListener("pointerup", () => {
    if (!state.activeControlDrag) return;
    renderState.controls.enabled = true;
    state.activeControlDrag = null;
    hideHoverTooltip();
    renderCurrentPatcher();
  });

  canvas.addEventListener("pointerleave", () => {
    if (state.activeControlDrag) return;
    hideHoverTooltip();
    if (!state.hoverToken) return;
    applyHoverState(null);
    renderCurrentPatcher();
  });

  canvas.addEventListener("click", (event) => {
    if (state.ignoreNextClick) {
      state.ignoreNextClick = false;
      return;
    }
    const uid = pickBoxUidFromEvent(event);
    if (uid) {
      selectUid(uid);
    }
  });

  canvas.addEventListener("dblclick", (event) => {
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

function readUrlParams() {
  const params = new URLSearchParams(window.location.search);
  const targetUrl = params.get("data");
  const baseUrl = params.get("base");
  if (targetUrl) {
    dom.urlInput.value = targetUrl;
    loadUrl(targetUrl, false).then(() => {
      if (baseUrl) {
        loadUrl(baseUrl, true);
      }
    });
    return;
  }
  if (baseUrl) {
    loadUrl(baseUrl, true);
  }
}

async function loadFromFile(file, isBase) {
  try {
    const text = await file.text();
    const payload = JSON.parse(text);
    if (isBase) {
      loadBaseDataset(payload, file.name);
      setStatus(`Loaded base diff source: ${file.name}`);
    } else {
      loadTargetDataset(payload, file.name);
      setStatus(`Loaded target patch: ${file.name}`);
    }
  } catch (error) {
    const role = isBase ? "base" : "target";
    if (String(file.name).toLowerCase().endsWith(".amxd")) {
      setStatus(
        `${role} file is .amxd (binary). Export first: python3 tools/maxpat_query.py export-viz <file.amxd> > patch.viz.json`,
      );
      return;
    }
    setStatus(`Could not parse ${role} file: ${error.message}`);
  }
}

async function loadUrl(url, isBase) {
  const role = isBase ? "base" : "target";
  setStatus(`Loading ${role} URL: ${url} ...`);
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }
    const payload = await response.json();
    if (isBase) {
      loadBaseDataset(payload, url);
    } else {
      loadTargetDataset(payload, url);
    }
    setStatus(`Loaded ${role} URL: ${url}`);
  } catch (error) {
    setStatus(`URL load failed (${role}): ${error.message}`);
  }
}

function loadTargetDataset(payload, sourceName) {
  const normalized = normalizeDataset(payload, sourceName);
  state.dataset = normalized;
  state.datasetName = sourceName || "loaded target";

  rebuildTargetIndexes();
  clearTrace(true, true);
  refreshDiffModel();
  state.controlValues = new Map();
  state.activeControlDrag = null;
  applyHoverState(null);
  hideHoverTooltip();

  const rootPath = normalized.root_patcher_path || "root";
  const initialPath = state.patcherByPath.has(rootPath)
    ? rootPath
    : [...state.patcherByPath.keys()][0] || "";

  state.selectedUid = "";
  state.currentPatcherPath = initialPath;

  goToPatcher(initialPath, true);
  runSearch();
}

function loadBaseDataset(payload, sourceName) {
  const normalized = normalizeDataset(payload, sourceName);
  state.baseDataset = normalized;
  state.baseDatasetName = sourceName || "loaded base";
  refreshDiffModel();
  renderCurrentPatcher();
}

function rebuildTargetIndexes() {
  state.patcherByPath = new Map();
  state.parentPathByChild = new Map();
  state.boxByUid = new Map();
  state.searchable = [];

  for (const patcher of state.dataset?.patchers || []) {
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
}

function normalizeDataset(payload, sourceName) {
  if (
    payload &&
    typeof payload === "object" &&
    Array.isArray(payload.patchers) &&
    typeof payload.root_patcher_path === "string"
  ) {
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

  const unwrapBoxes = (patcher) =>
    (Array.isArray(patcher?.boxes) ? patcher.boxes : [])
      .map((item) => (item && typeof item === "object" ? item.box : null))
      .filter((item) => item && typeof item === "object");

  const unwrapLines = (patcher) =>
    (Array.isArray(patcher?.lines) ? patcher.lines : [])
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
        order: Object.prototype.hasOwnProperty.call(line, "order")
          ? safeInt(line.order, -1)
          : null,
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
      walk(
        box.patcher,
        childPath(patcherPath, box),
        uidById.get(id) || `${patcherPath}/${id}`,
      );
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

function refreshDiffModel() {
  const toggleWasOn = dom.diffOverlayToggle.checked;
  if (!state.dataset || !state.baseDataset) {
    state.diffModel = null;
    state.diffOverlayEnabled = false;
    dom.diffOverlayToggle.checked = false;
    dom.diffOverlayToggle.disabled = true;
    renderDiffMeta();
    return;
  }

  state.diffModel = computeSemanticDiff(state.dataset, state.baseDataset);
  dom.diffOverlayToggle.disabled = false;
  state.diffOverlayEnabled = toggleWasOn;
  dom.diffOverlayToggle.checked = state.diffOverlayEnabled;
  renderDiffMeta();
}

function computeSemanticDiff(targetDataset, baseDataset) {
  const targetByPath = new Map((targetDataset.patchers || []).map((patcher) => [patcher.path, patcher]));
  const baseByPath = new Map((baseDataset.patchers || []).map((patcher) => [patcher.path, patcher]));

  const allPaths = new Set([...targetByPath.keys(), ...baseByPath.keys()]);
  const byPatcher = new Map();

  const summary = {
    addedBoxes: 0,
    removedBoxes: 0,
    modifiedBoxes: 0,
    addedLines: 0,
    removedLines: 0,
    patchersOnlyInTarget: 0,
    patchersOnlyInBase: 0,
  };

  for (const path of [...allPaths].sort()) {
    const targetPatcher = targetByPath.get(path) || null;
    const basePatcher = baseByPath.get(path) || null;

    if (targetPatcher && !basePatcher) summary.patchersOnlyInTarget += 1;
    if (!targetPatcher && basePatcher) summary.patchersOnlyInBase += 1;

    if (!targetPatcher && basePatcher) {
      summary.removedBoxes += basePatcher.boxes?.length || 0;
      summary.removedLines += basePatcher.lines?.length || 0;
      continue;
    }

    if (!targetPatcher) continue;

    const patcherDiff = {
      addedBoxIds: new Set(),
      modifiedBoxIds: new Set(),
      removedBoxes: [],
      addedLineKeys: new Set(),
      removedLines: [],
      counts: {
        addedBoxes: 0,
        removedBoxes: 0,
        modifiedBoxes: 0,
        addedLines: 0,
        removedLines: 0,
      },
    };

    if (!basePatcher) {
      for (const box of targetPatcher.boxes || []) {
        patcherDiff.addedBoxIds.add(box.id);
      }
      for (const line of targetPatcher.lines || []) {
        patcherDiff.addedLineKeys.add(lineSemanticKey(line));
      }
      patcherDiff.counts.addedBoxes = targetPatcher.boxes?.length || 0;
      patcherDiff.counts.addedLines = targetPatcher.lines?.length || 0;

      summary.addedBoxes += patcherDiff.counts.addedBoxes;
      summary.addedLines += patcherDiff.counts.addedLines;

      byPatcher.set(path, patcherDiff);
      continue;
    }

    const baseBoxById = new Map((basePatcher.boxes || []).map((box) => [box.id, box]));
    const targetBoxById = new Map((targetPatcher.boxes || []).map((box) => [box.id, box]));

    for (const [id, targetBox] of targetBoxById) {
      const baseBox = baseBoxById.get(id);
      if (!baseBox) {
        patcherDiff.addedBoxIds.add(id);
        continue;
      }
      if (!boxSemanticallyEqual(baseBox, targetBox)) {
        patcherDiff.modifiedBoxIds.add(id);
      }
    }

    for (const [id, baseBox] of baseBoxById) {
      if (!targetBoxById.has(id)) {
        patcherDiff.removedBoxes.push(baseBox);
      }
    }

    patcherDiff.counts.addedBoxes = patcherDiff.addedBoxIds.size;
    patcherDiff.counts.modifiedBoxes = patcherDiff.modifiedBoxIds.size;
    patcherDiff.counts.removedBoxes = patcherDiff.removedBoxes.length;

    const baseLineCounts = new Map();
    for (const line of basePatcher.lines || []) {
      const key = lineSemanticKey(line);
      baseLineCounts.set(key, (baseLineCounts.get(key) || 0) + 1);
    }

    const targetLineCounts = new Map();
    for (const line of targetPatcher.lines || []) {
      const key = lineSemanticKey(line);
      targetLineCounts.set(key, (targetLineCounts.get(key) || 0) + 1);
      const seen = targetLineCounts.get(key);
      const baseCount = baseLineCounts.get(key) || 0;
      if (seen > baseCount) {
        patcherDiff.addedLineKeys.add(key);
        patcherDiff.counts.addedLines += 1;
      }
    }

    const seenBaseCounts = new Map();
    for (const line of basePatcher.lines || []) {
      const key = lineSemanticKey(line);
      seenBaseCounts.set(key, (seenBaseCounts.get(key) || 0) + 1);
      const seen = seenBaseCounts.get(key);
      const targetCount = targetLineCounts.get(key) || 0;
      if (seen > targetCount) {
        patcherDiff.removedLines.push(line);
        patcherDiff.counts.removedLines += 1;
      }
    }

    summary.addedBoxes += patcherDiff.counts.addedBoxes;
    summary.modifiedBoxes += patcherDiff.counts.modifiedBoxes;
    summary.removedBoxes += patcherDiff.counts.removedBoxes;
    summary.addedLines += patcherDiff.counts.addedLines;
    summary.removedLines += patcherDiff.counts.removedLines;

    const changed =
      patcherDiff.counts.addedBoxes ||
      patcherDiff.counts.modifiedBoxes ||
      patcherDiff.counts.removedBoxes ||
      patcherDiff.counts.addedLines ||
      patcherDiff.counts.removedLines;

    if (changed) {
      byPatcher.set(path, patcherDiff);
    }
  }

  return { summary, byPatcher };
}

function boxSemanticallyEqual(baseBox, targetBox) {
  const signature = (box) => ({
    maxclass: box.maxclass || "",
    object_name: box.object_name || "",
    text: box.text || "",
    varname: box.varname || "",
    numinlets: Number(box.numinlets || 0),
    numoutlets: Number(box.numoutlets || 0),
    outlettype: Array.isArray(box.outlettype) ? box.outlettype : [],
    has_child_patcher: Boolean(box.has_child_patcher),
    child_patcher_path: box.child_patcher_path || "",
  });
  return JSON.stringify(signature(baseBox)) === JSON.stringify(signature(targetBox));
}

function lineSemanticKey(line) {
  const order = line?.order === null || line?.order === undefined ? "n" : String(line.order);
  return [
    String(line?.source_id || ""),
    String(line?.source_outlet ?? -1),
    String(line?.destination_id || ""),
    String(line?.destination_inlet ?? -1),
    order,
  ].join("|");
}

function getCurrentPatcherDiff() {
  if (!state.diffModel) return null;
  return state.diffModel.byPatcher.get(state.currentPatcherPath) || null;
}

function goToPatcher(path, fitView) {
  if (!path || !state.patcherByPath.has(path)) return;
  state.currentPatcherPath = path;
  state.selectedUid = "";
  applyHoverState(null);
  hideHoverTooltip();
  renderCurrentPatcher();
  if (fitView) fitToCurrentPatcher();
}

function renderCurrentPatcher() {
  clearRenderGroup();

  const patcher = state.patcherByPath.get(state.currentPatcherPath);
  if (!patcher) {
    setStatus("No patcher selected.");
    renderPatcherMeta(null);
    renderBreadcrumbs();
    renderSelection();
    renderHoverMeta();
    renderState.renderer.domElement.style.cursor = "default";
    return;
  }

  renderState.boxMeshByUid = new Map();
  renderState.targetBoxById = new Map();
  renderState.baseBoxById = new Map();
  renderState.controlHitMeshes = [];
  renderState.portHitMeshes = [];
  renderState.lineHitMeshes = [];

  for (const box of patcher.boxes || []) {
    renderState.targetBoxById.set(box.id, box);
  }

  const patcherDiff = state.diffOverlayEnabled ? getCurrentPatcherDiff() : null;
  const basePatcher =
    patcherDiff && state.baseDataset?.patchers
      ? state.baseDataset.patchers.find((item) => item.path === state.currentPatcherPath)
      : null;
  if (patcherDiff?.removedBoxes?.length) {
    for (const baseBox of patcherDiff.removedBoxes) {
      renderState.baseBoxById.set(baseBox.id, baseBox);
    }
  }
  if (patcherDiff?.removedLines?.length) {
    for (const line of patcherDiff.removedLines) {
      if (!renderState.baseBoxById.has(line.source_id)) {
        const sourceBox = basePatcher?.boxes?.find((box) => box.id === line.source_id);
        if (sourceBox) renderState.baseBoxById.set(sourceBox.id, sourceBox);
      }
      if (!renderState.baseBoxById.has(line.destination_id)) {
        const destinationBox = basePatcher?.boxes?.find(
          (box) => box.id === line.destination_id,
        );
        if (destinationBox) renderState.baseBoxById.set(destinationBox.id, destinationBox);
      }
    }
  }

  for (const line of patcher.lines || []) {
    renderLine(line, renderState.targetBoxById, {
      removed: false,
      patcherDiff,
    });
  }

  if (patcherDiff?.removedLines?.length) {
    for (const baseLine of patcherDiff.removedLines) {
      renderLine(baseLine, renderState.baseBoxById, {
        removed: true,
        patcherDiff,
      });
    }
  }

  if (patcherDiff?.removedBoxes?.length) {
    for (const baseBox of patcherDiff.removedBoxes) {
      renderRemovedGhostBox(baseBox);
    }
  }

  for (const box of patcher.boxes || []) {
    renderBox(box, patcherDiff);
  }

  renderPatcherMeta(patcher);
  renderBreadcrumbs();
  renderSelection();
  renderHoverMeta();
  renderTraceMeta();

  const diffSuffix =
    state.diffOverlayEnabled && patcherDiff
      ? ` | diff +${patcherDiff.counts.addedBoxes}/-${patcherDiff.counts.removedBoxes}/~${patcherDiff.counts.modifiedBoxes}`
      : "";

  setStatus(`${patcher.path} | ${patcher.box_count} boxes | ${patcher.line_count} lines${diffSuffix}`);
  renderState.renderer.domElement.style.cursor = cursorForCurrentInteraction();
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

function renderLine(line, boxLookup, options) {
  const src = boxLookup.get(line.source_id);
  const dst = boxLookup.get(line.destination_id);
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

  const edgeKey = lineSemanticKey(line);
  const isTraceEdge = state.traceEdgeKeys.has(edgeKey) && !options.removed;
  const isDiffAdded =
    state.diffOverlayEnabled && !options.removed && Boolean(options.patcherDiff?.addedLineKeys?.has(edgeKey));
  const isHoveredLine = state.hoverLineKey === edgeKey;

  let lineColor = line.order === null ? COLORS.line : COLORS.lineOrdered;
  let lineOpacity = 0.9;
  if (isHoveredLine) {
    lineColor = COLORS.hoverLine;
    lineOpacity = 1.0;
  } else if (options.removed) {
    lineColor = COLORS.diffRemoved;
    lineOpacity = 0.75;
  } else if (isTraceEdge) {
    lineColor = COLORS.trace;
    lineOpacity = 1.0;
  } else if (isDiffAdded) {
    lineColor = COLORS.diffAdded;
    lineOpacity = 1.0;
  }

  const vectors = points.map((point) => new THREE.Vector3(point.x, -point.y, 0));
  const geometry = new THREE.BufferGeometry().setFromPoints(vectors);
  const material = new THREE.LineBasicMaterial({
    color: lineColor,
    transparent: true,
    opacity: lineOpacity,
  });
  const wire = new THREE.Line(geometry, material);
  wire.position.z = options.removed ? 0.015 : 0.02;
  wire.userData = {
    line: {
      key: edgeKey,
      srcUid: src.uid,
      dstUid: dst.uid,
      srcLabel: boxLabel(src),
      dstLabel: boxLabel(dst),
      sourceOutlet: Number(line.source_outlet ?? -1),
      destinationInlet: Number(line.destination_inlet ?? -1),
      order: line.order,
      removed: Boolean(options.removed),
    },
  };
  renderState.lineHitMeshes.push(wire);
  renderState.renderGroup.add(wire);
}

function renderBox(box, patcherDiff) {
  const rect = safeRect(box.patching_rect);
  const [x, y, width, height] = rect;
  const controlKind = controlKindForBox(box, rect);

  const diffStatus =
    state.diffOverlayEnabled && patcherDiff
      ? patcherDiff.addedBoxIds.has(box.id)
        ? "added"
        : patcherDiff.modifiedBoxIds.has(box.id)
          ? "modified"
          : ""
      : "";

  const isTraceNode = state.traceNodeUids.has(box.uid);
  const isSource = state.traceSourceUid === box.uid;
  const isTarget = state.traceTargetUid === box.uid;
  const isSelected = state.selectedUid === box.uid;
  const isHovered = state.hoverUid === box.uid;
  const isLineEndpoint = state.hoverLineEndpoints.has(box.uid);
  const hoveredPort = state.hoverPortKey ? parsePortKey(state.hoverPortKey) : null;

  const { fillColor, borderColor } = boxVisualStyle({
    box,
    diffStatus,
    isTraceNode,
    isSource,
    isTarget,
    isSelected,
    isHovered,
    isLineEndpoint,
  });

  const geometry = new THREE.PlaneGeometry(Math.max(width, 24), Math.max(height, 14));
  const material = new THREE.MeshBasicMaterial({ color: fillColor });
  const mesh = new THREE.Mesh(geometry, material);
  mesh.position.set(x + width / 2, -(y + height / 2), 0.25);
  mesh.userData = {
    uid: box.uid,
    box,
  };
  renderState.boxMeshByUid.set(box.uid, mesh);
  renderState.renderGroup.add(mesh);

  const borderGeometry = new THREE.EdgesGeometry(geometry);
  const borderMaterial = new THREE.LineBasicMaterial({ color: borderColor });
  const border = new THREE.LineSegments(borderGeometry, borderMaterial);
  border.position.copy(mesh.position);
  border.position.z = 0.3;
  renderState.renderGroup.add(border);

  renderPorts(
    box,
    rect,
    mesh.position.z + 0.02,
    hoveredPort && hoveredPort.uid === box.uid ? hoveredPort : null,
  );

  if (controlKind) {
    renderControlWidget(box, rect, controlKind, mesh.position.z + 0.05);
  }

  const label = boxLabel(box);
  if (label) {
    const sprite = createTextSprite(label, width, height, "#f1f6fb", {
      compact: Boolean(controlKind),
      emphasize: isSelected || isHovered,
    });
    sprite.position.set(mesh.position.x, mesh.position.y, 0.35);
    renderState.renderGroup.add(sprite);
  }
}

function renderRemovedGhostBox(baseBox) {
  const rect = safeRect(baseBox.patching_rect);
  const [x, y, width, height] = rect;

  const geometry = new THREE.PlaneGeometry(Math.max(width, 24), Math.max(height, 14));
  const material = new THREE.MeshBasicMaterial({
    color: COLORS.diffRemoved,
    transparent: true,
    opacity: 0.22,
  });
  const mesh = new THREE.Mesh(geometry, material);
  mesh.position.set(x + width / 2, -(y + height / 2), 0.18);
  renderState.renderGroup.add(mesh);

  const borderGeometry = new THREE.EdgesGeometry(geometry);
  const borderMaterial = new THREE.LineBasicMaterial({ color: COLORS.diffRemoved });
  const border = new THREE.LineSegments(borderGeometry, borderMaterial);
  border.position.copy(mesh.position);
  border.position.z = 0.22;
  renderState.renderGroup.add(border);

  const label = boxLabel(baseBox);
  if (label) {
    const sprite = createTextSprite(`- ${label}`, width, height, "#ffd7de", {
      compact: true,
    });
    sprite.position.set(mesh.position.x, mesh.position.y, 0.24);
    renderState.renderGroup.add(sprite);
  }
}

function controlKindForBox(box, rect) {
  const maxclass = String(box?.maxclass || "");
  if (maxclass === "slider" || maxclass === "live.slider" || maxclass === "multislider") {
    return rect[3] > rect[2] * 1.25 ? "vslider" : "hslider";
  }
  if (maxclass === "dial" || maxclass === "live.dial") {
    return "dial";
  }
  return "";
}

function getControlValue(uid, fallback = 0.5) {
  if (!state.controlValues.has(uid)) {
    state.controlValues.set(uid, fallback);
  }
  return Number(state.controlValues.get(uid));
}

function setControlValue(uid, value) {
  const clamped = Math.max(0, Math.min(1, value));
  state.controlValues.set(uid, clamped);
  return clamped;
}

function renderControlWidget(box, rect, kind, zBase) {
  const [x, y, width, height] = rect;
  const centerX = x + width / 2;
  const centerY = -(y + height / 2);
  const value = getControlValue(box.uid, 0.5);

  if (kind === "vslider" || kind === "hslider") {
    const trackLength = kind === "vslider" ? Math.max(20, height * 0.72) : Math.max(20, width * 0.72);
    const trackBreadth = kind === "vslider" ? Math.min(width - 4, Math.max(6, width * 0.22)) : Math.min(height - 4, Math.max(6, height * 0.22));

    const trackGeometry =
      kind === "vslider"
        ? new THREE.PlaneGeometry(trackBreadth, trackLength)
        : new THREE.PlaneGeometry(trackLength, trackBreadth);
    const trackMaterial = new THREE.MeshBasicMaterial({
      color: 0x0f2029,
      transparent: true,
      opacity: 0.85,
    });
    const track = new THREE.Mesh(trackGeometry, trackMaterial);
    track.position.set(centerX, centerY, zBase + 0.04);
    renderState.renderGroup.add(track);

    const thumbSize =
      kind === "vslider"
        ? {
            w: Math.min(width - 4, Math.max(10, trackBreadth * 1.9)),
            h: Math.max(8, Math.min(16, height * 0.1)),
          }
        : {
            w: Math.max(8, Math.min(16, width * 0.1)),
            h: Math.min(height - 4, Math.max(10, trackBreadth * 1.9)),
          };

    const thumbGeometry = new THREE.PlaneGeometry(thumbSize.w, thumbSize.h);
    const thumbMaterial = new THREE.MeshBasicMaterial({
      color: 0xa7c6d8,
      transparent: true,
      opacity: 0.92,
    });
    const thumb = new THREE.Mesh(thumbGeometry, thumbMaterial);

    if (kind === "vslider") {
      const py = y + (1 - value) * Math.max(1, height - 8) + 4;
      thumb.position.set(centerX, -py, zBase + 0.08);
    } else {
      const px = x + value * Math.max(1, width - 8) + 4;
      thumb.position.set(px, centerY, zBase + 0.08);
    }
    renderState.renderGroup.add(thumb);
  } else if (kind === "dial") {
    const radius = Math.max(8, Math.min(width, height) * 0.33);

    const ringGeometry = new THREE.RingGeometry(radius * 0.72, radius, 28);
    const ringMaterial = new THREE.MeshBasicMaterial({
      color: 0x10222d,
      transparent: true,
      opacity: 0.9,
    });
    const ring = new THREE.Mesh(ringGeometry, ringMaterial);
    ring.position.set(centerX, centerY, zBase + 0.05);
    renderState.renderGroup.add(ring);

    const pointerGeometry = new THREE.PlaneGeometry(radius * 0.9, Math.max(2, radius * 0.12));
    const pointerMaterial = new THREE.MeshBasicMaterial({ color: 0xbad6e6 });
    const pointer = new THREE.Mesh(pointerGeometry, pointerMaterial);
    pointer.position.set(centerX, centerY, zBase + 0.08);
    pointer.rotation.z = dialAngleFromValue(value);
    renderState.renderGroup.add(pointer);
  }

  const hitGeometry = new THREE.PlaneGeometry(Math.max(width, 24), Math.max(height, 14));
  const hitMaterial = new THREE.MeshBasicMaterial({
    color: 0xffffff,
    transparent: true,
    opacity: 0.001,
    depthWrite: false,
  });
  const hitMesh = new THREE.Mesh(hitGeometry, hitMaterial);
  hitMesh.position.set(centerX, centerY, zBase + 0.12);
  hitMesh.userData = {
    control: {
      uid: box.uid,
      kind,
    },
  };
  renderState.controlHitMeshes.push(hitMesh);
  renderState.renderGroup.add(hitMesh);
}

function portKey(uid, dir, index) {
  return JSON.stringify([String(uid || ""), String(dir || ""), Number(index || 0)]);
}

function parsePortKey(key) {
  if (!key) return null;
  try {
    const parsed = JSON.parse(String(key));
    if (!Array.isArray(parsed) || parsed.length !== 3) return null;
    const index = Number(parsed[2]);
    if (!Number.isFinite(index)) return null;
    return {
      uid: String(parsed[0] || ""),
      dir: String(parsed[1] || ""),
      index,
    };
  } catch (error) {
    // Backward-compat: accept the legacy "uid|dir|index" format.
    const parts = String(key).split("|");
    if (parts.length !== 3) return null;
    const index = Number(parts[2]);
    if (!Number.isFinite(index)) return null;
    return {
      uid: parts[0],
      dir: parts[1],
      index,
    };
  }
}

function portDescription(box, dir, index) {
  const label = boxLabel(box) || box.id || "object";
  if (dir === "in") {
    const hotness = index === 0 ? "hot inlet" : "cold inlet";
    return `${label} — Inlet ${index + 1} (${hotness}; object-specific behavior)`;
  }
  let outType = "";
  if (Array.isArray(box.outlettype) && box.outlettype[index] !== undefined) {
    outType = String(box.outlettype[index] || "").trim();
  }
  if (!outType) outType = "any";
  return `${label} — Outlet ${index + 1} (${outType})`;
}

function renderPorts(box, rect, zBase, hoveredPort) {
  const [x, y, width, height] = rect;
  const inletCount = Math.max(0, Number(box.numinlets || 0));
  const outletCount = Math.max(0, Number(box.numoutlets || 0));

  const portRadius = Math.max(1.8, Math.min(3.2, Math.min(width, height) * 0.06));
  const hitRadius = Math.max(portRadius * 2.2, 6);

  for (let i = 0; i < inletCount; i += 1) {
    const px = inletX(rect, i, inletCount);
    const py = y + 1.8;
    const key = portKey(box.uid, "in", i);
    const isHovered = Boolean(hoveredPort && hoveredPort.dir === "in" && hoveredPort.index === i);

    const dotGeometry = new THREE.CircleGeometry(portRadius, 16);
    const dotMaterial = new THREE.MeshBasicMaterial({
      color: isHovered ? COLORS.hoverPort : COLORS.port,
      transparent: true,
      opacity: isHovered ? 1.0 : 0.9,
    });
    const dot = new THREE.Mesh(dotGeometry, dotMaterial);
    dot.position.set(px, -py, zBase + 0.01);
    renderState.renderGroup.add(dot);

    const hitGeometry = new THREE.CircleGeometry(hitRadius, 16);
    const hitMaterial = new THREE.MeshBasicMaterial({
      color: 0xffffff,
      transparent: true,
      opacity: 0.001,
      depthWrite: false,
    });
    const hitMesh = new THREE.Mesh(hitGeometry, hitMaterial);
    hitMesh.position.copy(dot.position);
    hitMesh.position.z = zBase + 0.04;
    hitMesh.userData = {
      port: {
        key,
        uid: box.uid,
        dir: "in",
        index: i,
        description: portDescription(box, "in", i),
      },
    };
    renderState.portHitMeshes.push(hitMesh);
    renderState.renderGroup.add(hitMesh);
  }

  for (let i = 0; i < outletCount; i += 1) {
    const px = outletX(rect, i, outletCount);
    const py = y + height - 1.8;
    const key = portKey(box.uid, "out", i);
    const isHovered = Boolean(hoveredPort && hoveredPort.dir === "out" && hoveredPort.index === i);

    const dotGeometry = new THREE.CircleGeometry(portRadius, 16);
    const dotMaterial = new THREE.MeshBasicMaterial({
      color: isHovered ? COLORS.hoverPort : COLORS.port,
      transparent: true,
      opacity: isHovered ? 1.0 : 0.9,
    });
    const dot = new THREE.Mesh(dotGeometry, dotMaterial);
    dot.position.set(px, -py, zBase + 0.01);
    renderState.renderGroup.add(dot);

    const hitGeometry = new THREE.CircleGeometry(hitRadius, 16);
    const hitMaterial = new THREE.MeshBasicMaterial({
      color: 0xffffff,
      transparent: true,
      opacity: 0.001,
      depthWrite: false,
    });
    const hitMesh = new THREE.Mesh(hitGeometry, hitMaterial);
    hitMesh.position.copy(dot.position);
    hitMesh.position.z = zBase + 0.04;
    hitMesh.userData = {
      port: {
        key,
        uid: box.uid,
        dir: "out",
        index: i,
        description: portDescription(box, "out", i),
      },
    };
    renderState.portHitMeshes.push(hitMesh);
    renderState.renderGroup.add(hitMesh);
  }
}

function boxVisualStyle(flags) {
  let fillColor = boxColor(flags.box);
  let borderColor = COLORS.border;

  if (flags.diffStatus === "added") {
    fillColor = blendColor(fillColor, COLORS.diffAdded, 0.38);
    borderColor = COLORS.diffAdded;
  } else if (flags.diffStatus === "modified") {
    fillColor = blendColor(fillColor, COLORS.diffModified, 0.35);
    borderColor = COLORS.diffModified;
  }

  if (flags.isTraceNode) {
    fillColor = blendColor(fillColor, COLORS.trace, 0.45);
    borderColor = COLORS.trace;
  }

  if (flags.isSource) borderColor = COLORS.traceSource;
  if (flags.isTarget) borderColor = COLORS.traceTarget;

  if (flags.isHovered && !flags.isSelected) {
    fillColor = blendColor(fillColor, 0x9dd4ff, 0.16);
    borderColor = 0xaedaff;
  }

  if (flags.isLineEndpoint && !flags.isSelected) {
    fillColor = blendColor(fillColor, 0xdff4ff, 0.24);
    borderColor = 0xc8e8ff;
  }

  if (flags.isSelected) {
    fillColor = COLORS.selected;
    borderColor = 0xfde68a;
  }

  return { fillColor, borderColor };
}

function blendColor(colorA, colorB, alpha) {
  const a = new THREE.Color(colorA);
  const b = new THREE.Color(colorB);
  a.lerp(b, Math.max(0, Math.min(alpha, 1)));
  return a.getHex();
}

function boxColor(box) {
  const maxclass = String(box?.maxclass || "");
  if (maxclass === "inlet" || maxclass === "outlet") return 0x4c5560;
  if (maxclass === "comment" || maxclass === "message") return 0x654833;
  if (
    maxclass === "toggle" ||
    maxclass === "number" ||
    maxclass === "flonum" ||
    maxclass === "slider" ||
    maxclass === "dial"
  ) {
    return 0x2f5b48;
  }
  if (maxclass.startsWith("live.")) return 0x776128;
  if (maxclass === "newobj") return 0x2c436c;
  return 0x3e4a56;
}

function boxLabel(box) {
  const raw = String(
    box.varname || box.text || box.object_name || box.maxclass || box.id || "",
  ).trim();
  if (!raw) return "";
  const compact = raw.replace(/\s+/g, " ");
  return compact.length > 38 ? `${compact.slice(0, 35)}...` : compact;
}

function createTextSprite(text, width, height, color = "#f1f6fb", options = {}) {
  const compact = Boolean(options.compact);
  const emphasize = Boolean(options.emphasize);

  const maxChars = compact ? 24 : 36;
  const clipped = text.length > maxChars ? `${text.slice(0, maxChars - 1)}…` : text;

  const canvas = document.createElement("canvas");
  canvas.width = 512;
  canvas.height = 128;
  const context = canvas.getContext("2d");
  context.clearRect(0, 0, canvas.width, canvas.height);
  context.fillStyle = color;
  context.font = `${emphasize ? "700" : "500"} 42px "IBM Plex Mono", monospace`;
  context.textAlign = "center";
  context.textBaseline = "middle";
  context.fillText(clipped, canvas.width / 2, canvas.height / 2);

  const texture = new THREE.CanvasTexture(canvas);
  texture.needsUpdate = true;
  texture.minFilter = THREE.LinearFilter;
  texture.magFilter = THREE.LinearFilter;

  const material = new THREE.SpriteMaterial({
    map: texture,
    transparent: true,
    depthTest: false,
    depthWrite: false,
  });
  const sprite = new THREE.Sprite(material);

  const maxLabelWidth = Math.max(16, width - 8);
  const maxLabelHeight = Math.max(10, Math.min(height * (compact ? 0.5 : 0.72), compact ? 18 : 22));
  const aspect = canvas.width / canvas.height;
  let spriteHeight = maxLabelHeight;
  let spriteWidth = spriteHeight * aspect;
  if (spriteWidth > maxLabelWidth) {
    spriteWidth = maxLabelWidth;
    spriteHeight = spriteWidth / aspect;
  }

  sprite.scale.set(spriteWidth, spriteHeight, 1);
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
  renderState.camera.position.set(
    rect[0] + rect[2] / 2,
    -(rect[1] + rect[3] / 2),
    100,
  );
  renderState.controls.target.set(rect[0] + rect[2] / 2, -(rect[1] + rect[3] / 2), 0);
  renderState.camera.updateProjectionMatrix();
  renderState.controls.update();
}

function setPointerFromEvent(event) {
  const canvasRect = renderState.renderer.domElement.getBoundingClientRect();
  renderState.pointer.x = ((event.clientX - canvasRect.left) / canvasRect.width) * 2 - 1;
  renderState.pointer.y = -((event.clientY - canvasRect.top) / canvasRect.height) * 2 + 1;
}

function pickBoxUidFromEvent(event) {
  setPointerFromEvent(event);
  renderState.raycaster.setFromCamera(renderState.pointer, renderState.camera);
  const candidates = [...renderState.boxMeshByUid.values()];
  const hits = renderState.raycaster.intersectObjects(candidates, false);
  if (!hits.length) return "";
  return String(hits[0]?.object?.userData?.uid || "");
}

function pickControlFromEvent(event) {
  if (!renderState.controlHitMeshes.length) return null;
  setPointerFromEvent(event);
  renderState.raycaster.setFromCamera(renderState.pointer, renderState.camera);
  const hits = renderState.raycaster.intersectObjects(renderState.controlHitMeshes, false);
  if (!hits.length) return null;
  const control = hits[0]?.object?.userData?.control;
  if (!control?.uid || !control?.kind) return null;
  return control;
}

function pickPortFromEvent(event) {
  if (!renderState.portHitMeshes.length) return null;
  setPointerFromEvent(event);
  renderState.raycaster.setFromCamera(renderState.pointer, renderState.camera);
  const hits = renderState.raycaster.intersectObjects(renderState.portHitMeshes, false);
  if (!hits.length) return null;
  const port = hits[0]?.object?.userData?.port;
  if (!port?.uid || !port?.dir) return null;
  return port;
}

function pickLineFromEvent(event) {
  if (!renderState.lineHitMeshes.length) return null;
  setPointerFromEvent(event);
  renderState.raycaster.setFromCamera(renderState.pointer, renderState.camera);
  const hits = renderState.raycaster.intersectObjects(renderState.lineHitMeshes, false);
  if (!hits.length) return null;
  const line = hits[0]?.object?.userData?.line;
  if (!line?.key) return null;
  return line;
}

function pickHoverFromEvent(event) {
  const port = pickPortFromEvent(event);
  if (port) {
    return {
      type: "port",
      token: `p:${port.key}`,
      ...port,
    };
  }

  const line = pickLineFromEvent(event);
  if (line) {
    return {
      type: "line",
      token: `l:${line.key}`,
      ...line,
    };
  }

  const uid = pickBoxUidFromEvent(event);
  if (uid) {
    return {
      type: "box",
      token: `b:${uid}`,
      uid,
    };
  }

  return null;
}

function hoverToken(hover) {
  if (!hover) return "";
  return hover.token || "";
}

function applyHoverState(hover) {
  state.hoverInfo = hover || null;
  state.hoverToken = hoverToken(hover);
  state.hoverUid = "";
  state.hoverPortKey = "";
  state.hoverLineKey = "";
  state.hoverLineEndpoints = new Set();

  if (!hover) return;

  if (hover.type === "port") {
    state.hoverUid = hover.uid;
    state.hoverPortKey = hover.key;
    return;
  }

  if (hover.type === "line") {
    state.hoverLineKey = hover.key;
    if (hover.srcUid) state.hoverLineEndpoints.add(hover.srcUid);
    if (hover.dstUid) state.hoverLineEndpoints.add(hover.dstUid);
    return;
  }

  if (hover.type === "box") {
    state.hoverUid = hover.uid;
  }
}

function tooltipTextForHover(hover) {
  if (!hover) return "";
  if (hover.type === "port") {
    return hover.description || "";
  }
  if (hover.type === "line") {
    const src = hover.srcLabel || hover.srcUid || "source";
    const dst = hover.dstLabel || hover.dstUid || "destination";
    const srcOutlet = Number.isFinite(hover.sourceOutlet) ? hover.sourceOutlet + 1 : "?";
    const dstInlet = Number.isFinite(hover.destinationInlet) ? hover.destinationInlet + 1 : "?";
    return `${src} [${srcOutlet}] → ${dst} [${dstInlet}]`;
  }
  if (hover.type === "box") {
    const box = state.boxByUid.get(hover.uid);
    if (!box) return "";
    return `${boxLabel(box)} (${box.id})`;
  }
  if (hover.type === "control") {
    const box = state.boxByUid.get(hover.uid);
    return box ? `Adjusting ${boxLabel(box)}` : "Adjusting control";
  }
  return "";
}

function updateHoverTooltip(event, hover) {
  const tip = dom.hoverTooltip;
  if (!tip) return;
  const text = tooltipTextForHover(hover);
  if (!text) {
    hideHoverTooltip();
    return;
  }
  const canvasRect = renderState.renderer.domElement.getBoundingClientRect();
  const pointerX = event.clientX - canvasRect.left;
  const pointerY = event.clientY - canvasRect.top;
  const safeX = Number.isFinite(pointerX) ? pointerX : 0;
  const safeY = Number.isFinite(pointerY) ? pointerY : 0;
  tip.textContent = text;
  tip.style.left = `${safeX}px`;
  tip.style.top = `${safeY}px`;
  tip.classList.add("visible");
}

function hideHoverTooltip() {
  const tip = dom.hoverTooltip;
  if (!tip) return;
  tip.classList.remove("visible");
}

function screenToPatchCoordinates(event) {
  const canvasRect = renderState.renderer.domElement.getBoundingClientRect();
  const ndc = new THREE.Vector3(
    ((event.clientX - canvasRect.left) / canvasRect.width) * 2 - 1,
    -((event.clientY - canvasRect.top) / canvasRect.height) * 2 + 1,
    0,
  );
  ndc.unproject(renderState.camera);
  return {
    x: ndc.x,
    y: -ndc.y,
  };
}

function dialAngleFromValue(value) {
  const start = -Math.PI * 0.75;
  const span = Math.PI * 1.5;
  return start + Math.max(0, Math.min(1, value)) * span;
}

function valueFromDialAngle(angle) {
  const start = -Math.PI * 0.75;
  const end = Math.PI * 0.75;
  let adjusted = angle;
  if (adjusted < start) adjusted += Math.PI * 2;
  const clamped = Math.max(start, Math.min(end, adjusted));
  return (clamped - start) / (end - start);
}

function updateControlValueFromPointer(uid, kind, event) {
  const box = state.boxByUid.get(uid);
  if (!box) return;
  const rect = safeRect(box.patching_rect);
  const pointer = screenToPatchCoordinates(event);

  let value = getControlValue(uid, 0.5);
  if (kind === "vslider") {
    value = 1 - (pointer.y - rect[1]) / Math.max(1, rect[3]);
  } else if (kind === "hslider") {
    value = (pointer.x - rect[0]) / Math.max(1, rect[2]);
  } else if (kind === "dial") {
    const centerX = rect[0] + rect[2] / 2;
    const centerY = rect[1] + rect[3] / 2;
    const dx = pointer.x - centerX;
    const dy = centerY - pointer.y;
    value = valueFromDialAngle(Math.atan2(dy, dx));
  }

  const next = setControlValue(uid, value);
  const label = boxLabel(box);
  setStatus(`Adjusting ${label || box.id}: ${(next * 100).toFixed(0)}%`);
}

function cursorForCurrentInteraction() {
  if (state.activeControlDrag) {
    if (state.activeControlDrag.kind === "vslider") return "ns-resize";
    if (state.activeControlDrag.kind === "hslider") return "ew-resize";
    return "grabbing";
  }
  if (state.hoverPortKey) return "help";
  if (state.hoverLineKey) return "pointer";
  if (state.hoverUid) return "pointer";
  return "grab";
}

function selectUid(uid, options = {}) {
  if (!uid || !state.boxByUid.has(uid)) return;
  state.selectedUid = uid;
  if (!options.skipRender) {
    renderCurrentPatcher();
  }
}

function renderPatcherMeta(patcher) {
  dom.patcherMeta.innerHTML = "";
  if (!patcher) {
    dom.patcherMeta.classList.add("empty");
    dom.patcherMeta.textContent = "No patcher selected";
    return;
  }
  dom.patcherMeta.classList.remove("empty");
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
  addMetaRow(
    dom.selectionMeta,
    "Subpatch",
    box.has_child_patcher ? box.child_patcher_path : "none",
  );
  dom.enterSubpatchBtn.disabled = !box.has_child_patcher;
  dom.highlightInSearchBtn.disabled = false;
}

function docsObjectNameForBox(box) {
  if (!box) return "";
  const maxclass = String(box.maxclass || "").trim();
  if (maxclass === "newobj") {
    const objectName = String(box.object_name || "").trim();
    if (objectName) return objectName;
    const text = String(box.text || "").trim();
    return text ? text.split(/\s+/)[0] : "";
  }
  return maxclass;
}

function docsUrlForBox(box) {
  const name = docsObjectNameForBox(box);
  if (!name) return "";
  const blacklist = new Set([
    "p",
    "v8",
    "js",
    "jsui",
    "node.script",
    "amxd~",
  ]);
  if (blacklist.has(name)) return "";
  if (name.endsWith(".maxpat") || name.endsWith(".amxd") || name.endsWith(".js")) return "";
  if (name.includes("/") || name.includes("\\") || name.includes(" ")) return "";
  return `https://docs.cycling74.com/reference/${encodeURIComponent(name)}/`;
}

function currentHoverBox() {
  if (!state.hoverUid) return null;
  return state.boxByUid.get(state.hoverUid) || null;
}

function renderHoverMeta() {
  const hover = state.hoverInfo;
  dom.hoverMeta.innerHTML = "";

  if (!hover) {
    dom.hoverMeta.classList.add("empty");
    dom.hoverMeta.textContent = "Hover over an object, inlet/outlet, or cable.";
    dom.hoverDocsLink.classList.add("hidden");
    dom.hoverDocsLink.removeAttribute("href");
    return;
  }

  dom.hoverMeta.classList.remove("empty");
  const hoverBox = currentHoverBox();

  if (hover.type === "port") {
    addMetaRow(dom.hoverMeta, "Type", hover.dir === "in" ? "Inlet" : "Outlet");
    addMetaRow(dom.hoverMeta, "Port", `${hover.index + 1}`);
    addMetaRow(dom.hoverMeta, "Info", hover.description || "");
    if (hoverBox) {
      addMetaRow(dom.hoverMeta, "Object", `${boxLabel(hoverBox)} (${hoverBox.id})`);
    }
  } else if (hover.type === "line") {
    const srcOutlet = Number.isFinite(hover.sourceOutlet) ? hover.sourceOutlet + 1 : "?";
    const dstInlet = Number.isFinite(hover.destinationInlet) ? hover.destinationInlet + 1 : "?";
    addMetaRow(dom.hoverMeta, "Type", hover.removed ? "Cable (removed)" : "Cable");
    addMetaRow(
      dom.hoverMeta,
      "Route",
      `${hover.srcLabel || hover.srcUid} [${srcOutlet}] → ${hover.dstLabel || hover.dstUid} [${dstInlet}]`,
    );
    addMetaRow(
      dom.hoverMeta,
      "Order",
      hover.order === null || hover.order === undefined ? "none" : String(hover.order),
    );
  } else if (hover.type === "box" && hoverBox) {
    addMetaRow(dom.hoverMeta, "Type", "Object");
    addMetaRow(dom.hoverMeta, "Label", boxLabel(hoverBox));
    addMetaRow(dom.hoverMeta, "Class", hoverBox.maxclass || "");
    addMetaRow(dom.hoverMeta, "ID", hoverBox.id || "");
  }

  const docsBox = hoverBox;
  const docsUrl = docsUrlForBox(docsBox);
  if (docsUrl) {
    dom.hoverDocsLink.href = docsUrl;
    dom.hoverDocsLink.textContent = `Open Docs: ${docsObjectNameForBox(docsBox)}`;
    dom.hoverDocsLink.classList.remove("hidden");
  } else {
    dom.hoverDocsLink.classList.add("hidden");
    dom.hoverDocsLink.removeAttribute("href");
  }
}

function renderDiffMeta() {
  dom.diffMeta.innerHTML = "";

  if (!state.dataset) {
    dom.diffMeta.classList.add("empty");
    dom.diffMeta.textContent = "Load a target patch first.";
    dom.diffOverlayToggle.checked = false;
    dom.diffOverlayToggle.disabled = true;
    return;
  }

  if (!state.baseDataset || !state.diffModel) {
    dom.diffMeta.classList.add("empty");
    dom.diffMeta.textContent = "Load a base file to compute diff.";
    dom.diffOverlayToggle.checked = false;
    dom.diffOverlayToggle.disabled = true;
    return;
  }

  dom.diffMeta.classList.remove("empty");
  const summary = state.diffModel.summary;
  addMetaRow(dom.diffMeta, "Target", state.datasetName || "target");
  addMetaRow(dom.diffMeta, "Base", state.baseDatasetName || "base");
  addMetaRow(
    dom.diffMeta,
    "Boxes",
    `+${summary.addedBoxes} / -${summary.removedBoxes} / ~${summary.modifiedBoxes}`,
  );
  addMetaRow(dom.diffMeta, "Lines", `+${summary.addedLines} / -${summary.removedLines}`);
  addMetaRow(
    dom.diffMeta,
    "Patcher Scope",
    `target-only ${summary.patchersOnlyInTarget}, base-only ${summary.patchersOnlyInBase}`,
  );
}

function renderTraceMeta() {
  dom.traceMeta.innerHTML = "";

  const sourceBox = state.boxByUid.get(state.traceSourceUid);
  const targetBox = state.boxByUid.get(state.traceTargetUid);

  if (!sourceBox && !targetBox) {
    dom.traceMeta.classList.add("empty");
    dom.traceMeta.textContent = "Select source and target in the same patcher.";
    return;
  }

  dom.traceMeta.classList.remove("empty");
  addMetaRow(
    dom.traceMeta,
    "Source",
    sourceBox ? `${boxLabel(sourceBox)} (${sourceBox.id})` : "not set",
  );
  addMetaRow(
    dom.traceMeta,
    "Target",
    targetBox ? `${boxLabel(targetBox)} (${targetBox.id})` : "not set",
  );

  if (state.traceLastHops !== null) {
    addMetaRow(dom.traceMeta, "Last Path", `${state.traceLastHops} hops`);
  } else if (state.traceLastMessage) {
    addMetaRow(dom.traceMeta, "Status", state.traceLastMessage);
  }
}

function setTraceEndpoint(kind) {
  const selected = state.boxByUid.get(state.selectedUid);
  if (!selected) {
    state.traceLastMessage = "Select an object first.";
    state.traceLastHops = null;
    renderTraceMeta();
    return;
  }

  if (kind === "source") {
    state.traceSourceUid = selected.uid;
  } else {
    state.traceTargetUid = selected.uid;
  }

  state.traceNodeUids = new Set();
  state.traceEdgeKeys = new Set();
  state.traceLastMessage = "Endpoints set. Run trace.";
  state.traceLastHops = null;

  renderTraceMeta();
  renderCurrentPatcher();
}

function clearTrace(clearEndpoints, skipRender = false) {
  if (clearEndpoints) {
    state.traceSourceUid = "";
    state.traceTargetUid = "";
  }
  state.traceNodeUids = new Set();
  state.traceEdgeKeys = new Set();
  state.traceLastMessage = clearEndpoints ? "Trace cleared." : "";
  state.traceLastHops = null;
  renderTraceMeta();
  if (!skipRender) {
    renderCurrentPatcher();
  }
}

function runTrace() {
  const sourceBox = state.boxByUid.get(state.traceSourceUid);
  const targetBox = state.boxByUid.get(state.traceTargetUid);
  if (!sourceBox || !targetBox) {
    state.traceLastMessage = "Set both source and target before running trace.";
    state.traceLastHops = null;
    renderTraceMeta();
    return;
  }

  if (sourceBox.patcher_path !== targetBox.patcher_path) {
    state.traceNodeUids = new Set();
    state.traceEdgeKeys = new Set();
    state.traceLastMessage = "Source and target must be in the same patcher for visual trace.";
    state.traceLastHops = null;
    renderTraceMeta();
    renderCurrentPatcher();
    return;
  }

  if (state.currentPatcherPath !== sourceBox.patcher_path) {
    goToPatcher(sourceBox.patcher_path, true);
  }

  const patcher = state.patcherByPath.get(sourceBox.patcher_path);
  if (!patcher) {
    state.traceLastMessage = "Source patcher not found.";
    state.traceLastHops = null;
    renderTraceMeta();
    return;
  }

  const result = traceInPatcher(patcher, sourceBox.uid, targetBox.uid);
  if (!result) {
    state.traceNodeUids = new Set();
    state.traceEdgeKeys = new Set();
    state.traceLastMessage = "No directed path found.";
    state.traceLastHops = null;
    renderTraceMeta();
    renderCurrentPatcher();
    return;
  }

  state.traceNodeUids = new Set(result.nodeUids);
  state.traceEdgeKeys = new Set(result.edgeKeys);
  state.traceLastHops = result.edgeKeys.length;
  state.traceLastMessage = "";
  renderTraceMeta();
  renderCurrentPatcher();
}

function traceInPatcher(patcher, sourceUid, targetUid) {
  if (sourceUid === targetUid) {
    return { nodeUids: [sourceUid], edgeKeys: [] };
  }

  const uidById = new Map((patcher.boxes || []).map((box) => [box.id, box.uid]));
  const adjacency = new Map();

  for (const line of patcher.lines || []) {
    const srcUid = uidById.get(line.source_id);
    const dstUid = uidById.get(line.destination_id);
    if (!srcUid || !dstUid) continue;

    if (!adjacency.has(srcUid)) adjacency.set(srcUid, []);
    adjacency.get(srcUid).push({
      nextUid: dstUid,
      edgeKey: lineSemanticKey(line),
    });
  }

  const queue = [sourceUid];
  const visited = new Set([sourceUid]);
  const prev = new Map();

  while (queue.length) {
    const uid = queue.shift();
    for (const edge of adjacency.get(uid) || []) {
      if (visited.has(edge.nextUid)) continue;
      visited.add(edge.nextUid);
      prev.set(edge.nextUid, { uid, edgeKey: edge.edgeKey });
      if (edge.nextUid === targetUid) {
        const nodeUids = [targetUid];
        const edgeKeys = [];
        let cursor = targetUid;
        while (cursor !== sourceUid) {
          const hop = prev.get(cursor);
          if (!hop) break;
          nodeUids.push(hop.uid);
          edgeKeys.push(hop.edgeKey);
          cursor = hop.uid;
        }
        nodeUids.reverse();
        edgeKeys.reverse();
        return { nodeUids, edgeKeys };
      }
      queue.push(edge.nextUid);
    }
  }

  return null;
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
  return [box.id, box.text, box.varname, box.maxclass, box.object_name]
    .filter(Boolean)
    .join(" ")
    .toLowerCase();
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

  results.sort(
    (a, b) =>
      b.score - a.score ||
      a.path.localeCompare(b.path) ||
      a.box.id.localeCompare(b.box.id),
  );

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

{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 9,
			"minor": 0,
			"revision": 0,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [100.0, 100.0, 880.0, 680.0],
		"bglocked": 0,
		"openinpresentation": 0,
		"default_fontsize": 10.0,
		"default_fontface": 1,
		"default_fontname": "Arial",
		"gridonopen": 1,
		"gridsize": [8.0, 8.0],
		"gridsnaponopen": 1,
		"objectsnaponopen": 1,
		"statusbarvisible": 2,
		"toolbarvisible": 1,
		"lefttoolbarpinned": 0,
		"toptoolbarpinned": 0,
		"righttoolbarpinned": 0,
		"bottomtoolbarpinned": 0,
		"toolbars_unpinned_last_save": 0,
		"tallnewobj": 0,
		"boxanimatetime": 200,
		"enablehscroll": 1,
		"enablevscroll": 1,
		"devicewidth": 0.0,
		"description": "Bounded ring buffer for messages with random access and dump",
		"digest": "Circular message history buffer with get, dump, clear, capacity",
		"tags": "utility buffer ring history",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "inlet",
					"index": 1,
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [56.0, 16.0, 30.0, 30.0],
					"comment": "message to append (any type, hot)"
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "inlet",
					"index": 2,
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 16.0, 30.0, 30.0],
					"comment": "control: get, dump, clear, capacity, size, reset, bypass"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "outlet",
					"index": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 616.0, 30.0, 30.0],
					"comment": "retrieved values (from get or dump)"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "outlet",
					"index": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 616.0, 30.0, 30.0],
					"comment": "status (full, cleared, size N)"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "comment",
					"text": "--- INIT ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [600.0, 16.0, 80.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [600.0, 40.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"text": "patcherargs 16",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [600.0, 64.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [600.0, 96.0, 42.0, 22.0],
					"comment": "R-to-L: init bypass=0 (first), send cap (second)"
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "prepend capacity",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 128.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [680.0, 96.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [680.0, 120.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "comment",
					"text": "--- CONTROL ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 56.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "route bypass",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [400.0, 80.0, 72.0, 22.0],
					"comment": "split off bypass, rest passes through to v8"
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 112.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "comment",
					"text": "--- BYPASS ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 56.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [56.0, 80.0, 42.0, 22.0],
					"comment": "R-to-L: get bypass (first), pass msg (second)"
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [56.0, 112.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [56.0, 136.0, 30.0, 22.0],
					"comment": "bypass=0 -> gate 1 (store), bypass=1 -> gate 2 (pass)"
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"text": "gate 2 1",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [56.0, 168.0, 152.0, 22.0],
					"comment": "1=store, 2=bypass"
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "comment",
					"text": "--- RING BUFFER (v8.codebox) ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 208.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "v8.codebox @code \"var buf = [];\\nvar head = 0;\\nvar count = 0;\\nvar cap = 16;\\n\\nfunction capacity(n) {\\n  n = Math.max(1, Math.floor(n));\\n  if (n !== cap) {\\n    cap = n;\\n    buf = [];\\n    head = 0;\\n    count = 0;\\n  }\\n}\\n\\nfunction msg_int(v) { doStore([v]); }\\nfunction msg_float(v) { doStore([v]); }\\nfunction list() { doStore(Array.from(arguments)); }\\nfunction anything() {\\n  var name = String(this.messagename);\\n  if (name === 'get') { get(arguments.length > 0 ? arguments[0] : 0); return; }\\n  if (name === 'dump') { dump(); return; }\\n  if (name === 'clear') { doClear(); return; }\\n  if (name === 'capacity') { capacity(arguments[0]); return; }\\n  if (name === 'size') { doSize(); return; }\\n  if (name === 'reset') { doReset(); return; }\\n  doStore([name].concat(Array.from(arguments)));\\n}\\n\\nfunction doStore(item) {\\n  buf[head % cap] = item;\\n  head++;\\n  var wasFull = (count === cap);\\n  if (count < cap) count++;\\n  if (count === cap && !wasFull) {\\n    this.outlet(1, 'full');\\n  }\\n}\\n\\nfunction get(idx) {\\n  idx = (idx === undefined) ? 0 : Math.floor(idx);\\n  if (idx < 0 || idx >= count) return;\\n  var pos = ((head - 1 - idx) % cap + cap) % cap;\\n  var item = buf[pos];\\n  if (item.length === 1) {\\n    this.outlet(0, item[0]);\\n  } else {\\n    this.outlet(0, item);\\n  }\\n}\\n\\nfunction dump() {\\n  if (count === 0) return;\\n  var start = (count < cap) ? 0 : head % cap;\\n  for (var i = 0; i < count; i++) {\\n    var pos = (start + i) % cap;\\n    var item = buf[pos];\\n    if (item.length === 1) {\\n      this.outlet(0, item[0]);\\n    } else {\\n      this.outlet(0, item);\\n    }\\n  }\\n}\\n\\nfunction doClear() {\\n  buf = [];\\n  head = 0;\\n  count = 0;\\n  this.outlet(1, 'cleared');\\n}\\n\\nfunction doSize() {\\n  this.outlet(1, ['size', count]);\\n}\\n\\nfunction doReset() {\\n  buf = [];\\n  head = 0;\\n  count = 0;\\n  cap = 16;\\n  this.outlet(1, 'cleared');\\n}\\n\"",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [56.0, 232.0, 480.0, 340.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-1", 0],
					"destination": ["obj-16", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-16", 1],
					"destination": ["obj-17", 0],
					"comment": "get bypass (fires first)"
				}
			},
			{
				"patchline": {
					"source": ["obj-16", 0],
					"destination": ["obj-19", 1],
					"comment": "msg to gate (fires second)"
				}
			},
			{
				"patchline": {
					"source": ["obj-17", 0],
					"destination": ["obj-18", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-18", 0],
					"destination": ["obj-19", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-19", 1],
					"destination": ["obj-3", 0],
					"comment": "bypass passthrough"
				}
			},
			{
				"patchline": {
					"source": ["obj-19", 0],
					"destination": ["obj-21", 0],
					"comment": "store in ring buffer"
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 0],
					"destination": ["obj-3", 0],
					"comment": "retrieved values"
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 1],
					"destination": ["obj-4", 0],
					"comment": "status"
				}
			},
			{
				"patchline": {
					"source": ["obj-2", 0],
					"destination": ["obj-13", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 0],
					"destination": ["obj-14", 0],
					"comment": "bypass value"
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 1],
					"destination": ["obj-21", 0],
					"comment": "all other control msgs to v8"
				}
			},
			{
				"patchline": {
					"source": ["obj-6", 0],
					"destination": ["obj-7", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-7", 0],
					"destination": ["obj-8", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-8", 0],
					"destination": ["obj-9", 0],
					"comment": "prepend capacity"
				}
			},
			{
				"patchline": {
					"source": ["obj-8", 1],
					"destination": ["obj-10", 0],
					"comment": "init bypass=0"
				}
			},
			{
				"patchline": {
					"source": ["obj-9", 0],
					"destination": ["obj-21", 0],
					"comment": "capacity from init"
				}
			},
			{
				"patchline": {
					"source": ["obj-10", 0],
					"destination": ["obj-11", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
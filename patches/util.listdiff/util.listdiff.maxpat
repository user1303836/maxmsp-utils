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
		"description": "Compare incoming list against previous and output added, removed, common items",
		"digest": "List differ with duplicate-aware comparison",
		"tags": "utility list diff compare",
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
					"comment": "list to compare (hot - triggers diff against stored previous)"
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
					"comment": "control: reset, bypass, sorted"
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
					"comment": "added items (in new, not in previous)"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "outlet",
					"index": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [192.0, 616.0, 30.0, 30.0],
					"comment": "removed items (in previous, not in new)"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "outlet",
					"index": 3,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [328.0, 616.0, 30.0, 30.0],
					"comment": "common items (in both lists)"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "outlet",
					"index": 4,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [464.0, 616.0, 30.0, 30.0],
					"comment": "bang when no changes detected"
				}
			},
			{
				"box": {
					"id": "obj-7",
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
					"id": "obj-8",
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
					"id": "obj-9",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 64.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 88.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
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
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "route reset bypass sorted",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": ["", "", "", ""],
					"patching_rect": [400.0, 80.0, 144.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [432.0, 112.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"text": "prepend sorted",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [464.0, 112.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 112.0, 36.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
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
					"id": "obj-17",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [56.0, 80.0, 42.0, 22.0],
					"comment": "R-to-L: get bypass (first), pass list (second)"
				}
			},
			{
				"box": {
					"id": "obj-18",
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
					"id": "obj-19",
					"maxclass": "newobj",
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [56.0, 136.0, 30.0, 22.0],
					"comment": "bypass=0 -> gate 1, bypass=1 -> gate 2"
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "gate 2 1",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [56.0, 168.0, 152.0, 22.0],
					"comment": "1=diff, 2=bypass passthrough"
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"text": "--- DIFF (v8.codebox) ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 208.0, 160.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"text": "v8.codebox @code \"var prev = [];\\nvar doSort = 0;\\n\\nfunction reset() {\\n  prev = [];\\n}\\n\\nfunction sorted(v) {\\n  doSort = v ? 1 : 0;\\n}\\n\\nfunction msg_int(v) {\\n  handleList([v]);\\n}\\n\\nfunction msg_float(v) {\\n  handleList([v]);\\n}\\n\\nfunction list() {\\n  handleList(Array.from(arguments));\\n}\\n\\nfunction anything() {\\n  handleList([this.messagename].concat(Array.from(arguments)));\\n}\\n\\nfunction handleList(newArr) {\\n  var oldArr = prev.slice();\\n  var nw = doSort ? newArr.slice().sort() : newArr.slice();\\n  var ol = doSort ? oldArr.slice().sort() : oldArr.slice();\\n  var oldBag = new Map();\\n  for (var i = 0; i < ol.length; i++) {\\n    var k = String(ol[i]);\\n    oldBag.set(k, (oldBag.get(k) || 0) + 1);\\n  }\\n  var added = [], common = [];\\n  var wb = new Map(oldBag);\\n  for (var j = 0; j < nw.length; j++) {\\n    var k2 = String(nw[j]);\\n    if (wb.has(k2) && wb.get(k2) > 0) {\\n      common.push(nw[j]);\\n      wb.set(k2, wb.get(k2) - 1);\\n    } else {\\n      added.push(nw[j]);\\n    }\\n  }\\n  var newBag = new Map();\\n  for (var m = 0; m < nw.length; m++) {\\n    var nk = String(nw[m]);\\n    newBag.set(nk, (newBag.get(nk) || 0) + 1);\\n  }\\n  var removed = [];\\n  var wb2 = new Map(newBag);\\n  for (var n = 0; n < ol.length; n++) {\\n    var rk = String(ol[n]);\\n    if (wb2.has(rk) && wb2.get(rk) > 0) {\\n      wb2.set(rk, wb2.get(rk) - 1);\\n    } else {\\n      removed.push(ol[n]);\\n    }\\n  }\\n  prev = newArr.slice();\\n  if (added.length === 0 && removed.length === 0) {\\n    this.outlet(3, 'bang');\\n  }\\n  if (common.length > 0) {\\n    this.outlet(2, common.length === 1 ? common[0] : common);\\n  }\\n  if (removed.length > 0) {\\n    this.outlet(1, removed.length === 1 ? removed[0] : removed);\\n  }\\n  if (added.length > 0) {\\n    this.outlet(0, added.length === 1 ? added[0] : added);\\n  }\\n}\\n\"",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": ["", "", "", ""],
					"patching_rect": [56.0, 232.0, 456.0, 340.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-1", 0],
					"destination": ["obj-17", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-17", 1],
					"destination": ["obj-18", 0],
					"comment": "get bypass (fires first)"
				}
			},
			{
				"patchline": {
					"source": ["obj-17", 0],
					"destination": ["obj-20", 1],
					"comment": "list to gate (fires second)"
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
					"source": ["obj-19", 0],
					"destination": ["obj-20", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 1],
					"destination": ["obj-3", 0],
					"comment": "bypass passthrough"
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 0],
					"destination": ["obj-22", 0],
					"comment": "to diff"
				}
			},
			{
				"patchline": {
					"source": ["obj-22", 0],
					"destination": ["obj-3", 0],
					"comment": "added"
				}
			},
			{
				"patchline": {
					"source": ["obj-22", 1],
					"destination": ["obj-4", 0],
					"comment": "removed"
				}
			},
			{
				"patchline": {
					"source": ["obj-22", 2],
					"destination": ["obj-5", 0],
					"comment": "common"
				}
			},
			{
				"patchline": {
					"source": ["obj-22", 3],
					"destination": ["obj-6", 0],
					"comment": "no changes"
				}
			},
			{
				"patchline": {
					"source": ["obj-2", 0],
					"destination": ["obj-12", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-12", 0],
					"destination": ["obj-15", 0],
					"comment": "reset"
				}
			},
			{
				"patchline": {
					"source": ["obj-12", 1],
					"destination": ["obj-13", 0],
					"comment": "bypass"
				}
			},
			{
				"patchline": {
					"source": ["obj-12", 2],
					"destination": ["obj-14", 0],
					"comment": "sorted value to prepend"
				}
			},
			{
				"patchline": {
					"source": ["obj-15", 0],
					"destination": ["obj-22", 0],
					"comment": "reset msg to v8"
				}
			},
			{
				"patchline": {
					"source": ["obj-14", 0],
					"destination": ["obj-22", 0],
					"comment": "sorted msg to v8"
				}
			},
			{
				"patchline": {
					"source": ["obj-8", 0],
					"destination": ["obj-9", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-9", 0],
					"destination": ["obj-10", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
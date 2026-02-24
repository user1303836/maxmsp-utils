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
		"rect": [100.0, 100.0, 880.0, 760.0],
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
		"description": "Debounce any message: delay output until input quiet for N ms",
		"digest": "Message debouncer with leading/trailing edge options",
		"tags": "utility debounce timer delay",
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
					"comment": "message to debounce (any type)"
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
					"comment": "control: time, leading, trailing, flush, cancel, bypass, reset"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "outlet",
					"index": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 712.0, 30.0, 30.0],
					"comment": "debounced output"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "outlet",
					"index": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [648.0, 712.0, 30.0, 30.0],
					"comment": "status (scheduled, flushed, canceled)"
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
					"patching_rect": [640.0, 16.0, 80.0, 20.0]
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
					"patching_rect": [640.0, 40.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"text": "patcherargs 50",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [640.0, 64.0, 88.0, 22.0]
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
					"patching_rect": [640.0, 96.0, 42.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "prepend time",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 128.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "t b b b b",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": ["bang", "bang", "bang", "bang"],
					"patching_rect": [720.0, 96.0, 80.0, 22.0],
					"comment": "init defaults"
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [720.0, 128.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [720.0, 152.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [752.0, 128.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"text": "v #0_leading",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [752.0, 152.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "message",
					"text": "1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [784.0, 128.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"text": "v #0_trailing",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [784.0, 152.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [816.0, 128.0, 25.0, 22.0]
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
					"patching_rect": [816.0, 152.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
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
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "route time leading trailing flush cancel bypass reset",
					"numinlets": 1,
					"numoutlets": 8,
					"outlettype": ["", "", "", "", "", "", "", ""],
					"patching_rect": [400.0, 80.0, 224.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "v #0_time",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 112.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"text": "v #0_leading",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [432.0, 136.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "newobj",
					"text": "v #0_trailing",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [464.0, 160.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "newobj",
					"text": "s #0_flush",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [496.0, 112.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"text": "s #0_cancel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [520.0, 136.0, 68.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [576.0, 144.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-87",
					"maxclass": "newobj",
					"text": "t i i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["int", "int"],
					"patching_rect": [544.0, 112.0, 48.0, 22.0],
					"comment": "set bypass state, then cancel if enabling"
				}
			},
			{
				"box": {
					"id": "obj-88",
					"maxclass": "newobj",
					"text": "sel 1",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", ""],
					"patching_rect": [544.0, 144.0, 36.0, 22.0],
					"comment": "bypass=1 triggers cancel"
				}
			},
			{
				"box": {
					"id": "obj-89",
					"maxclass": "newobj",
					"text": "s #0_cancel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [544.0, 168.0, 68.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "s #0_reset",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [568.0, 136.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
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
					"id": "obj-29",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [56.0, 80.0, 42.0, 22.0],
					"comment": "check bypass, pass msg"
				}
			},
			{
				"box": {
					"id": "obj-30",
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
					"id": "obj-31",
					"maxclass": "newobj",
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [56.0, 136.0, 30.0, 22.0],
					"comment": "bypass=0 -> gate 1 (debounce), bypass=1 -> gate 2 (passthrough)"
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"text": "gate 2 1",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [56.0, 168.0, 152.0, 22.0],
					"comment": "outlet 1=debounce, outlet 2=bypass"
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "comment",
					"text": "--- DEBOUNCE CORE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 208.0, 140.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "newobj",
					"text": "t b l l",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "", ""],
					"patching_rect": [56.0, 232.0, 200.0, 22.0],
					"comment": "on input: R-to-L: 2)store in buffer, 1)check leading, 0)reset timer (last)"
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "newobj",
					"text": "zl reg",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [56.0, 448.0, 45.0, 22.0],
					"comment": "message buffer: store on right inlet, recall on bang"
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "comment",
					"text": "--- LEADING EDGE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [144.0, 264.0, 130.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [144.0, 288.0, 42.0, 22.0],
					"comment": "check pending state, hold msg"
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [144.0, 312.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"text": "sel 0",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", ""],
					"patching_rect": [144.0, 336.0, 36.0, 22.0],
					"comment": "only emit leading if not already pending (first msg in burst)"
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"text": "v #0_leading",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [144.0, 360.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "newobj",
					"text": "gate 1 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [144.0, 392.0, 52.0, 22.0],
					"comment": "leading gate: open only if leading=1"
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "comment",
					"text": "--- TIMER ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [248.0, 264.0, 90.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", "bang"],
					"patching_rect": [248.0, 288.0, 62.0, 22.0],
					"comment": "reset timer: 1) set pending, 2) stop delay, 3) restart delay"
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "message",
					"text": "1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [248.0, 320.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [248.0, 344.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "message",
					"text": "stop",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [280.0, 320.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"text": "delay 50",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [320.0, 384.0, 52.0, 22.0],
					"comment": "debounce timer"
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "newobj",
					"text": "v #0_time",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [352.0, 320.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "newobj",
					"text": "t b f",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", "float"],
					"patching_rect": [352.0, 352.0, 42.0, 22.0],
					"comment": "set delay time then start"
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "comment",
					"text": "--- TIMER EXPIRED ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 432.0, 140.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", "bang"],
					"patching_rect": [56.0, 480.0, 300.0, 22.0],
					"comment": "timer expired: 1) recall msg, 2) get trailing flag, 3) clear pending"
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "newobj",
					"text": "v #0_trailing",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [200.0, 512.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "newobj",
					"text": "gate 1 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [56.0, 544.0, 152.0, 22.0],
					"comment": "trailing gate: open only if trailing=1"
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [344.0, 512.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [344.0, 544.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "comment",
					"text": "--- FLUSH / CANCEL (via send/receive) ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [448.0, 400.0, 240.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-57",
					"maxclass": "newobj",
					"text": "r #0_flush",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [448.0, 424.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-58",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", "bang"],
					"patching_rect": [448.0, 448.0, 62.0, 22.0],
					"comment": "flush: 1) check pending, 2) stop timer, 3) clear pending"
				}
			},
			{
				"box": {
					"id": "obj-59",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [448.0, 480.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "newobj",
					"text": "sel 1",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", ""],
					"patching_rect": [448.0, 512.0, 36.0, 22.0],
					"comment": "only flush if pending"
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", "bang"],
					"patching_rect": [448.0, 544.0, 62.0, 22.0],
					"comment": "do flush: 1) emit buffered, 2) clear pending, 3) status"
				}
			},
			{
				"box": {
					"id": "obj-62",
					"maxclass": "newobj",
					"text": "zl reg",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [448.0, 576.0, 45.0, 22.0],
					"comment": "recall buffered msg for flush"
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [480.0, 576.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-64",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [480.0, 608.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "message",
					"text": "flushed",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [512.0, 576.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-66",
					"maxclass": "message",
					"text": "stop",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [480.0, 480.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-67",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [504.0, 480.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-68",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [504.0, 512.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-69",
					"maxclass": "newobj",
					"text": "r #0_cancel",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 424.0, 68.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-70",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", "bang"],
					"patching_rect": [600.0, 448.0, 62.0, 22.0],
					"comment": "cancel: 1) status, 2) stop timer, 3) clear pending"
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "message",
					"text": "canceled",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 480.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-72",
					"maxclass": "message",
					"text": "stop",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [632.0, 480.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-73",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [656.0, 480.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-74",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [656.0, 512.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "newobj",
					"text": "r #0_reset",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [744.0, 424.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-76",
					"maxclass": "newobj",
					"text": "t b b b b",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": ["bang", "bang", "bang", "bang"],
					"patching_rect": [744.0, 448.0, 80.0, 22.0],
					"comment": "reset: stop timer, pending=0, leading=0, trailing=1"
				}
			},
			{
				"box": {
					"id": "obj-77",
					"maxclass": "message",
					"text": "stop",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [744.0, 480.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-78",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [776.0, 480.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-79",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [776.0, 512.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-80",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [808.0, 480.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-81",
					"maxclass": "newobj",
					"text": "v #0_leading",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [808.0, 512.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-82",
					"maxclass": "message",
					"text": "1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [840.0, 480.0, 25.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-83",
					"maxclass": "newobj",
					"text": "v #0_trailing",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [840.0, 512.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-84",
					"maxclass": "comment",
					"text": "--- STATUS OUT ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [648.0, 616.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-85",
					"maxclass": "message",
					"text": "scheduled",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [248.0, 376.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-86",
					"maxclass": "message",
					"text": "flushed",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [56.0, 600.0, 48.0, 22.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-1", 0],
					"destination": ["obj-29", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-29", 1],
					"destination": ["obj-30", 0],
					"comment": "bang: get bypass state (fires first)"
				}
			},
			{
				"patchline": {
					"source": ["obj-29", 0],
					"destination": ["obj-32", 1],
					"comment": "list: msg to bypass gate (fires second)"
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-31", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-31", 0],
					"destination": ["obj-32", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-32", 1],
					"destination": ["obj-3", 0],
					"comment": "bypass passthrough"
				}
			},
			{
				"patchline": {
					"source": ["obj-32", 0],
					"destination": ["obj-34", 0],
					"comment": "to debounce core"
				}
			},
			{
				"patchline": {
					"source": ["obj-34", 2],
					"destination": ["obj-35", 1],
					"order": 1,
					"comment": "store msg in zl reg (fires first)"
				}
			},
			{
				"patchline": {
					"source": ["obj-34", 2],
					"destination": ["obj-62", 1],
					"order": 0,
					"comment": "also store in flush zl reg (fires first)"
				}
			},
			{
				"patchline": {
					"source": ["obj-34", 1],
					"destination": ["obj-37", 0],
					"comment": "list: check leading edge (fires second)"
				}
			},
			{
				"patchline": {
					"source": ["obj-34", 0],
					"destination": ["obj-43", 0],
					"comment": "bang: reset timer and set pending=1 (fires last)"
				}
			},
			{
				"patchline": {
					"source": ["obj-37", 1],
					"destination": ["obj-38", 0],
					"comment": "bang: get pending state (fires first)"
				}
			},
			{
				"patchline": {
					"source": ["obj-37", 0],
					"destination": ["obj-41", 1],
					"comment": "list: msg to leading gate (fires second)"
				}
			},
			{
				"patchline": {
					"source": ["obj-38", 0],
					"destination": ["obj-39", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-39", 0],
					"destination": ["obj-40", 0],
					"comment": "not pending: get leading flag"
				}
			},
			{
				"patchline": {
					"source": ["obj-40", 0],
					"destination": ["obj-41", 0],
					"comment": "set leading gate"
				}
			},
			{
				"patchline": {
					"source": ["obj-41", 0],
					"destination": ["obj-3", 0],
					"comment": "leading output"
				}
			},
			{
				"patchline": {
					"source": ["obj-43", 0],
					"destination": ["obj-44", 0],
					"order": 1,
					"comment": "set pending=1"
				}
			},
			{
				"patchline": {
					"source": ["obj-43", 0],
					"destination": ["obj-85", 0],
					"order": 0,
					"comment": "status: scheduled"
				}
			},
			{
				"patchline": {
					"source": ["obj-43", 1],
					"destination": ["obj-48", 0],
					"comment": "get delay time and restart"
				}
			},
			{
				"patchline": {
					"source": ["obj-43", 2],
					"destination": ["obj-46", 0],
					"comment": "stop old timer first"
				}
			},
			{
				"patchline": {
					"source": ["obj-44", 0],
					"destination": ["obj-45", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-46", 0],
					"destination": ["obj-47", 0],
					"comment": "stop delay"
				}
			},
			{
				"patchline": {
					"source": ["obj-48", 0],
					"destination": ["obj-49", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-49", 0],
					"destination": ["obj-47", 0],
					"comment": "start delay"
				}
			},
			{
				"patchline": {
					"source": ["obj-49", 1],
					"destination": ["obj-47", 1],
					"comment": "set delay time"
				}
			},
			{
				"patchline": {
					"source": ["obj-47", 0],
					"destination": ["obj-51", 0],
					"comment": "timer expired"
				}
			},
			{
				"patchline": {
					"source": ["obj-51", 0],
					"destination": ["obj-35", 0],
					"comment": "recall buffered msg"
				}
			},
			{
				"patchline": {
					"source": ["obj-51", 1],
					"destination": ["obj-52", 0],
					"comment": "get trailing flag"
				}
			},
			{
				"patchline": {
					"source": ["obj-51", 2],
					"destination": ["obj-54", 0],
					"comment": "clear pending"
				}
			},
			{
				"patchline": {
					"source": ["obj-52", 0],
					"destination": ["obj-53", 0],
					"comment": "set trailing gate"
				}
			},
			{
				"patchline": {
					"source": ["obj-35", 0],
					"destination": ["obj-53", 1],
					"comment": "msg to trailing gate"
				}
			},
			{
				"patchline": {
					"source": ["obj-53", 0],
					"destination": ["obj-86", 0],
					"order": 0,
					"comment": "status: flushed"
				}
			},
			{
				"patchline": {
					"source": ["obj-53", 0],
					"destination": ["obj-3", 0],
					"order": 1,
					"comment": "trailing output"
				}
			},
			{
				"patchline": {
					"source": ["obj-54", 0],
					"destination": ["obj-55", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-85", 0],
					"destination": ["obj-4", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-86", 0],
					"destination": ["obj-4", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-2", 0],
					"destination": ["obj-20", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 0],
					"destination": ["obj-21", 0],
					"comment": "time"
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 1],
					"destination": ["obj-22", 0],
					"comment": "leading"
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 2],
					"destination": ["obj-23", 0],
					"comment": "trailing"
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 3],
					"destination": ["obj-24", 0],
					"comment": "flush"
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 4],
					"destination": ["obj-25", 0],
					"comment": "cancel"
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 5],
					"destination": ["obj-87", 0],
					"comment": "bypass value to trigger"
				}
			},
			{
				"patchline": {
					"source": ["obj-87", 1],
					"destination": ["obj-26", 0],
					"comment": "set bypass state (fires first)"
				}
			},
			{
				"patchline": {
					"source": ["obj-87", 0],
					"destination": ["obj-88", 0],
					"comment": "check if bypass=1 (fires second)"
				}
			},
			{
				"patchline": {
					"source": ["obj-88", 0],
					"destination": ["obj-89", 0],
					"comment": "bypass=1: cancel pending timer"
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 6],
					"destination": ["obj-27", 0],
					"comment": "reset"
				}
			},
			{
				"patchline": {
					"source": ["obj-57", 0],
					"destination": ["obj-58", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-58", 0],
					"destination": ["obj-67", 0],
					"comment": "clear pending (fires last)"
				}
			},
			{
				"patchline": {
					"source": ["obj-58", 1],
					"destination": ["obj-66", 0],
					"comment": "stop timer"
				}
			},
			{
				"patchline": {
					"source": ["obj-58", 2],
					"destination": ["obj-59", 0],
					"comment": "check pending (fires first)"
				}
			},
			{
				"patchline": {
					"source": ["obj-59", 0],
					"destination": ["obj-60", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-60", 0],
					"destination": ["obj-61", 0],
					"comment": "pending=1, proceed with flush"
				}
			},
			{
				"patchline": {
					"source": ["obj-61", 0],
					"destination": ["obj-65", 0],
					"comment": "status: flushed (fires last)"
				}
			},
			{
				"patchline": {
					"source": ["obj-61", 1],
					"destination": ["obj-63", 0],
					"comment": "clear pending (fires middle)"
				}
			},
			{
				"patchline": {
					"source": ["obj-61", 2],
					"destination": ["obj-62", 0],
					"comment": "bang to recall msg (fires first)"
				}
			},
			{
				"patchline": {
					"source": ["obj-62", 0],
					"destination": ["obj-3", 0],
					"comment": "flush output"
				}
			},
			{
				"patchline": {
					"source": ["obj-63", 0],
					"destination": ["obj-64", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-65", 0],
					"destination": ["obj-4", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-66", 0],
					"destination": ["obj-47", 0],
					"comment": "stop delay on flush"
				}
			},
			{
				"patchline": {
					"source": ["obj-67", 0],
					"destination": ["obj-68", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-69", 0],
					"destination": ["obj-70", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-70", 0],
					"destination": ["obj-71", 0],
					"comment": "status: canceled"
				}
			},
			{
				"patchline": {
					"source": ["obj-70", 1],
					"destination": ["obj-72", 0],
					"comment": "stop timer"
				}
			},
			{
				"patchline": {
					"source": ["obj-70", 2],
					"destination": ["obj-73", 0],
					"comment": "clear pending"
				}
			},
			{
				"patchline": {
					"source": ["obj-71", 0],
					"destination": ["obj-4", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-72", 0],
					"destination": ["obj-47", 0],
					"comment": "stop delay on cancel"
				}
			},
			{
				"patchline": {
					"source": ["obj-73", 0],
					"destination": ["obj-74", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-75", 0],
					"destination": ["obj-76", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-76", 0],
					"destination": ["obj-77", 0],
					"comment": "stop timer"
				}
			},
			{
				"patchline": {
					"source": ["obj-76", 1],
					"destination": ["obj-78", 0],
					"comment": "pending=0"
				}
			},
			{
				"patchline": {
					"source": ["obj-76", 2],
					"destination": ["obj-80", 0],
					"comment": "leading=0"
				}
			},
			{
				"patchline": {
					"source": ["obj-76", 3],
					"destination": ["obj-82", 0],
					"comment": "trailing=1"
				}
			},
			{
				"patchline": {
					"source": ["obj-77", 0],
					"destination": ["obj-47", 0],
					"comment": "stop delay on reset"
				}
			},
			{
				"patchline": {
					"source": ["obj-78", 0],
					"destination": ["obj-79", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-80", 0],
					"destination": ["obj-81", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-82", 0],
					"destination": ["obj-83", 0]
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
					"comment": "prepend time to patcherargs"
				}
			},
			{
				"patchline": {
					"source": ["obj-8", 1],
					"destination": ["obj-10", 0],
					"comment": "init defaults"
				}
			},
			{
				"patchline": {
					"source": ["obj-9", 0],
					"destination": ["obj-20", 0],
					"comment": "send time from init"
				}
			},
			{
				"patchline": {
					"source": ["obj-10", 0],
					"destination": ["obj-11", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-10", 1],
					"destination": ["obj-13", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-10", 2],
					"destination": ["obj-15", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-10", 3],
					"destination": ["obj-17", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-11", 0],
					"destination": ["obj-12", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 0],
					"destination": ["obj-14", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-15", 0],
					"destination": ["obj-16", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-17", 0],
					"destination": ["obj-18", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

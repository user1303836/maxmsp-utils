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
		"rect": [100.0, 100.0, 760.0, 680.0],
		"bglocked": 0,
		"openinpresentation": 0,
		"default_fontsize": 12.0,
		"default_fontface": 0,
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
		"description": "Help patch for util.debounce",
		"digest": "Demonstrates debounce abstraction usage",
		"tags": "help utility debounce",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "util.debounce",
					"fontface": 1,
					"fontsize": 16.0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 16.0, 160.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"text": "Delay output until input has been quiet for N ms. Supports leading and trailing edge modes.",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 42.0, 480.0, 34.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"text": "--- BASIC TRAILING (DEFAULT) ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 88.0, 220.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "comment",
					"text": "Click rapidly. Only the last value is output after 200ms of quiet.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 108.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [16.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"text": "util.debounce 200",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 168.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [16.0, 200.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"text": "print status-trailing",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [104.0, 200.0, 120.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "comment",
					"text": "--- LEADING EDGE ONLY ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 240.0, 180.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "comment",
					"text": "First message passes immediately, then silent for 300ms.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 260.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [16.0, 288.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "util.debounce 300",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 344.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [16.0, 376.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "message",
					"text": "leading 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [80.0, 288.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "message",
					"text": "trailing 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [144.0, 288.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [80.0, 224.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "newobj",
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", "bang"],
					"patching_rect": [80.0, 248.0, 280.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", "bang"],
					"patching_rect": [80.0, 312.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "comment",
					"text": "--- BOTH EDGES ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 88.0, 130.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "comment",
					"text": "First and last messages pass through.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 108.0, 300.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [280.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "util.debounce 150",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [280.0, 192.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [280.0, 224.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "message",
					"text": "leading 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [344.0, 136.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "comment",
					"text": "--- FLUSH / CANCEL ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 268.0, 160.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "comment",
					"text": "Send messages, then flush or cancel before timeout.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 288.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [280.0, 312.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "newobj",
					"text": "util.debounce 2000",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [280.0, 376.0, 112.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [280.0, 408.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "message",
					"text": "flush",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [344.0, 312.0, 36.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "message",
					"text": "cancel",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [384.0, 312.0, 42.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"text": "print status-flushcancel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [376.0, 408.0, 136.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "comment",
					"text": "--- BYPASS ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 424.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "comment",
					"text": "Toggle bypass for immediate passthrough.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 444.0, 300.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [16.0, 472.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "newobj",
					"text": "util.debounce 500",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 536.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [16.0, 568.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [80.0, 472.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"text": "prepend bypass",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [80.0, 504.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "comment",
					"text": "--- LIST / SYMBOL INPUT ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 448.0, 180.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "comment",
					"text": "Any message type is preserved through debounce.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 468.0, 350.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "message",
					"text": "hello world",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [280.0, 496.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "message",
					"text": "1 2 3",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [356.0, 496.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "newobj",
					"text": "util.debounce 100",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [280.0, 536.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"text": "print debounced-msg",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 568.0, 116.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "comment",
					"text": "--- CONTROL MESSAGES (right inlet) ---\n\ntime <ms>       - set debounce delay\nleading <0|1>   - emit on leading edge\ntrailing <0|1>  - emit on trailing edge\nflush           - emit pending immediately\ncancel          - drop pending message\nbypass <0|1>    - passthrough mode\nreset           - clear state, restore defaults",
					"linecount": 9,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [480.0, 424.0, 250.0, 140.0]
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "comment",
					"text": "Argument sets default debounce time in ms (default 50).",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 608.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "comment",
					"text": "--- DYNAMIC TIME ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [520.0, 88.0, 140.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "comment",
					"text": "Change time on the fly.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [520.0, 108.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [520.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "newobj",
					"text": "util.debounce",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [520.0, 200.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [520.0, 232.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [608.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "newobj",
					"text": "prepend time",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [608.0, 168.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [680.0, 168.0, 40.0, 22.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-5", 0],
					"destination": ["obj-6", 0]
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
					"source": ["obj-6", 1],
					"destination": ["obj-8", 0]
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
					"source": ["obj-12", 0],
					"destination": ["obj-13", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-16", 0],
					"destination": ["obj-56", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-56", 0],
					"destination": ["obj-17", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-56", 1],
					"destination": ["obj-23", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-17", 0],
					"destination": ["obj-14", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-17", 1],
					"destination": ["obj-15", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-14", 0],
					"destination": ["obj-12", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-15", 0],
					"destination": ["obj-12", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 0],
					"destination": ["obj-21", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 0],
					"destination": ["obj-22", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-23", 0],
					"destination": ["obj-21", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 0],
					"destination": ["obj-28", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-28", 0],
					"destination": ["obj-29", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-28", 1],
					"destination": ["obj-32", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-28", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-31", 0],
					"destination": ["obj-28", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-35", 0],
					"destination": ["obj-36", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-36", 0],
					"destination": ["obj-37", 0]
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
					"destination": ["obj-36", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-42", 0],
					"destination": ["obj-44", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-43", 0],
					"destination": ["obj-44", 0]
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
					"source": ["obj-50", 0],
					"destination": ["obj-51", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-51", 0],
					"destination": ["obj-52", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-53", 0],
					"destination": ["obj-54", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-54", 0],
					"destination": ["obj-51", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-55", 0],
					"destination": ["obj-51", 1]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

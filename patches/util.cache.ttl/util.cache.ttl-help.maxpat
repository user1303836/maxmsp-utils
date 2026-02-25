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
		"rect": [100.0, 100.0, 900.0, 700.0],
		"bglocked": 0,
		"openinpresentation": 0,
		"default_fontsize": 12.0,
		"default_fontface": 0,
		"default_fontname": "Arial",
		"gridonopen": 1,
		"gridsize": [15.0, 15.0],
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
		"description": "",
		"digest": "",
		"tags": "",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "util.cache.ttl",
					"fontsize": 18.0,
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 15.0, 200.0, 27.0]
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"text": "Key-value cache with time-to-live expiration. Stores values and automatically expires them after a configurable TTL.",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 45.0, 450.0, 33.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"text": "--- Basic set/get ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 90.0, 150.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "message",
					"text": "set foo 42",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [15.0, 120.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "message",
					"text": "set bar hello",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [90.0, 120.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "message",
					"text": "get foo",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [180.0, 120.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "message",
					"text": "get bar",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [240.0, 120.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "message",
					"text": "get nonexistent",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [300.0, 120.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "util.cache.ttl 2000",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["", "", ""],
					"patching_rect": [15.0, 165.0, 112.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "print hits",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 210.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "print status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [90.0, 210.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "print diag",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [180.0, 210.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "comment",
					"text": "--- TTL expiry ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 255.0, 150.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "comment",
					"text": "Set a value with 500ms TTL, then try to get it after the TTL expires.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 275.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "message",
					"text": "set temp 99",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [15.0, 300.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "message",
					"text": "get temp",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [180.0, 300.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "message",
					"text": "ttl 500",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [90.0, 300.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"text": "util.cache.ttl 500",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["", "", ""],
					"patching_rect": [15.0, 345.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"text": "print ttl-hits",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 390.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "print ttl-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [90.0, 390.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"text": "1) Click 'set temp 99' to store. 2) Immediately click 'get temp' -> hit. 3) Wait >500ms, click 'get temp' again -> miss (expired).",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [250.0, 300.0, 400.0, 33.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "comment",
					"text": "--- has / invalidate / clear ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 435.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "message",
					"text": "set key1 aaa",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [15.0, 465.0, 76.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "message",
					"text": "has key1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [105.0, 465.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "message",
					"text": "invalidate key1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [170.0, 465.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "message",
					"text": "clear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [270.0, 465.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "util.cache.ttl 5000",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["", "", ""],
					"patching_rect": [15.0, 510.0, 112.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "newobj",
					"text": "print cmd-hits",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 555.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"text": "print cmd-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [105.0, 555.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "comment",
					"text": "--- sweep + diagnostics ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [500.0, 90.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "message",
					"text": "set a 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [500.0, 120.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "message",
					"text": "set b 2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [560.0, 120.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "message",
					"text": "set c 3",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [620.0, 120.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "message",
					"text": "sweep",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [700.0, 120.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "newobj",
					"text": "util.cache.ttl 1000",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["", "", ""],
					"patching_rect": [500.0, 165.0, 112.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "newobj",
					"text": "print sweep-hits",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [500.0, 210.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"text": "print sweep-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [600.0, 210.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "newobj",
					"text": "print sweep-diag",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [715.0, 210.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "comment",
					"text": "1) Set a, b, c. 2) Click sweep immediately -> size 3. 3) Wait >1s, sweep again -> size 0 (all expired).",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [500.0, 240.0, 380.0, 33.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "comment",
					"text": "--- dynamic TTL ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [500.0, 290.0, 150.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "message",
					"text": "set x 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [500.0, 320.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "message",
					"text": "get x",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [570.0, 320.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "message",
					"text": "ttl 200",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [700.0, 320.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "message",
					"text": "ttl 10000",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [760.0, 320.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"text": "util.cache.ttl 3000",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["", "", ""],
					"patching_rect": [500.0, 365.0, 112.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "newobj",
					"text": "print dyn-hits",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [500.0, 410.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"text": "print dyn-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [600.0, 410.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "comment",
					"text": "Change TTL on the fly via right inlet.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [630.0, 320.0, 220.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "comment",
					"text": "--- reset ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [500.0, 460.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "message",
					"text": "set y 200",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [500.0, 490.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [700.0, 490.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "message",
					"text": "get y",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [570.0, 490.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "newobj",
					"text": "util.cache.ttl 5000",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["", "", ""],
					"patching_rect": [500.0, 535.0, 112.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "newobj",
					"text": "print reset-hits",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [500.0, 580.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "newobj",
					"text": "print reset-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [600.0, 580.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "comment",
					"text": "1) Set y. 2) Reset clears cache and restores default TTL. 3) Get y -> miss.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [500.0, 610.0, 380.0, 20.0]
				}
			}
		],
		"lines": [
			{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-9", 0] } },
			{ "patchline": { "source": ["obj-5", 0], "destination": ["obj-9", 0] } },
			{ "patchline": { "source": ["obj-6", 0], "destination": ["obj-9", 0] } },
			{ "patchline": { "source": ["obj-7", 0], "destination": ["obj-9", 0] } },
			{ "patchline": { "source": ["obj-8", 0], "destination": ["obj-9", 0] } },
			{ "patchline": { "source": ["obj-9", 0], "destination": ["obj-10", 0] } },
			{ "patchline": { "source": ["obj-9", 1], "destination": ["obj-11", 0] } },
			{ "patchline": { "source": ["obj-9", 2], "destination": ["obj-12", 0] } },
			{ "patchline": { "source": ["obj-15", 0], "destination": ["obj-18", 0] } },
			{ "patchline": { "source": ["obj-16", 0], "destination": ["obj-18", 0] } },
			{ "patchline": { "source": ["obj-17", 0], "destination": ["obj-18", 1] } },
			{ "patchline": { "source": ["obj-18", 0], "destination": ["obj-19", 0] } },
			{ "patchline": { "source": ["obj-18", 1], "destination": ["obj-20", 0] } },
			{ "patchline": { "source": ["obj-23", 0], "destination": ["obj-27", 0] } },
			{ "patchline": { "source": ["obj-24", 0], "destination": ["obj-27", 0] } },
			{ "patchline": { "source": ["obj-25", 0], "destination": ["obj-27", 0] } },
			{ "patchline": { "source": ["obj-26", 0], "destination": ["obj-27", 0] } },
			{ "patchline": { "source": ["obj-27", 0], "destination": ["obj-28", 0] } },
			{ "patchline": { "source": ["obj-27", 1], "destination": ["obj-29", 0] } },
			{ "patchline": { "source": ["obj-31", 0], "destination": ["obj-35", 0] } },
			{ "patchline": { "source": ["obj-32", 0], "destination": ["obj-35", 0] } },
			{ "patchline": { "source": ["obj-33", 0], "destination": ["obj-35", 0] } },
			{ "patchline": { "source": ["obj-34", 0], "destination": ["obj-35", 1] } },
			{ "patchline": { "source": ["obj-35", 0], "destination": ["obj-36", 0] } },
			{ "patchline": { "source": ["obj-35", 1], "destination": ["obj-37", 0] } },
			{ "patchline": { "source": ["obj-35", 2], "destination": ["obj-38", 0] } },
			{ "patchline": { "source": ["obj-41", 0], "destination": ["obj-45", 0] } },
			{ "patchline": { "source": ["obj-42", 0], "destination": ["obj-45", 0] } },
			{ "patchline": { "source": ["obj-43", 0], "destination": ["obj-45", 1] } },
			{ "patchline": { "source": ["obj-44", 0], "destination": ["obj-45", 1] } },
			{ "patchline": { "source": ["obj-45", 0], "destination": ["obj-46", 0] } },
			{ "patchline": { "source": ["obj-45", 1], "destination": ["obj-47", 0] } },
			{ "patchline": { "source": ["obj-50", 0], "destination": ["obj-53", 0] } },
			{ "patchline": { "source": ["obj-51", 0], "destination": ["obj-53", 1] } },
			{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-53", 0] } },
			{ "patchline": { "source": ["obj-53", 0], "destination": ["obj-54", 0] } },
			{ "patchline": { "source": ["obj-53", 1], "destination": ["obj-55", 0] } }
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
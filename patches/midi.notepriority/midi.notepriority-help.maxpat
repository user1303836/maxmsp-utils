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
		"rect": [100.0, 100.0, 760.0, 640.0],
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
		"description": "Help patch for midi.notepriority",
		"digest": "Demonstrates monophonic note-priority abstraction",
		"tags": "help midi note priority",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "midi.notepriority",
					"fontface": 1,
					"fontsize": 16.0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 16.0, 200.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"text": "Monophonic note-priority filter. Choose which held note sounds based on low, high, or last priority. Outputs filtered note pairs (pitch velocity).",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 42.0, 520.0, 34.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"text": "--- LAST MODE (DEFAULT) ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 88.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "comment",
					"text": "Most recently pressed note always wins. Try overlapping notes.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 108.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "message",
					"text": "60 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [16.0, 136.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "message",
					"text": "64 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [72.0, 136.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "message",
					"text": "67 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [128.0, 136.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "message",
					"text": "60 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [184.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "message",
					"text": "64 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [232.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "message",
					"text": "67 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [280.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "midi.notepriority",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 168.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "print last-notes",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 200.0, 92.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "print last-state",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [104.0, 200.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "comment",
					"text": "--- LOW MODE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 240.0, 140.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "comment",
					"text": "Lowest held note always wins.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 260.0, 300.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "message",
					"text": "60 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [16.0, 288.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "message",
					"text": "48 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [72.0, 288.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "message",
					"text": "48 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [128.0, 288.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "message",
					"text": "60 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [176.0, 288.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "midi.notepriority low",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 320.0, 120.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "print low-notes",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 352.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"text": "print low-state",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [120.0, 352.0, 84.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"text": "--- HIGH MODE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 88.0, 140.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "comment",
					"text": "Highest held note always wins.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 108.0, 300.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "message",
					"text": "60 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 136.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "message",
					"text": "72 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [456.0, 136.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "message",
					"text": "72 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [512.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "message",
					"text": "60 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [560.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"text": "midi.notepriority high",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [400.0, 168.0, 128.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"text": "print high-notes",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 200.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "newobj",
					"text": "print high-state",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [512.0, 200.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "comment",
					"text": "--- PANIC / RESET ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 240.0, 160.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "comment",
					"text": "Panic: note-off active note, clear held state.\nReset: same as panic.",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 260.0, 350.0, 34.0]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "message",
					"text": "60 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 304.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "message",
					"text": "panic",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [456.0, 304.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [504.0, 304.0, 36.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"text": "midi.notepriority",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [400.0, 336.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "newobj",
					"text": "print panic-notes",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 368.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"text": "print panic-state",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [488.0, 368.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "comment",
					"text": "--- MODE CHANGE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 400.0, 140.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "comment",
					"text": "Change mode on the fly via right inlet.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 420.0, 300.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "message",
					"text": "60 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [16.0, 448.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "message",
					"text": "mode low",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [128.0, 448.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "message",
					"text": "mode high",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [192.0, 448.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "message",
					"text": "mode last",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [260.0, 448.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "newobj",
					"text": "midi.notepriority",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 480.0, 264.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"text": "print mode-notes",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 512.0, 100.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "newobj",
					"text": "print mode-state",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [264.0, 512.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "comment",
					"text": "--- CONTROL MESSAGES (right inlet) ---\n\nmode <low|high|last> - set priority mode\npanic                - note-off active, clear state\nreset                - same as panic\nbypass <0|1>         - passthrough mode",
					"linecount": 6,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 420.0, 280.0, 100.0]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "comment",
					"text": "Argument sets initial mode (default: last).",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 560.0, 350.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "comment",
					"text": "--- BYPASS ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 536.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "message",
					"text": "60 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 560.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "message",
					"text": "bypass 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [504.0, 560.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "message",
					"text": "bypass 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [564.0, 560.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "newobj",
					"text": "midi.notepriority",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [400.0, 592.0, 176.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "newobj",
					"text": "print bypass-notes",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 616.0, 108.0, 22.0]
				}
			}
		],
		"lines": [
			{ "patchline": { "source": ["obj-5", 0], "destination": ["obj-11", 0] } },
			{ "patchline": { "source": ["obj-6", 0], "destination": ["obj-11", 0] } },
			{ "patchline": { "source": ["obj-7", 0], "destination": ["obj-11", 0] } },
			{ "patchline": { "source": ["obj-8", 0], "destination": ["obj-11", 0] } },
			{ "patchline": { "source": ["obj-9", 0], "destination": ["obj-11", 0] } },
			{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-11", 0] } },
			{ "patchline": { "source": ["obj-11", 0], "destination": ["obj-12", 0] } },
			{ "patchline": { "source": ["obj-11", 1], "destination": ["obj-13", 0] } },
			{ "patchline": { "source": ["obj-16", 0], "destination": ["obj-20", 0] } },
			{ "patchline": { "source": ["obj-17", 0], "destination": ["obj-20", 0] } },
			{ "patchline": { "source": ["obj-18", 0], "destination": ["obj-20", 0] } },
			{ "patchline": { "source": ["obj-19", 0], "destination": ["obj-20", 0] } },
			{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-21", 0] } },
			{ "patchline": { "source": ["obj-20", 1], "destination": ["obj-22", 0] } },
			{ "patchline": { "source": ["obj-25", 0], "destination": ["obj-29", 0] } },
			{ "patchline": { "source": ["obj-26", 0], "destination": ["obj-29", 0] } },
			{ "patchline": { "source": ["obj-27", 0], "destination": ["obj-29", 0] } },
			{ "patchline": { "source": ["obj-28", 0], "destination": ["obj-29", 0] } },
			{ "patchline": { "source": ["obj-29", 0], "destination": ["obj-30", 0] } },
			{ "patchline": { "source": ["obj-29", 1], "destination": ["obj-31", 0] } },
			{ "patchline": { "source": ["obj-34", 0], "destination": ["obj-37", 0] } },
			{ "patchline": { "source": ["obj-35", 0], "destination": ["obj-37", 1] } },
			{ "patchline": { "source": ["obj-36", 0], "destination": ["obj-37", 1] } },
			{ "patchline": { "source": ["obj-37", 0], "destination": ["obj-38", 0] } },
			{ "patchline": { "source": ["obj-37", 1], "destination": ["obj-39", 0] } },
			{ "patchline": { "source": ["obj-42", 0], "destination": ["obj-46", 0] } },
			{ "patchline": { "source": ["obj-43", 0], "destination": ["obj-46", 1] } },
			{ "patchline": { "source": ["obj-44", 0], "destination": ["obj-46", 1] } },
			{ "patchline": { "source": ["obj-45", 0], "destination": ["obj-46", 1] } },
			{ "patchline": { "source": ["obj-46", 0], "destination": ["obj-47", 0] } },
			{ "patchline": { "source": ["obj-46", 1], "destination": ["obj-48", 0] } },
			{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-55", 0] } },
			{ "patchline": { "source": ["obj-53", 0], "destination": ["obj-55", 1] } },
			{ "patchline": { "source": ["obj-54", 0], "destination": ["obj-55", 1] } },
			{ "patchline": { "source": ["obj-55", 0], "destination": ["obj-56", 0] } }
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
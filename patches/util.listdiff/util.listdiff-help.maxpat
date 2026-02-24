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
		"description": "Help patch for util.listdiff",
		"digest": "Demonstrates list diff abstraction usage",
		"tags": "help utility list diff",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "util.listdiff",
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
					"text": "Compare incoming list against previous list. Outputs added, removed, and common items. Duplicate-aware: each occurrence is tracked independently.",
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
					"text": "--- BASIC DIFF ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 88.0, 130.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "comment",
					"text": "Send different lists. First list: all items are 'added'. Subsequent lists show changes.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 108.0, 520.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "message",
					"text": "1 2 3",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [16.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "message",
					"text": "2 3 4",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [64.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "message",
					"text": "2 3 4",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [112.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "message",
					"text": "5 6",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [160.0, 136.0, 32.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "util.listdiff",
					"numinlets": 2,
					"numoutlets": 4,
					"outlettype": ["", "", "", ""],
					"patching_rect": [16.0, 168.0, 280.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "print added",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 200.0, 68.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "print removed",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [104.0, 200.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "print common",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [200.0, 200.0, 76.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "print no-change",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [288.0, 200.0, 92.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "comment",
					"text": "--- DUPLICATE-AWARE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 240.0, 160.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "comment",
					"text": "Duplicates tracked independently: [1 1 2] vs [1 2 2] -> added: 2, removed: 1",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 260.0, 500.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "message",
					"text": "1 1 2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [16.0, 288.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "message",
					"text": "1 2 2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [64.0, 288.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"text": "util.listdiff",
					"numinlets": 2,
					"numoutlets": 4,
					"outlettype": ["", "", "", ""],
					"patching_rect": [16.0, 320.0, 280.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"text": "print dup-added",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 352.0, 92.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "print dup-removed",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [120.0, 352.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"text": "--- SYMBOL SUPPORT ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 88.0, 150.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "comment",
					"text": "Works with symbols too.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 108.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "message",
					"text": "foo bar baz",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 136.0, 68.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "message",
					"text": "bar baz qux",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [472.0, 136.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"text": "util.listdiff",
					"numinlets": 2,
					"numoutlets": 4,
					"outlettype": ["", "", "", ""],
					"patching_rect": [400.0, 168.0, 280.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "newobj",
					"text": "print sym-added",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 200.0, 92.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "print sym-removed",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [504.0, 200.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "comment",
					"text": "--- RESET ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 240.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "comment",
					"text": "Reset clears stored previous list.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 260.0, 300.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "message",
					"text": "1 2 3",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 288.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [456.0, 288.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"text": "util.listdiff",
					"numinlets": 2,
					"numoutlets": 4,
					"outlettype": ["", "", "", ""],
					"patching_rect": [400.0, 320.0, 280.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "newobj",
					"text": "print reset-added",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 352.0, 100.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "comment",
					"text": "--- SORTED MODE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 400.0, 130.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "comment",
					"text": "Sort both lists before comparison (order-independent diff).",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 420.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "message",
					"text": "3 1 2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [16.0, 448.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "message",
					"text": "1 2 3",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [64.0, 448.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "message",
					"text": "sorted 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [120.0, 448.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [120.0, 424.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"text": "util.listdiff",
					"numinlets": 2,
					"numoutlets": 4,
					"outlettype": ["", "", "", ""],
					"patching_rect": [16.0, 504.0, 280.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "newobj",
					"text": "print sorted-added",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 536.0, 108.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "newobj",
					"text": "print sorted-nochange",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [288.0, 536.0, 124.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "comment",
					"text": "--- OUTLETS ---\n\nOutlet 1: added items\nOutlet 2: removed items\nOutlet 3: common items\nOutlet 4: bang if no changes\n\n--- CONTROL MESSAGES (right inlet) ---\n\nreset           - clear stored previous list\nbypass <0|1>    - pass list to outlet 1 unchanged\nsorted <0|1>    - sort before comparing",
					"linecount": 12,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [440.0, 400.0, 260.0, 180.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-5", 0],
					"destination": ["obj-9", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-6", 0],
					"destination": ["obj-9", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-7", 0],
					"destination": ["obj-9", 0]
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
			},
			{
				"patchline": {
					"source": ["obj-9", 1],
					"destination": ["obj-11", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-9", 2],
					"destination": ["obj-12", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-9", 3],
					"destination": ["obj-13", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-16", 0],
					"destination": ["obj-18", 0]
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
					"source": ["obj-18", 1],
					"destination": ["obj-20", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-23", 0],
					"destination": ["obj-25", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-24", 0],
					"destination": ["obj-25", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-25", 0],
					"destination": ["obj-26", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-25", 1],
					"destination": ["obj-27", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-32", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-31", 0],
					"destination": ["obj-32", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-32", 0],
					"destination": ["obj-33", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-36", 0],
					"destination": ["obj-40", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-37", 0],
					"destination": ["obj-40", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-39", 0],
					"destination": ["obj-38", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-38", 0],
					"destination": ["obj-40", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-40", 0],
					"destination": ["obj-41", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-40", 3],
					"destination": ["obj-42", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
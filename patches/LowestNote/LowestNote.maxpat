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
		"rect": [100.0, 100.0, 640.0, 480.0],
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
		"description": "Passes only the lowest note from simultaneously played chords",
		"digest": "Lowest note MIDI filter",
		"tags": "MIDI filter lowest note chord",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "Lowest Note Filter",
					"fontface": 1,
					"fontsize": 14.0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [24.0, 16.0, 200.0, 23.0]
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"text": "Only the lowest note from simultaneous note-ons passes through. All other MIDI (CC, bend, etc.) is passed through unchanged.",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [24.0, 40.0, 400.0, 34.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "newobj",
					"text": "midiin",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [160.0, 88.0, 44.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "newobj",
					"text": "midiparse",
					"numinlets": 1,
					"numoutlets": 7,
					"outlettype": ["", "", "", "", "", "", ""],
					"patching_rect": [160.0, 128.0, 136.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "newobj",
					"text": "v8 lowest_note_filter.js",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [160.0, 232.0, 144.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"text": "delay 5",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [344.0, 200.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"text": "midiformat",
					"numinlets": 7,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [160.0, 304.0, 136.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"text": "midiout",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [160.0, 344.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "comment",
					"text": "5ms chord detection window",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 200.0, 168.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "comment",
					"text": "Non-note MIDI passes through unchanged",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [320.0, 264.0, 240.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "live.thisdevice",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "int"],
					"patching_rect": [24.0, 128.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [24.0, 200.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "sel 0",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", ""],
					"patching_rect": [72.0, 168.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "comment",
					"text": "Init on load + reset on bypass/deactivation",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [24.0, 104.0, 260.0, 20.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-3", 0],
					"destination": ["obj-4", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 0],
					"destination": ["obj-5", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 1],
					"destination": ["obj-7", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 2],
					"destination": ["obj-7", 2]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 3],
					"destination": ["obj-7", 3]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 4],
					"destination": ["obj-7", 4]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 5],
					"destination": ["obj-7", 5]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 6],
					"destination": ["obj-7", 6]
				}
			},
			{
				"patchline": {
					"source": ["obj-5", 0],
					"destination": ["obj-7", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-5", 1],
					"destination": ["obj-6", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-6", 0],
					"destination": ["obj-5", 1]
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
					"source": ["obj-11", 0],
					"destination": ["obj-12", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-11", 1],
					"destination": ["obj-13", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 0],
					"destination": ["obj-12", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-12", 0],
					"destination": ["obj-5", 0]
				}
			}
		],
		"dependency_cache": [
			{
				"name": "lowest_note_filter.js",
				"bootpath": "code",
				"type": "TEXT",
				"implicit": 1
			}
		],
		"autosave": 0
	}
}

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
					"text": "p LowestNoteLogic",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [160.0, 232.0, 112.0, 22.0],
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
						"rect": [100.0, 100.0, 870.0, 780.0],
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
									"maxclass": "inlet",
									"index": 1,
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [300.0, 15.0, 30.0, 30.0],
									"comment": "notes (pitch vel) or reset"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [300.0, 720.0, 30.0, 30.0],
									"comment": "filtered notes (pitch vel)"
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "route reset",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": ["", ""],
									"patching_rect": [300.0, 60.0, 72.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "comment",
									"text": "--- RESET ---",
									"fontface": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [15.0, 90.0, 100.0, 20.0]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "t b b b",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": ["bang", "bang", "bang"],
									"patching_rect": [45.0, 120.0, 62.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "message",
									"text": "stop",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [45.0, 165.0, 34.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "message",
									"text": "dump",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [75.0, 165.0, 38.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "newobj",
									"text": "coll sentNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [75.0, 195.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "newobj",
									"text": "pack 0 0",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [75.0, 255.0, 56.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "message",
									"text": "clear",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [90.0, 300.0, 38.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-11",
									"maxclass": "newobj",
									"text": "coll sentNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [90.0, 345.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-12",
									"maxclass": "newobj",
									"text": "coll tempNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [90.0, 375.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "comment",
									"text": "--- NOTE ROUTING ---",
									"fontface": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [300.0, 90.0, 145.0, 20.0]
								}
							},
							{
								"box": {
									"id": "obj-14",
									"maxclass": "newobj",
									"text": "unpack 0 0",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": ["int", "int"],
									"patching_rect": [360.0, 120.0, 72.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-15",
									"maxclass": "newobj",
									"text": "t i i",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": ["int", "int"],
									"patching_rect": [417.0, 150.0, 42.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-16",
									"maxclass": "newobj",
									"text": "> 0",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": ["int"],
									"patching_rect": [417.0, 180.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-17",
									"maxclass": "newobj",
									"text": "+ 1",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": ["int"],
									"patching_rect": [417.0, 210.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-18",
									"maxclass": "newobj",
									"text": "gate 2",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": ["", ""],
									"patching_rect": [360.0, 255.0, 72.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-19",
									"maxclass": "comment",
									"text": "--- NOTE-OFF ---",
									"fontface": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [255.0, 300.0, 110.0, 20.0]
								}
							},
							{
								"box": {
									"id": "obj-20",
									"maxclass": "newobj",
									"text": "t i i i",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": ["int", "int", "int"],
									"patching_rect": [300.0, 330.0, 62.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-21",
									"maxclass": "message",
									"text": "remove $1",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [347.0, 360.0, 64.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-22",
									"maxclass": "newobj",
									"text": "coll tempNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [347.0, 390.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-23",
									"maxclass": "newobj",
									"text": "i",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": ["int"],
									"patching_rect": [315.0, 390.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-24",
									"maxclass": "newobj",
									"text": "coll sentNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [300.0, 420.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-25",
									"maxclass": "newobj",
									"text": "sel 1",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": ["bang", ""],
									"patching_rect": [300.0, 450.0, 36.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-26",
									"maxclass": "newobj",
									"text": "pack 0 0",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [300.0, 540.0, 56.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-27",
									"maxclass": "message",
									"text": "remove $1",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [345.0, 510.0, 64.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-28",
									"maxclass": "newobj",
									"text": "coll sentNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [345.0, 540.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-29",
									"maxclass": "comment",
									"text": "--- NOTE-ON ---",
									"fontface": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [525.0, 300.0, 110.0, 20.0]
								}
							},
							{
								"box": {
									"id": "obj-30",
									"maxclass": "newobj",
									"text": "pack 0 0",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [525.0, 330.0, 56.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-31",
									"maxclass": "newobj",
									"text": "t l b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": ["", "bang"],
									"patching_rect": [525.0, 360.0, 42.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-32",
									"maxclass": "message",
									"text": "store $1 $2",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [525.0, 390.0, 72.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-33",
									"maxclass": "newobj",
									"text": "coll tempNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [525.0, 420.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-34",
									"maxclass": "newobj",
									"text": "t b b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": ["bang", "bang"],
									"patching_rect": [600.0, 360.0, 42.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-35",
									"maxclass": "message",
									"text": "stop",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [627.0, 390.0, 34.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-36",
									"maxclass": "newobj",
									"text": "delay 5",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": ["bang"],
									"patching_rect": [600.0, 420.0, 52.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-37",
									"maxclass": "comment",
									"text": "--- CHORD WINDOW FIRES ---",
									"fontface": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [525.0, 465.0, 175.0, 20.0]
								}
							},
							{
								"box": {
									"id": "obj-38",
									"maxclass": "newobj",
									"text": "t b b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": ["bang", "bang"],
									"patching_rect": [600.0, 495.0, 42.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-39",
									"maxclass": "message",
									"text": "sort",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [627.0, 525.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-40",
									"maxclass": "message",
									"text": "nth 1",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [600.0, 525.0, 38.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-41",
									"maxclass": "newobj",
									"text": "coll tempNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [600.0, 555.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-42",
									"maxclass": "newobj",
									"text": "t i i",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": ["int", "int"],
									"patching_rect": [675.0, 585.0, 42.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-43",
									"maxclass": "message",
									"text": "store $1 1",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [702.0, 615.0, 64.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-44",
									"maxclass": "newobj",
									"text": "coll sentNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [702.0, 645.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-45",
									"maxclass": "newobj",
									"text": "i",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": ["int"],
									"patching_rect": [675.0, 645.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-46",
									"maxclass": "newobj",
									"text": "t b i b",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": ["bang", "int", "bang"],
									"patching_rect": [600.0, 585.0, 62.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-47",
									"maxclass": "message",
									"text": "clear",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [647.0, 615.0, 38.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-48",
									"maxclass": "newobj",
									"text": "coll tempNotes",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": ["", "", "", ""],
									"patching_rect": [647.0, 645.0, 90.0, 22.0],
									"saved_object_attributes": {
										"embed": 0
									}
								}
							},
							{
								"box": {
									"id": "obj-49",
									"maxclass": "newobj",
									"text": "pack 0 0",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [600.0, 675.0, 56.0, 22.0]
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"source": ["obj-1", 0],
									"destination": ["obj-3", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-3", 0],
									"destination": ["obj-5", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-3", 1],
									"destination": ["obj-14", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-5", 2],
									"destination": ["obj-6", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-5", 1],
									"destination": ["obj-7", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-5", 0],
									"destination": ["obj-10", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-6", 0],
									"destination": ["obj-36", 0]
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
									"source": ["obj-8", 1],
									"destination": ["obj-9", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-9", 0],
									"destination": ["obj-2", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-10", 0],
									"destination": ["obj-11", 0],
									"order": 1
								}
							},
							{
								"patchline": {
									"source": ["obj-10", 0],
									"destination": ["obj-12", 0],
									"order": 0
								}
							},
							{
								"patchline": {
									"source": ["obj-14", 0],
									"destination": ["obj-18", 1]
								}
							},
							{
								"patchline": {
									"source": ["obj-14", 1],
									"destination": ["obj-15", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-15", 1],
									"destination": ["obj-30", 1]
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
									"source": ["obj-16", 0],
									"destination": ["obj-17", 0]
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
									"destination": ["obj-20", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-18", 1],
									"destination": ["obj-30", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-20", 2],
									"destination": ["obj-21", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-20", 1],
									"destination": ["obj-23", 1]
								}
							},
							{
								"patchline": {
									"source": ["obj-20", 0],
									"destination": ["obj-24", 0]
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
									"source": ["obj-24", 0],
									"destination": ["obj-25", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-25", 0],
									"destination": ["obj-23", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-23", 0],
									"destination": ["obj-26", 0],
									"order": 1
								}
							},
							{
								"patchline": {
									"source": ["obj-23", 0],
									"destination": ["obj-27", 0],
									"order": 0
								}
							},
							{
								"patchline": {
									"source": ["obj-26", 0],
									"destination": ["obj-2", 0]
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
									"source": ["obj-31", 1],
									"destination": ["obj-34", 0]
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
									"source": ["obj-34", 1],
									"destination": ["obj-35", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-34", 0],
									"destination": ["obj-36", 0]
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
									"destination": ["obj-38", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-38", 1],
									"destination": ["obj-39", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-38", 0],
									"destination": ["obj-40", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-39", 0],
									"destination": ["obj-41", 0]
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
									"source": ["obj-41", 1],
									"destination": ["obj-42", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-41", 0],
									"destination": ["obj-46", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-42", 1],
									"destination": ["obj-43", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-42", 0],
									"destination": ["obj-45", 1]
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
									"source": ["obj-46", 2],
									"destination": ["obj-47", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-46", 1],
									"destination": ["obj-49", 1]
								}
							},
							{
								"patchline": {
									"source": ["obj-46", 0],
									"destination": ["obj-45", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-47", 0],
									"destination": ["obj-48", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-45", 0],
									"destination": ["obj-49", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-49", 0],
									"destination": ["obj-2", 0]
								}
							}
						]
					},
					"saved_object_attributes": {
						"globalpatchername": ""
					}
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
		"dependency_cache": [],
		"autosave": 0
	}
}

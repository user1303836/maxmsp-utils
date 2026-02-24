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
		"rect": [
			100.0,
			100.0,
			800.0,
			700.0
		],
		"bglocked": 0,
		"openinpresentation": 0,
		"default_fontsize": 10.0,
		"default_fontface": 1,
		"default_fontname": "Arial",
		"gridonopen": 1,
		"gridsize": [
			8.0,
			8.0
		],
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
		"description": "Help patch for util.dict.defaults",
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
					"text": "util.dict.defaults",
					"fontsize": 18.0,
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						16.0,
						16.0,
						224.0,
						28.0
					]
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"text": "Merge defaults into dictionaries and validate required keys",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						16.0,
						48.0,
						400.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"text": "--- Basic Usage: Fill missing keys from defaults ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						16.0,
						80.0,
						360.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "comment",
					"text": "1. Set up a defaults dictionary",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						16.0,
						104.0,
						240.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "message",
					"text": "clear, set color blue, set size 10, set shape circle",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						16.0,
						128.0,
						320.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"text": "dict my_defaults",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						16.0,
						152.0,
						104.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "message",
					"text": "defaults my_defaults",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						16.0,
						184.0,
						128.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "comment",
					"text": "2. Create an input dict with some keys",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400.0,
						104.0,
						280.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "message",
					"text": "clear, set color red, set name test",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						400.0,
						128.0,
						224.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "dict my_input",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						400.0,
						152.0,
						88.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "comment",
					"text": "3. Send input dict to be processed",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400.0,
						184.0,
						240.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "message",
					"text": "dictionary my_input",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						400.0,
						208.0,
						120.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "util.dict.defaults",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						400.0,
						264.0,
						272.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"text": "print merged",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400.0,
						336.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"text": "print status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						528.0,
						336.0,
						72.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"text": "print diagnostics",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						656.0,
						336.0,
						104.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"text": "route dictionary",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						400.0,
						296.0,
						104.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"text": "dict.print",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400.0,
						368.0,
						64.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "comment",
					"text": "--- Required Key Validation ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						16.0,
						416.0,
						240.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "message",
					"text": "required color size name",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						16.0,
						440.0,
						152.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"text": "<-- set required keys, then re-send input dict",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						176.0,
						440.0,
						304.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "message",
					"text": "addrequired weight",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						16.0,
						464.0,
						120.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"text": "<-- add more required keys",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						144.0,
						464.0,
						200.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "message",
					"text": "clearrequired",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						16.0,
						488.0,
						88.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "comment",
					"text": "<-- clear required keys (all pass)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						112.0,
						488.0,
						240.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "comment",
					"text": "--- Force Mode ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						16.0,
						528.0,
						160.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "message",
					"text": "force 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						16.0,
						552.0,
						56.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "comment",
					"text": "<-- defaults overwrite input keys",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						80.0,
						552.0,
						240.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "message",
					"text": "force 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						16.0,
						576.0,
						56.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "comment",
					"text": "<-- input wins, defaults fill gaps (default)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						80.0,
						576.0,
						304.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						16.0,
						616.0,
						40.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "comment",
					"text": "<-- clear all state (defaults + required + force flag)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						64.0,
						616.0,
						360.0,
						20.0
					]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-5",
						0
					],
					"destination": [
						"obj-6",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-7",
						0
					],
					"destination": [
						"obj-13",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-9",
						0
					],
					"destination": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-12",
						0
					],
					"destination": [
						"obj-13",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-13",
						0
					],
					"destination": [
						"obj-17",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-13",
						1
					],
					"destination": [
						"obj-15",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-13",
						2
					],
					"destination": [
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-17",
						0
					],
					"destination": [
						"obj-14",
						0
					],
					"order": 1
				}
			},
			{
				"patchline": {
					"source": [
						"obj-17",
						0
					],
					"destination": [
						"obj-18",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						0
					],
					"destination": [
						"obj-13",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						0
					],
					"destination": [
						"obj-13",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-24",
						0
					],
					"destination": [
						"obj-13",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-27",
						0
					],
					"destination": [
						"obj-13",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-29",
						0
					],
					"destination": [
						"obj-13",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-31",
						0
					],
					"destination": [
						"obj-13",
						1
					]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

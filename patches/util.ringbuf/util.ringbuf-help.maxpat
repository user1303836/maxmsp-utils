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
		"rect": [100.0, 100.0, 760.0, 800.0],
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
		"description": "Help patch for util.ringbuf",
		"digest": "Demonstrates ring buffer abstraction usage",
		"tags": "help utility buffer ring",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "util.ringbuf",
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
					"text": "Bounded ring buffer for messages with random access and dump. Stores up to N items in a circular history.",
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
					"text": "--- STORE AND GET ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 88.0, 180.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "comment",
					"text": "Send values in the left inlet to store. Use 'get N' to retrieve the Nth most recent (0 = newest).",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 108.0, 500.0, 20.0]
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
					"maxclass": "message",
					"text": "get 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [136.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "message",
					"text": "get 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [184.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "message",
					"text": "get 2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [232.0, 136.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "util.ringbuf 4",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 168.0, 256.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "print retrieved",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 200.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "print status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [200.0, 200.0, 68.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "comment",
					"text": "--- DUMP ALL ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 240.0, 140.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "comment",
					"text": "Store several values, then send 'dump' to output all from oldest to newest.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 260.0, 460.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "message",
					"text": "10",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [16.0, 288.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "message",
					"text": "20",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [56.0, 288.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "message",
					"text": "30",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [96.0, 288.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "message",
					"text": "dump",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [184.0, 288.0, 38.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "message",
					"text": "clear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [232.0, 288.0, 38.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"text": "util.ringbuf 8",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 320.0, 256.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "print dump-out",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 352.0, 84.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "print dump-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [200.0, 352.0, 100.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "comment",
					"text": "--- LIST AND SYMBOL INPUT ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 392.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"text": "Store lists and symbols. They are preserved through the buffer.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 412.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "message",
					"text": "1 2 3",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [16.0, 440.0, 42.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "message",
					"text": "hello world",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [68.0, 440.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "message",
					"text": "get 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [200.0, 440.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "message",
					"text": "dump",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [248.0, 440.0, 38.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "newobj",
					"text": "util.ringbuf 4",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 472.0, 272.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"text": "print list-out",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 504.0, 76.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"text": "print list-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [216.0, 504.0, 92.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "comment",
					"text": "--- CAPACITY AND SIZE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 544.0, 180.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "comment",
					"text": "Change capacity dynamically. 'size' reports current fill count. 'full' status when buffer is full.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 564.0, 560.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [16.0, 592.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "message",
					"text": "capacity 3",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [136.0, 592.0, 64.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "message",
					"text": "size",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [208.0, 592.0, 32.0, 22.0]
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
					"patching_rect": [248.0, 592.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"text": "util.ringbuf 4",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 624.0, 272.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "newobj",
					"text": "print cap-out",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 656.0, 80.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"text": "print cap-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [216.0, 656.0, 92.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "comment",
					"text": "--- BYPASS ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 88.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "comment",
					"text": "When bypassed, input passes directly to outlet 1 without being stored.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 108.0, 340.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [400.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "message",
					"text": "bypass 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [520.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "message",
					"text": "bypass 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [584.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"text": "util.ringbuf 4",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [400.0, 168.0, 240.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "newobj",
					"text": "print bypass-out",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 200.0, 92.0, 22.0]
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
					"destination": ["obj-9", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-7", 0],
					"destination": ["obj-9", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-8", 0],
					"destination": ["obj-9", 1]
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
					"source": ["obj-14", 0],
					"destination": ["obj-19", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-15", 0],
					"destination": ["obj-19", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-16", 0],
					"destination": ["obj-19", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-17", 0],
					"destination": ["obj-19", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-18", 0],
					"destination": ["obj-19", 1]
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
					"source": ["obj-19", 1],
					"destination": ["obj-21", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-24", 0],
					"destination": ["obj-28", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-25", 0],
					"destination": ["obj-28", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-26", 0],
					"destination": ["obj-28", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 0],
					"destination": ["obj-28", 1]
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
					"destination": ["obj-30", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-33", 0],
					"destination": ["obj-37", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-34", 0],
					"destination": ["obj-37", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-35", 0],
					"destination": ["obj-37", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-36", 0],
					"destination": ["obj-37", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-37", 0],
					"destination": ["obj-38", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-37", 1],
					"destination": ["obj-39", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-42", 0],
					"destination": ["obj-45", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-43", 0],
					"destination": ["obj-45", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-44", 0],
					"destination": ["obj-45", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-45", 0],
					"destination": ["obj-46", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
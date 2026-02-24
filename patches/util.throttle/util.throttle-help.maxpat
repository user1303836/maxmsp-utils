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
		"rect": [100.0, 100.0, 760.0, 720.0],
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
		"description": "Help patch for util.throttle",
		"digest": "Demonstrates throttle abstraction usage",
		"tags": "help utility throttle",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "util.throttle",
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
					"text": "Rate-limit messages: pass at most one per interval. Three policies control what happens during cooldown: drop, latest, queue.",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 42.0, 500.0, 34.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"text": "--- DROP POLICY (DEFAULT) ---",
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
					"text": "First message passes, rest dropped during 200ms cooldown.",
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
					"text": "util.throttle 200",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 168.0, 96.0, 22.0]
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
					"text": "print status-drop",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [96.0, 200.0, 100.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "comment",
					"text": "--- LATEST POLICY ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 240.0, 150.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "comment",
					"text": "Most recent message during cooldown is emitted when interval expires.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 260.0, 450.0, 20.0]
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
					"text": "util.throttle 200",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 344.0, 96.0, 22.0]
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
					"text": "policy latest",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [80.0, 288.0, 76.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [80.0, 264.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "comment",
					"text": "--- QUEUE POLICY ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 88.0, 140.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "comment",
					"text": "Messages queued during cooldown, emitted one per interval.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 108.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [280.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"text": "util.throttle 300",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [280.0, 200.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [280.0, 232.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "message",
					"text": "policy queue",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [344.0, 136.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [344.0, 112.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "newobj",
					"text": "print status-queue",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [360.0, 232.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "comment",
					"text": "--- FLUSH ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 280.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "comment",
					"text": "Immediately emit all pending messages.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 300.0, 300.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [280.0, 328.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "util.throttle 2000",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [280.0, 392.0, 104.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [280.0, 424.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "message",
					"text": "flush",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [344.0, 328.0, 36.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "message",
					"text": "policy latest",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [384.0, 328.0, 76.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [384.0, 304.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-32",
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
					"id": "obj-33",
					"maxclass": "comment",
					"text": "Toggle bypass for immediate passthrough.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 444.0, 300.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [16.0, 472.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "newobj",
					"text": "util.throttle 500",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [16.0, 536.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [16.0, 568.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [80.0, 472.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-38",
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
					"id": "obj-39",
					"maxclass": "comment",
					"text": "--- LIST / SYMBOL INPUT ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 464.0, 180.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "comment",
					"text": "Any message type is preserved through throttle.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 484.0, 350.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "message",
					"text": "hello world",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [280.0, 512.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "message",
					"text": "1 2 3",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [356.0, 512.0, 40.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"text": "util.throttle 150",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [280.0, 552.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "newobj",
					"text": "print throttled-msg",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [280.0, 584.0, 108.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "comment",
					"text": "--- CONTROL MESSAGES (right inlet) ---\n\ninterval <ms>     - set minimum time between outputs\npolicy drop       - silently drop during cooldown (default)\npolicy latest     - keep newest, emit when interval expires\npolicy queue      - enqueue, emit one per interval\ncapacity <N>      - max queue size (default 8)\nflush             - emit all pending immediately\nreset             - clear state, restore defaults\nbypass <0|1>      - passthrough mode",
					"linecount": 10,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [480.0, 424.0, 260.0, 152.0]
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "comment",
					"text": "Argument sets default interval in ms (default 100).",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 624.0, 400.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "comment",
					"text": "--- DYNAMIC INTERVAL ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [520.0, 88.0, 160.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "comment",
					"text": "Change interval on the fly.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [520.0, 108.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [520.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "newobj",
					"text": "util.throttle",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [520.0, 200.0, 72.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [520.0, 232.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [608.0, 136.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "newobj",
					"text": "prepend interval",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [608.0, 168.0, 88.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [704.0, 168.0, 40.0, 22.0]
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
					"source": ["obj-15", 0],
					"destination": ["obj-14", 0]
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
					"source": ["obj-19", 1],
					"destination": ["obj-23", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-22", 0],
					"destination": ["obj-21", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 0],
					"destination": ["obj-19", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-26", 0],
					"destination": ["obj-27", 0]
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
					"source": ["obj-29", 0],
					"destination": ["obj-27", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-31", 0],
					"destination": ["obj-30", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-27", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-34", 0],
					"destination": ["obj-35", 0]
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
					"source": ["obj-37", 0],
					"destination": ["obj-38", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-38", 0],
					"destination": ["obj-35", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-41", 0],
					"destination": ["obj-43", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-42", 0],
					"destination": ["obj-43", 0]
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
					"source": ["obj-49", 0],
					"destination": ["obj-50", 0]
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
					"source": ["obj-52", 0],
					"destination": ["obj-53", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-53", 0],
					"destination": ["obj-50", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-54", 0],
					"destination": ["obj-50", 1]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
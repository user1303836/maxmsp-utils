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
			1300.0,
			760.0
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
		"description": "Rate-limit messages with selectable policy (drop, latest, queue)",
		"digest": "Message throttle with drop, latest, and queue policies",
		"tags": "utility throttle rate-limit speedlim",
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
					"outlettype": [
						""
					],
					"patching_rect": [
						56.0,
						16.0,
						30.0,
						30.0
					],
					"comment": "message to throttle (any type)"
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "inlet",
					"index": 2,
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						400.0,
						16.0,
						30.0,
						30.0
					],
					"comment": "control: interval, policy, capacity, flush, reset, bypass"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "outlet",
					"index": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						712.0,
						30.0,
						30.0
					],
					"comment": "throttled output"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "outlet",
					"index": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						648.0,
						712.0,
						30.0,
						30.0
					],
					"comment": "status (passed, dropped, queued, flushed)"
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
					"patching_rect": [
						752.0,
						16.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						752.0,
						40.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"text": "patcherargs 100",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						752.0,
						64.0,
						88.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						752.0,
						96.0,
						42.0,
						22.0
					],
					"comment": "send args then init defaults"
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "prepend interval",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						752.0,
						128.0,
						88.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "t b b b b b",
					"numinlets": 1,
					"numoutlets": 5,
					"outlettype": [
						"bang",
						"bang",
						"bang",
						"bang",
						"bang"
					],
					"patching_rect": [
						832.0,
						96.0,
						120.0,
						22.0
					],
					"comment": "init defaults R-to-L: bypass=0, cap=8, policy=0, cd=0, qidx=0"
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						832.0,
						128.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "v #0_qidx",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						832.0,
						152.0,
						56.0,
						22.0
					],
					"comment": "queue write index"
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						864.0,
						128.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"text": "v #0_cd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						864.0,
						152.0,
						48.0,
						22.0
					],
					"comment": "cooldown state: 0=ready, 1=in cooldown"
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						896.0,
						128.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"text": "v #0_policy",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						896.0,
						152.0,
						64.0,
						22.0
					],
					"comment": "0=drop, 1=latest, 2=queue"
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "message",
					"text": "8",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						928.0,
						128.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"text": "v #0_cap",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						928.0,
						152.0,
						52.0,
						22.0
					],
					"comment": "queue capacity"
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						960.0,
						128.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						960.0,
						152.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"text": "--- CONTROL ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400.0,
						56.0,
						100.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"text": "route interval policy capacity flush reset bypass",
					"numinlets": 1,
					"numoutlets": 7,
					"outlettype": [
						"",
						"",
						"",
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						400.0,
						80.0,
						280.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "newobj",
					"text": "v #0_interval",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						400.0,
						112.0,
						72.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "newobj",
					"text": "route drop latest queue",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						448.0,
						112.0,
						128.0,
						22.0
					],
					"comment": "convert policy name to number"
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						448.0,
						136.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "message",
					"text": "1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						480.0,
						136.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "message",
					"text": "2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						512.0,
						136.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "newobj",
					"text": "v #0_policy",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						448.0,
						168.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"text": "v #0_cap",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						544.0,
						112.0,
						52.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"text": "s #0_flush",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						592.0,
						112.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "newobj",
					"text": "s #0_reset",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						624.0,
						136.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"text": "t i i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"patching_rect": [
						648.0,
						112.0,
						48.0,
						22.0
					],
					"comment": "R-to-L: set bypass (first), then check cancel (second)"
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						680.0,
						144.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "newobj",
					"text": "sel 1",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						648.0,
						144.0,
						36.0,
						22.0
					],
					"comment": "bypass=1 triggers cancel"
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "newobj",
					"text": "s #0_cancel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						648.0,
						168.0,
						68.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "comment",
					"text": "--- BYPASS ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						56.0,
						100.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						56.0,
						80.0,
						42.0,
						22.0
					],
					"comment": "R-to-L: get bypass (first), pass msg (second)"
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						56.0,
						112.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						56.0,
						136.0,
						30.0,
						22.0
					],
					"comment": "bypass=0 -> gate 1, bypass=1 -> gate 2"
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"text": "gate 2 1",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						56.0,
						168.0,
						152.0,
						22.0
					],
					"comment": "outlet 1=throttle, outlet 2=bypass"
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "comment",
					"text": "--- THROTTLE CORE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						208.0,
						140.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						56.0,
						232.0,
						200.0,
						22.0
					],
					"comment": "R-to-L: get cd (first), pass msg (second)"
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"text": "v #0_cd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						240.0,
						256.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "newobj",
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						240.0,
						280.0,
						30.0,
						22.0
					],
					"comment": "cd=0 -> gate 1, cd=1 -> gate 2"
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"text": "gate 2 1",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						56.0,
						312.0,
						272.0,
						22.0
					],
					"comment": "outlet 1=pass, outlet 2=in cooldown"
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "comment",
					"text": "--- READY: pass + start cooldown ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						344.0,
						220.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"text": "t l b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"bang",
						"bang"
					],
					"patching_rect": [
						56.0,
						368.0,
						200.0,
						22.0
					],
					"comment": "R-to-L: set cd=1 (first), start timer (second), output (last)"
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "message",
					"text": "1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						240.0,
						392.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "newobj",
					"text": "v #0_cd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						240.0,
						416.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "newobj",
					"text": "s #0_starttimer",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						152.0,
						392.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "message",
					"text": "passed",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						56.0,
						416.0,
						42.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "comment",
					"text": "--- TIMER ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						752.0,
						192.0,
						90.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "newobj",
					"text": "r #0_starttimer",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						752.0,
						216.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "newobj",
					"text": "v #0_interval",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						752.0,
						240.0,
						72.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "newobj",
					"text": "t b f",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"float"
					],
					"patching_rect": [
						752.0,
						264.0,
						42.0,
						22.0
					],
					"comment": "R-to-L: set time (first), start (second)"
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "newobj",
					"text": "delay 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						752.0,
						296.0,
						56.0,
						22.0
					],
					"comment": "cooldown timer"
				}
			},
			{
				"box": {
					"id": "obj-57",
					"maxclass": "newobj",
					"text": "s #0_expired",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						752.0,
						320.0,
						68.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-58",
					"maxclass": "comment",
					"text": "--- COOLDOWN: route by policy ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						312.0,
						344.0,
						200.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-59",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						312.0,
						368.0,
						200.0,
						22.0
					],
					"comment": "R-to-L: get policy (first), pass msg (second)"
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "newobj",
					"text": "v #0_policy",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						496.0,
						392.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "newobj",
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						496.0,
						416.0,
						30.0,
						22.0
					],
					"comment": "0->gate 1 (drop), 1->gate 2 (latest), 2->gate 3 (queue)"
				}
			},
			{
				"box": {
					"id": "obj-62",
					"maxclass": "newobj",
					"text": "gate 3 1",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						312.0,
						448.0,
						300.0,
						22.0
					],
					"comment": "1=drop, 2=latest, 3=queue"
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "comment",
					"text": "--- DROP ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						312.0,
						480.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-64",
					"maxclass": "message",
					"text": "dropped",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						312.0,
						504.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "comment",
					"text": "--- LATEST ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						456.0,
						480.0,
						90.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-66",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						456.0,
						504.0,
						80.0,
						22.0
					],
					"comment": "R-to-L: set flag (first), store msg (second)"
				}
			},
			{
				"box": {
					"id": "obj-67",
					"maxclass": "newobj",
					"text": "zl reg",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						456.0,
						536.0,
						45.0,
						22.0
					],
					"comment": "latest message buffer"
				}
			},
			{
				"box": {
					"id": "obj-68",
					"maxclass": "message",
					"text": "1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						520.0,
						504.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-69",
					"maxclass": "newobj",
					"text": "v #0_has_latest",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						520.0,
						536.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-70",
					"maxclass": "message",
					"text": "queued",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						456.0,
						568.0,
						42.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "comment",
					"text": "--- QUEUE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						600.0,
						480.0,
						88.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-72",
					"maxclass": "newobj",
					"text": "t b l b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"",
						"bang"
					],
					"patching_rect": [
						600.0,
						584.0,
						160.0,
						22.0
					],
					"comment": "R-to-L: get cap (first), get qidx (second), store (last)"
				}
			},
			{
				"box": {
					"id": "obj-73",
					"maxclass": "newobj",
					"text": "v #0_qidx",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						696.0,
						616.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-74",
					"maxclass": "newobj",
					"text": "v #0_cap",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						744.0,
						616.0,
						52.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "newobj",
					"text": "t i i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"patching_rect": [
						696.0,
						640.0,
						48.0,
						22.0
					],
					"comment": "R-to-L: inc+clamp (first), use as store key (second)"
				}
			},
			{
				"box": {
					"id": "obj-76",
					"maxclass": "newobj",
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						728.0,
						664.0,
						30.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-77",
					"maxclass": "newobj",
					"text": "minimum",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"patching_rect": [
						728.0,
						688.0,
						52.0,
						22.0
					],
					"comment": "clamp to capacity"
				}
			},
			{
				"box": {
					"id": "obj-78",
					"maxclass": "newobj",
					"text": "v #0_qidx",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						728.0,
						712.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-79",
					"maxclass": "newobj",
					"text": "pack i l",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						600.0,
						664.0,
						104.0,
						22.0
					],
					"comment": "qidx key + msg value"
				}
			},
			{
				"box": {
					"id": "obj-80",
					"maxclass": "newobj",
					"text": "prepend store",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						600.0,
						688.0,
						76.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-81",
					"maxclass": "newobj",
					"text": "coll #0_q",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						600.0,
						712.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-82",
					"maxclass": "message",
					"text": "queued",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						600.0,
						744.0,
						42.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-83",
					"maxclass": "comment",
					"text": "--- TIMER EXPIRED ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						456.0,
						140.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-84",
					"maxclass": "newobj",
					"text": "r #0_expired",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						56.0,
						480.0,
						68.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-85",
					"maxclass": "newobj",
					"text": "v #0_policy",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						56.0,
						504.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-86",
					"maxclass": "newobj",
					"text": "route 0 1 2",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						56.0,
						528.0,
						200.0,
						22.0
					],
					"comment": "0=drop, 1=latest, 2=queue"
				}
			},
			{
				"box": {
					"id": "obj-87",
					"maxclass": "comment",
					"text": "drop: just clear cd",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						552.0,
						110.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-88",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						56.0,
						568.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-89",
					"maxclass": "newobj",
					"text": "v #0_cd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						56.0,
						592.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-90",
					"maxclass": "comment",
					"text": "latest: emit buffered or clear cd",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						120.0,
						552.0,
						180.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-91",
					"maxclass": "newobj",
					"text": "v #0_has_latest",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						152.0,
						568.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-92",
					"maxclass": "newobj",
					"text": "sel 1",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						152.0,
						592.0,
						36.0,
						22.0
					],
					"comment": "has data -> emit"
				}
			},
			{
				"box": {
					"id": "obj-93",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"bang",
						"bang"
					],
					"patching_rect": [
						152.0,
						616.0,
						100.0,
						22.0
					],
					"comment": "R-to-L: clear flag (first), restart timer (second), emit (last)"
				}
			},
			{
				"box": {
					"id": "obj-94",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						240.0,
						640.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-95",
					"maxclass": "newobj",
					"text": "v #0_has_latest",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						240.0,
						664.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-96",
					"maxclass": "newobj",
					"text": "s #0_starttimer",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						200.0,
						640.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-97",
					"maxclass": "newobj",
					"text": "zl reg",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						152.0,
						640.0,
						45.0,
						22.0
					],
					"comment": "recall latest msg"
				}
			},
			{
				"box": {
					"id": "obj-98",
					"maxclass": "comment",
					"text": "queue: dequeue or clear cd",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						240.0,
						552.0,
						160.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-99",
					"maxclass": "newobj",
					"text": "v #0_qidx",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						312.0,
						568.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-100",
					"maxclass": "newobj",
					"text": "sel 0",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						312.0,
						592.0,
						36.0,
						22.0
					],
					"comment": "empty -> clear cd"
				}
			},
			{
				"box": {
					"id": "obj-101",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						312.0,
						616.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-102",
					"maxclass": "newobj",
					"text": "v #0_cd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						312.0,
						640.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-103",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"bang",
						"bang"
					],
					"patching_rect": [
						344.0,
						616.0,
						100.0,
						22.0
					],
					"comment": "R-to-L: restart timer (first), dequeue item (second), output (last)"
				}
			},
			{
				"box": {
					"id": "obj-104",
					"maxclass": "newobj",
					"text": "s #0_starttimer",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						432.0,
						640.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-105",
					"maxclass": "newobj",
					"text": "s #0_dequeue",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						392.0,
						640.0,
						72.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-106",
					"maxclass": "newobj",
					"text": "r #0_dequeued",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						56.0,
						672.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-107",
					"maxclass": "comment",
					"text": "--- DEQUEUE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						880.0,
						344.0,
						100.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-108",
					"maxclass": "newobj",
					"text": "r #0_dequeue",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						880.0,
						368.0,
						72.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-109",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"bang",
						"bang"
					],
					"patching_rect": [
						880.0,
						392.0,
						160.0,
						22.0
					],
					"comment": "R-to-L: dec qidx (first), remove 0 (second), get 0 (last)"
				}
			},
			{
				"box": {
					"id": "obj-110",
					"maxclass": "newobj",
					"text": "v #0_qidx",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1024.0,
						416.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-111",
					"maxclass": "newobj",
					"text": "- 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						1024.0,
						440.0,
						30.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-112",
					"maxclass": "newobj",
					"text": "maximum 0",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"patching_rect": [
						1024.0,
						464.0,
						64.0,
						22.0
					],
					"comment": "clamp >= 0"
				}
			},
			{
				"box": {
					"id": "obj-113",
					"maxclass": "newobj",
					"text": "v #0_qidx",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1024.0,
						488.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-114",
					"maxclass": "newobj",
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						952.0,
						416.0,
						60.0,
						22.0
					],
					"comment": "R-to-L: renumber (first), remove 0 (second)"
				}
			},
			{
				"box": {
					"id": "obj-115",
					"maxclass": "message",
					"text": "remove 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						952.0,
						440.0,
						52.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-116",
					"maxclass": "message",
					"text": "renumber 0 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1000.0,
						440.0,
						72.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-117",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						880.0,
						416.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-118",
					"maxclass": "newobj",
					"text": "coll #0_q",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						880.0,
						448.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-119",
					"maxclass": "newobj",
					"text": "s #0_dequeued",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						880.0,
						480.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-120",
					"maxclass": "comment",
					"text": "--- FLUSH ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						880.0,
						520.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-121",
					"maxclass": "newobj",
					"text": "r #0_flush",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						880.0,
						544.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-122",
					"maxclass": "newobj",
					"text": "t b b b b",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"bang",
						"bang",
						"bang",
						"bang"
					],
					"patching_rect": [
						880.0,
						568.0,
						200.0,
						22.0
					],
					"comment": "R-to-L: cd=0 (first), stop timer (second), flush latest (third), dump queue (last)"
				}
			},
			{
				"box": {
					"id": "obj-123",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1064.0,
						592.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-124",
					"maxclass": "newobj",
					"text": "v #0_cd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1064.0,
						616.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-125",
					"maxclass": "message",
					"text": "stop",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1016.0,
						592.0,
						30.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-126",
					"maxclass": "newobj",
					"text": "v #0_has_latest",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						952.0,
						592.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-127",
					"maxclass": "newobj",
					"text": "sel 1",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						952.0,
						616.0,
						36.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-128",
					"maxclass": "newobj",
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						952.0,
						640.0,
						60.0,
						22.0
					],
					"comment": "R-to-L: clear flag (first), recall (second)"
				}
			},
			{
				"box": {
					"id": "obj-129",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1000.0,
						664.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-130",
					"maxclass": "newobj",
					"text": "v #0_has_latest",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1000.0,
						688.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-131",
					"maxclass": "newobj",
					"text": "zl reg",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						952.0,
						664.0,
						45.0,
						22.0
					],
					"comment": "recall latest for flush"
				}
			},
			{
				"box": {
					"id": "obj-132",
					"maxclass": "newobj",
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						880.0,
						592.0,
						60.0,
						22.0
					],
					"comment": "R-to-L: clear q state (first), dump (second)"
				}
			},
			{
				"box": {
					"id": "obj-133",
					"maxclass": "newobj",
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						928.0,
						592.0,
						60.0,
						22.0
					],
					"comment": "R-to-L: clear coll (first), qidx=0 (second)"
				}
			},
			{
				"box": {
					"id": "obj-134",
					"maxclass": "message",
					"text": "clear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						928.0,
						616.0,
						34.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-135",
					"maxclass": "newobj",
					"text": "coll #0_q",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						928.0,
						640.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-136",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						976.0,
						616.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-137",
					"maxclass": "newobj",
					"text": "v #0_qidx",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						976.0,
						640.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-138",
					"maxclass": "message",
					"text": "dump",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						880.0,
						616.0,
						32.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-139",
					"maxclass": "newobj",
					"text": "coll #0_q",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						880.0,
						640.0,
						56.0,
						22.0
					],
					"comment": "dump all queue items"
				}
			},
			{
				"box": {
					"id": "obj-140",
					"maxclass": "message",
					"text": "flushed",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						880.0,
						688.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-141",
					"maxclass": "comment",
					"text": "--- CANCEL ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1104.0,
						344.0,
						100.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-142",
					"maxclass": "newobj",
					"text": "r #0_cancel",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1104.0,
						368.0,
						68.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-143",
					"maxclass": "newobj",
					"text": "t b b b b b",
					"numinlets": 1,
					"numoutlets": 5,
					"outlettype": [
						"bang",
						"bang",
						"bang",
						"bang",
						"bang"
					],
					"patching_rect": [
						1104.0,
						392.0,
						120.0,
						22.0
					],
					"comment": "R-to-L: has_latest=0, clear coll, qidx=0, stop, cd=0, status"
				}
			},
			{
				"box": {
					"id": "obj-144",
					"maxclass": "message",
					"text": "canceled",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1104.0,
						416.0,
						52.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-145",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1136.0,
						416.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-146",
					"maxclass": "newobj",
					"text": "v #0_cd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1136.0,
						440.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-147",
					"maxclass": "message",
					"text": "stop",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1168.0,
						416.0,
						30.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-148",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1200.0,
						416.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-149",
					"maxclass": "newobj",
					"text": "v #0_qidx",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1200.0,
						440.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-150",
					"maxclass": "message",
					"text": "clear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1232.0,
						416.0,
						34.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-151",
					"maxclass": "newobj",
					"text": "coll #0_q",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						1232.0,
						440.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-152",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1264.0,
						416.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-153",
					"maxclass": "newobj",
					"text": "v #0_has_latest",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1264.0,
						440.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-154",
					"maxclass": "comment",
					"text": "--- RESET ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1104.0,
						488.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-155",
					"maxclass": "newobj",
					"text": "r #0_reset",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1104.0,
						512.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-156",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"bang",
						"bang"
					],
					"patching_rect": [
						1104.0,
						536.0,
						100.0,
						22.0
					],
					"comment": "R-to-L: cap=8 (first), policy=0 (second), cancel (last)"
				}
			},
			{
				"box": {
					"id": "obj-157",
					"maxclass": "newobj",
					"text": "s #0_cancel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1104.0,
						560.0,
						68.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-158",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1152.0,
						560.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-159",
					"maxclass": "newobj",
					"text": "v #0_policy",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1152.0,
						584.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-160",
					"maxclass": "message",
					"text": "8",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1192.0,
						560.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-161",
					"maxclass": "newobj",
					"text": "v #0_cap",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1192.0,
						584.0,
						52.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-162",
					"maxclass": "newobj",
					"text": "r #0_latest_store",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						488.0,
						568.0,
						88.0,
						22.0
					],
					"comment": "shared latest buffer store"
				}
			},
			{
				"box": {
					"id": "obj-163",
					"maxclass": "newobj",
					"text": "s #0_latest_store",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						456.0,
						592.0,
						88.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-164",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						600.0,
						504.0,
						120.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-165",
					"maxclass": "newobj",
					"text": "v #0_qidx",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						696.0,
						504.0,
						56.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-166",
					"maxclass": "newobj",
					"text": "v #0_cap",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						760.0,
						504.0,
						52.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-167",
					"maxclass": "newobj",
					"text": ">=",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						696.0,
						528.0,
						72.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-168",
					"maxclass": "newobj",
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						696.0,
						552.0,
						30.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-169",
					"maxclass": "newobj",
					"text": "gate 2 1",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						600.0,
						556.0,
						104.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-170",
					"maxclass": "message",
					"text": "overflow",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						656.0,
						580.0,
						50.0,
						22.0
					]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-1",
						0
					],
					"destination": [
						"obj-37",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						1
					],
					"destination": [
						"obj-38",
						0
					],
					"comment": "get bypass (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						0
					],
					"destination": [
						"obj-40",
						1
					],
					"comment": "msg to gate (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						0
					],
					"destination": [
						"obj-39",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-39",
						0
					],
					"destination": [
						"obj-40",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						1
					],
					"destination": [
						"obj-3",
						0
					],
					"comment": "bypass passthrough"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						0
					],
					"destination": [
						"obj-42",
						0
					],
					"comment": "to throttle core"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-42",
						1
					],
					"destination": [
						"obj-43",
						0
					],
					"comment": "get cd (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-42",
						0
					],
					"destination": [
						"obj-45",
						1
					],
					"comment": "msg to cd gate (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-43",
						0
					],
					"destination": [
						"obj-44",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-44",
						0
					],
					"destination": [
						"obj-45",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-45",
						0
					],
					"destination": [
						"obj-47",
						0
					],
					"comment": "ready: pass and start cd"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-45",
						1
					],
					"destination": [
						"obj-59",
						0
					],
					"comment": "in cooldown: route by policy"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						2
					],
					"destination": [
						"obj-48",
						0
					],
					"comment": "set cd=1 (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						1
					],
					"destination": [
						"obj-50",
						0
					],
					"comment": "start timer (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						0
					],
					"destination": [
						"obj-3",
						0
					],
					"order": 1,
					"comment": "output (fires last)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						0
					],
					"destination": [
						"obj-51",
						0
					],
					"order": 0,
					"comment": "status: passed"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-48",
						0
					],
					"destination": [
						"obj-49",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-53",
						0
					],
					"destination": [
						"obj-54",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						0
					],
					"destination": [
						"obj-55",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-55",
						0
					],
					"destination": [
						"obj-56",
						0
					],
					"comment": "start delay"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-55",
						1
					],
					"destination": [
						"obj-56",
						1
					],
					"comment": "set delay time"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-56",
						0
					],
					"destination": [
						"obj-57",
						0
					],
					"comment": "timer expired"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-59",
						1
					],
					"destination": [
						"obj-60",
						0
					],
					"comment": "get policy (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-59",
						0
					],
					"destination": [
						"obj-62",
						1
					],
					"comment": "msg to gate (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-61",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-61",
						0
					],
					"destination": [
						"obj-62",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-62",
						0
					],
					"destination": [
						"obj-64",
						0
					],
					"comment": "drop: status"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-62",
						1
					],
					"destination": [
						"obj-66",
						0
					],
					"comment": "latest: store"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-64",
						0
					],
					"destination": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-66",
						0
					],
					"destination": [
						"obj-163",
						0
					],
					"comment": "store in latest buffer via send"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-66",
						1
					],
					"destination": [
						"obj-68",
						0
					],
					"order": 1,
					"comment": "set has_latest=1 (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-66",
						1
					],
					"destination": [
						"obj-70",
						0
					],
					"order": 0,
					"comment": "status: queued"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-68",
						0
					],
					"destination": [
						"obj-69",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-70",
						0
					],
					"destination": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-162",
						0
					],
					"destination": [
						"obj-67",
						1
					],
					"comment": "receive stored latest msg"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-72",
						2
					],
					"destination": [
						"obj-74",
						0
					],
					"comment": "get cap (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-73",
						0
					],
					"destination": [
						"obj-75",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-75",
						0
					],
					"destination": [
						"obj-79",
						0
					],
					"comment": "qidx as key"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-75",
						1
					],
					"destination": [
						"obj-76",
						0
					],
					"comment": "inc qidx"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-74",
						0
					],
					"destination": [
						"obj-77",
						1
					],
					"comment": "cap as clamp max"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-76",
						0
					],
					"destination": [
						"obj-77",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-77",
						0
					],
					"destination": [
						"obj-78",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-79",
						0
					],
					"destination": [
						"obj-80",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-80",
						0
					],
					"destination": [
						"obj-81",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-81",
						0
					],
					"destination": [
						"obj-82",
						0
					],
					"comment": "status: queued after store"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-82",
						0
					],
					"destination": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-84",
						0
					],
					"destination": [
						"obj-85",
						0
					],
					"comment": "get policy on timer expire"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-85",
						0
					],
					"destination": [
						"obj-86",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-86",
						0
					],
					"destination": [
						"obj-88",
						0
					],
					"comment": "drop: clear cd"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-88",
						0
					],
					"destination": [
						"obj-89",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-86",
						1
					],
					"destination": [
						"obj-91",
						0
					],
					"comment": "latest: check has_latest"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-91",
						0
					],
					"destination": [
						"obj-92",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-92",
						0
					],
					"destination": [
						"obj-93",
						0
					],
					"comment": "has data: emit"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-92",
						1
					],
					"destination": [
						"obj-88",
						0
					],
					"comment": "no data: clear cd"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-93",
						2
					],
					"destination": [
						"obj-94",
						0
					],
					"comment": "clear has_latest (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-93",
						1
					],
					"destination": [
						"obj-96",
						0
					],
					"comment": "restart timer (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-93",
						0
					],
					"destination": [
						"obj-97",
						0
					],
					"comment": "recall msg (fires last)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-94",
						0
					],
					"destination": [
						"obj-95",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-97",
						0
					],
					"destination": [
						"obj-3",
						0
					],
					"comment": "latest output"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-86",
						2
					],
					"destination": [
						"obj-99",
						0
					],
					"comment": "queue: check qidx"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-99",
						0
					],
					"destination": [
						"obj-100",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-100",
						0
					],
					"destination": [
						"obj-101",
						0
					],
					"comment": "empty: clear cd"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-101",
						0
					],
					"destination": [
						"obj-102",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-100",
						1
					],
					"destination": [
						"obj-103",
						0
					],
					"comment": "has items: dequeue"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-103",
						2
					],
					"destination": [
						"obj-104",
						0
					],
					"comment": "restart timer (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-103",
						1
					],
					"destination": [
						"obj-105",
						0
					],
					"comment": "dequeue (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-106",
						0
					],
					"destination": [
						"obj-3",
						0
					],
					"comment": "dequeued to output"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-108",
						0
					],
					"destination": [
						"obj-109",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-109",
						2
					],
					"destination": [
						"obj-110",
						0
					],
					"comment": "dec qidx (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-109",
						1
					],
					"destination": [
						"obj-114",
						0
					],
					"comment": "remove+renumber (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-109",
						0
					],
					"destination": [
						"obj-117",
						0
					],
					"comment": "get index 0 (fires last)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-110",
						0
					],
					"destination": [
						"obj-111",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						0
					],
					"destination": [
						"obj-112",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-112",
						0
					],
					"destination": [
						"obj-113",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-114",
						1
					],
					"destination": [
						"obj-116",
						0
					],
					"comment": "renumber (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-114",
						0
					],
					"destination": [
						"obj-115",
						0
					],
					"comment": "remove 0 (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-115",
						0
					],
					"destination": [
						"obj-118",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-116",
						0
					],
					"destination": [
						"obj-118",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-117",
						0
					],
					"destination": [
						"obj-118",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-118",
						0
					],
					"destination": [
						"obj-119",
						0
					],
					"comment": "output to dequeued"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-2",
						0
					],
					"destination": [
						"obj-22",
						0
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
						"obj-23",
						0
					],
					"comment": "interval"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						1
					],
					"destination": [
						"obj-24",
						0
					],
					"comment": "policy"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						2
					],
					"destination": [
						"obj-29",
						0
					],
					"comment": "capacity"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						3
					],
					"destination": [
						"obj-30",
						0
					],
					"comment": "flush"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						4
					],
					"destination": [
						"obj-31",
						0
					],
					"comment": "reset"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						5
					],
					"destination": [
						"obj-32",
						0
					],
					"comment": "bypass"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-32",
						1
					],
					"destination": [
						"obj-33",
						0
					],
					"comment": "set bypass (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-32",
						0
					],
					"destination": [
						"obj-34",
						0
					],
					"comment": "check cancel (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-34",
						0
					],
					"destination": [
						"obj-35",
						0
					],
					"comment": "bypass=1: cancel"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-24",
						0
					],
					"destination": [
						"obj-25",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-24",
						1
					],
					"destination": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-24",
						2
					],
					"destination": [
						"obj-27",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						0
					],
					"destination": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-26",
						0
					],
					"destination": [
						"obj-28",
						0
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
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-6",
						0
					],
					"destination": [
						"obj-7",
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
						"obj-8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-8",
						0
					],
					"destination": [
						"obj-9",
						0
					],
					"comment": "prepend interval"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-8",
						1
					],
					"destination": [
						"obj-10",
						0
					],
					"comment": "init defaults"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-9",
						0
					],
					"destination": [
						"obj-22",
						0
					],
					"comment": "send interval from init"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						0
					],
					"destination": [
						"obj-11",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						1
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
						"obj-10",
						2
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
						"obj-10",
						3
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
						"obj-10",
						4
					],
					"destination": [
						"obj-19",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-11",
						0
					],
					"destination": [
						"obj-12",
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
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-15",
						0
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
						"obj-18",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						0
					],
					"destination": [
						"obj-20",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-121",
						0
					],
					"destination": [
						"obj-122",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-122",
						3
					],
					"destination": [
						"obj-123",
						0
					],
					"comment": "cd=0 (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-122",
						2
					],
					"destination": [
						"obj-125",
						0
					],
					"comment": "stop timer (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-122",
						1
					],
					"destination": [
						"obj-126",
						0
					],
					"comment": "flush latest (fires third)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-122",
						0
					],
					"destination": [
						"obj-132",
						0
					],
					"comment": "dump queue (fires last)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-123",
						0
					],
					"destination": [
						"obj-124",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-125",
						0
					],
					"destination": [
						"obj-56",
						0
					],
					"comment": "stop delay"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-126",
						0
					],
					"destination": [
						"obj-127",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-127",
						0
					],
					"destination": [
						"obj-128",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-128",
						1
					],
					"destination": [
						"obj-129",
						0
					],
					"comment": "clear flag (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-128",
						0
					],
					"destination": [
						"obj-131",
						0
					],
					"comment": "recall (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-129",
						0
					],
					"destination": [
						"obj-130",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-131",
						0
					],
					"destination": [
						"obj-3",
						0
					],
					"comment": "flushed latest"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-133",
						1
					],
					"destination": [
						"obj-134",
						0
					],
					"comment": "clear coll (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-133",
						0
					],
					"destination": [
						"obj-136",
						0
					],
					"comment": "qidx=0 (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-134",
						0
					],
					"destination": [
						"obj-135",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-136",
						0
					],
					"destination": [
						"obj-137",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-138",
						0
					],
					"destination": [
						"obj-139",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-139",
						0
					],
					"destination": [
						"obj-3",
						0
					],
					"comment": "queue items to output"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-139",
						3
					],
					"destination": [
						"obj-140",
						0
					],
					"comment": "dump done: flushed"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-140",
						0
					],
					"destination": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-142",
						0
					],
					"destination": [
						"obj-143",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-143",
						0
					],
					"destination": [
						"obj-144",
						0
					],
					"comment": "status (fires last)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-143",
						1
					],
					"destination": [
						"obj-145",
						0
					],
					"comment": "cd=0"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-143",
						2
					],
					"destination": [
						"obj-147",
						0
					],
					"comment": "stop timer"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-143",
						3
					],
					"destination": [
						"obj-148",
						0
					],
					"comment": "qidx=0"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-143",
						4
					],
					"destination": [
						"obj-150",
						0
					],
					"order": 1,
					"comment": "clear coll"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-143",
						4
					],
					"destination": [
						"obj-152",
						0
					],
					"order": 0,
					"comment": "has_latest=0"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-144",
						0
					],
					"destination": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-145",
						0
					],
					"destination": [
						"obj-146",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-147",
						0
					],
					"destination": [
						"obj-56",
						0
					],
					"comment": "stop delay"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-148",
						0
					],
					"destination": [
						"obj-149",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-150",
						0
					],
					"destination": [
						"obj-151",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-152",
						0
					],
					"destination": [
						"obj-153",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-155",
						0
					],
					"destination": [
						"obj-156",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-156",
						2
					],
					"destination": [
						"obj-160",
						0
					],
					"comment": "cap=8 (fires first)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-156",
						1
					],
					"destination": [
						"obj-158",
						0
					],
					"comment": "policy=0 (fires second)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-156",
						0
					],
					"destination": [
						"obj-157",
						0
					],
					"comment": "cancel (fires last)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-158",
						0
					],
					"destination": [
						"obj-159",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-160",
						0
					],
					"destination": [
						"obj-161",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-72",
						1
					],
					"destination": [
						"obj-79",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-72",
						0
					],
					"destination": [
						"obj-73",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-62",
						2
					],
					"destination": [
						"obj-164",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-164",
						1
					],
					"destination": [
						"obj-165",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-164",
						1
					],
					"destination": [
						"obj-166",
						0
					],
					"order": 1
				}
			},
			{
				"patchline": {
					"source": [
						"obj-165",
						0
					],
					"destination": [
						"obj-167",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-166",
						0
					],
					"destination": [
						"obj-167",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-167",
						0
					],
					"destination": [
						"obj-168",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-168",
						0
					],
					"destination": [
						"obj-169",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-164",
						0
					],
					"destination": [
						"obj-169",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-169",
						0
					],
					"destination": [
						"obj-72",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-169",
						1
					],
					"destination": [
						"obj-170",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-170",
						0
					],
					"destination": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-132",
						1
					],
					"destination": [
						"obj-138",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-132",
						0
					],
					"destination": [
						"obj-133",
						0
					]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

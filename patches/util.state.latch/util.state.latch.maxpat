{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 8,
			"minor": 5,
			"revision": 5,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [85.0, 104.0, 1392.0, 800.0],
		"openinpresentation": 0,
		"default_fontsize": 10.0,
		"default_fontname": "Arial Bold",
		"gridsize": [8.0, 8.0],
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [56.0, 16.0, 30.0, 30.0],
					"index": 1,
					"comment": "numeric input (int/float)"
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [768.0, 16.0, 30.0, 30.0],
					"index": 2,
					"comment": "control: low high dwell init reset bypass"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [496.0, 752.0, 30.0, 30.0],
					"index": 1,
					"comment": "latched state (0 or 1)"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [640.0, 752.0, 30.0, 30.0],
					"index": 2,
					"comment": "events: rise fall pending state"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [784.0, 752.0, 30.0, 30.0],
					"index": 3,
					"comment": "diagnostics"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "comment",
					"text": "== CREATION ARGS ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [1048.0, 16.0, 120.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"text": "patcherargs 0.4 0.6",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [1048.0, 40.0, 112.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"text": "unpack f f",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["float", "float"],
					"patching_rect": [1048.0, 72.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "v #0_low",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1048.0, 104.0, 52.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "v #0_high",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1104.0, 104.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "comment",
					"text": "== DEFAULTS INIT ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [1048.0, 136.0, 120.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [1048.0, 160.0, 52.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "t b b b b b b",
					"numinlets": 1,
					"numoutlets": 6,
					"outlettype": ["bang", "bang", "bang", "bang", "bang", "bang"],
					"patching_rect": [1048.0, 192.0, 272.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "message",
					"text": "0.4",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1048.0, 224.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"text": "v #0_low",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1048.0, 256.0, 52.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "message",
					"text": "0.6",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1104.0, 224.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"text": "v #0_high",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1104.0, 256.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "message",
					"text": "20",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1160.0, 224.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"text": "v #0_dwell",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1160.0, 256.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1216.0, 224.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "v #0_state",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1216.0, 256.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "message",
					"text": "-1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1272.0, 224.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1272.0, 256.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1328.0, 224.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [1328.0, 256.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "comment",
					"text": "== CONTROL INLET ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [768.0, 56.0, 120.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "route low high dwell init reset bypass",
					"numinlets": 1,
					"numoutlets": 7,
					"outlettype": ["", "", "", "", "", "", ""],
					"patching_rect": [768.0, 80.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "newobj",
					"text": "v #0_low",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [768.0, 112.0, 52.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"text": "v #0_high",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [808.0, 144.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"text": "v #0_dwell",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [848.0, 176.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "comment",
					"text": "init: set state without event",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [928.0, 208.0, 160.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"text": "v #0_state",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [888.0, 208.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "comment",
					"text": "reset: cancel + restore state=0",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [768.0, 240.0, 176.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", "bang"],
					"patching_rect": [768.0, 264.0, 120.0, 20.0]
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
					"patching_rect": [768.0, 296.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "newobj",
					"text": "s #0_delay",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [768.0, 328.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "message",
					"text": "-1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [832.0, 296.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [832.0, 328.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [896.0, 296.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"text": "v #0_state",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [896.0, 328.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [928.0, 264.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "comment",
					"text": "== INPUT PATH ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 56.0, 104.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"text": "t f f",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["float", "float"],
					"patching_rect": [56.0, 80.0, 80.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "newobj",
					"text": "prepend value",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [120.0, 112.0, 80.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"text": "s #0_diag",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [120.0, 144.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "comment",
					"text": "-- bypass check --",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [160.0, 176.0, 104.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"text": "t f b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["float", "bang"],
					"patching_rect": [56.0, 176.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [112.0, 208.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "newobj",
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [112.0, 240.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "newobj",
					"text": "gate 2",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [56.0, 272.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "comment",
					"text": "gate: 1=normal, 2=bypass",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [144.0, 272.0, 144.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "comment",
					"text": "-- bypass: immediate >= high --",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [240.0, 304.0, 176.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "newobj",
					"text": "t f b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["float", "bang"],
					"patching_rect": [112.0, 304.0, 48.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "newobj",
					"text": "v #0_high",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [144.0, 336.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "newobj",
					"text": ">= 0.",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [112.0, 368.0, 48.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "newobj",
					"text": "s #0_commit",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [112.0, 400.0, 68.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-57",
					"maxclass": "comment",
					"text": "== NORMAL PATH: region detect ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 432.0, 192.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-58",
					"maxclass": "newobj",
					"text": "t f f b b",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": ["float", "float", "bang", "bang"],
					"patching_rect": [56.0, 456.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-59",
					"maxclass": "newobj",
					"text": ">= 0.",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [56.0, 488.0, 40.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "newobj",
					"text": "<= 0.",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [120.0, 488.0, 40.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "newobj",
					"text": "v #0_high",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [176.0, 488.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-62",
					"maxclass": "newobj",
					"text": "v #0_low",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [240.0, 488.0, 52.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "comment",
					"text": "region: 2=above high, 1=below low, 0=band",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [184.0, 520.0, 248.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-64",
					"maxclass": "newobj",
					"text": "* 2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [56.0, 520.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "newobj",
					"text": "+",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [56.0, 552.0, 80.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-66",
					"maxclass": "newobj",
					"text": "sel 1 2",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", ""],
					"patching_rect": [56.0, 584.0, 80.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-67",
					"maxclass": "comment",
					"text": "1=below low, 2=above high, else=band",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [152.0, 584.0, 216.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-68",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [56.0, 616.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-69",
					"maxclass": "newobj",
					"text": "s #0_request",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 648.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-70",
					"maxclass": "message",
					"text": "1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [96.0, 616.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "newobj",
					"text": "s #0_request",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [96.0, 648.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-72",
					"maxclass": "comment",
					"text": "-- in band: cancel pending --",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [144.0, 616.0, 168.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-73",
					"maxclass": "newobj",
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", "bang"],
					"patching_rect": [144.0, 648.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-74",
					"maxclass": "message",
					"text": "stop",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [144.0, 680.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "newobj",
					"text": "s #0_delay",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [144.0, 712.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-76",
					"maxclass": "message",
					"text": "-1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [208.0, 680.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-77",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [208.0, 712.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-78",
					"maxclass": "message",
					"text": "pending 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [272.0, 680.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-79",
					"maxclass": "newobj",
					"text": "s #0_events",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [272.0, 712.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-80",
					"maxclass": "comment",
					"text": "== REQUEST HANDLER ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 432.0, 136.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-81",
					"maxclass": "newobj",
					"text": "r #0_request",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 456.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-82",
					"maxclass": "newobj",
					"text": "t i b i",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["int", "bang", "int"],
					"patching_rect": [400.0, 488.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-83",
					"maxclass": "newobj",
					"text": "v #0_state",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [456.0, 520.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-84",
					"maxclass": "newobj",
					"text": "!=",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [504.0, 520.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-85",
					"maxclass": "comment",
					"text": "skip if already in requested state",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [552.0, 520.0, 192.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-86",
					"maxclass": "newobj",
					"text": "gate",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 552.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-87",
					"maxclass": "newobj",
					"text": "t i i b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["int", "int", "bang"],
					"patching_rect": [400.0, 584.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-88",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [456.0, 616.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-89",
					"maxclass": "newobj",
					"text": "v #0_dwell",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [504.0, 616.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-90",
					"maxclass": "newobj",
					"text": "sel 0",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", ""],
					"patching_rect": [504.0, 648.0, 40.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-91",
					"maxclass": "comment",
					"text": "dwell=0: immediate",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [560.0, 648.0, 112.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-92",
					"maxclass": "newobj",
					"text": "s #0_do_commit",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [504.0, 680.0, 84.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-93",
					"maxclass": "newobj",
					"text": "s #0_delay",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [536.0, 712.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-94",
					"maxclass": "newobj",
					"text": "prepend pending",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 616.0, 88.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-95",
					"maxclass": "newobj",
					"text": "s #0_events",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 648.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-96",
					"maxclass": "comment",
					"text": "== DWELL TIMER ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 744.0, 112.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-97",
					"maxclass": "newobj",
					"text": "r #0_delay",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 768.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-98",
					"maxclass": "newobj",
					"text": "delay 20",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [400.0, 800.0, 52.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-99",
					"maxclass": "newobj",
					"text": "s #0_do_commit",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [400.0, 832.0, 84.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-100",
					"maxclass": "comment",
					"text": "== COMMIT: read pending + output ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [496.0, 432.0, 208.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-101",
					"maxclass": "newobj",
					"text": "r #0_do_commit",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [696.0, 456.0, 84.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-102",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [696.0, 488.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-103",
					"maxclass": "newobj",
					"text": "s #0_commit",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [696.0, 520.0, 68.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-104",
					"maxclass": "comment",
					"text": "== COMMIT OUTPUT ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [496.0, 552.0, 120.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-105",
					"maxclass": "newobj",
					"text": "r #0_commit",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [496.0, 576.0, 68.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-106",
					"maxclass": "newobj",
					"text": "t i i b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["int", "int", "bang"],
					"patching_rect": [496.0, 608.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-107",
					"maxclass": "newobj",
					"text": "v #0_state",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 640.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-108",
					"maxclass": "newobj",
					"text": "!=",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [544.0, 640.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-109",
					"maxclass": "comment",
					"text": "suppress duplicate state",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [672.0, 640.0, 136.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-110",
					"maxclass": "newobj",
					"text": "gate",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [496.0, 672.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-111",
					"maxclass": "newobj",
					"text": "t i i i i",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": ["int", "int", "int", "int"],
					"patching_rect": [496.0, 704.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-112",
					"maxclass": "newobj",
					"text": "s #0_out",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [496.0, 736.0, 48.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-113",
					"maxclass": "newobj",
					"text": "sel 0 1",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", ""],
					"patching_rect": [560.0, 736.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-114",
					"maxclass": "message",
					"text": "fall",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [560.0, 768.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-115",
					"maxclass": "message",
					"text": "rise",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 768.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-116",
					"maxclass": "newobj",
					"text": "s #0_events",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [560.0, 800.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-117",
					"maxclass": "newobj",
					"text": "s #0_events",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [600.0, 800.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-118",
					"maxclass": "message",
					"text": "-1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 736.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-119",
					"maxclass": "newobj",
					"text": "v #0_pending",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 768.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-120",
					"maxclass": "newobj",
					"text": "v #0_state",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [680.0, 736.0, 60.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-121",
					"maxclass": "comment",
					"text": "== OUTPUT ==",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [496.0, 840.0, 80.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-122",
					"maxclass": "newobj",
					"text": "r #0_out",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [496.0, 864.0, 48.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-123",
					"maxclass": "newobj",
					"text": "r #0_events",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 864.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-124",
					"maxclass": "newobj",
					"text": "r #0_diag",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [784.0, 864.0, 56.0, 20.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-1", 0],
					"destination": ["obj-43", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-2", 0],
					"destination": ["obj-27", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-43", 0],
					"destination": ["obj-47", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-43", 1],
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
					"source": ["obj-47", 0],
					"destination": ["obj-50", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-47", 1],
					"destination": ["obj-48", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-48", 0],
					"destination": ["obj-49", 0]
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
					"destination": ["obj-58", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-50", 1],
					"destination": ["obj-53", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-53", 0],
					"destination": ["obj-55", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-53", 1],
					"destination": ["obj-54", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-54", 0],
					"destination": ["obj-55", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-55", 0],
					"destination": ["obj-56", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-58", 0],
					"destination": ["obj-59", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-58", 1],
					"destination": ["obj-60", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-58", 2],
					"destination": ["obj-61", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-58", 3],
					"destination": ["obj-62", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-61", 0],
					"destination": ["obj-59", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-62", 0],
					"destination": ["obj-60", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-59", 0],
					"destination": ["obj-64", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-60", 0],
					"destination": ["obj-65", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-64", 0],
					"destination": ["obj-65", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-65", 0],
					"destination": ["obj-66", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-66", 0],
					"destination": ["obj-68", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-66", 1],
					"destination": ["obj-70", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-66", 2],
					"destination": ["obj-73", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-68", 0],
					"destination": ["obj-69", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-70", 0],
					"destination": ["obj-71", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-73", 0],
					"destination": ["obj-74", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-73", 1],
					"destination": ["obj-76", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-73", 2],
					"destination": ["obj-78", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-74", 0],
					"destination": ["obj-75", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-76", 0],
					"destination": ["obj-77", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-78", 0],
					"destination": ["obj-79", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-81", 0],
					"destination": ["obj-82", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-82", 0],
					"destination": ["obj-86", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-82", 1],
					"destination": ["obj-83", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-82", 2],
					"destination": ["obj-84", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-83", 0],
					"destination": ["obj-84", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-84", 0],
					"destination": ["obj-86", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-86", 0],
					"destination": ["obj-87", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-87", 0],
					"destination": ["obj-94", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-87", 1],
					"destination": ["obj-88", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-87", 2],
					"destination": ["obj-89", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-89", 0],
					"destination": ["obj-90", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-90", 0],
					"destination": ["obj-92", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-90", 1],
					"destination": ["obj-93", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-94", 0],
					"destination": ["obj-95", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-97", 0],
					"destination": ["obj-98", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-98", 0],
					"destination": ["obj-99", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-101", 0],
					"destination": ["obj-102", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-102", 0],
					"destination": ["obj-103", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-105", 0],
					"destination": ["obj-106", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-106", 0],
					"destination": ["obj-110", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-106", 1],
					"destination": ["obj-108", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-106", 2],
					"destination": ["obj-107", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-107", 0],
					"destination": ["obj-108", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-108", 0],
					"destination": ["obj-110", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-110", 0],
					"destination": ["obj-111", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-111", 0],
					"destination": ["obj-112", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-111", 1],
					"destination": ["obj-113", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-111", 2],
					"destination": ["obj-118", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-111", 3],
					"destination": ["obj-120", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-113", 0],
					"destination": ["obj-114", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-113", 1],
					"destination": ["obj-115", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-114", 0],
					"destination": ["obj-116", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-115", 0],
					"destination": ["obj-117", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-118", 0],
					"destination": ["obj-119", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-122", 0],
					"destination": ["obj-3", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-123", 0],
					"destination": ["obj-4", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-124", 0],
					"destination": ["obj-5", 0]
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
					"source": ["obj-8", 0],
					"destination": ["obj-9", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-8", 1],
					"destination": ["obj-10", 0]
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
					"source": ["obj-13", 0],
					"destination": ["obj-14", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 1],
					"destination": ["obj-16", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 2],
					"destination": ["obj-18", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 3],
					"destination": ["obj-20", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 4],
					"destination": ["obj-22", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 5],
					"destination": ["obj-24", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-14", 0],
					"destination": ["obj-15", 0]
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
					"source": ["obj-18", 0],
					"destination": ["obj-19", 0]
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
					"source": ["obj-22", 0],
					"destination": ["obj-23", 0]
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
					"source": ["obj-27", 0],
					"destination": ["obj-28", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 1],
					"destination": ["obj-29", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 2],
					"destination": ["obj-30", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 3],
					"destination": ["obj-32", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 4],
					"destination": ["obj-34", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 5],
					"destination": ["obj-41", 0]
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
					"source": ["obj-34", 1],
					"destination": ["obj-37", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-34", 2],
					"destination": ["obj-39", 0]
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
					"source": ["obj-39", 0],
					"destination": ["obj-40", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

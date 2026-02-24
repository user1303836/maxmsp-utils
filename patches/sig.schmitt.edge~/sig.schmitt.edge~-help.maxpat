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
		"rect": [100.0, 100.0, 800.0, 640.0],
		"bglocked": 0,
		"openinpresentation": 0,
		"default_fontsize": 10.0,
		"default_fontface": 1,
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
		"description": "sig.schmitt.edge~ help patch",
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
					"text": "sig.schmitt.edge~",
					"fontsize": 16.0,
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 16.0, 200.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"text": "Signal-rate Schmitt trigger with hysteresis and edge bang outputs",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 40.0, 400.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"text": "-- Basic usage: rising sweep with default thresholds (0.4 / 0.6) --",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 72.0, 400.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "cycle~ 0.5",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [56.0, 104.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "comment",
					"text": "0.5 Hz sine: sweeps -1 to 1",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [128.0, 104.0, 168.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "sig.schmitt.edge~",
					"numinlets": 4,
					"numoutlets": 4,
					"outlettype": ["signal", "bang", "bang", ""],
					"patching_rect": [56.0, 136.0, 232.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "snapshot~ 50",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["float"],
					"patching_rect": [56.0, 176.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [56.0, 200.0, 48.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [160.0, 176.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [232.0, 176.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"text": "print status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [272.0, 176.0, 64.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "comment",
					"text": "state (0./1.)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [56.0, 224.0, 80.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "comment",
					"text": "rise",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [160.0, 208.0, 32.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "comment",
					"text": "fall",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [232.0, 208.0, 32.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "comment",
					"text": "-- Custom thresholds via creation args --",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 256.0, 280.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "newobj",
					"text": "noise~",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [56.0, 288.0, 40.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "sig.schmitt.edge~ 0.2 0.8",
					"numinlets": 4,
					"numoutlets": 4,
					"outlettype": ["signal", "bang", "bang", ""],
					"patching_rect": [56.0, 320.0, 232.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [160.0, 352.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [232.0, 352.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "comment",
					"text": "wider hysteresis band: fewer toggles from noise",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [104.0, 288.0, 280.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "comment",
					"text": "-- Runtime threshold changes via inlets 2 and 3 --",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 400.0, 320.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "newobj",
					"text": "cycle~ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [56.0, 432.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [160.0, 432.0, 48.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [224.0, 432.0, 48.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"text": "sig.schmitt.edge~",
					"numinlets": 4,
					"numoutlets": 4,
					"outlettype": ["signal", "bang", "bang", ""],
					"patching_rect": [56.0, 464.0, 232.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [160.0, 496.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [232.0, 496.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "comment",
					"text": "low",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [160.0, 416.0, 32.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "comment",
					"text": "high",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [224.0, 416.0, 32.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "comment",
					"text": "-- Control messages (inlet 4): reset, bypass --",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [424.0, 72.0, 320.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "newobj",
					"text": "cycle~ 2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [440.0, 104.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 104.0, 40.0, 20.0]
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
					"patching_rect": [648.0, 104.0, 56.0, 20.0]
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
					"patching_rect": [712.0, 104.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "newobj",
					"text": "sig.schmitt.edge~ 0.3 0.7",
					"numinlets": 4,
					"numoutlets": 4,
					"outlettype": ["signal", "bang", "bang", ""],
					"patching_rect": [440.0, 136.0, 280.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [552.0, 168.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-57",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [608.0, 168.0, 24.0, 24.0]
				}
			},
			{
				"box": {
					"id": "obj-58",
					"maxclass": "newobj",
					"text": "print ctrl-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [648.0, 168.0, 88.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "newobj",
					"text": "ezdac~",
					"numinlets": 2,
					"numoutlets": 0,
					"patching_rect": [424.0, 560.0, 44.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "comment",
					"text": "Turn on audio to hear/see signal processing",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [472.0, 560.0, 264.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-70",
					"maxclass": "comment",
					"text": "-- init message: set initial state --",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [424.0, 256.0, 240.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "message",
					"text": "init 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 288.0, 40.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-72",
					"maxclass": "message",
					"text": "init 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [648.0, 288.0, 40.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-73",
					"maxclass": "newobj",
					"text": "cycle~ 0.25",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [440.0, 288.0, 72.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-74",
					"maxclass": "newobj",
					"text": "sig.schmitt.edge~",
					"numinlets": 4,
					"numoutlets": 4,
					"outlettype": ["signal", "bang", "bang", ""],
					"patching_rect": [440.0, 320.0, 232.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "newobj",
					"text": "print init-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [648.0, 352.0, 88.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-80",
					"maxclass": "comment",
					"text": "-- threshold via control messages --",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [424.0, 400.0, 240.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-81",
					"maxclass": "message",
					"text": "low 0.1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [600.0, 432.0, 48.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-82",
					"maxclass": "message",
					"text": "high 0.9",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [656.0, 432.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-83",
					"maxclass": "newobj",
					"text": "noise~",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [440.0, 432.0, 40.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-84",
					"maxclass": "newobj",
					"text": "sig.schmitt.edge~",
					"numinlets": 4,
					"numoutlets": 4,
					"outlettype": ["signal", "bang", "bang", ""],
					"patching_rect": [440.0, 464.0, 232.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-85",
					"maxclass": "newobj",
					"text": "print thresh-status",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [648.0, 496.0, 104.0, 20.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-10", 0],
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
					"source": ["obj-12", 1],
					"destination": ["obj-15", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-12", 2],
					"destination": ["obj-16", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-12", 3],
					"destination": ["obj-17", 0]
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
					"source": ["obj-26", 0],
					"destination": ["obj-27", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 1],
					"destination": ["obj-28", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 2],
					"destination": ["obj-29", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-36", 0],
					"destination": ["obj-39", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-37", 0],
					"destination": ["obj-39", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-38", 0],
					"destination": ["obj-39", 2]
				}
			},
			{
				"patchline": {
					"source": ["obj-39", 1],
					"destination": ["obj-40", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-39", 2],
					"destination": ["obj-41", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-51", 0],
					"destination": ["obj-55", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-52", 0],
					"destination": ["obj-55", 3]
				}
			},
			{
				"patchline": {
					"source": ["obj-53", 0],
					"destination": ["obj-55", 3]
				}
			},
			{
				"patchline": {
					"source": ["obj-54", 0],
					"destination": ["obj-55", 3]
				}
			},
			{
				"patchline": {
					"source": ["obj-55", 1],
					"destination": ["obj-56", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-55", 2],
					"destination": ["obj-57", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-55", 3],
					"destination": ["obj-58", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-71", 0],
					"destination": ["obj-74", 3]
				}
			},
			{
				"patchline": {
					"source": ["obj-72", 0],
					"destination": ["obj-74", 3]
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
					"source": ["obj-74", 3],
					"destination": ["obj-75", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-81", 0],
					"destination": ["obj-84", 3]
				}
			},
			{
				"patchline": {
					"source": ["obj-82", 0],
					"destination": ["obj-84", 3]
				}
			},
			{
				"patchline": {
					"source": ["obj-83", 0],
					"destination": ["obj-84", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-84", 3],
					"destination": ["obj-85", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

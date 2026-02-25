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
		"rect": [100.0, 100.0, 800.0, 600.0],
		"openinpresentation": 0,
		"default_fontsize": 12.0,
		"default_fontname": "Arial",
		"gridsize": [15.0, 15.0],
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "util.state.latch",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 15.0, 200.0, 20.0],
					"fontsize": 16.0,
					"fontface": 1
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"text": "Schmitt-style latch with dwell time. Suppresses jitter/chatter in noisy control streams by requiring the input to remain in a threshold region for a specified dwell time before changing state.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 45.0, 760.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"text": "-- basic usage --",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 75.0, 120.0, 20.0],
					"fontface": 1
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [30.0, 105.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "newobj",
					"text": "util.state.latch",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["", "", ""],
					"patching_rect": [30.0, 135.0, 96.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [30.0, 180.0, 50.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"text": "print state-events",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [105.0, 180.0, 108.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"text": "print diagnostics",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [225.0, 180.0, 102.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "comment",
					"text": "Send a float 0.-1. Input >= 0.6 for 20ms -> state 1. Input <= 0.4 for 20ms -> state 0.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [120.0, 105.0, 600.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "comment",
					"text": "-- custom thresholds --",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 225.0, 150.0, 20.0],
					"fontface": 1
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [30.0, 255.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "util.state.latch 0.3 0.7",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["", "", ""],
					"patching_rect": [30.0, 285.0, 136.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [30.0, 330.0, 50.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "comment",
					"text": "Creation args set low=0.3 high=0.7. Wider hysteresis band = more noise rejection.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [120.0, 255.0, 600.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "comment",
					"text": "-- control messages --",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 375.0, 150.0, 20.0],
					"fontface": 1
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [30.0, 405.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "message",
					"text": "low 0.2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [150.0, 405.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "message",
					"text": "high 0.8",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [210.0, 405.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "message",
					"text": "dwell 50",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [275.0, 405.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "message",
					"text": "dwell 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [340.0, 405.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "message",
					"text": "reset",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [400.0, 405.0, 37.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "message",
					"text": "bypass 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [450.0, 405.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "message",
					"text": "bypass 0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [515.0, 405.0, 56.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "message",
					"text": "init 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [580.0, 405.0, 41.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"text": "util.state.latch",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["", "", ""],
					"patching_rect": [30.0, 450.0, 555.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "bang"],
					"patching_rect": [30.0, 495.0, 50.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "print ctrl-events",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [300.0, 495.0, 100.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "comment",
					"text": "dwell 0 = immediate switching with hysteresis (no timer). bypass = simple >= high threshold.",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [120.0, 375.0, 600.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "comment",
					"text": "Outlet 1: latched state (0/1)    Outlet 2: events (rise/fall/pending)    Outlet 3: diagnostics",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 540.0, 600.0, 20.0],
					"fontface": 2
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-4", 0],
					"destination": ["obj-5", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-5", 0],
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
					"source": ["obj-5", 2],
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
					"source": ["obj-16", 0],
					"destination": ["obj-25", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-17", 0],
					"destination": ["obj-25", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-18", 0],
					"destination": ["obj-25", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-19", 0],
					"destination": ["obj-25", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 0],
					"destination": ["obj-25", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 0],
					"destination": ["obj-25", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-22", 0],
					"destination": ["obj-25", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-23", 0],
					"destination": ["obj-25", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-24", 0],
					"destination": ["obj-25", 1]
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
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

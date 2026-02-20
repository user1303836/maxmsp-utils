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
		"rect": [100.0, 100.0, 700.0, 500.0],
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
		"description": "TRK2 modulation output: exposes pitch, velocity, gate as live.dial parameters",
		"digest": "Metropolix TRK2 modulation output",
		"tags": "",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "--- Track2Output ---\nTRK2 modulation output. Converts signal-rate pitch/gate to\nnormalized parameter values exposed as live.dial objects.\nUser maps these to any destination in their Live project.",
					"linecount": 4,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 15.0, 400.0, 62.0]
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "inlet",
					"index": 1,
					"comment": "TRK2 pitch signal (MIDI note number 0-127)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [30.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "inlet",
					"index": 2,
					"comment": "TRK2 gate signal (1=on, 0=off)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [210.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "inlet",
					"index": 3,
					"comment": "TRK2 velocity (int 1-127)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [390.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "snapshot~ 30",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["float"],
					"patching_rect": [30.0, 165.0, 75.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "snapshot~ 30",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["float"],
					"patching_rect": [210.0, 165.0, 75.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "/ 127.",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["float"],
					"patching_rect": [30.0, 195.0, 38.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "/ 127.",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["float"],
					"patching_rect": [390.0, 165.0, 38.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"text": "clip 0. 1.",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [30.0, 225.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"text": "clip 0. 1.",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [390.0, 195.0, 60.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [30.0, 270.0, 44.0, 48.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "TRK2 Pitch",
							"parameter_shortname": "T2 Pitch",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.0],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "TRK2 Pitch"
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [210.0, 270.0, 44.0, 48.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "TRK2 Gate",
							"parameter_shortname": "T2 Gate",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.0],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "TRK2 Gate"
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [390.0, 270.0, 44.0, 48.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "TRK2 Velocity",
							"parameter_shortname": "T2 Vel",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.0],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "TRK2 Velocity"
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"text": "These live.dial outputs are automatable parameters.\nUser maps them to any destination via Live's parameter mapping.",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [30.0, 345.0, 400.0, 34.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-2", 0],
					"destination": ["obj-10", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-3", 0],
					"destination": ["obj-11", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-10", 0],
					"destination": ["obj-12", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-12", 0],
					"destination": ["obj-14", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 0],
					"destination": ["obj-13", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 0],
					"destination": ["obj-15", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-14", 0],
					"destination": ["obj-20", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-11", 0],
					"destination": ["obj-21", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-15", 0],
					"destination": ["obj-22", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

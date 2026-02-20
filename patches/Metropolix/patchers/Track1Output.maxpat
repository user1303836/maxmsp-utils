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
		"rect": [100.0, 100.0, 700.0, 550.0],
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
		"description": "TRK1 MIDI output: signal-to-message conversion, note-on/off, schedule for timing precision",
		"digest": "Metropolix TRK1 MIDI output",
		"tags": "",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "--- Track1Output ---\nConverts signal-rate pitch and gate to MIDI note-on/note-off.\nUses edge detection to fire notes only on gate transitions.\nRoutes through schedule for scheduler-thread precision.",
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
					"comment": "Pitch signal (MIDI note number)",
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
					"comment": "Gate signal (1=on, 0=off)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [180.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "inlet",
					"index": 3,
					"comment": "Velocity (int 1-127)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [330.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "inlet",
					"index": 4,
					"comment": "MIDI channel (int 1-16)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [450.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "inlet",
					"index": 5,
					"comment": "MIDI thru from midiin (raw bytes)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [570.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "gen~ @title NoteEdgeDetect",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": ["signal", "signal", "signal"],
					"patching_rect": [30.0, 180.0, 280.0, 22.0],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 9,
							"minor": 0,
							"revision": 0,
							"architecture": "x64",
							"modernui": 1
						},
						"classnamespace": "dsp.gen",
						"rect": [100.0, 100.0, 640.0, 480.0],
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
									"maxclass": "newobj",
									"text": "in 1",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [30.0, 30.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "in 2",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [180.0, 30.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "codebox",
									"numinlets": 2,
									"numoutlets": 3,
									"outlettype": ["", "", ""],
									"patching_rect": [30.0, 90.0, 400.0, 200.0],
									"code": "// Note edge detector\n// in1 = pitch signal (MIDI note number)\n// in2 = gate signal (1=on, 0=off)\n//\n// out1 = note-on trigger (pitch on rising edge, 0 otherwise)\n// out2 = note-off trigger (pitch on falling edge, 0 otherwise)\n// out3 = current pitch (held for note-off)\n\nHistory prev_gate(0);\nHistory held_pitch(0);\n\npitch = round(clamp(in1, 0, 127));\ngate = in2;\n\nnote_on = 0;\nnote_off = 0;\n\n// Rising edge: gate was 0, now 1 → note on\nif (gate > 0.5 && prev_gate < 0.5) {\n    note_on = pitch;\n    held_pitch = pitch;\n}\n\n// Falling edge: gate was 1, now 0 → note off\nif (gate < 0.5 && prev_gate > 0.5) {\n    note_off = held_pitch;\n}\n\n// Pitch change while gate is on: retrigger\nif (gate > 0.5 && prev_gate > 0.5 && pitch != held_pitch) {\n    note_off = held_pitch;\n    note_on = pitch;\n    held_pitch = pitch;\n}\n\nprev_gate = gate;\n\nout1 = note_on;\nout2 = note_off;\nout3 = held_pitch;"
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "out 1",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [30.0, 330.0, 34.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "out 2",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [180.0, 330.0, 34.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "out 3",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [330.0, 330.0, 34.0, 22.0]
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
									"source": ["obj-2", 0],
									"destination": ["obj-3", 1]
								}
							},
							{
								"patchline": {
									"source": ["obj-3", 0],
									"destination": ["obj-4", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-3", 1],
									"destination": ["obj-5", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-3", 2],
									"destination": ["obj-6", 0]
								}
							}
						]
					}
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "comment",
					"text": "Note-on edge detection (only fire on transitions)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [315.0, 180.0, 260.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "snapshot~ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["float"],
					"patching_rect": [30.0, 225.0, 70.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"text": "snapshot~ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["float"],
					"patching_rect": [180.0, 225.0, 70.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"text": "Sample note-on/off triggers at high rate for edge capture",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [255.0, 225.0, 300.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "newobj",
					"text": "change",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "int"],
					"patching_rect": [30.0, 255.0, 46.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"text": "change",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "int"],
					"patching_rect": [180.0, 255.0, 46.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "newobj",
					"text": "sel 0",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", ""],
					"patching_rect": [30.0, 285.0, 36.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "sel 0",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["bang", ""],
					"patching_rect": [180.0, 285.0, 36.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"text": "t i i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["int", "int"],
					"patching_rect": [48.0, 315.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "newobj",
					"text": "pack 0 0 0",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [30.0, 360.0, 120.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"text": "t i i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["int", "int"],
					"patching_rect": [198.0, 315.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "newobj",
					"text": "pack 0 0 0",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [180.0, 360.0, 120.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"text": "schedule",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [30.0, 390.0, 55.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "newobj",
					"text": "schedule",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [180.0, 390.0, 55.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "newobj",
					"text": "midiformat",
					"numinlets": 7,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [30.0, 420.0, 100.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"text": "midiformat",
					"numinlets": 7,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [180.0, 420.0, 100.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "outlet",
					"index": 1,
					"comment": "MIDI output (raw bytes to midiout)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [30.0, 480.0, 30.0, 30.0]
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
					"destination": ["obj-10", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-10", 0],
					"destination": ["obj-21", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-10", 1],
					"destination": ["obj-22", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 0],
					"destination": ["obj-24", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-22", 0],
					"destination": ["obj-25", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-24", 0],
					"destination": ["obj-26", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-25", 0],
					"destination": ["obj-27", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-26", 1],
					"destination": ["obj-30", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 0],
					"destination": ["obj-31", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-5", 0],
					"destination": ["obj-31", 2]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-31", 0],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 1],
					"destination": ["obj-31", 1],
					"order": 1
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 1],
					"destination": ["obj-32", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-32", 0],
					"destination": ["obj-33", 0],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": ["obj-32", 1],
					"destination": ["obj-33", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-5", 0],
					"destination": ["obj-33", 2]
				}
			},
			{
				"patchline": {
					"source": ["obj-31", 0],
					"destination": ["obj-40", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-33", 0],
					"destination": ["obj-41", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-40", 0],
					"destination": ["obj-42", 0]
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
					"destination": ["obj-50", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-43", 0],
					"destination": ["obj-50", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-6", 0],
					"destination": ["obj-50", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

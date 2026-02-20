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
		"rect": [100.0, 100.0, 960.0, 750.0],
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
		"description": "Sequencer core: stepcounter~, stepdiv~, stepfun~ for pitch/gate lookup per track",
		"digest": "Metropolix sequencer core",
		"tags": "",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "--- SequencerCore ---\nDual-track step sequencer using stepcounter~, stepdiv~, stepfun~.\nReceives divided phasors from ClockEngine.\nOutputs current pitch (MIDI note), gate phasor, and stage index per track.",
					"linecount": 4,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [15.0, 15.0, 450.0, 62.0]
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "inlet",
					"index": 1,
					"comment": "TRK1 divided phasor (signal)",
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
					"comment": "TRK2 divided phasor (signal)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [480.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "inlet",
					"index": 3,
					"comment": "TRK1 pulse counts message (list of ints for stepcounter~ seq)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [120.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "inlet",
					"index": 4,
					"comment": "TRK2 pulse counts message (list of ints for stepcounter~ seq)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [570.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "inlet",
					"index": 5,
					"comment": "TRK1 pitch pattern message (list of MIDI notes for stepfun~ pattern)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [210.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "inlet",
					"index": 6,
					"comment": "TRK2 pitch pattern message (list of MIDI notes for stepfun~ pattern)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [660.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "inlet",
					"index": 7,
					"comment": "TRK1 gate type pattern (list for stepfun~: 0=rest, 1=single, 2=multi, 3=hold)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [300.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "inlet",
					"index": 8,
					"comment": "TRK2 gate type pattern (list for stepfun~: 0=rest, 1=single, 2=multi, 3=hold)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [750.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "inlet",
					"index": 9,
					"comment": "TRK1 gate length (float 0.01-1.0)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [390.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "inlet",
					"index": 10,
					"comment": "TRK2 gate length (float 0.01-1.0)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [840.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "comment",
					"text": "--- TRK1 ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [30.0, 165.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "stepcounter~ @seq 1 1 1 1 1 1 1 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [30.0, 195.0, 240.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"text": "prepend seq",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [120.0, 165.0, 75.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "newobj",
					"text": "stepdiv~ @pattern 1 1 1 1 1 1 1 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [30.0, 255.0, 240.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "newobj",
					"text": "stepfun~ @pattern 60 60 60 60 60 60 60 60",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [30.0, 315.0, 280.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"text": "prepend pattern",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [210.0, 285.0, 95.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "newobj",
					"text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [30.0, 375.0, 240.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "prepend pattern",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [300.0, 345.0, 95.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "newobj",
					"text": "gen~ @title GateGenTRK1",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [30.0, 435.0, 240.0, 22.0],
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
									"text": "in 3",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [330.0, 30.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "codebox",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [30.0, 90.0, 420.0, 200.0],
									"code": "// Gate generator\n// in1 = step phasor from stepdiv~ (0-1 ramp per pulse)\n// in2 = gate type from stepfun~ (0=rest, 1=single, 2=multi, 3=hold)\n// in3 = gate length (0.01-1.0)\n//\n// out1 = gate signal (1 = gate on, 0 = gate off)\n\nphasor = in1;\ngate_type = in2;\ngate_len = clamp(in3, 0.01, 1.0);\n\n// Gate type behavior:\n// 0 = Rest: no gate output\n// 1 = Single: one gate per stage (gate on during first pulse only)\n// 2 = Multi: gate on for each pulse\n// 3 = Hold: gate stays on for entire stage duration\n\ngate_out = 0;\n\nif (gate_type < 0.5) {\n    // Rest: no gate\n    gate_out = 0;\n} else if (gate_type < 1.5) {\n    // Single: gate on when phasor < gate_len\n    gate_out = phasor < gate_len;\n} else if (gate_type < 2.5) {\n    // Multi: gate on when phasor < gate_len (per-pulse phasor from stepdiv~)\n    gate_out = phasor < gate_len;\n} else {\n    // Hold: gate always on (legato)\n    gate_out = 1;\n}\n\nout1 = gate_out;"
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "out 1",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [30.0, 330.0, 34.0, 22.0]
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"source": ["obj-1", 0],
									"destination": ["obj-4", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-2", 0],
									"destination": ["obj-4", 1]
								}
							},
							{
								"patchline": {
									"source": ["obj-3", 0],
									"destination": ["obj-4", 2]
								}
							},
							{
								"patchline": {
									"source": ["obj-4", 0],
									"destination": ["obj-5", 0]
								}
							}
						]
					}
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"text": "sig~ 0.5",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [390.0, 165.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "comment",
					"text": "--- TRK2 ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [480.0, 165.0, 100.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "newobj",
					"text": "stepcounter~ @seq 1 1 1 1 1 1 1 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [480.0, 195.0, 240.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-62",
					"maxclass": "newobj",
					"text": "prepend seq",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [570.0, 165.0, 75.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "newobj",
					"text": "stepdiv~ @pattern 1 1 1 1 1 1 1 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [480.0, 255.0, 240.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-64",
					"maxclass": "newobj",
					"text": "stepfun~ @pattern 60 60 60 60 60 60 60 60",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [480.0, 315.0, 280.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "newobj",
					"text": "prepend pattern",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [660.0, 285.0, 95.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-66",
					"maxclass": "newobj",
					"text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [480.0, 375.0, 240.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-67",
					"maxclass": "newobj",
					"text": "prepend pattern",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [750.0, 345.0, 95.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-68",
					"maxclass": "newobj",
					"text": "gen~ @title GateGenTRK2",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [480.0, 435.0, 240.0, 22.0],
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
									"text": "in 3",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [330.0, 30.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "codebox",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [30.0, 90.0, 420.0, 200.0],
									"code": "// Gate generator\n// in1 = step phasor from stepdiv~ (0-1 ramp per pulse)\n// in2 = gate type from stepfun~ (0=rest, 1=single, 2=multi, 3=hold)\n// in3 = gate length (0.01-1.0)\n//\n// out1 = gate signal (1 = gate on, 0 = gate off)\n\nphasor = in1;\ngate_type = in2;\ngate_len = clamp(in3, 0.01, 1.0);\n\n// Gate type behavior:\n// 0 = Rest: no gate output\n// 1 = Single: one gate per stage (gate on during first pulse only)\n// 2 = Multi: gate on for each pulse\n// 3 = Hold: gate stays on for entire stage duration\n\ngate_out = 0;\n\nif (gate_type < 0.5) {\n    // Rest: no gate\n    gate_out = 0;\n} else if (gate_type < 1.5) {\n    // Single: gate on when phasor < gate_len\n    gate_out = phasor < gate_len;\n} else if (gate_type < 2.5) {\n    // Multi: gate on when phasor < gate_len (per-pulse phasor from stepdiv~)\n    gate_out = phasor < gate_len;\n} else {\n    // Hold: gate always on (legato)\n    gate_out = 1;\n}\n\nout1 = gate_out;"
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "out 1",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [30.0, 330.0, 34.0, 22.0]
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"source": ["obj-1", 0],
									"destination": ["obj-4", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-2", 0],
									"destination": ["obj-4", 1]
								}
							},
							{
								"patchline": {
									"source": ["obj-3", 0],
									"destination": ["obj-4", 2]
								}
							},
							{
								"patchline": {
									"source": ["obj-4", 0],
									"destination": ["obj-5", 0]
								}
							}
						]
					}
				}
			},
			{
				"box": {
					"id": "obj-69",
					"maxclass": "newobj",
					"text": "sig~ 0.5",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [840.0, 165.0, 52.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"text": "snapshot~ 20",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["float"],
					"patching_rect": [300.0, 225.0, 75.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "newobj",
					"text": "snapshot~ 20",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["float"],
					"patching_rect": [750.0, 225.0, 75.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-80",
					"maxclass": "outlet",
					"index": 1,
					"comment": "TRK1 pitch (signal, MIDI note number)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [30.0, 510.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-81",
					"maxclass": "outlet",
					"index": 2,
					"comment": "TRK1 gate (signal, 1=on 0=off)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [120.0, 510.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-82",
					"maxclass": "outlet",
					"index": 3,
					"comment": "TRK1 stage index (message, int)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [300.0, 510.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-83",
					"maxclass": "outlet",
					"index": 4,
					"comment": "TRK2 pitch (signal, MIDI note number)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [480.0, 510.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-84",
					"maxclass": "outlet",
					"index": 5,
					"comment": "TRK2 gate (signal, 1=on 0=off)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [570.0, 510.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-85",
					"maxclass": "outlet",
					"index": 6,
					"comment": "TRK2 stage index (message, int)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [750.0, 510.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-86",
					"maxclass": "outlet",
					"index": 7,
					"comment": "TRK1 step phasor (signal, per-pulse ramp 0-1)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [210.0, 510.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-87",
					"maxclass": "outlet",
					"index": 8,
					"comment": "TRK2 step phasor (signal, per-pulse ramp 0-1)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [660.0, 510.0, 30.0, 30.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-2", 0],
					"destination": ["obj-21", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 0],
					"destination": ["obj-22", 0]
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
					"source": ["obj-2", 0],
					"destination": ["obj-23", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 0],
					"destination": ["obj-23", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-23", 0],
					"destination": ["obj-24", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-6", 0],
					"destination": ["obj-25", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-25", 0],
					"destination": ["obj-24", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-23", 0],
					"destination": ["obj-26", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-8", 0],
					"destination": ["obj-27", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-27", 0],
					"destination": ["obj-26", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-23", 0],
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
					"source": ["obj-10", 0],
					"destination": ["obj-29", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-29", 0],
					"destination": ["obj-28", 2]
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 0],
					"destination": ["obj-30", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-3", 0],
					"destination": ["obj-61", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-5", 0],
					"destination": ["obj-62", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-62", 0],
					"destination": ["obj-61", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-3", 0],
					"destination": ["obj-63", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-61", 0],
					"destination": ["obj-63", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-63", 0],
					"destination": ["obj-64", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-7", 0],
					"destination": ["obj-65", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-65", 0],
					"destination": ["obj-64", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-63", 0],
					"destination": ["obj-66", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-9", 0],
					"destination": ["obj-67", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-67", 0],
					"destination": ["obj-66", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-63", 0],
					"destination": ["obj-68", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-66", 0],
					"destination": ["obj-68", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-11", 0],
					"destination": ["obj-69", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-69", 0],
					"destination": ["obj-68", 2]
				}
			},
			{
				"patchline": {
					"source": ["obj-61", 0],
					"destination": ["obj-31", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-24", 0],
					"destination": ["obj-80", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-28", 0],
					"destination": ["obj-81", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-82", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-64", 0],
					"destination": ["obj-83", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-68", 0],
					"destination": ["obj-84", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-31", 0],
					"destination": ["obj-85", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-23", 0],
					"destination": ["obj-86", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-63", 0],
					"destination": ["obj-87", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

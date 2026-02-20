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
		"rect": [100.0, 100.0, 900.0, 700.0],
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
		"description": "Clock engine: phasor~ @lock 1, clock division, swing, edge detection",
		"digest": "Metropolix clock engine",
		"tags": "",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "--- ClockEngine ---\nMaster clock (phasor~ @lock 1), plugsync~ transport state,\ngen.codebox~ for per-track clock division + swing,\nedge detection for step triggers.",
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
					"comment": "Clock division TRK1 (int 1-64)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [30.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "inlet",
					"index": 2,
					"comment": "Swing TRK1 (int 50-78)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [120.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "inlet",
					"index": 3,
					"comment": "Clock division TRK2 (int 1-64)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [450.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "inlet",
					"index": 4,
					"comment": "Swing TRK2 (int 50-78)",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [540.0, 105.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "phasor~ 16n @lock 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [240.0, 150.0, 120.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "plugsync~",
					"numinlets": 0,
					"numoutlets": 9,
					"outlettype": ["signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal"],
					"patching_rect": [630.0, 150.0, 200.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "comment",
					"text": "plugsync~ outlet 0: transport state (1=running, 0=stopped)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [630.0, 180.0, 250.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "sig~ 1",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [30.0, 165.0, 42.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"text": "sig~ 50",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [120.0, 165.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"text": "sig~ 1",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [450.0, 165.0, 42.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"text": "sig~ 50",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [540.0, 165.0, 48.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "gen~ @title ClockDividerTRK1",
					"numinlets": 3,
					"numoutlets": 2,
					"outlettype": ["signal", "signal"],
					"patching_rect": [30.0, 240.0, 255.0, 22.0],
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
									"patching_rect": [120.0, 30.0, 30.0, 22.0]
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
									"patching_rect": [210.0, 30.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "codebox",
									"numinlets": 3,
									"numoutlets": 2,
									"outlettype": ["", ""],
									"patching_rect": [30.0, 90.0, 400.0, 200.0],
									"code": "// Clock divider with swing\n// in1 = master phasor (0-1 at 16th note rate)\n// in2 = clock division (1-64)\n// in3 = swing amount (50-78, where 50 = no swing)\n//\n// out1 = divided phasor (0-1)\n// out2 = edge trigger (1 on reset, 0 otherwise)\n\nHistory prev_phasor(0);\nHistory pulse_count(0);\nHistory divided_phase(0);\n\nmaster = in1;\ndivision = max(in2, 1);\nswing_pct = clamp(in3, 50, 78) / 100.0;\n\n// Detect master phasor reset (falling edge)\nedge = (master < 0.5) && (prev_phasor >= 0.5);\n\nif (edge) {\n    pulse_count = wrap(pulse_count + 1, 0, division);\n}\n\n// Compute divided phase\n// Each division tick advances by 1/division of the divided cycle\nraw_phase = (pulse_count + master) / division;\ndivided_phase = wrap(raw_phase, 0, 1);\n\n// Apply swing: delay odd-numbered pulses (1-indexed)\n// Swing shifts the midpoint of even/odd pairs\n// pulse_count is 0-indexed, so odd 0-indexed = even 1-indexed\nis_odd_pulse = floor(divided_phase * 2) % 2;\nswung_phase = divided_phase;\nif (is_odd_pulse > 0.5) {\n    // Compress the second half\n    half_phase = (divided_phase - 0.5) * 2;\n    swung_phase = swing_pct + half_phase * (1 - swing_pct);\n} else {\n    // Stretch the first half\n    half_phase = divided_phase * 2;\n    swung_phase = half_phase * swing_pct;\n}\n\n// Detect divided phasor reset\nHistory prev_divided(0);\ndiv_edge = (swung_phase < prev_divided - 0.5);\nprev_divided = swung_phase;\n\nprev_phasor = master;\n\nout1 = swung_phase;\nout2 = div_edge;"
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
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "out 2",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [210.0, 330.0, 34.0, 22.0]
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
							},
							{
								"patchline": {
									"source": ["obj-4", 1],
									"destination": ["obj-6", 0]
								}
							}
						]
					}
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "gen~ @title ClockDividerTRK2",
					"numinlets": 3,
					"numoutlets": 2,
					"outlettype": ["signal", "signal"],
					"patching_rect": [450.0, 240.0, 255.0, 22.0],
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
									"patching_rect": [120.0, 30.0, 30.0, 22.0]
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
									"patching_rect": [210.0, 30.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "codebox",
									"numinlets": 3,
									"numoutlets": 2,
									"outlettype": ["", ""],
									"patching_rect": [30.0, 90.0, 400.0, 200.0],
									"code": "// Clock divider with swing\n// in1 = master phasor (0-1 at 16th note rate)\n// in2 = clock division (1-64)\n// in3 = swing amount (50-78, where 50 = no swing)\n//\n// out1 = divided phasor (0-1)\n// out2 = edge trigger (1 on reset, 0 otherwise)\n\nHistory prev_phasor(0);\nHistory pulse_count(0);\nHistory divided_phase(0);\n\nmaster = in1;\ndivision = max(in2, 1);\nswing_pct = clamp(in3, 50, 78) / 100.0;\n\n// Detect master phasor reset (falling edge)\nedge = (master < 0.5) && (prev_phasor >= 0.5);\n\nif (edge) {\n    pulse_count = wrap(pulse_count + 1, 0, division);\n}\n\n// Compute divided phase\n// Each division tick advances by 1/division of the divided cycle\nraw_phase = (pulse_count + master) / division;\ndivided_phase = wrap(raw_phase, 0, 1);\n\n// Apply swing: delay odd-numbered pulses (1-indexed)\n// Swing shifts the midpoint of even/odd pairs\n// pulse_count is 0-indexed, so odd 0-indexed = even 1-indexed\nis_odd_pulse = floor(divided_phase * 2) % 2;\nswung_phase = divided_phase;\nif (is_odd_pulse > 0.5) {\n    // Compress the second half\n    half_phase = (divided_phase - 0.5) * 2;\n    swung_phase = swing_pct + half_phase * (1 - swing_pct);\n} else {\n    // Stretch the first half\n    half_phase = divided_phase * 2;\n    swung_phase = half_phase * swing_pct;\n}\n\n// Detect divided phasor reset\nHistory prev_divided(0);\ndiv_edge = (swung_phase < prev_divided - 0.5);\nprev_divided = swung_phase;\n\nprev_phasor = master;\n\nout1 = swung_phase;\nout2 = div_edge;"
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
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "out 2",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [210.0, 330.0, 34.0, 22.0]
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
							},
							{
								"patchline": {
									"source": ["obj-4", 1],
									"destination": ["obj-6", 0]
								}
							}
						]
					}
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"text": ">~ 0.5",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [630.0, 240.0, 42.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "comment",
					"text": "Transport gate: mute phasors when stopped",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [675.0, 240.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"text": "*~",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [30.0, 300.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "newobj",
					"text": "*~",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["signal"],
					"patching_rect": [450.0, 300.0, 30.0, 22.0]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "comment",
					"text": "TRK1 divided phasor",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [30.0, 360.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "comment",
					"text": "TRK1 edge trigger",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [180.0, 360.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "comment",
					"text": "TRK2 divided phasor",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [450.0, 360.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "comment",
					"text": "TRK2 edge trigger",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [600.0, 360.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "outlet",
					"index": 1,
					"comment": "TRK1 divided phasor (signal)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [30.0, 390.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "outlet",
					"index": 2,
					"comment": "TRK1 edge trigger (signal)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [180.0, 390.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "outlet",
					"index": 3,
					"comment": "TRK2 divided phasor (signal)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [450.0, 390.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "outlet",
					"index": 4,
					"comment": "TRK2 edge trigger (signal)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [600.0, 390.0, 30.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "outlet",
					"index": 5,
					"comment": "Transport state (signal: 1=playing, 0=stopped)",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [630.0, 390.0, 30.0, 30.0]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-2", 0],
					"destination": ["obj-13", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-3", 0],
					"destination": ["obj-14", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-4", 0],
					"destination": ["obj-15", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-5", 0],
					"destination": ["obj-16", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-10", 0],
					"destination": ["obj-20", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-13", 0],
					"destination": ["obj-20", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-14", 0],
					"destination": ["obj-20", 2]
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
					"source": ["obj-15", 0],
					"destination": ["obj-21", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-16", 0],
					"destination": ["obj-21", 2]
				}
			},
			{
				"patchline": {
					"source": ["obj-11", 0],
					"destination": ["obj-30", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 0],
					"destination": ["obj-32", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-32", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 0],
					"destination": ["obj-33", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-33", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-32", 0],
					"destination": ["obj-50", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 1],
					"destination": ["obj-51", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-33", 0],
					"destination": ["obj-52", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-21", 1],
					"destination": ["obj-53", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-54", 0]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}

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
		"rect": [85.0, 104.0, 750.0, 600.0],
		"bglocked": 0,
		"openinpresentation": 1,
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
		"devicewidth": 728.0,
		"description": "Metropolix - 8-stage pitch and gate sequencer inspired by Intellijel Metropolix",
		"digest": "8-stage MIDI sequencer",
		"tags": "MIDI sequencer pitch gate",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"text": "METROPOLIX",
					"fontface": 1,
					"fontsize": 12.0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 16.0, 120.0, 21.0],
					"presentation": 1,
					"presentation_rect": [8.0, 4.0, 120.0, 21.0]
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"text": "8-Stage Pitch & Gate Sequencer",
					"fontsize": 9.0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [16.0, 40.0, 200.0, 18.0],
					"presentation": 1,
					"presentation_rect": [8.0, 24.0, 200.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "newobj",
					"text": "midiin",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [560.0, 72.0, 44.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "newobj",
					"text": "midiout",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [560.0, 528.0, 48.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "newobj",
					"text": "live.thisdevice",
					"numinlets": 0,
					"numoutlets": 2,
					"outlettype": ["", ""],
					"patching_rect": [640.0, 72.0, 84.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": ["bang"],
					"patching_rect": [640.0, 104.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"text": "t b b b b",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": ["bang", "bang", "bang", "bang"],
					"patching_rect": [640.0, 128.0, 56.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "comment",
					"text": "Init: loadbang → trigger for deterministic init order",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [640.0, 152.0, 200.0, 18.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "v8 config-manager.js",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 200.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "comment",
					"text": "v8: config, scale DB, preset logic, UI state.\nNOT in timing-critical path.",
					"linecount": 2,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [640.0, 224.0, 200.0, 30.0]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "p ClockEngine",
					"numinlets": 4,
					"numoutlets": 5,
					"outlettype": ["signal", "signal", "signal", "signal", "signal"],
					"patching_rect": [16.0, 184.0, 200.0, 20.0],
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
									"text": "phasor~ 16n @lock 1",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": ["signal"],
									"patching_rect": [200.0, 60.0, 120.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "plugsync~",
									"numinlets": 0,
									"numoutlets": 9,
									"outlettype": ["signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal"],
									"patching_rect": [400.0, 60.0, 200.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "inlet",
									"index": 1,
									"comment": "Clock division TRK1",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [30.0, 30.0, 30.0, 30.0]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "inlet",
									"index": 2,
									"comment": "Swing TRK1",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [80.0, 30.0, 30.0, 30.0]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "inlet",
									"index": 3,
									"comment": "Clock division TRK2",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [130.0, 30.0, 30.0, 30.0]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "inlet",
									"index": 4,
									"comment": "Swing TRK2",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [180.0, 30.0, 30.0, 30.0]
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "newobj",
									"text": "sig~ 1",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": ["signal"],
									"patching_rect": [30.0, 90.0, 42.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-11",
									"maxclass": "newobj",
									"text": "sig~ 50",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": ["signal"],
									"patching_rect": [80.0, 90.0, 48.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-12",
									"maxclass": "newobj",
									"text": "sig~ 1",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": ["signal"],
									"patching_rect": [130.0, 90.0, 42.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "newobj",
									"text": "sig~ 50",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": ["signal"],
									"patching_rect": [180.0, 90.0, 48.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-20",
									"maxclass": "newobj",
									"text": "gen~ @title ClockDivTRK1",
									"numinlets": 3,
									"numoutlets": 2,
									"outlettype": ["signal", "signal"],
									"patching_rect": [30.0, 150.0, 160.0, 22.0],
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
													"patching_rect": [150.0, 30.0, 30.0, 22.0]
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
													"patching_rect": [270.0, 30.0, 30.0, 22.0]
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
													"code": "// Clock divider with swing\n// in1 = master phasor (0-1)\n// in2 = division (1-64)\n// in3 = swing (50-78)\n// out1 = divided phasor, out2 = edge trigger\n\nHistory prev(0);\nHistory count(0);\n\nmaster = in1;\ndiv = max(in2, 1);\nswing = clamp(in3, 50, 78) / 100.0;\n\nedge = (master < 0.5) && (prev >= 0.5);\nif (edge) { count = wrap(count + 1, 0, div); }\n\nraw = wrap((count + master) / div, 0, 1);\n\nodd = floor(raw * 2) % 2;\nswung = raw;\nif (odd > 0.5) {\n    swung = swing + (raw - 0.5) * 2 * (1 - swing);\n} else {\n    swung = raw * 2 * swing;\n}\n\nHistory pd(0);\nde = (swung < pd - 0.5);\npd = swung;\nprev = master;\n\nout1 = swung;\nout2 = de;"
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
													"patching_rect": [270.0, 330.0, 34.0, 22.0]
												}
											}
										],
										"lines": [
											{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-4", 0] } },
											{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-4", 1] } },
											{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-4", 2] } },
											{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-5", 0] } },
											{ "patchline": { "source": ["obj-4", 1], "destination": ["obj-6", 0] } }
										]
									}
								}
							},
							{
								"box": {
									"id": "obj-21",
									"maxclass": "newobj",
									"text": "gen~ @title ClockDivTRK2",
									"numinlets": 3,
									"numoutlets": 2,
									"outlettype": ["signal", "signal"],
									"patching_rect": [300.0, 150.0, 160.0, 22.0],
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
													"patching_rect": [150.0, 30.0, 30.0, 22.0]
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
													"patching_rect": [270.0, 30.0, 30.0, 22.0]
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
													"code": "// Clock divider with swing (TRK2)\nHistory prev(0);\nHistory count(0);\n\nmaster = in1;\ndiv = max(in2, 1);\nswing = clamp(in3, 50, 78) / 100.0;\n\nedge = (master < 0.5) && (prev >= 0.5);\nif (edge) { count = wrap(count + 1, 0, div); }\n\nraw = wrap((count + master) / div, 0, 1);\n\nodd = floor(raw * 2) % 2;\nswung = raw;\nif (odd > 0.5) {\n    swung = swing + (raw - 0.5) * 2 * (1 - swing);\n} else {\n    swung = raw * 2 * swing;\n}\n\nHistory pd(0);\nde = (swung < pd - 0.5);\npd = swung;\nprev = master;\n\nout1 = swung;\nout2 = de;"
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
													"patching_rect": [270.0, 330.0, 34.0, 22.0]
												}
											}
										],
										"lines": [
											{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-4", 0] } },
											{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-4", 1] } },
											{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-4", 2] } },
											{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-5", 0] } },
											{ "patchline": { "source": ["obj-4", 1], "destination": ["obj-6", 0] } }
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
									"patching_rect": [400.0, 110.0, 42.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-31",
									"maxclass": "newobj",
									"text": "*~",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": ["signal"],
									"patching_rect": [30.0, 210.0, 30.0, 22.0]
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
									"patching_rect": [300.0, 210.0, 30.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-40",
									"maxclass": "outlet",
									"index": 1,
									"comment": "TRK1 divided phasor",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [30.0, 270.0, 30.0, 30.0]
								}
							},
							{
								"box": {
									"id": "obj-41",
									"maxclass": "outlet",
									"index": 2,
									"comment": "TRK1 edge trigger",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [130.0, 270.0, 30.0, 30.0]
								}
							},
							{
								"box": {
									"id": "obj-42",
									"maxclass": "outlet",
									"index": 3,
									"comment": "TRK2 divided phasor",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [300.0, 270.0, 30.0, 30.0]
								}
							},
							{
								"box": {
									"id": "obj-43",
									"maxclass": "outlet",
									"index": 4,
									"comment": "TRK2 edge trigger",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [400.0, 270.0, 30.0, 30.0]
								}
							},
							{
								"box": {
									"id": "obj-44",
									"maxclass": "outlet",
									"index": 5,
									"comment": "Transport state",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [500.0, 270.0, 30.0, 30.0]
								}
							}
						],
						"lines": [
							{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-10", 0] } },
							{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-11", 0] } },
							{ "patchline": { "source": ["obj-5", 0], "destination": ["obj-12", 0] } },
							{ "patchline": { "source": ["obj-6", 0], "destination": ["obj-13", 0] } },
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-20", 0] } },
							{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-20", 1] } },
							{ "patchline": { "source": ["obj-11", 0], "destination": ["obj-20", 2] } },
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-21", 0] } },
							{ "patchline": { "source": ["obj-12", 0], "destination": ["obj-21", 1] } },
							{ "patchline": { "source": ["obj-13", 0], "destination": ["obj-21", 2] } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-30", 0] } },
							{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-31", 0] } },
							{ "patchline": { "source": ["obj-30", 0], "destination": ["obj-31", 1] } },
							{ "patchline": { "source": ["obj-21", 0], "destination": ["obj-32", 0] } },
							{ "patchline": { "source": ["obj-30", 0], "destination": ["obj-32", 1] } },
							{ "patchline": { "source": ["obj-31", 0], "destination": ["obj-40", 0] } },
							{ "patchline": { "source": ["obj-20", 1], "destination": ["obj-41", 0] } },
							{ "patchline": { "source": ["obj-32", 0], "destination": ["obj-42", 0] } },
							{ "patchline": { "source": ["obj-21", 1], "destination": ["obj-43", 0] } },
							{ "patchline": { "source": ["obj-30", 0], "destination": ["obj-44", 0] } }
						],
						"saved_object_attributes": {
							"globalpatchername": ""
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"text": "p SequencerCore",
					"numinlets": 10,
					"numoutlets": 8,
					"outlettype": ["signal", "signal", "", "signal", "signal", "", "signal", "signal"],
					"patching_rect": [16.0, 264.0, 400.0, 20.0],
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
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"assistshowspatchername": 0,
						"boxes": [
							{
								"box": { "id": "obj-1", "maxclass": "inlet", "index": 1, "comment": "TRK1 phasor", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-2", "maxclass": "inlet", "index": 2, "comment": "TRK2 phasor", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-3", "maxclass": "inlet", "index": 3, "comment": "TRK1 pulse counts", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [120.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-4", "maxclass": "inlet", "index": 4, "comment": "TRK2 pulse counts", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [570.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-5", "maxclass": "inlet", "index": 5, "comment": "TRK1 pitches", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [210.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-6", "maxclass": "inlet", "index": 6, "comment": "TRK2 pitches", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [660.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-7", "maxclass": "inlet", "index": 7, "comment": "TRK1 gate types", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [300.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-8", "maxclass": "inlet", "index": 8, "comment": "TRK2 gate types", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [750.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-9", "maxclass": "inlet", "index": 9, "comment": "TRK1 gate len", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [390.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-10", "maxclass": "inlet", "index": 10, "comment": "TRK2 gate len", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [840.0, 30.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-20", "maxclass": "newobj", "text": "stepcounter~ @seq 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 120.0, 240.0, 22.0] }
							},
							{
								"box": { "id": "obj-21", "maxclass": "newobj", "text": "prepend seq", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [120.0, 90.0, 75.0, 22.0] }
							},
							{
								"box": { "id": "obj-22", "maxclass": "newobj", "text": "stepdiv~ @pattern 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 180.0, 240.0, 22.0] }
							},
							{
								"box": { "id": "obj-23", "maxclass": "newobj", "text": "stepfun~ @pattern 60 60 60 60 60 60 60 60", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 240.0, 280.0, 22.0] }
							},
							{
								"box": { "id": "obj-24", "maxclass": "newobj", "text": "prepend pattern", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [210.0, 210.0, 95.0, 22.0] }
							},
							{
								"box": { "id": "obj-25", "maxclass": "newobj", "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 300.0, 240.0, 22.0] }
							},
							{
								"box": { "id": "obj-26", "maxclass": "newobj", "text": "prepend pattern", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [300.0, 270.0, 95.0, 22.0] }
							},
							{
								"box": { "id": "obj-27", "maxclass": "newobj", "text": "sig~ 0.5", "numinlets": 1, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [390.0, 90.0, 52.0, 22.0] }
							},
							{
								"box": {
									"id": "obj-28",
									"maxclass": "newobj",
									"text": "gen~ @title GateGenT1",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": ["signal"],
									"patching_rect": [30.0, 360.0, 220.0, 22.0],
									"patcher": {
										"fileversion": 1,
										"appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
										"classnamespace": "dsp.gen",
										"rect": [100.0, 100.0, 640.0, 480.0],
										"bglocked": 0, "openinpresentation": 0, "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
										"gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1, "objectsnaponopen": 1,
										"statusbarvisible": 2, "toolbarvisible": 1,
										"lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
										"enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0,
										"description": "", "digest": "", "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
										"boxes": [
											{ "box": { "id": "obj-1", "maxclass": "newobj", "text": "in 1", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "in 2", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [180.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-3", "maxclass": "newobj", "text": "in 3", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [330.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-4", "maxclass": "newobj", "text": "codebox", "numinlets": 3, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 90.0, 400.0, 180.0], "code": "// Gate generator\nphasor = in1;\ngt = in2;\ngl = clamp(in3, 0.01, 1.0);\n\ngate = 0;\nif (gt < 0.5) { gate = 0; }\nelse if (gt < 1.5) { gate = phasor < gl; }\nelse if (gt < 2.5) { gate = phasor < gl; }\nelse { gate = 1; }\n\nout1 = gate;" } },
											{ "box": { "id": "obj-5", "maxclass": "newobj", "text": "out 1", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 300.0, 34.0, 22.0] } }
										],
										"lines": [
											{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-4", 0] } },
											{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-4", 1] } },
											{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-4", 2] } },
											{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-5", 0] } }
										]
									}
								}
							},
							{
								"box": { "id": "obj-29", "maxclass": "newobj", "text": "snapshot~ 20", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [300.0, 150.0, 75.0, 22.0] }
							},
							{
								"box": { "id": "obj-50", "maxclass": "newobj", "text": "stepcounter~ @seq 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 120.0, 240.0, 22.0] }
							},
							{
								"box": { "id": "obj-51", "maxclass": "newobj", "text": "prepend seq", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [570.0, 90.0, 75.0, 22.0] }
							},
							{
								"box": { "id": "obj-52", "maxclass": "newobj", "text": "stepdiv~ @pattern 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 180.0, 240.0, 22.0] }
							},
							{
								"box": { "id": "obj-53", "maxclass": "newobj", "text": "stepfun~ @pattern 60 60 60 60 60 60 60 60", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 240.0, 280.0, 22.0] }
							},
							{
								"box": { "id": "obj-54", "maxclass": "newobj", "text": "prepend pattern", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [660.0, 210.0, 95.0, 22.0] }
							},
							{
								"box": { "id": "obj-55", "maxclass": "newobj", "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 300.0, 240.0, 22.0] }
							},
							{
								"box": { "id": "obj-56", "maxclass": "newobj", "text": "prepend pattern", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [750.0, 270.0, 95.0, 22.0] }
							},
							{
								"box": { "id": "obj-57", "maxclass": "newobj", "text": "sig~ 0.5", "numinlets": 1, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [840.0, 90.0, 52.0, 22.0] }
							},
							{
								"box": {
									"id": "obj-58",
									"maxclass": "newobj",
									"text": "gen~ @title GateGenT2",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": ["signal"],
									"patching_rect": [480.0, 360.0, 220.0, 22.0],
									"patcher": {
										"fileversion": 1,
										"appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
										"classnamespace": "dsp.gen",
										"rect": [100.0, 100.0, 640.0, 480.0],
										"bglocked": 0, "openinpresentation": 0, "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
										"gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1, "objectsnaponopen": 1,
										"statusbarvisible": 2, "toolbarvisible": 1,
										"lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
										"enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0,
										"description": "", "digest": "", "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
										"boxes": [
											{ "box": { "id": "obj-1", "maxclass": "newobj", "text": "in 1", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "in 2", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [180.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-3", "maxclass": "newobj", "text": "in 3", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [330.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-4", "maxclass": "newobj", "text": "codebox", "numinlets": 3, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 90.0, 400.0, 180.0], "code": "// Gate generator (TRK2)\nphasor = in1;\ngt = in2;\ngl = clamp(in3, 0.01, 1.0);\n\ngate = 0;\nif (gt < 0.5) { gate = 0; }\nelse if (gt < 1.5) { gate = phasor < gl; }\nelse if (gt < 2.5) { gate = phasor < gl; }\nelse { gate = 1; }\n\nout1 = gate;" } },
											{ "box": { "id": "obj-5", "maxclass": "newobj", "text": "out 1", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 300.0, 34.0, 22.0] } }
										],
										"lines": [
											{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-4", 0] } },
											{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-4", 1] } },
											{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-4", 2] } },
											{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-5", 0] } }
										]
									}
								}
							},
							{
								"box": { "id": "obj-59", "maxclass": "newobj", "text": "snapshot~ 20", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [750.0, 150.0, 75.0, 22.0] }
							},
							{
								"box": { "id": "obj-70", "maxclass": "outlet", "index": 1, "comment": "TRK1 pitch", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 420.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-71", "maxclass": "outlet", "index": 2, "comment": "TRK1 gate", "numinlets": 1, "numoutlets": 0, "patching_rect": [120.0, 420.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-72", "maxclass": "outlet", "index": 3, "comment": "TRK1 stage idx", "numinlets": 1, "numoutlets": 0, "patching_rect": [300.0, 420.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-73", "maxclass": "outlet", "index": 4, "comment": "TRK2 pitch", "numinlets": 1, "numoutlets": 0, "patching_rect": [480.0, 420.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-74", "maxclass": "outlet", "index": 5, "comment": "TRK2 gate", "numinlets": 1, "numoutlets": 0, "patching_rect": [570.0, 420.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-75", "maxclass": "outlet", "index": 6, "comment": "TRK2 stage idx", "numinlets": 1, "numoutlets": 0, "patching_rect": [750.0, 420.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-76", "maxclass": "outlet", "index": 7, "comment": "TRK1 step phasor", "numinlets": 1, "numoutlets": 0, "patching_rect": [210.0, 420.0, 30.0, 30.0] }
							},
							{
								"box": { "id": "obj-77", "maxclass": "outlet", "index": 8, "comment": "TRK2 step phasor", "numinlets": 1, "numoutlets": 0, "patching_rect": [660.0, 420.0, 30.0, 30.0] }
							}
						],
						"lines": [
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-20", 0] } },
							{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-21", 0] } },
							{ "patchline": { "source": ["obj-21", 0], "destination": ["obj-20", 0] } },
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-22", 0] } },
							{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-22", 1] } },
							{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-29", 0] } },
							{ "patchline": { "source": ["obj-22", 0], "destination": ["obj-23", 0] } },
							{ "patchline": { "source": ["obj-5", 0], "destination": ["obj-24", 0] } },
							{ "patchline": { "source": ["obj-24", 0], "destination": ["obj-23", 0] } },
							{ "patchline": { "source": ["obj-22", 0], "destination": ["obj-25", 0] } },
							{ "patchline": { "source": ["obj-7", 0], "destination": ["obj-26", 0] } },
							{ "patchline": { "source": ["obj-26", 0], "destination": ["obj-25", 0] } },
							{ "patchline": { "source": ["obj-9", 0], "destination": ["obj-27", 0] } },
							{ "patchline": { "source": ["obj-22", 0], "destination": ["obj-28", 0] } },
							{ "patchline": { "source": ["obj-25", 0], "destination": ["obj-28", 1] } },
							{ "patchline": { "source": ["obj-27", 0], "destination": ["obj-28", 2] } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-50", 0] } },
							{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-51", 0] } },
							{ "patchline": { "source": ["obj-51", 0], "destination": ["obj-50", 0] } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-52", 0] } },
							{ "patchline": { "source": ["obj-50", 0], "destination": ["obj-52", 1] } },
							{ "patchline": { "source": ["obj-50", 0], "destination": ["obj-59", 0] } },
							{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-53", 0] } },
							{ "patchline": { "source": ["obj-6", 0], "destination": ["obj-54", 0] } },
							{ "patchline": { "source": ["obj-54", 0], "destination": ["obj-53", 0] } },
							{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-55", 0] } },
							{ "patchline": { "source": ["obj-8", 0], "destination": ["obj-56", 0] } },
							{ "patchline": { "source": ["obj-56", 0], "destination": ["obj-55", 0] } },
							{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-57", 0] } },
							{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-58", 0] } },
							{ "patchline": { "source": ["obj-55", 0], "destination": ["obj-58", 1] } },
							{ "patchline": { "source": ["obj-57", 0], "destination": ["obj-58", 2] } },
							{ "patchline": { "source": ["obj-23", 0], "destination": ["obj-70", 0] } },
							{ "patchline": { "source": ["obj-28", 0], "destination": ["obj-71", 0] } },
							{ "patchline": { "source": ["obj-29", 0], "destination": ["obj-72", 0] } },
							{ "patchline": { "source": ["obj-53", 0], "destination": ["obj-73", 0] } },
							{ "patchline": { "source": ["obj-58", 0], "destination": ["obj-74", 0] } },
							{ "patchline": { "source": ["obj-59", 0], "destination": ["obj-75", 0] } },
							{ "patchline": { "source": ["obj-22", 0], "destination": ["obj-76", 0] } },
							{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-77", 0] } }
						],
						"saved_object_attributes": {
							"globalpatchername": ""
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"text": "p Track1Output",
					"numinlets": 5,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [16.0, 344.0, 200.0, 20.0],
					"patcher": {
						"fileversion": 1,
						"appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
						"classnamespace": "box",
						"rect": [100.0, 100.0, 700.0, 550.0],
						"bglocked": 0, "openinpresentation": 0, "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
						"gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1, "objectsnaponopen": 1,
						"statusbarvisible": 2, "toolbarvisible": 1,
						"lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
						"enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0,
						"description": "", "digest": "", "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
						"boxes": [
							{ "box": { "id": "obj-1", "maxclass": "inlet", "index": 1, "comment": "Pitch signal", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-2", "maxclass": "inlet", "index": 2, "comment": "Gate signal", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [150.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-3", "maxclass": "inlet", "index": 3, "comment": "Velocity", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [270.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-4", "maxclass": "inlet", "index": 4, "comment": "MIDI channel", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [390.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-5", "maxclass": "inlet", "index": 5, "comment": "MIDI thru", "numinlets": 0, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [510.0, 30.0, 30.0, 30.0] } },
							{
								"box": {
									"id": "obj-10",
									"maxclass": "newobj",
									"text": "gen~ @title NoteEdge",
									"numinlets": 2,
									"numoutlets": 3,
									"outlettype": ["signal", "signal", "signal"],
									"patching_rect": [30.0, 90.0, 200.0, 22.0],
									"patcher": {
										"fileversion": 1,
										"appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
										"classnamespace": "dsp.gen",
										"rect": [100.0, 100.0, 640.0, 480.0],
										"bglocked": 0, "openinpresentation": 0, "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
										"gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1, "objectsnaponopen": 1,
										"statusbarvisible": 2, "toolbarvisible": 1,
										"lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
										"enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0,
										"description": "", "digest": "", "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
										"boxes": [
											{ "box": { "id": "obj-1", "maxclass": "newobj", "text": "in 1", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "in 2", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [180.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-3", "maxclass": "newobj", "text": "codebox", "numinlets": 2, "numoutlets": 3, "outlettype": ["", "", ""], "patching_rect": [30.0, 90.0, 400.0, 200.0], "code": "// Note edge detector\nHistory prev_gate(0);\nHistory held_pitch(0);\n\npitch = round(clamp(in1, 0, 127));\ngate = in2;\n\nnote_on = 0;\nnote_off = 0;\n\nif (gate > 0.5 && prev_gate < 0.5) {\n    note_on = pitch;\n    held_pitch = pitch;\n}\nif (gate < 0.5 && prev_gate > 0.5) {\n    note_off = held_pitch;\n}\nif (gate > 0.5 && prev_gate > 0.5 && pitch != held_pitch) {\n    note_off = held_pitch;\n    note_on = pitch;\n    held_pitch = pitch;\n}\n\nprev_gate = gate;\nout1 = note_on;\nout2 = note_off;\nout3 = held_pitch;" } },
											{ "box": { "id": "obj-4", "maxclass": "newobj", "text": "out 1", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 330.0, 34.0, 22.0] } },
											{ "box": { "id": "obj-5", "maxclass": "newobj", "text": "out 2", "numinlets": 1, "numoutlets": 0, "patching_rect": [180.0, 330.0, 34.0, 22.0] } },
											{ "box": { "id": "obj-6", "maxclass": "newobj", "text": "out 3", "numinlets": 1, "numoutlets": 0, "patching_rect": [330.0, 330.0, 34.0, 22.0] } }
										],
										"lines": [
											{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-3", 0] } },
											{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-3", 1] } },
											{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-4", 0] } },
											{ "patchline": { "source": ["obj-3", 1], "destination": ["obj-5", 0] } },
											{ "patchline": { "source": ["obj-3", 2], "destination": ["obj-6", 0] } }
										]
									}
								}
							},
							{ "box": { "id": "obj-20", "maxclass": "newobj", "text": "snapshot~ 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [30.0, 130.0, 70.0, 22.0] } },
							{ "box": { "id": "obj-21", "maxclass": "newobj", "text": "snapshot~ 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [150.0, 130.0, 70.0, 22.0] } },
							{ "box": { "id": "obj-22", "maxclass": "newobj", "text": "change", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "int"], "patching_rect": [30.0, 160.0, 46.0, 22.0] } },
							{ "box": { "id": "obj-23", "maxclass": "newobj", "text": "change", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "int"], "patching_rect": [150.0, 160.0, 46.0, 22.0] } },
							{ "box": { "id": "obj-24", "maxclass": "newobj", "text": "sel 0", "numinlets": 1, "numoutlets": 2, "outlettype": ["bang", ""], "patching_rect": [30.0, 190.0, 36.0, 22.0] } },
							{ "box": { "id": "obj-25", "maxclass": "newobj", "text": "sel 0", "numinlets": 1, "numoutlets": 2, "outlettype": ["bang", ""], "patching_rect": [150.0, 190.0, 36.0, 22.0] } },
							{ "box": { "id": "obj-30", "maxclass": "newobj", "text": "pack 0 0 0", "numinlets": 3, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 260.0, 120.0, 22.0] } },
							{ "box": { "id": "obj-31", "maxclass": "newobj", "text": "pack 0 0 0", "numinlets": 3, "numoutlets": 1, "outlettype": [""], "patching_rect": [150.0, 260.0, 120.0, 22.0] } },
							{ "box": { "id": "obj-32", "maxclass": "newobj", "text": "schedule", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 290.0, 55.0, 22.0] } },
							{ "box": { "id": "obj-33", "maxclass": "newobj", "text": "schedule", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [150.0, 290.0, 55.0, 22.0] } },
							{ "box": { "id": "obj-34", "maxclass": "newobj", "text": "midiformat", "numinlets": 7, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [30.0, 330.0, 100.0, 22.0] } },
							{ "box": { "id": "obj-35", "maxclass": "newobj", "text": "midiformat", "numinlets": 7, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [150.0, 330.0, 100.0, 22.0] } },
							{ "box": { "id": "obj-40", "maxclass": "outlet", "index": 1, "comment": "MIDI out", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 390.0, 30.0, 30.0] } }
						],
						"lines": [
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-10", 0] } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-10", 1] } },
							{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-20", 0] } },
							{ "patchline": { "source": ["obj-10", 1], "destination": ["obj-21", 0] } },
							{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-22", 0] } },
							{ "patchline": { "source": ["obj-21", 0], "destination": ["obj-23", 0] } },
							{ "patchline": { "source": ["obj-22", 0], "destination": ["obj-24", 0] } },
							{ "patchline": { "source": ["obj-23", 0], "destination": ["obj-25", 0] } },
							{ "patchline": { "source": ["obj-24", 1], "destination": ["obj-30", 0] } },
							{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-30", 1] } },
							{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-30", 2] } },
							{ "patchline": { "source": ["obj-25", 1], "destination": ["obj-31", 0] } },
							{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-31", 2] } },
							{ "patchline": { "source": ["obj-30", 0], "destination": ["obj-32", 0] } },
							{ "patchline": { "source": ["obj-31", 0], "destination": ["obj-33", 0] } },
							{ "patchline": { "source": ["obj-32", 0], "destination": ["obj-34", 0] } },
							{ "patchline": { "source": ["obj-33", 0], "destination": ["obj-35", 0] } },
							{ "patchline": { "source": ["obj-34", 0], "destination": ["obj-40", 0] } },
							{ "patchline": { "source": ["obj-35", 0], "destination": ["obj-40", 0] } },
							{ "patchline": { "source": ["obj-5", 0], "destination": ["obj-40", 0] } }
						],
						"saved_object_attributes": {
							"globalpatchername": ""
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "newobj",
					"text": "p Track2Output",
					"numinlets": 3,
					"numoutlets": 0,
					"patching_rect": [280.0, 344.0, 200.0, 20.0],
					"patcher": {
						"fileversion": 1,
						"appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
						"classnamespace": "box",
						"rect": [100.0, 100.0, 500.0, 400.0],
						"bglocked": 0, "openinpresentation": 0, "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
						"gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1, "objectsnaponopen": 1,
						"statusbarvisible": 2, "toolbarvisible": 1,
						"lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
						"enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0,
						"description": "", "digest": "", "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
						"boxes": [
							{ "box": { "id": "obj-1", "maxclass": "inlet", "index": 1, "comment": "TRK2 pitch signal", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-2", "maxclass": "inlet", "index": 2, "comment": "TRK2 gate signal", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [150.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-3", "maxclass": "inlet", "index": 3, "comment": "TRK2 velocity", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [270.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-10", "maxclass": "newobj", "text": "snapshot~ 30", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [30.0, 90.0, 75.0, 22.0] } },
							{ "box": { "id": "obj-11", "maxclass": "newobj", "text": "snapshot~ 30", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [150.0, 90.0, 75.0, 22.0] } },
							{ "box": { "id": "obj-12", "maxclass": "newobj", "text": "/ 127.", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [30.0, 120.0, 38.0, 22.0] } },
							{ "box": { "id": "obj-13", "maxclass": "newobj", "text": "/ 127.", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [270.0, 90.0, 38.0, 22.0] } },
							{ "box": { "id": "obj-14", "maxclass": "newobj", "text": "clip 0. 1.", "numinlets": 3, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 150.0, 60.0, 22.0] } },
							{ "box": { "id": "obj-15", "maxclass": "newobj", "text": "clip 0. 1.", "numinlets": 3, "numoutlets": 1, "outlettype": [""], "patching_rect": [270.0, 120.0, 60.0, 22.0] } },
							{
								"box": {
									"id": "obj-20",
									"maxclass": "live.dial",
									"numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"],
									"parameter_enable": 1,
									"patching_rect": [30.0, 195.0, 44.0, 48.0],
									"saved_attribute_attributes": {
										"valueof": {
											"parameter_longname": "TRK2 Pitch",
											"parameter_shortname": "T2 Pitch",
											"parameter_type": 0,
											"parameter_mmax": 1.0, "parameter_mmin": 0.0,
											"parameter_initial_enable": 1, "parameter_initial": [0.0],
											"parameter_unitstyle": 1, "parameter_linknames": 1
										}
									},
									"varname": "TRK2 Pitch"
								}
							},
							{
								"box": {
									"id": "obj-21",
									"maxclass": "live.dial",
									"numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"],
									"parameter_enable": 1,
									"patching_rect": [150.0, 195.0, 44.0, 48.0],
									"saved_attribute_attributes": {
										"valueof": {
											"parameter_longname": "TRK2 Gate",
											"parameter_shortname": "T2 Gate",
											"parameter_type": 0,
											"parameter_mmax": 1.0, "parameter_mmin": 0.0,
											"parameter_initial_enable": 1, "parameter_initial": [0.0],
											"parameter_unitstyle": 1, "parameter_linknames": 1
										}
									},
									"varname": "TRK2 Gate"
								}
							},
							{
								"box": {
									"id": "obj-22",
									"maxclass": "live.dial",
									"numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"],
									"parameter_enable": 1,
									"patching_rect": [270.0, 195.0, 44.0, 48.0],
									"saved_attribute_attributes": {
										"valueof": {
											"parameter_longname": "TRK2 Velocity",
											"parameter_shortname": "T2 Vel",
											"parameter_type": 0,
											"parameter_mmax": 1.0, "parameter_mmin": 0.0,
											"parameter_initial_enable": 1, "parameter_initial": [0.0],
											"parameter_unitstyle": 1, "parameter_linknames": 1
										}
									},
									"varname": "TRK2 Velocity"
								}
							}
						],
						"lines": [
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-10", 0] } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-11", 0] } },
							{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-12", 0] } },
							{ "patchline": { "source": ["obj-12", 0], "destination": ["obj-14", 0] } },
							{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-13", 0] } },
							{ "patchline": { "source": ["obj-13", 0], "destination": ["obj-15", 0] } },
							{ "patchline": { "source": ["obj-14", 0], "destination": ["obj-20", 0] } },
							{ "patchline": { "source": ["obj-11", 0], "destination": ["obj-21", 0] } },
							{ "patchline": { "source": ["obj-15", 0], "destination": ["obj-22", 0] } }
						],
						"saved_object_attributes": {
							"globalpatchername": ""
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-100",
					"maxclass": "live.slider",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [16.0, 424.0, 40.0, 95.0],
					"presentation": 1,
					"presentation_rect": [8.0, 48.0, 36.0, 95.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Stage 1 Pitch",
							"parameter_shortname": "1",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.5],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "Stage 1 Pitch"
				}
			},
			{
				"box": {
					"id": "obj-101",
					"maxclass": "live.slider",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [64.0, 424.0, 40.0, 95.0],
					"presentation": 1,
					"presentation_rect": [52.0, 48.0, 36.0, 95.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Stage 2 Pitch",
							"parameter_shortname": "2",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.5],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "Stage 2 Pitch"
				}
			},
			{
				"box": {
					"id": "obj-102",
					"maxclass": "live.slider",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [112.0, 424.0, 40.0, 95.0],
					"presentation": 1,
					"presentation_rect": [96.0, 48.0, 36.0, 95.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Stage 3 Pitch",
							"parameter_shortname": "3",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.5],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "Stage 3 Pitch"
				}
			},
			{
				"box": {
					"id": "obj-103",
					"maxclass": "live.slider",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [160.0, 424.0, 40.0, 95.0],
					"presentation": 1,
					"presentation_rect": [140.0, 48.0, 36.0, 95.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Stage 4 Pitch",
							"parameter_shortname": "4",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.5],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "Stage 4 Pitch"
				}
			},
			{
				"box": {
					"id": "obj-104",
					"maxclass": "live.slider",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [208.0, 424.0, 40.0, 95.0],
					"presentation": 1,
					"presentation_rect": [184.0, 48.0, 36.0, 95.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Stage 5 Pitch",
							"parameter_shortname": "5",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.5],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "Stage 5 Pitch"
				}
			},
			{
				"box": {
					"id": "obj-105",
					"maxclass": "live.slider",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [256.0, 424.0, 40.0, 95.0],
					"presentation": 1,
					"presentation_rect": [228.0, 48.0, 36.0, 95.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Stage 6 Pitch",
							"parameter_shortname": "6",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.5],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "Stage 6 Pitch"
				}
			},
			{
				"box": {
					"id": "obj-106",
					"maxclass": "live.slider",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [304.0, 424.0, 40.0, 95.0],
					"presentation": 1,
					"presentation_rect": [272.0, 48.0, 36.0, 95.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Stage 7 Pitch",
							"parameter_shortname": "7",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.5],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "Stage 7 Pitch"
				}
			},
			{
				"box": {
					"id": "obj-107",
					"maxclass": "live.slider",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [352.0, 424.0, 40.0, 95.0],
					"presentation": 1,
					"presentation_rect": [316.0, 48.0, 36.0, 95.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Stage 8 Pitch",
							"parameter_shortname": "8",
							"parameter_type": 0,
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [0.5],
							"parameter_unitstyle": 1,
							"parameter_linknames": 1
						}
					},
					"varname": "Stage 8 Pitch"
				}
			},
			{
				"box": {
					"id": "obj-110",
					"maxclass": "live.tab",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["", "", "float"],
					"parameter_enable": 1,
					"patching_rect": [424.0, 424.0, 100.0, 20.0],
					"presentation": 1,
					"presentation_rect": [368.0, 48.0, 100.0, 20.0],
					"num_lines_patching": 1,
					"num_lines_presentation": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Track Select",
							"parameter_shortname": "Track",
							"parameter_type": 2,
							"parameter_enum": ["TRK1", "TRK2"],
							"parameter_initial_enable": 1,
							"parameter_initial": [0],
							"parameter_linknames": 1
						}
					},
					"varname": "Track Select"
				}
			},
			{
				"box": {
					"id": "obj-111",
					"maxclass": "live.menu",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["", "", "float"],
					"parameter_enable": 1,
					"patching_rect": [424.0, 456.0, 100.0, 15.0],
					"presentation": 1,
					"presentation_rect": [368.0, 80.0, 100.0, 15.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Playback Order",
							"parameter_shortname": "Order",
							"parameter_type": 2,
							"parameter_enum": ["Linear", "Ping Pong", "Pendulum", "Random", "Shuffle", "Brownian", "Converge", "Diverge", "Pedal Point", "Hopscotch"],
							"parameter_initial_enable": 1,
							"parameter_initial": [0],
							"parameter_linknames": 1
						}
					},
					"varname": "Playback Order"
				}
			},
			{
				"box": {
					"id": "obj-112",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [424.0, 488.0, 44.0, 48.0],
					"presentation": 1,
					"presentation_rect": [368.0, 104.0, 44.0, 48.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Clock Division",
							"parameter_shortname": "Div",
							"parameter_type": 1,
							"parameter_mmax": 64.0,
							"parameter_mmin": 1.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [1],
							"parameter_unitstyle": 0,
							"parameter_linknames": 1
						}
					},
					"varname": "Clock Division"
				}
			},
			{
				"box": {
					"id": "obj-113",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [480.0, 488.0, 44.0, 48.0],
					"presentation": 1,
					"presentation_rect": [424.0, 104.0, 44.0, 48.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Swing",
							"parameter_shortname": "Swing",
							"parameter_type": 1,
							"parameter_mmax": 78.0,
							"parameter_mmin": 50.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [50],
							"parameter_unitstyle": 5,
							"parameter_linknames": 1
						}
					},
					"varname": "Swing"
				}
			},
			{
				"box": {
					"id": "obj-114",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [536.0, 488.0, 44.0, 48.0],
					"presentation": 1,
					"presentation_rect": [480.0, 104.0, 44.0, 48.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Stages Length",
							"parameter_shortname": "Len",
							"parameter_type": 1,
							"parameter_mmax": 8.0,
							"parameter_mmin": 1.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [8],
							"parameter_unitstyle": 0,
							"parameter_linknames": 1
						}
					},
					"varname": "Stages Length"
				}
			},
			{
				"box": {
					"id": "obj-115",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": ["", "float"],
					"parameter_enable": 1,
					"patching_rect": [424.0, 544.0, 44.0, 48.0],
					"presentation": 1,
					"presentation_rect": [536.0, 104.0, 44.0, 48.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Gate Length",
							"parameter_shortname": "Gate",
							"parameter_type": 1,
							"parameter_mmax": 100.0,
							"parameter_mmin": 1.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [50],
							"parameter_unitstyle": 5,
							"parameter_linknames": 1
						}
					},
					"varname": "Gate Length"
				}
			},
			{
				"box": {
					"id": "obj-116",
					"maxclass": "live.menu",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["", "", "float"],
					"parameter_enable": 1,
					"patching_rect": [480.0, 544.0, 100.0, 15.0],
					"presentation": 1,
					"presentation_rect": [592.0, 104.0, 100.0, 15.0],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Root Note",
							"parameter_shortname": "Root",
							"parameter_type": 2,
							"parameter_enum": ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"],
							"parameter_initial_enable": 1,
							"parameter_initial": [0],
							"parameter_linknames": 1
						}
					},
					"varname": "Root Note"
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": ["obj-20", 0],
					"destination": ["obj-30", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-20", 2],
					"destination": ["obj-30", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 0],
					"destination": ["obj-40", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 1],
					"destination": ["obj-40", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 3],
					"destination": ["obj-50", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-30", 4],
					"destination": ["obj-50", 1]
				}
			},
			{
				"patchline": {
					"source": ["obj-40", 0],
					"destination": ["obj-4", 0]
				}
			},
			{
				"patchline": {
					"source": ["obj-3", 0],
					"destination": ["obj-40", 4]
				}
			}
		],
		"parameters": {
			"obj-100": ["Stage 1 Pitch", "1", 0],
			"obj-101": ["Stage 2 Pitch", "2", 0],
			"obj-102": ["Stage 3 Pitch", "3", 0],
			"obj-103": ["Stage 4 Pitch", "4", 0],
			"obj-104": ["Stage 5 Pitch", "5", 0],
			"obj-105": ["Stage 6 Pitch", "6", 0],
			"obj-106": ["Stage 7 Pitch", "7", 0],
			"obj-107": ["Stage 8 Pitch", "8", 0],
			"obj-110": ["Track Select", "Track", 0],
			"obj-111": ["Playback Order", "Order", 0],
			"obj-112": ["Clock Division", "Div", 0],
			"obj-113": ["Swing", "Swing", 0],
			"obj-114": ["Stages Length", "Len", 0],
			"obj-115": ["Gate Length", "Gate", 0],
			"obj-116": ["Root Note", "Root", 0],
			"parameterbanks": {}
		},
		"dependency_cache": [],
		"autosave": 0
	}
}

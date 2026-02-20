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
					"numinlets": 1,
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
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": ["bang", "bang", "bang"],
					"patching_rect": [640.0, 128.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"text": "v8 config-manager.js",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 176.0, 120.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "route pitches_trk1 pitches_trk2 pulses_trk1 pulses_trk2 gatetypes_trk1 gatetypes_trk2",
					"numinlets": 1,
					"numoutlets": 7,
					"outlettype": ["", "", "", "", "", "", ""],
					"patching_rect": [640.0, 208.0, 200.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "prepend init",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 152.0, 68.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "prepend pattern",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 240.0, 90.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "prepend pattern",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 272.0, 90.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "prepend seq",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 304.0, 68.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"text": "prepend seq",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 336.0, 68.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"text": "prepend pattern",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 368.0, 90.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"text": "prepend pattern",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [640.0, 400.0, 90.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"text": "i 100",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [440.0, 312.0, 32.0, 20.0]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"text": "i 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [480.0, 312.0, 24.0, 20.0]
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
						"appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
						"classnamespace": "box",
						"rect": [100.0, 100.0, 900.0, 700.0],
						"bglocked": 0, "openinpresentation": 0, "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
						"gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1, "objectsnaponopen": 1,
						"statusbarvisible": 2, "toolbarvisible": 1,
						"lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
						"enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0,
						"description": "", "digest": "", "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
						"boxes": [
							{ "box": { "id": "obj-1", "maxclass": "newobj", "text": "phasor~ 16n @lock 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [200.0, 60.0, 120.0, 22.0] } },
							{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "plugsync~", "numinlets": 0, "numoutlets": 9, "outlettype": ["signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal"], "patching_rect": [400.0, 60.0, 200.0, 22.0] } },
							{ "box": { "id": "obj-3", "maxclass": "inlet", "index": 1, "comment": "Clock division TRK1", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-4", "maxclass": "inlet", "index": 2, "comment": "Swing TRK1", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [80.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-5", "maxclass": "inlet", "index": 3, "comment": "Clock division TRK2", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [130.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-6", "maxclass": "inlet", "index": 4, "comment": "Swing TRK2", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [180.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-10", "maxclass": "newobj", "text": "sig~ 1", "numinlets": 1, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 90.0, 42.0, 22.0] } },
							{ "box": { "id": "obj-11", "maxclass": "newobj", "text": "sig~ 50", "numinlets": 1, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [80.0, 90.0, 48.0, 22.0] } },
							{ "box": { "id": "obj-12", "maxclass": "newobj", "text": "sig~ 1", "numinlets": 1, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [130.0, 90.0, 42.0, 22.0] } },
							{ "box": { "id": "obj-13", "maxclass": "newobj", "text": "sig~ 50", "numinlets": 1, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [180.0, 90.0, 48.0, 22.0] } },
							{
								"box": {
									"id": "obj-20", "maxclass": "newobj", "text": "gen~ @title ClockDivTRK1", "numinlets": 3, "numoutlets": 2, "outlettype": ["signal", "signal"],
									"patching_rect": [30.0, 150.0, 160.0, 22.0],
									"patcher": {
										"fileversion": 1, "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
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
											{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "in 2", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [150.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-3", "maxclass": "newobj", "text": "in 3", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [270.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-4", "maxclass": "newobj", "text": "codebox", "numinlets": 3, "numoutlets": 2, "outlettype": ["", ""], "patching_rect": [30.0, 90.0, 400.0, 200.0], "code": "// Clock divider with swing\n// in1=phasor in2=division(1-64) in3=swing(50-78)\n// out1=divided phasor out2=edge trigger\n\nHistory prev(0);\nHistory count(0);\n\nmaster = in1;\ndiv = max(in2, 1);\nswing = clamp(in3, 50, 78) / 100.0;\n\nedge = (master < 0.5) && (prev >= 0.5);\nif (edge) { count = wrap(count + 1, 0, div); }\n\nraw = wrap((count + master) / div, 0, 1);\n\nodd = floor(raw * 2) % 2;\nswung = raw;\nif (odd > 0.5) {\n    swung = swing + (raw - 0.5) * 2 * (1 - swing);\n} else {\n    swung = raw * 2 * swing;\n}\n\nHistory pd(0);\nde = (swung < pd - 0.5);\npd = swung;\nprev = master;\n\nout1 = swung;\nout2 = de;" } },
											{ "box": { "id": "obj-5", "maxclass": "newobj", "text": "out 1", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 330.0, 34.0, 22.0] } },
											{ "box": { "id": "obj-6", "maxclass": "newobj", "text": "out 2", "numinlets": 1, "numoutlets": 0, "patching_rect": [270.0, 330.0, 34.0, 22.0] } }
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
									"id": "obj-21", "maxclass": "newobj", "text": "gen~ @title ClockDivTRK2", "numinlets": 3, "numoutlets": 2, "outlettype": ["signal", "signal"],
									"patching_rect": [300.0, 150.0, 160.0, 22.0],
									"patcher": {
										"fileversion": 1, "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
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
											{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "in 2", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [150.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-3", "maxclass": "newobj", "text": "in 3", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [270.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-4", "maxclass": "newobj", "text": "codebox", "numinlets": 3, "numoutlets": 2, "outlettype": ["", ""], "patching_rect": [30.0, 90.0, 400.0, 200.0], "code": "// Clock divider with swing (TRK2)\nHistory prev(0);\nHistory count(0);\n\nmaster = in1;\ndiv = max(in2, 1);\nswing = clamp(in3, 50, 78) / 100.0;\n\nedge = (master < 0.5) && (prev >= 0.5);\nif (edge) { count = wrap(count + 1, 0, div); }\n\nraw = wrap((count + master) / div, 0, 1);\n\nodd = floor(raw * 2) % 2;\nswung = raw;\nif (odd > 0.5) {\n    swung = swing + (raw - 0.5) * 2 * (1 - swing);\n} else {\n    swung = raw * 2 * swing;\n}\n\nHistory pd(0);\nde = (swung < pd - 0.5);\npd = swung;\nprev = master;\n\nout1 = swung;\nout2 = de;" } },
											{ "box": { "id": "obj-5", "maxclass": "newobj", "text": "out 1", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 330.0, 34.0, 22.0] } },
											{ "box": { "id": "obj-6", "maxclass": "newobj", "text": "out 2", "numinlets": 1, "numoutlets": 0, "patching_rect": [270.0, 330.0, 34.0, 22.0] } }
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
							{ "box": { "id": "obj-30", "maxclass": "newobj", "text": ">~ 0.5", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [400.0, 110.0, 42.0, 22.0] } },
							{ "box": { "id": "obj-31", "maxclass": "newobj", "text": "*~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 210.0, 30.0, 22.0] } },
							{ "box": { "id": "obj-32", "maxclass": "newobj", "text": "*~", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [300.0, 210.0, 30.0, 22.0] } },
							{ "box": { "id": "obj-40", "maxclass": "outlet", "index": 1, "comment": "TRK1 divided phasor", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 270.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-41", "maxclass": "outlet", "index": 2, "comment": "TRK1 edge trigger", "numinlets": 1, "numoutlets": 0, "patching_rect": [130.0, 270.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-42", "maxclass": "outlet", "index": 3, "comment": "TRK2 divided phasor", "numinlets": 1, "numoutlets": 0, "patching_rect": [300.0, 270.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-43", "maxclass": "outlet", "index": 4, "comment": "TRK2 edge trigger", "numinlets": 1, "numoutlets": 0, "patching_rect": [400.0, 270.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-44", "maxclass": "outlet", "index": 5, "comment": "Transport state", "numinlets": 1, "numoutlets": 0, "patching_rect": [500.0, 270.0, 30.0, 30.0] } }
						],
						"lines": [
							{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-10", 0] } },
							{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-11", 0] } },
							{ "patchline": { "source": ["obj-5", 0], "destination": ["obj-12", 0] } },
							{ "patchline": { "source": ["obj-6", 0], "destination": ["obj-13", 0] } },
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-20", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-20", 1] } },
							{ "patchline": { "source": ["obj-11", 0], "destination": ["obj-20", 2] } },
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-21", 0], "order": 0 } },
							{ "patchline": { "source": ["obj-12", 0], "destination": ["obj-21", 1] } },
							{ "patchline": { "source": ["obj-13", 0], "destination": ["obj-21", 2] } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-30", 0] } },
							{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-31", 0] } },
							{ "patchline": { "source": ["obj-30", 0], "destination": ["obj-31", 1], "order": 2 } },
							{ "patchline": { "source": ["obj-21", 0], "destination": ["obj-32", 0] } },
							{ "patchline": { "source": ["obj-30", 0], "destination": ["obj-32", 1], "order": 1 } },
							{ "patchline": { "source": ["obj-31", 0], "destination": ["obj-40", 0] } },
							{ "patchline": { "source": ["obj-20", 1], "destination": ["obj-41", 0] } },
							{ "patchline": { "source": ["obj-32", 0], "destination": ["obj-42", 0] } },
							{ "patchline": { "source": ["obj-21", 1], "destination": ["obj-43", 0] } },
							{ "patchline": { "source": ["obj-30", 0], "destination": ["obj-44", 0], "order": 0 } }
						],
						"saved_object_attributes": { "globalpatchername": "" }
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
						"fileversion": 1, "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
						"classnamespace": "box",
						"rect": [100.0, 100.0, 960.0, 750.0],
						"bglocked": 0, "openinpresentation": 0, "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
						"gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1, "objectsnaponopen": 1,
						"statusbarvisible": 2, "toolbarvisible": 1,
						"lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
						"enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0,
						"description": "", "digest": "", "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
						"boxes": [
							{ "box": { "id": "obj-1", "maxclass": "inlet", "index": 1, "comment": "TRK1 phasor", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-2", "maxclass": "inlet", "index": 2, "comment": "TRK2 phasor", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-3", "maxclass": "inlet", "index": 3, "comment": "TRK1 pulse counts (seq msg)", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [120.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-4", "maxclass": "inlet", "index": 4, "comment": "TRK2 pulse counts (seq msg)", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [570.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-5", "maxclass": "inlet", "index": 5, "comment": "TRK1 pitches (pattern msg)", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [210.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-6", "maxclass": "inlet", "index": 6, "comment": "TRK2 pitches (pattern msg)", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [660.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-7", "maxclass": "inlet", "index": 7, "comment": "TRK1 gate types (pattern msg)", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [300.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-8", "maxclass": "inlet", "index": 8, "comment": "TRK2 gate types (pattern msg)", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [750.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-9", "maxclass": "inlet", "index": 9, "comment": "TRK1 gate len", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [390.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-10", "maxclass": "inlet", "index": 10, "comment": "TRK2 gate len", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [840.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-20", "maxclass": "newobj", "text": "stepcounter~ @seq 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 120.0, 240.0, 22.0] } },
							{ "box": { "id": "obj-22", "maxclass": "newobj", "text": "stepdiv~ @pattern 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 180.0, 240.0, 22.0] } },
							{ "box": { "id": "obj-23", "maxclass": "newobj", "text": "stepfun~ @pattern 60 60 60 60 60 60 60 60", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 240.0, 280.0, 22.0] } },
							{ "box": { "id": "obj-25", "maxclass": "newobj", "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 300.0, 240.0, 22.0] } },
							{ "box": { "id": "obj-27", "maxclass": "newobj", "text": "sig~ 0.5", "numinlets": 1, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [390.0, 90.0, 52.0, 22.0] } },
							{
								"box": {
									"id": "obj-28", "maxclass": "newobj", "text": "gen~ @title GateGenT1", "numinlets": 4, "numoutlets": 1, "outlettype": ["signal"],
									"patching_rect": [30.0, 360.0, 300.0, 22.0],
									"patcher": {
										"fileversion": 1, "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
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
											{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "in 2", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [150.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-3", "maxclass": "newobj", "text": "in 3", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [270.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-7", "maxclass": "newobj", "text": "in 4", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [390.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-4", "maxclass": "newobj", "text": "codebox", "numinlets": 4, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 90.0, 420.0, 200.0], "code": "// Gate generator with Single vs Multi distinction\n// in1 = step phasor (0-1 per pulse from stepdiv~)\n// in2 = gate type (0=rest, 1=single, 2=multi, 3=hold)\n// in3 = gate length (0.01-1.0)\n// in4 = stepcounter~ output (stage+pulse index signal)\n//\n// Single (1): gate on first pulse of stage only\n// Multi (2): gate on every pulse\n// Hold (3): gate always on (legato)\n// Rest (0): no gate\n\nHistory prev_counter(0);\nHistory is_first_pulse(1);\n\nphasor = in1;\ngt = in2;\ngl = clamp(in3, 0.01, 1.0);\ncounter = in4;\n\n// Detect stage change: counter jumps indicate new stage\nif (counter != prev_counter) {\n    // stepcounter~ resets pulse count per stage\n    // When counter wraps or changes, mark as first pulse\n    is_first_pulse = 1;\n} else if (phasor < 0.01) {\n    // Phasor reset within same stage = subsequent pulse\n    is_first_pulse = 0;\n}\nprev_counter = counter;\n\ngate = 0;\nif (gt < 0.5) {\n    gate = 0;\n} else if (gt < 1.5) {\n    // Single: only gate on first pulse of stage\n    gate = (phasor < gl) && is_first_pulse;\n} else if (gt < 2.5) {\n    // Multi: gate on every pulse\n    gate = phasor < gl;\n} else {\n    // Hold: gate always on\n    gate = 1;\n}\n\nout1 = gate;" } },
											{ "box": { "id": "obj-5", "maxclass": "newobj", "text": "out 1", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 330.0, 34.0, 22.0] } }
										],
										"lines": [
											{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-4", 0] } },
											{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-4", 1] } },
											{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-4", 2] } },
											{ "patchline": { "source": ["obj-7", 0], "destination": ["obj-4", 3] } },
											{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-5", 0] } }
										]
									}
								}
							},
							{ "box": { "id": "obj-29", "maxclass": "newobj", "text": "snapshot~ 20", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [300.0, 150.0, 75.0, 22.0] } },
							{ "box": { "id": "obj-50", "maxclass": "newobj", "text": "stepcounter~ @seq 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 120.0, 240.0, 22.0] } },
							{ "box": { "id": "obj-52", "maxclass": "newobj", "text": "stepdiv~ @pattern 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 180.0, 240.0, 22.0] } },
							{ "box": { "id": "obj-53", "maxclass": "newobj", "text": "stepfun~ @pattern 60 60 60 60 60 60 60 60", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 240.0, 280.0, 22.0] } },
							{ "box": { "id": "obj-55", "maxclass": "newobj", "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1", "numinlets": 2, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [480.0, 300.0, 240.0, 22.0] } },
							{ "box": { "id": "obj-57", "maxclass": "newobj", "text": "sig~ 0.5", "numinlets": 1, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [840.0, 90.0, 52.0, 22.0] } },
							{
								"box": {
									"id": "obj-58", "maxclass": "newobj", "text": "gen~ @title GateGenT2", "numinlets": 4, "numoutlets": 1, "outlettype": ["signal"],
									"patching_rect": [480.0, 360.0, 300.0, 22.0],
									"patcher": {
										"fileversion": 1, "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
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
											{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "in 2", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [150.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-3", "maxclass": "newobj", "text": "in 3", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [270.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-7", "maxclass": "newobj", "text": "in 4", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [390.0, 30.0, 30.0, 22.0] } },
											{ "box": { "id": "obj-4", "maxclass": "newobj", "text": "codebox", "numinlets": 4, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 90.0, 420.0, 200.0], "code": "// Gate generator with Single vs Multi (TRK2)\nHistory prev_counter(0);\nHistory is_first_pulse(1);\n\nphasor = in1;\ngt = in2;\ngl = clamp(in3, 0.01, 1.0);\ncounter = in4;\n\nif (counter != prev_counter) {\n    is_first_pulse = 1;\n} else if (phasor < 0.01) {\n    is_first_pulse = 0;\n}\nprev_counter = counter;\n\ngate = 0;\nif (gt < 0.5) { gate = 0; }\nelse if (gt < 1.5) { gate = (phasor < gl) && is_first_pulse; }\nelse if (gt < 2.5) { gate = phasor < gl; }\nelse { gate = 1; }\n\nout1 = gate;" } },
											{ "box": { "id": "obj-5", "maxclass": "newobj", "text": "out 1", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 330.0, 34.0, 22.0] } }
										],
										"lines": [
											{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-4", 0] } },
											{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-4", 1] } },
											{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-4", 2] } },
											{ "patchline": { "source": ["obj-7", 0], "destination": ["obj-4", 3] } },
											{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-5", 0] } }
										]
									}
								}
							},
							{ "box": { "id": "obj-59", "maxclass": "newobj", "text": "snapshot~ 20", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [750.0, 150.0, 75.0, 22.0] } },
							{ "box": { "id": "obj-70", "maxclass": "outlet", "index": 1, "comment": "TRK1 pitch", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 420.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-71", "maxclass": "outlet", "index": 2, "comment": "TRK1 gate", "numinlets": 1, "numoutlets": 0, "patching_rect": [120.0, 420.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-72", "maxclass": "outlet", "index": 3, "comment": "TRK1 stage idx", "numinlets": 1, "numoutlets": 0, "patching_rect": [300.0, 420.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-73", "maxclass": "outlet", "index": 4, "comment": "TRK2 pitch", "numinlets": 1, "numoutlets": 0, "patching_rect": [480.0, 420.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-74", "maxclass": "outlet", "index": 5, "comment": "TRK2 gate", "numinlets": 1, "numoutlets": 0, "patching_rect": [570.0, 420.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-75", "maxclass": "outlet", "index": 6, "comment": "TRK2 stage idx", "numinlets": 1, "numoutlets": 0, "patching_rect": [750.0, 420.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-76", "maxclass": "outlet", "index": 7, "comment": "TRK1 step phasor", "numinlets": 1, "numoutlets": 0, "patching_rect": [210.0, 420.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-77", "maxclass": "outlet", "index": 8, "comment": "TRK2 step phasor", "numinlets": 1, "numoutlets": 0, "patching_rect": [660.0, 420.0, 30.0, 30.0] } }
						],
						"lines": [
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-20", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-20", 0] } },
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-22", 0], "order": 0 } },
							{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-22", 1], "order": 2 } },
							{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-29", 0], "order": 0 } },
							{ "patchline": { "source": ["obj-22", 0], "destination": ["obj-23", 0], "order": 3 } },
							{ "patchline": { "source": ["obj-5", 0], "destination": ["obj-23", 0] } },
							{ "patchline": { "source": ["obj-22", 0], "destination": ["obj-25", 0], "order": 2 } },
							{ "patchline": { "source": ["obj-7", 0], "destination": ["obj-25", 0] } },
							{ "patchline": { "source": ["obj-9", 0], "destination": ["obj-27", 0] } },
							{ "patchline": { "source": ["obj-22", 0], "destination": ["obj-28", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-25", 0], "destination": ["obj-28", 1] } },
							{ "patchline": { "source": ["obj-27", 0], "destination": ["obj-28", 2] } },
							{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-28", 3], "order": 1 } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-50", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-50", 0] } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-52", 0], "order": 0 } },
							{ "patchline": { "source": ["obj-50", 0], "destination": ["obj-52", 1], "order": 2 } },
							{ "patchline": { "source": ["obj-50", 0], "destination": ["obj-59", 0], "order": 0 } },
							{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-53", 0], "order": 3 } },
							{ "patchline": { "source": ["obj-6", 0], "destination": ["obj-53", 0] } },
							{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-55", 0], "order": 2 } },
							{ "patchline": { "source": ["obj-8", 0], "destination": ["obj-55", 0] } },
							{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-57", 0] } },
							{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-58", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-55", 0], "destination": ["obj-58", 1] } },
							{ "patchline": { "source": ["obj-57", 0], "destination": ["obj-58", 2] } },
							{ "patchline": { "source": ["obj-50", 0], "destination": ["obj-58", 3], "order": 1 } },
							{ "patchline": { "source": ["obj-23", 0], "destination": ["obj-70", 0] } },
							{ "patchline": { "source": ["obj-28", 0], "destination": ["obj-71", 0] } },
							{ "patchline": { "source": ["obj-29", 0], "destination": ["obj-72", 0] } },
							{ "patchline": { "source": ["obj-53", 0], "destination": ["obj-73", 0] } },
							{ "patchline": { "source": ["obj-58", 0], "destination": ["obj-74", 0] } },
							{ "patchline": { "source": ["obj-59", 0], "destination": ["obj-75", 0] } },
							{ "patchline": { "source": ["obj-22", 0], "destination": ["obj-76", 0], "order": 0 } },
							{ "patchline": { "source": ["obj-52", 0], "destination": ["obj-77", 0], "order": 0 } }
						],
						"saved_object_attributes": { "globalpatchername": "" }
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
						"fileversion": 1, "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
						"classnamespace": "box",
						"rect": [100.0, 100.0, 700.0, 600.0],
						"bglocked": 0, "openinpresentation": 0, "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
						"gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1, "objectsnaponopen": 1,
						"statusbarvisible": 2, "toolbarvisible": 1,
						"lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
						"enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0,
						"description": "Converts pitch+gate step-function signals to MIDI note-on/off messages", "digest": "", "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
						"boxes": [
							{ "box": { "id": "obj-1", "maxclass": "inlet", "index": 1, "comment": "Pitch signal (step function from stepfun~)", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-2", "maxclass": "inlet", "index": 2, "comment": "Gate signal (0/1 step function from GateGen)", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [200.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-3", "maxclass": "inlet", "index": 3, "comment": "Velocity (int)", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [400.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-4", "maxclass": "inlet", "index": 4, "comment": "MIDI channel (int)", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [500.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-5", "maxclass": "inlet", "index": 5, "comment": "MIDI thru (raw)", "numinlets": 0, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [600.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-10", "maxclass": "newobj", "text": "snapshot~ 20", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [30.0, 90.0, 75.0, 22.0] } },
							{ "box": { "id": "obj-11", "maxclass": "newobj", "text": "snapshot~ 20", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [200.0, 90.0, 75.0, 22.0] } },
							{ "box": { "id": "obj-12", "maxclass": "newobj", "text": "i 60", "numinlets": 2, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [30.0, 195.0, 28.0, 22.0] } },
							{ "box": { "id": "obj-23", "maxclass": "newobj", "text": "int", "numinlets": 2, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [120.0, 120.0, 30.0, 22.0] } },
							{ "box": { "id": "obj-13", "maxclass": "newobj", "text": "> 0.5", "numinlets": 2, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [200.0, 120.0, 38.0, 22.0] } },
							{ "box": { "id": "obj-18", "maxclass": "newobj", "text": "change", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "int"], "patching_rect": [120.0, 150.0, 46.0, 22.0] } },
							{ "box": { "id": "obj-17", "maxclass": "newobj", "text": "int", "numinlets": 2, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [200.0, 150.0, 30.0, 22.0] } },
							{ "box": { "id": "obj-14", "maxclass": "newobj", "text": "change", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "int"], "patching_rect": [250.0, 150.0, 46.0, 22.0] } },
							{ "box": { "id": "obj-19", "maxclass": "newobj", "text": "gate 1", "numinlets": 2, "numoutlets": 1, "outlettype": [""], "patching_rect": [120.0, 195.0, 42.0, 22.0] } },
							{ "box": { "id": "obj-15", "maxclass": "newobj", "text": "sel 0", "numinlets": 1, "numoutlets": 2, "outlettype": ["bang", ""], "patching_rect": [250.0, 195.0, 36.0, 22.0] } },
							{ "box": { "id": "obj-20", "maxclass": "newobj", "text": "t b b", "numinlets": 1, "numoutlets": 2, "outlettype": ["bang", "bang"], "patching_rect": [180.0, 240.0, 34.0, 22.0] } },
							{ "box": { "id": "obj-24", "maxclass": "newobj", "text": "t b b", "numinlets": 1, "numoutlets": 2, "outlettype": ["bang", "bang"], "patching_rect": [300.0, 240.0, 34.0, 22.0] } },
							{ "box": { "id": "obj-16", "maxclass": "newobj", "text": "i 0", "numinlets": 2, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [200.0, 285.0, 24.0, 22.0] } },
							{ "box": { "id": "obj-22", "maxclass": "newobj", "text": "sel 0", "numinlets": 1, "numoutlets": 2, "outlettype": ["bang", ""], "patching_rect": [200.0, 315.0, 36.0, 22.0] } },
							{ "box": { "id": "obj-25", "maxclass": "message", "text": "0", "numinlets": 2, "numoutlets": 1, "outlettype": [""], "patching_rect": [345.0, 285.0, 30.0, 22.0] } },
							{ "box": { "id": "obj-21", "maxclass": "newobj", "text": "t i i", "numinlets": 1, "numoutlets": 2, "outlettype": ["int", "int"], "patching_rect": [30.0, 345.0, 34.0, 22.0] } },
							{ "box": { "id": "obj-30", "maxclass": "newobj", "text": "pack 0 0 0", "numinlets": 3, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 390.0, 120.0, 22.0] } },
							{ "box": { "id": "obj-31", "maxclass": "newobj", "text": "pack 0 0 0", "numinlets": 3, "numoutlets": 1, "outlettype": [""], "patching_rect": [300.0, 390.0, 120.0, 22.0] } },
							{ "box": { "id": "obj-32", "maxclass": "newobj", "text": "schedule", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 420.0, 55.0, 22.0] } },
							{ "box": { "id": "obj-33", "maxclass": "newobj", "text": "schedule", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [300.0, 420.0, 55.0, 22.0] } },
							{ "box": { "id": "obj-34", "maxclass": "newobj", "text": "midiformat", "numinlets": 7, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [30.0, 450.0, 100.0, 22.0] } },
							{ "box": { "id": "obj-35", "maxclass": "newobj", "text": "midiformat", "numinlets": 7, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [300.0, 450.0, 100.0, 22.0] } },
							{ "box": { "id": "obj-40", "maxclass": "outlet", "index": 1, "comment": "MIDI out", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 510.0, 30.0, 30.0] } }
						],
						"lines": [
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-10", 0] } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-11", 0] } },
							{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-12", 1], "order": 0 } },
							{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-23", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-11", 0], "destination": ["obj-13", 0] } },
							{ "patchline": { "source": ["obj-13", 0], "destination": ["obj-17", 0] } },
							{ "patchline": { "source": ["obj-17", 0], "destination": ["obj-14", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-17", 0], "destination": ["obj-19", 0], "order": 0 } },
							{ "patchline": { "source": ["obj-14", 0], "destination": ["obj-15", 0] } },
							{ "patchline": { "source": ["obj-23", 0], "destination": ["obj-18", 0] } },
							{ "patchline": { "source": ["obj-18", 0], "destination": ["obj-19", 1] } },
							{ "patchline": { "source": ["obj-15", 1], "destination": ["obj-20", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-19", 0], "destination": ["obj-20", 0], "order": 0 } },
							{ "patchline": { "source": ["obj-15", 0], "destination": ["obj-24", 0] } },
							{ "patchline": { "source": ["obj-20", 1], "destination": ["obj-16", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-24", 1], "destination": ["obj-16", 0], "order": 0 } },
							{ "patchline": { "source": ["obj-16", 0], "destination": ["obj-22", 0] } },
							{ "patchline": { "source": ["obj-22", 1], "destination": ["obj-31", 0] } },
							{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-12", 0] } },
							{ "patchline": { "source": ["obj-12", 0], "destination": ["obj-21", 0] } },
							{ "patchline": { "source": ["obj-21", 1], "destination": ["obj-16", 1] } },
							{ "patchline": { "source": ["obj-21", 0], "destination": ["obj-30", 0] } },
							{ "patchline": { "source": ["obj-24", 0], "destination": ["obj-25", 0] } },
							{ "patchline": { "source": ["obj-25", 0], "destination": ["obj-16", 1] } },
							{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-30", 1] } },
							{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-30", 2], "order": 1 } },
							{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-31", 2], "order": 0 } },
							{ "patchline": { "source": ["obj-30", 0], "destination": ["obj-32", 0] } },
							{ "patchline": { "source": ["obj-31", 0], "destination": ["obj-33", 0] } },
							{ "patchline": { "source": ["obj-32", 0], "destination": ["obj-34", 0] } },
							{ "patchline": { "source": ["obj-33", 0], "destination": ["obj-35", 0] } },
							{ "patchline": { "source": ["obj-34", 0], "destination": ["obj-40", 0], "order": 2 } },
							{ "patchline": { "source": ["obj-35", 0], "destination": ["obj-40", 0], "order": 1 } },
							{ "patchline": { "source": ["obj-5", 0], "destination": ["obj-40", 0], "order": 0 } }
						],
						"saved_object_attributes": { "globalpatchername": "" }
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
						"fileversion": 1, "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
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
									"id": "obj-20", "maxclass": "live.dial", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"],
									"parameter_enable": 1, "patching_rect": [30.0, 195.0, 44.0, 48.0],
									"saved_attribute_attributes": { "valueof": { "parameter_longname": "TRK2 Pitch", "parameter_shortname": "T2 Pitch", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.0], "parameter_unitstyle": 1, "parameter_linknames": 1 } },
									"varname": "TRK2 Pitch"
								}
							},
							{
								"box": {
									"id": "obj-21", "maxclass": "live.dial", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"],
									"parameter_enable": 1, "patching_rect": [150.0, 195.0, 44.0, 48.0],
									"saved_attribute_attributes": { "valueof": { "parameter_longname": "TRK2 Gate", "parameter_shortname": "T2 Gate", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.0], "parameter_unitstyle": 1, "parameter_linknames": 1 } },
									"varname": "TRK2 Gate"
								}
							},
							{
								"box": {
									"id": "obj-22", "maxclass": "live.dial", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"],
									"parameter_enable": 1, "patching_rect": [270.0, 195.0, 44.0, 48.0],
									"saved_attribute_attributes": { "valueof": { "parameter_longname": "TRK2 Velocity", "parameter_shortname": "T2 Vel", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.0], "parameter_unitstyle": 1, "parameter_linknames": 1 } },
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
						"saved_object_attributes": { "globalpatchername": "" }
					}
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "newobj",
					"text": "p TransportStop",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": ["int"],
					"patching_rect": [16.0, 392.0, 96.0, 20.0],
					"patcher": {
						"fileversion": 1, "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
						"classnamespace": "box",
						"rect": [100.0, 100.0, 400.0, 300.0],
						"bglocked": 0, "openinpresentation": 0, "default_fontsize": 12.0, "default_fontface": 0, "default_fontname": "Arial",
						"gridonopen": 1, "gridsize": [15.0, 15.0], "gridsnaponopen": 1, "objectsnaponopen": 1,
						"statusbarvisible": 2, "toolbarvisible": 1,
						"lefttoolbarpinned": 0, "toptoolbarpinned": 0, "righttoolbarpinned": 0, "bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0, "tallnewobj": 0, "boxanimatetime": 200,
						"enablehscroll": 1, "enablevscroll": 1, "devicewidth": 0.0,
						"description": "Sends CC 123 (All Notes Off) when transport stops", "digest": "", "tags": "", "style": "", "subpatcher_template": "", "assistshowspatchername": 0,
						"boxes": [
							{ "box": { "id": "obj-1", "maxclass": "inlet", "index": 1, "comment": "Transport state (signal)", "numinlets": 0, "numoutlets": 1, "outlettype": ["signal"], "patching_rect": [30.0, 30.0, 30.0, 30.0] } },
							{ "box": { "id": "obj-2", "maxclass": "newobj", "text": "snapshot~ 30", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [30.0, 90.0, 75.0, 22.0] } },
							{ "box": { "id": "obj-3", "maxclass": "newobj", "text": "change", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "int"], "patching_rect": [30.0, 120.0, 46.0, 22.0] } },
							{ "box": { "id": "obj-4", "maxclass": "newobj", "text": "sel 0", "numinlets": 1, "numoutlets": 2, "outlettype": ["bang", ""], "patching_rect": [30.0, 150.0, 36.0, 22.0] } },
							{ "box": { "id": "obj-5", "maxclass": "message", "text": "123 0", "numinlets": 2, "numoutlets": 1, "outlettype": [""], "patching_rect": [30.0, 180.0, 42.0, 22.0] } },
							{ "box": { "id": "obj-6", "maxclass": "newobj", "text": "midiformat", "numinlets": 7, "numoutlets": 1, "outlettype": ["int"], "patching_rect": [30.0, 210.0, 100.0, 22.0] } },
							{ "box": { "id": "obj-7", "maxclass": "outlet", "index": 1, "comment": "MIDI CC123 All Notes Off", "numinlets": 1, "numoutlets": 0, "patching_rect": [30.0, 250.0, 30.0, 30.0] } }
						],
						"lines": [
							{ "patchline": { "source": ["obj-1", 0], "destination": ["obj-2", 0] } },
							{ "patchline": { "source": ["obj-2", 0], "destination": ["obj-3", 0] } },
							{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-4", 0] } },
							{ "patchline": { "source": ["obj-4", 0], "destination": ["obj-5", 0] } },
							{ "patchline": { "source": ["obj-5", 0], "destination": ["obj-6", 2] } },
							{ "patchline": { "source": ["obj-6", 0], "destination": ["obj-7", 0] } }
						],
						"saved_object_attributes": { "globalpatchername": "" }
					}
				}
			},
			{
				"box": { "id": "obj-100", "maxclass": "live.slider", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [16.0, 448.0, 40.0, 95.0], "presentation": 1, "presentation_rect": [8.0, 48.0, 36.0, 95.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Stage 1 Pitch", "parameter_shortname": "1", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.5], "parameter_unitstyle": 1, "parameter_linknames": 1 } }, "varname": "Stage 1 Pitch" }
			},
			{
				"box": { "id": "obj-101", "maxclass": "live.slider", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [64.0, 448.0, 40.0, 95.0], "presentation": 1, "presentation_rect": [52.0, 48.0, 36.0, 95.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Stage 2 Pitch", "parameter_shortname": "2", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.5], "parameter_unitstyle": 1, "parameter_linknames": 1 } }, "varname": "Stage 2 Pitch" }
			},
			{
				"box": { "id": "obj-102", "maxclass": "live.slider", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [112.0, 448.0, 40.0, 95.0], "presentation": 1, "presentation_rect": [96.0, 48.0, 36.0, 95.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Stage 3 Pitch", "parameter_shortname": "3", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.5], "parameter_unitstyle": 1, "parameter_linknames": 1 } }, "varname": "Stage 3 Pitch" }
			},
			{
				"box": { "id": "obj-103", "maxclass": "live.slider", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [160.0, 448.0, 40.0, 95.0], "presentation": 1, "presentation_rect": [140.0, 48.0, 36.0, 95.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Stage 4 Pitch", "parameter_shortname": "4", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.5], "parameter_unitstyle": 1, "parameter_linknames": 1 } }, "varname": "Stage 4 Pitch" }
			},
			{
				"box": { "id": "obj-104", "maxclass": "live.slider", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [208.0, 448.0, 40.0, 95.0], "presentation": 1, "presentation_rect": [184.0, 48.0, 36.0, 95.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Stage 5 Pitch", "parameter_shortname": "5", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.5], "parameter_unitstyle": 1, "parameter_linknames": 1 } }, "varname": "Stage 5 Pitch" }
			},
			{
				"box": { "id": "obj-105", "maxclass": "live.slider", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [256.0, 448.0, 40.0, 95.0], "presentation": 1, "presentation_rect": [228.0, 48.0, 36.0, 95.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Stage 6 Pitch", "parameter_shortname": "6", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.5], "parameter_unitstyle": 1, "parameter_linknames": 1 } }, "varname": "Stage 6 Pitch" }
			},
			{
				"box": { "id": "obj-106", "maxclass": "live.slider", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [304.0, 448.0, 40.0, 95.0], "presentation": 1, "presentation_rect": [272.0, 48.0, 36.0, 95.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Stage 7 Pitch", "parameter_shortname": "7", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.5], "parameter_unitstyle": 1, "parameter_linknames": 1 } }, "varname": "Stage 7 Pitch" }
			},
			{
				"box": { "id": "obj-107", "maxclass": "live.slider", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [352.0, 448.0, 40.0, 95.0], "presentation": 1, "presentation_rect": [316.0, 48.0, 36.0, 95.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Stage 8 Pitch", "parameter_shortname": "8", "parameter_type": 0, "parameter_mmax": 1.0, "parameter_mmin": 0.0, "parameter_initial_enable": 1, "parameter_initial": [0.5], "parameter_unitstyle": 1, "parameter_linknames": 1 } }, "varname": "Stage 8 Pitch" }
			},
			{
				"box": { "id": "obj-108", "maxclass": "newobj", "text": "pak 0. 0. 0. 0. 0. 0. 0. 0.", "numinlets": 8, "numoutlets": 1, "outlettype": [""], "patching_rect": [16.0, 560.0, 376.0, 20.0] }
			},
			{
				"box": { "id": "obj-109", "maxclass": "newobj", "text": "prepend update_pitches", "numinlets": 2, "numoutlets": 1, "outlettype": [""], "patching_rect": [16.0, 584.0, 130.0, 20.0] }
			},
			{
				"box": { "id": "obj-110", "maxclass": "live.tab", "numinlets": 1, "numoutlets": 3, "outlettype": ["", "", "float"], "parameter_enable": 1, "patching_rect": [424.0, 448.0, 100.0, 20.0], "presentation": 1, "presentation_rect": [368.0, 48.0, 100.0, 20.0], "num_lines_patching": 1, "num_lines_presentation": 1, "saved_attribute_attributes": { "valueof": { "parameter_longname": "Track Select", "parameter_shortname": "Track", "parameter_type": 2, "parameter_enum": ["TRK1", "TRK2"], "parameter_initial_enable": 1, "parameter_initial": [0], "parameter_linknames": 1 } }, "varname": "Track Select" }
			},
			{
				"box": { "id": "obj-111", "maxclass": "live.menu", "numinlets": 1, "numoutlets": 3, "outlettype": ["", "", "float"], "parameter_enable": 1, "patching_rect": [424.0, 480.0, 100.0, 15.0], "presentation": 1, "presentation_rect": [368.0, 80.0, 100.0, 15.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Playback Order", "parameter_shortname": "Order", "parameter_type": 2, "parameter_enum": ["Linear", "Ping Pong", "Pendulum", "Random", "Shuffle", "Brownian", "Converge", "Diverge", "Pedal Point", "Hopscotch"], "parameter_initial_enable": 1, "parameter_initial": [0], "parameter_linknames": 1 } }, "varname": "Playback Order" }
			},
			{
				"box": { "id": "obj-112", "maxclass": "live.dial", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [424.0, 504.0, 44.0, 48.0], "presentation": 1, "presentation_rect": [368.0, 104.0, 44.0, 48.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Clock Division", "parameter_shortname": "Div", "parameter_type": 1, "parameter_mmax": 64.0, "parameter_mmin": 1.0, "parameter_initial_enable": 1, "parameter_initial": [1], "parameter_unitstyle": 0, "parameter_linknames": 1 } }, "varname": "Clock Division" }
			},
			{
				"box": { "id": "obj-113", "maxclass": "live.dial", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [480.0, 504.0, 44.0, 48.0], "presentation": 1, "presentation_rect": [424.0, 104.0, 44.0, 48.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Swing", "parameter_shortname": "Swing", "parameter_type": 1, "parameter_mmax": 78.0, "parameter_mmin": 50.0, "parameter_initial_enable": 1, "parameter_initial": [50], "parameter_unitstyle": 5, "parameter_linknames": 1 } }, "varname": "Swing" }
			},
			{
				"box": { "id": "obj-114", "maxclass": "live.dial", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [536.0, 504.0, 44.0, 48.0], "presentation": 1, "presentation_rect": [480.0, 104.0, 44.0, 48.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Stages Length", "parameter_shortname": "Len", "parameter_type": 1, "parameter_mmax": 8.0, "parameter_mmin": 1.0, "parameter_initial_enable": 1, "parameter_initial": [8], "parameter_unitstyle": 0, "parameter_linknames": 1 } }, "varname": "Stages Length" }
			},
			{
				"box": { "id": "obj-115", "maxclass": "live.dial", "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"], "parameter_enable": 1, "patching_rect": [424.0, 560.0, 44.0, 48.0], "presentation": 1, "presentation_rect": [536.0, 104.0, 44.0, 48.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Gate Length", "parameter_shortname": "Gate", "parameter_type": 1, "parameter_mmax": 100.0, "parameter_mmin": 1.0, "parameter_initial_enable": 1, "parameter_initial": [50], "parameter_unitstyle": 5, "parameter_linknames": 1 } }, "varname": "Gate Length" }
			},
			{
				"box": { "id": "obj-116", "maxclass": "live.menu", "numinlets": 1, "numoutlets": 3, "outlettype": ["", "", "float"], "parameter_enable": 1, "patching_rect": [480.0, 560.0, 100.0, 15.0], "presentation": 1, "presentation_rect": [592.0, 104.0, 100.0, 15.0], "saved_attribute_attributes": { "valueof": { "parameter_longname": "Root Note", "parameter_shortname": "Root", "parameter_type": 2, "parameter_enum": ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"], "parameter_initial_enable": 1, "parameter_initial": [0], "parameter_linknames": 1 } }, "varname": "Root Note" }
			},
			{
				"box": { "id": "obj-117", "maxclass": "newobj", "text": "/ 100.", "numinlets": 2, "numoutlets": 1, "outlettype": ["float"], "patching_rect": [424.0, 240.0, 40.0, 20.0] }
			}
		],
		"lines": [
			{ "patchline": { "source": ["obj-6", 0], "destination": ["obj-7", 0] } },
			{ "patchline": { "source": ["obj-7", 0], "destination": ["obj-10", 0], "order": 0 } },
			{ "patchline": { "source": ["obj-7", 1], "destination": ["obj-17", 0] } },
			{ "patchline": { "source": ["obj-7", 2], "destination": ["obj-18", 0] } },
			{ "patchline": { "source": ["obj-10", 0], "destination": ["obj-8", 0] } },
			{ "patchline": { "source": ["obj-8", 0], "destination": ["obj-9", 0] } },
			{ "patchline": { "source": ["obj-9", 0], "destination": ["obj-11", 0] } },
			{ "patchline": { "source": ["obj-9", 1], "destination": ["obj-12", 0] } },
			{ "patchline": { "source": ["obj-9", 2], "destination": ["obj-13", 0] } },
			{ "patchline": { "source": ["obj-9", 3], "destination": ["obj-14", 0] } },
			{ "patchline": { "source": ["obj-9", 4], "destination": ["obj-15", 0] } },
			{ "patchline": { "source": ["obj-9", 5], "destination": ["obj-16", 0] } },
			{ "patchline": { "source": ["obj-11", 0], "destination": ["obj-30", 4] } },
			{ "patchline": { "source": ["obj-12", 0], "destination": ["obj-30", 5] } },
			{ "patchline": { "source": ["obj-13", 0], "destination": ["obj-30", 2] } },
			{ "patchline": { "source": ["obj-14", 0], "destination": ["obj-30", 3] } },
			{ "patchline": { "source": ["obj-15", 0], "destination": ["obj-30", 6] } },
			{ "patchline": { "source": ["obj-16", 0], "destination": ["obj-30", 7] } },
			{ "patchline": { "source": ["obj-112", 0], "destination": ["obj-20", 0], "order": 1 } },
			{ "patchline": { "source": ["obj-113", 0], "destination": ["obj-20", 1], "order": 1 } },
			{ "patchline": { "source": ["obj-112", 0], "destination": ["obj-20", 2], "order": 0 } },
			{ "patchline": { "source": ["obj-113", 0], "destination": ["obj-20", 3], "order": 0 } },
			{ "patchline": { "source": ["obj-20", 0], "destination": ["obj-30", 0] } },
			{ "patchline": { "source": ["obj-20", 2], "destination": ["obj-30", 1] } },
			{ "patchline": { "source": ["obj-115", 0], "destination": ["obj-117", 0] } },
			{ "patchline": { "source": ["obj-117", 0], "destination": ["obj-30", 8], "order": 1 } },
			{ "patchline": { "source": ["obj-117", 0], "destination": ["obj-30", 9], "order": 0 } },
			{ "patchline": { "source": ["obj-30", 0], "destination": ["obj-40", 0] } },
			{ "patchline": { "source": ["obj-30", 1], "destination": ["obj-40", 1] } },
			{ "patchline": { "source": ["obj-17", 0], "destination": ["obj-40", 2], "order": 1 } },
			{ "patchline": { "source": ["obj-18", 0], "destination": ["obj-40", 3] } },
			{ "patchline": { "source": ["obj-3", 0], "destination": ["obj-40", 4] } },
			{ "patchline": { "source": ["obj-30", 3], "destination": ["obj-50", 0] } },
			{ "patchline": { "source": ["obj-30", 4], "destination": ["obj-50", 1] } },
			{ "patchline": { "source": ["obj-17", 0], "destination": ["obj-50", 2], "order": 0 } },
			{ "patchline": { "source": ["obj-40", 0], "destination": ["obj-4", 0], "order": 1 } },
			{ "patchline": { "source": ["obj-20", 4], "destination": ["obj-60", 0] } },
			{ "patchline": { "source": ["obj-60", 0], "destination": ["obj-4", 0], "order": 0 } },
			{ "patchline": { "source": ["obj-100", 0], "destination": ["obj-108", 0] } },
			{ "patchline": { "source": ["obj-101", 0], "destination": ["obj-108", 1] } },
			{ "patchline": { "source": ["obj-102", 0], "destination": ["obj-108", 2] } },
			{ "patchline": { "source": ["obj-103", 0], "destination": ["obj-108", 3] } },
			{ "patchline": { "source": ["obj-104", 0], "destination": ["obj-108", 4] } },
			{ "patchline": { "source": ["obj-105", 0], "destination": ["obj-108", 5] } },
			{ "patchline": { "source": ["obj-106", 0], "destination": ["obj-108", 6] } },
			{ "patchline": { "source": ["obj-107", 0], "destination": ["obj-108", 7] } },
			{ "patchline": { "source": ["obj-108", 0], "destination": ["obj-109", 0] } },
			{ "patchline": { "source": ["obj-109", 0], "destination": ["obj-8", 0] } }
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

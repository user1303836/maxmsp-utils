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
			1200.0,
			800.0
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
		"description": "Merge defaults into dictionaries and validate required keys",
		"digest": "Apply default values and check required keys on incoming dicts",
		"tags": "utility dictionary defaults merge validation",
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
					"comment": "input: dictionary name"
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
						560.0,
						16.0,
						30.0,
						30.0
					],
					"comment": "control: defaults, required, addrequired, clearrequired, force, reset"
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
						744.0,
						30.0,
						30.0
					],
					"comment": "merged dictionary"
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
						320.0,
						744.0,
						30.0,
						30.0
					],
					"comment": "validation/status: ok, missing keys, configured, reset"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "outlet",
					"index": 3,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						600.0,
						744.0,
						30.0,
						30.0
					],
					"comment": "diagnostics: applied N, preserved N"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "comment",
					"text": "--- INIT ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						800.0,
						16.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"text": "loadbang",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						800.0,
						40.0,
						56.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-8",
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
						800.0,
						64.0,
						64.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "patcherargs 0",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						920.0,
						64.0,
						88.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "v #0_force",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						920.0,
						96.0,
						64.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "dict #0_defaults",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						800.0,
						96.0,
						104.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"text": "dict #0_work",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						800.0,
						120.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "coll #0_required",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						800.0,
						144.0,
						104.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "comment",
					"text": "--- CONTROL (inlet 2) ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						560.0,
						56.0,
						160.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"text": "route defaults required addrequired clearrequired force reset",
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
						560.0,
						80.0,
						392.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"text": "p SetDefaults",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						560.0,
						112.0,
						88.0,
						20.0
					],
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
							200.0,
							200.0,
							640.0,
							480.0
						],
						"default_fontsize": 12.0,
						"default_fontname": "Arial",
						"gridsize": [
							15.0,
							15.0
						],
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
										50.0,
										40.0,
										30.0,
										30.0
									],
									"comment": "dict name to use as defaults source"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "t s b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"bang"
									],
									"patching_rect": [
										50.0,
										90.0,
										88.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "message",
									"text": "clear",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										120.0,
										120.0,
										40.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "dict #0_defaults",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										180.0,
										120.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "prepend import",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										150.0,
										95.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										240.0,
										30.0,
										30.0
									],
									"comment": "status: configured"
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "message",
									"text": "configured",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										210.0,
										72.0,
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
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										0
									],
									"destination": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										1
									],
									"destination": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3",
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
										"obj-5",
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
										"obj-4",
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
										"obj-6",
										0
									]
								}
							}
						]
					},
					"saved_object_attributes": {
						"globalpatchername": ""
					}
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"text": "p SetRequired",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						656.0,
						112.0,
						88.0,
						20.0
					],
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
							200.0,
							200.0,
							640.0,
							480.0
						],
						"default_fontsize": 12.0,
						"default_fontname": "Arial",
						"gridsize": [
							15.0,
							15.0
						],
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
										50.0,
										40.0,
										30.0,
										30.0
									],
									"comment": "required key list"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "t l b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"bang"
									],
									"patching_rect": [
										50.0,
										90.0,
										88.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "message",
									"text": "clear",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										120.0,
										120.0,
										40.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "coll #0_required",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										50.0,
										210.0,
										120.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "zl iter 1",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										150.0,
										60.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "prepend store",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										180.0,
										85.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										290.0,
										30.0,
										30.0
									],
									"comment": "status: configured"
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "message",
									"text": "configured",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										255.0,
										72.0,
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
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										0
									],
									"destination": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										1
									],
									"destination": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3",
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
										"obj-5",
										0
									],
									"destination": [
										"obj-6",
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
										"obj-4",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-4",
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
										"obj-7",
										0
									]
								}
							}
						]
					},
					"saved_object_attributes": {
						"globalpatchername": ""
					}
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"text": "p AddRequired",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						752.0,
						112.0,
						88.0,
						20.0
					],
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
							200.0,
							200.0,
							640.0,
							480.0
						],
						"default_fontsize": 12.0,
						"default_fontname": "Arial",
						"gridsize": [
							15.0,
							15.0
						],
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
										50.0,
										40.0,
										30.0,
										30.0
									],
									"comment": "keys to add to required list"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "zl iter 1",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										90.0,
										60.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "prepend store",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										120.0,
										85.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "coll #0_required",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										50.0,
										150.0,
										120.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										225.0,
										30.0,
										30.0
									],
									"comment": "status: configured"
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "message",
									"text": "configured",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										195.0,
										72.0,
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
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										0
									],
									"destination": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3",
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
										"obj-4",
										0
									],
									"destination": [
										"obj-6",
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
										"obj-5",
										0
									]
								}
							}
						]
					},
					"saved_object_attributes": {
						"globalpatchername": ""
					}
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"text": "p ClearRequired",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						848.0,
						112.0,
						96.0,
						20.0
					],
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
							200.0,
							200.0,
							640.0,
							480.0
						],
						"default_fontsize": 12.0,
						"default_fontname": "Arial",
						"gridsize": [
							15.0,
							15.0
						],
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
										50.0,
										40.0,
										30.0,
										30.0
									],
									"comment": "bang to clear required keys"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "message",
									"text": "clear",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										90.0,
										40.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "coll #0_required",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										50.0,
										120.0,
										120.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										195.0,
										30.0,
										30.0
									],
									"comment": "status: configured"
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "message",
									"text": "configured",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										165.0,
										72.0,
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
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										0
									],
									"destination": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3",
										0
									],
									"destination": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-5",
										0
									],
									"destination": [
										"obj-4",
										0
									]
								}
							}
						]
					},
					"saved_object_attributes": {
						"globalpatchername": ""
					}
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "v #0_force",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						952.0,
						112.0,
						64.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"text": "--- RESET ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1048.0,
						80.0,
						88.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"text": "p Reset",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1048.0,
						112.0,
						56.0,
						20.0
					],
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
							200.0,
							200.0,
							640.0,
							480.0
						],
						"default_fontsize": 12.0,
						"default_fontname": "Arial",
						"gridsize": [
							15.0,
							15.0
						],
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
										50.0,
										40.0,
										30.0,
										30.0
									],
									"comment": "bang to reset"
								}
							},
							{
								"box": {
									"id": "obj-2",
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
										50.0,
										90.0,
										165.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "message",
									"text": "clear",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										135.0,
										40.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "dict #0_defaults",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										165.0,
										120.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "message",
									"text": "clear",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										105.0,
										135.0,
										40.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "coll #0_required",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										105.0,
										165.0,
										120.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "message",
									"text": "0",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										160.0,
										135.0,
										24.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "newobj",
									"text": "v #0_force",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										160.0,
										165.0,
										75.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										255.0,
										30.0,
										30.0
									],
									"comment": "status: reset"
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "message",
									"text": "reset",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										197.0,
										135.0,
										40.0,
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
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										0
									],
									"destination": [
										"obj-10",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										1
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
										"obj-2",
										2
									],
									"destination": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										3
									],
									"destination": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3",
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
										"obj-5",
										0
									],
									"destination": [
										"obj-6",
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
										"obj-10",
										0
									],
									"destination": [
										"obj-9",
										0
									]
								}
							}
						]
					},
					"saved_object_attributes": {
						"globalpatchername": ""
					}
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"text": "--- PROCESS (inlet 1) ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						56.0,
						160.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "newobj",
					"text": "route dictionary",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						56.0,
						80.0,
						104.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"text": "p MergeDefaults",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						56.0,
						200.0,
						304.0,
						20.0
					],
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
							200.0,
							200.0,
							800.0,
							600.0
						],
						"default_fontsize": 12.0,
						"default_fontname": "Arial",
						"gridsize": [
							15.0,
							15.0
						],
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
										50.0,
										40.0,
										30.0,
										30.0
									],
									"comment": "input dict name"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "t s b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"bang"
									],
									"patching_rect": [
										50.0,
										90.0,
										165.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "dict #0_work",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										195.0,
										100.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "message",
									"text": "clear",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										197.0,
										120.0,
										40.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "prepend import",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										165.0,
										95.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "t b b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										50.0,
										225.0,
										88.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "newobj",
									"text": "v #0_force",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										120.0,
										255.0,
										75.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "newobj",
									"text": "sel 0 1",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"bang",
										"bang",
										""
									],
									"patching_rect": [
										120.0,
										285.0,
										75.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "newobj",
									"text": "p MergeGapFill",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										330.0,
										105.0,
										22.0
									],
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
											250.0,
											250.0,
											700.0,
											500.0
										],
										"default_fontsize": 12.0,
										"default_fontname": "Arial",
										"gridsize": [
											15.0,
											15.0
										],
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
														50.0,
														40.0,
														30.0,
														30.0
													],
													"comment": "bang to start merge"
												}
											},
											{
												"box": {
													"id": "obj-2",
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
														50.0,
														90.0,
														135.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-3",
													"maxclass": "message",
													"text": "0",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														120.0,
														24.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-4",
													"maxclass": "newobj",
													"text": "v #0_applied",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														150.0,
														85.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-5",
													"maxclass": "message",
													"text": "0",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														120.0,
														120.0,
														24.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-6",
													"maxclass": "newobj",
													"text": "v #0_preserved",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														120.0,
														150.0,
														95.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-7",
													"maxclass": "message",
													"text": "getkeys",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														170.0,
														120.0,
														52.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-8",
													"maxclass": "newobj",
													"text": "dict #0_defaults",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														150.0,
														120.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-9",
													"maxclass": "newobj",
													"text": "route keys",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														180.0,
														75.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-10",
													"maxclass": "newobj",
													"text": "zl iter 1",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														210.0,
														60.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-11",
													"maxclass": "newobj",
													"text": "t s s",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														240.0,
														88.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-12",
													"maxclass": "newobj",
													"text": "prepend contains",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														240.0,
														270.0,
														105.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-13",
													"maxclass": "newobj",
													"text": "dict #0_work",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														240.0,
														300.0,
														100.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-14",
													"maxclass": "newobj",
													"text": "sel 0",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"bang",
														""
													],
													"patching_rect": [
														240.0,
														330.0,
														50.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-15",
													"maxclass": "newobj",
													"text": "prepend get",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														170.0,
														360.0,
														78.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-16",
													"maxclass": "newobj",
													"text": "dict #0_defaults",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														390.0,
														120.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-17",
													"maxclass": "newobj",
													"text": "dict #0_work",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														420.0,
														100.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-18",
													"maxclass": "newobj",
													"text": "prepend set",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														170.0,
														450.0,
														78.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-19",
													"maxclass": "newobj",
													"text": "v #0_applied",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														410.0,
														360.0,
														85.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-20",
													"maxclass": "newobj",
													"text": "+ 1",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														"int"
													],
													"patching_rect": [
														410.0,
														390.0,
														40.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-21",
													"maxclass": "newobj",
													"text": "v #0_applied",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														410.0,
														420.0,
														85.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-22",
													"maxclass": "newobj",
													"text": "v #0_preserved",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														510.0,
														300.0,
														95.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-23",
													"maxclass": "newobj",
													"text": "+ 1",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														"int"
													],
													"patching_rect": [
														510.0,
														330.0,
														40.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-24",
													"maxclass": "newobj",
													"text": "v #0_preserved",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														510.0,
														360.0,
														95.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-25",
													"maxclass": "outlet",
													"index": 1,
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														50.0,
														460.0,
														30.0,
														30.0
													],
													"comment": "applied count"
												}
											},
											{
												"box": {
													"id": "obj-26",
													"maxclass": "outlet",
													"index": 2,
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														120.0,
														460.0,
														30.0,
														30.0
													],
													"comment": "preserved count"
												}
											},
											{
												"box": {
													"id": "obj-27",
													"maxclass": "newobj",
													"text": "v #0_applied",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														450.0,
														85.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-28",
													"maxclass": "newobj",
													"text": "v #0_preserved",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														120.0,
														450.0,
														95.0,
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
														"obj-2",
														0
													]
												}
											},
											{
												"patchline": {
													"source": [
														"obj-2",
														0
													],
													"destination": [
														"obj-27",
														0
													],
													"order": 1
												}
											},
											{
												"patchline": {
													"source": [
														"obj-2",
														0
													],
													"destination": [
														"obj-28",
														0
													],
													"order": 1
												}
											},
											{
												"patchline": {
													"source": [
														"obj-2",
														1
													],
													"destination": [
														"obj-5",
														0
													]
												}
											},
											{
												"patchline": {
													"source": [
														"obj-2",
														2
													],
													"destination": [
														"obj-3",
														0
													],
													"order": 1
												}
											},
											{
												"patchline": {
													"source": [
														"obj-3",
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
														"obj-5",
														0
													],
													"destination": [
														"obj-6",
														0
													]
												}
											},
											{
												"patchline": {
													"source": [
														"obj-2",
														2
													],
													"destination": [
														"obj-7",
														0
													],
													"order": 1
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
													]
												}
											},
											{
												"patchline": {
													"source": [
														"obj-9",
														0
													],
													"destination": [
														"obj-10",
														0
													]
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
														"obj-11",
														0
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
														"obj-11",
														1
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
														"obj-12",
														0
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
														"obj-14",
														0
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
														"obj-14",
														1
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
														"obj-16",
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
														"obj-18",
														0
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
														"obj-20",
														0
													],
													"destination": [
														"obj-21",
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
													]
												}
											},
											{
												"patchline": {
													"source": [
														"obj-23",
														0
													],
													"destination": [
														"obj-24",
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
														"obj-25",
														0
													]
												}
											},
											{
												"patchline": {
													"source": [
														"obj-28",
														0
													],
													"destination": [
														"obj-26",
														0
													]
												}
											}
										]
									},
									"saved_object_attributes": {
										"globalpatchername": ""
									}
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "newobj",
									"text": "p MergeForce",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										195.0,
										330.0,
										105.0,
										22.0
									],
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
											250.0,
											250.0,
											700.0,
											500.0
										],
										"default_fontsize": 12.0,
										"default_fontname": "Arial",
										"gridsize": [
											15.0,
											15.0
										],
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
														50.0,
														40.0,
														30.0,
														30.0
													],
													"comment": "bang to start force merge"
												}
											},
											{
												"box": {
													"id": "obj-2",
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
														50.0,
														90.0,
														135.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-3",
													"maxclass": "message",
													"text": "0",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														120.0,
														24.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-4",
													"maxclass": "newobj",
													"text": "v #0_applied",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														150.0,
														85.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-5",
													"maxclass": "message",
													"text": "0",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														120.0,
														120.0,
														24.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-6",
													"maxclass": "newobj",
													"text": "v #0_preserved",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														120.0,
														150.0,
														95.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-7",
													"maxclass": "message",
													"text": "getkeys",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														170.0,
														120.0,
														52.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-8",
													"maxclass": "newobj",
													"text": "dict #0_defaults",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														150.0,
														120.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-9",
													"maxclass": "newobj",
													"text": "route keys",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														180.0,
														75.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-10",
													"maxclass": "newobj",
													"text": "zl iter 1",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														210.0,
														60.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-11",
													"maxclass": "newobj",
													"text": "t s s",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														240.0,
														88.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-12",
													"maxclass": "newobj",
													"text": "prepend get",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														170.0,
														270.0,
														78.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-13",
													"maxclass": "newobj",
													"text": "dict #0_defaults",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														300.0,
														120.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-14",
													"maxclass": "newobj",
													"text": "prepend set",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														170.0,
														330.0,
														78.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-15",
													"maxclass": "newobj",
													"text": "dict #0_work",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														170.0,
														360.0,
														100.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-16",
													"maxclass": "newobj",
													"text": "v #0_applied",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														350.0,
														270.0,
														85.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-17",
													"maxclass": "newobj",
													"text": "+ 1",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														"int"
													],
													"patching_rect": [
														350.0,
														300.0,
														40.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-18",
													"maxclass": "newobj",
													"text": "v #0_applied",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														350.0,
														330.0,
														85.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-19",
													"maxclass": "outlet",
													"index": 1,
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														50.0,
														400.0,
														30.0,
														30.0
													],
													"comment": "applied count"
												}
											},
											{
												"box": {
													"id": "obj-20",
													"maxclass": "outlet",
													"index": 2,
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														120.0,
														400.0,
														30.0,
														30.0
													],
													"comment": "preserved count (always 0 in force mode)"
												}
											},
											{
												"box": {
													"id": "obj-21",
													"maxclass": "newobj",
													"text": "v #0_applied",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														390.0,
														85.0,
														22.0
													]
												}
											},
											{
												"box": {
													"id": "obj-22",
													"maxclass": "message",
													"text": "0",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														120.0,
														390.0,
														24.0,
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
														"obj-2",
														0
													]
												}
											},
											{
												"patchline": {
													"source": [
														"obj-2",
														0
													],
													"destination": [
														"obj-21",
														0
													],
													"order": 1
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
													],
													"order": 1
												}
											},
											{
												"patchline": {
													"source": [
														"obj-2",
														1
													],
													"destination": [
														"obj-5",
														0
													]
												}
											},
											{
												"patchline": {
													"source": [
														"obj-2",
														2
													],
													"destination": [
														"obj-3",
														0
													],
													"order": 1
												}
											},
											{
												"patchline": {
													"source": [
														"obj-2",
														2
													],
													"destination": [
														"obj-7",
														0
													],
													"order": 1
												}
											},
											{
												"patchline": {
													"source": [
														"obj-3",
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
														"obj-5",
														0
													],
													"destination": [
														"obj-6",
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
													]
												}
											},
											{
												"patchline": {
													"source": [
														"obj-9",
														0
													],
													"destination": [
														"obj-10",
														0
													]
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
														"obj-11",
														1
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
														"obj-12",
														0
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
														"obj-14",
														0
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
														"obj-16",
														0
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
														"obj-21",
														0
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
														"obj-22",
														0
													],
													"destination": [
														"obj-20",
														0
													]
												}
											}
										]
									},
									"saved_object_attributes": {
										"globalpatchername": ""
									}
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										510.0,
										30.0,
										30.0
									],
									"comment": "merged dict name"
								}
							},
							{
								"box": {
									"id": "obj-14",
									"maxclass": "outlet",
									"index": 2,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										195.0,
										510.0,
										30.0,
										30.0
									],
									"comment": "applied count"
								}
							},
							{
								"box": {
									"id": "obj-15",
									"maxclass": "outlet",
									"index": 3,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										282.0,
										510.0,
										30.0,
										30.0
									],
									"comment": "preserved count"
								}
							},
							{
								"box": {
									"id": "obj-16",
									"maxclass": "newobj",
									"text": "t b b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										50.0,
										375.0,
										148.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-17",
									"maxclass": "message",
									"text": "name",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										405.0,
										42.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-18",
									"maxclass": "newobj",
									"text": "dict #0_work",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										435.0,
										100.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-19",
									"maxclass": "newobj",
									"text": "route name",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										465.0,
										75.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-20",
									"maxclass": "newobj",
									"text": "prepend dictionary",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										480.0,
										115.0,
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
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										0
									],
									"destination": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										1
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
										"obj-4",
										0
									],
									"destination": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-5",
										0
									],
									"destination": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3",
										0
									],
									"destination": [
										"obj-6",
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
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-6",
										1
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
									]
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
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-9",
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
										"obj-9",
										1
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
										"obj-10",
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
										"obj-10",
										1
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
										"obj-16",
										0
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
										"obj-16",
										1
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
										"obj-18",
										0
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
										"obj-20",
										0
									],
									"destination": [
										"obj-13",
										0
									]
								}
							}
						]
					},
					"saved_object_attributes": {
						"globalpatchername": ""
					}
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "newobj",
					"text": "p ValidateRequired",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						200.0,
						200.0,
						112.0,
						20.0
					],
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
							200.0,
							200.0,
							700.0,
							500.0
						],
						"default_fontsize": 12.0,
						"default_fontname": "Arial",
						"gridsize": [
							15.0,
							15.0
						],
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
										50.0,
										40.0,
										30.0,
										30.0
									],
									"comment": "bang to validate"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "t b b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										50.0,
										90.0,
										88.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "coll #0_required",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										120.0,
										135.0,
										120.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "sel 0",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										120.0,
										165.0,
										50.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "message",
									"text": "ok",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										120.0,
										195.0,
										24.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "message",
									"text": "dump",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										120.0,
										40.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "newobj",
									"text": "zl reg",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										195.0,
										50.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "newobj",
									"text": "zl iter 1",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										225.0,
										60.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "newobj",
									"text": "prepend contains",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										255.0,
										105.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "newobj",
									"text": "dict #0_work",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										285.0,
										100.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-11",
									"maxclass": "newobj",
									"text": "sel 0",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										50.0,
										315.0,
										50.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-12",
									"maxclass": "newobj",
									"text": "zl group",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										345.0,
										60.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "newobj",
									"text": "prepend missing",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										375.0,
										100.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-14",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										420.0,
										30.0,
										30.0
									],
									"comment": "validation status"
								}
							},
							{
								"box": {
									"id": "obj-15",
									"maxclass": "newobj",
									"text": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										300.0,
										225.0,
										56.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-16",
									"maxclass": "newobj",
									"text": "prepend set",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										300.0,
										165.0,
										75.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-17",
									"maxclass": "newobj",
									"text": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										300.0,
										345.0,
										56.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-18",
									"maxclass": "newobj",
									"text": "prepend append",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										300.0,
										315.0,
										97.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-19",
									"maxclass": "message",
									"text": "length",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										120.0,
										120.0,
										45.0,
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
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										0
									],
									"destination": [
										"obj-6",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										1
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
										"obj-19",
										0
									],
									"destination": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3",
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
										"obj-16",
										0
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
										"obj-3",
										2
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
										"obj-4",
										0
									],
									"destination": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-5",
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
										"obj-6",
										0
									],
									"destination": [
										"obj-7",
										1
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
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-9",
										0
									],
									"destination": [
										"obj-10",
										0
									]
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
										"obj-11",
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
										"obj-18",
										0
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
										"obj-17",
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
										"obj-8",
										1
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
										"obj-12",
										0
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
										"obj-13",
										0
									],
									"destination": [
										"obj-14",
										0
									]
								}
							}
						]
					},
					"saved_object_attributes": {
						"globalpatchername": ""
					}
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "comment",
					"text": "--- EMIT ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						160.0,
						88.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "newobj",
					"text": "t s s",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						56.0,
						112.0,
						160.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"text": "t l l l",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						56.0,
						240.0,
						304.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"text": "pack s i",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						200.0,
						280.0,
						160.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "newobj",
					"text": "prepend applied",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						200.0,
						312.0,
						96.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"text": "prepend preserved",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						344.0,
						312.0,
						112.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "newobj",
					"text": "unpack s i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"int"
					],
					"patching_rect": [
						200.0,
						240.0,
						160.0,
						20.0
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
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-2",
						0
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
						"obj-13",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-8",
						1
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
						"obj-8",
						2
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
						"obj-9",
						1
					],
					"destination": [
						"obj-10",
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
						"obj-15",
						1
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
						"obj-15",
						2
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
						"obj-15",
						3
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
						"obj-15",
						4
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
						"obj-15",
						5
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
						"obj-16",
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
						"obj-17",
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
						"obj-18",
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
						"obj-19",
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
						"obj-22",
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
						"obj-24",
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
						"obj-28",
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
						"obj-28",
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
						"obj-25",
						0
					],
					"destination": [
						"obj-29",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-29",
						0
					],
					"destination": [
						"obj-3",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-29",
						1
					],
					"destination": [
						"obj-33",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-29",
						2
					],
					"destination": [
						"obj-26",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						1
					],
					"destination": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						2
					],
					"destination": [
						"obj-30",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-33",
						0
					],
					"destination": [
						"obj-31",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-33",
						1
					],
					"destination": [
						"obj-32",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-31",
						0
					],
					"destination": [
						"obj-5",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-32",
						0
					],
					"destination": [
						"obj-5",
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
						"obj-4",
						0
					]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
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
		"description": "Key-value cache with time-to-live expiration",
		"digest": "Store and retrieve values with automatic expiry",
		"tags": "utility cache ttl expiry dictionary",
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
					"comment": "commands: set, get, has, invalidate, clear"
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
					"comment": "control: ttl, bypass, sweep, reset"
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
					"comment": "hits: hit key value..."
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
					"comment": "misses/status: miss key, invalidated key, cleared, ok"
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
						680.0,
						744.0,
						30.0,
						30.0
					],
					"comment": "diagnostics: size N"
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
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"text": "patcherargs 1000",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						800.0,
						64.0,
						96.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"text": "t l b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						800.0,
						96.0,
						42.0,
						22.0
					],
					"comment": "R-to-L: init defaults (first), send ttl (second)"
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"text": "prepend ttl",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800.0,
						128.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						880.0,
						96.0,
						48.0,
						22.0
					],
					"comment": "R-to-L: bypass=0 (first), clear dicts (second)"
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "message",
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						912.0,
						128.0,
						25.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						912.0,
						152.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "message",
					"text": "clear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						880.0,
						128.0,
						32.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"text": "t s s",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						880.0,
						152.0,
						42.0,
						22.0
					],
					"comment": "R-to-L: clear expiry (first), clear values (second)"
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"text": "dict #0_values",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						880.0,
						176.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"text": "dict #0_expiry",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						912.0,
						176.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "comment",
					"text": "--- CONTROL ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						560.0,
						56.0,
						100.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"text": "route ttl bypass sweep reset",
					"numinlets": 1,
					"numoutlets": 5,
					"outlettype": [
						"",
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						560.0,
						80.0,
						168.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"text": "v #0_ttl",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						560.0,
						112.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"text": "v #0_bypass",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						600.0,
						112.0,
						64.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"text": "s #0_sweep",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						640.0,
						112.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "newobj",
					"text": "s #0_reset",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						680.0,
						112.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "comment",
					"text": "--- COMMAND ROUTER ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						56.0,
						150.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"text": "route set get has invalidate clear",
					"numinlets": 1,
					"numoutlets": 6,
					"outlettype": [
						"",
						"",
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						56.0,
						80.0,
						208.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "comment",
					"text": "--- SET ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						56.0,
						112.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"text": "p SetCmd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						56.0,
						136.0,
						56.0,
						22.0
					],
					"patcher": {
						"fileversion": 1,
						"classnamespace": "box",
						"rect": [
							200.0,
							200.0,
							520.0,
							400.0
						],
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
										30.0,
										30.0,
										30.0
									],
									"comment": "key value... from route set"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "t l l b",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"",
										"",
										"bang"
									],
									"patching_rect": [
										50.0,
										75.0,
										200.0,
										22.0
									],
									"comment": "R-to-L: compute expiry (1st), store key/value (2nd), output ok (3rd)"
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "t b f",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"float"
									],
									"patching_rect": [
										235.0,
										105.0,
										56.0,
										22.0
									],
									"comment": "R-to-L: store cpuclock (1st), get ttl (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-3b",
									"maxclass": "newobj",
									"text": "cpuclock",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										235.0,
										135.0,
										56.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "v #0_ttl",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										276.0,
										135.0,
										48.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "+",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										235.0,
										165.0,
										56.0,
										22.0
									],
									"comment": "expiry = cpuclock + ttl"
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "v #0_expirytime",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										235.0,
										195.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "newobj",
									"text": "zl slice 1",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										130.0,
										105.0,
										64.0,
										22.0
									],
									"comment": "split key from value"
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "newobj",
									"text": "v #0_setkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										130.0,
										135.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-20",
									"maxclass": "newobj",
									"text": "v #0_setval",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										178.0,
										135.0,
										56.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "newobj",
									"text": "t b b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										130.0,
										165.0,
										80.0,
										22.0
									],
									"comment": "R-to-L: set expiry (1st), set value (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "newobj",
									"text": "t s s",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										195.0,
										195.0,
										48.0,
										22.0
									],
									"comment": "R-to-L: get expiry (1st), get key for pack (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-10b",
									"maxclass": "newobj",
									"text": "v #0_setkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										195.0,
										225.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-11",
									"maxclass": "newobj",
									"text": "v #0_expirytime",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										228.0,
										225.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-12",
									"maxclass": "newobj",
									"text": "pack s f",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										195.0,
										255.0,
										48.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "newobj",
									"text": "prepend set",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										195.0,
										285.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-14",
									"maxclass": "newobj",
									"text": "dict #0_expiry",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										195.0,
										315.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-15",
									"maxclass": "newobj",
									"text": "t s s",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										130.0,
										195.0,
										48.0,
										22.0
									],
									"comment": "R-to-L: get value (1st), get key for pack (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-15b",
									"maxclass": "newobj",
									"text": "v #0_setkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										130.0,
										225.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-16",
									"maxclass": "newobj",
									"text": "v #0_setval",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										163.0,
										225.0,
										56.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-17",
									"maxclass": "newobj",
									"text": "pack s s",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										130.0,
										255.0,
										48.0,
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
										130.0,
										285.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-19",
									"maxclass": "newobj",
									"text": "dict #0_values",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										130.0,
										315.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-21",
									"maxclass": "message",
									"text": "ok",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										105.0,
										25.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-out",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										315.0,
										30.0,
										30.0
									],
									"comment": "ok status"
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
										2
									],
									"destination": [
										"obj-3",
										0
									],
									"comment": "compute expiry (fires 1st)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3",
										1
									],
									"destination": [
										"obj-4",
										0
									],
									"comment": "get cpuclock (fires 1st from t)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3",
										0
									],
									"destination": [
										"obj-3b",
										0
									],
									"comment": "get ttl (fires 2nd from t)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-3b",
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
										"obj-4",
										0
									],
									"destination": [
										"obj-5",
										1
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
										1
									],
									"destination": [
										"obj-7",
										0
									],
									"comment": "store key/value (fires 2nd)"
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
										"obj-7",
										1
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
										1
									],
									"destination": [
										"obj-10",
										0
									],
									"comment": "set expiry (fires 1st)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-10",
										1
									],
									"destination": [
										"obj-11",
										0
									],
									"comment": "get key (fires 1st from inner t)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-10",
										0
									],
									"destination": [
										"obj-10b",
										0
									],
									"comment": "get expiry (fires 2nd from inner t)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-10b",
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
										0
									],
									"destination": [
										"obj-12",
										1
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
										"obj-9",
										0
									],
									"destination": [
										"obj-15",
										0
									],
									"comment": "set value (fires 2nd)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-15",
										1
									],
									"destination": [
										"obj-16",
										0
									],
									"comment": "get key (fires 1st from inner t)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-15",
										0
									],
									"destination": [
										"obj-15b",
										0
									],
									"comment": "get value (fires 2nd from inner t)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-15b",
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
										0
									],
									"destination": [
										"obj-17",
										1
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
										"obj-2",
										0
									],
									"destination": [
										"obj-21",
										0
									],
									"comment": "output ok (fires last)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-21",
										0
									],
									"destination": [
										"obj-out",
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
					"id": "obj-28",
					"maxclass": "comment",
					"text": "--- GET ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						120.0,
						112.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"text": "p GetCmd",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						120.0,
						136.0,
						56.0,
						22.0
					],
					"patcher": {
						"fileversion": 1,
						"classnamespace": "box",
						"rect": [
							200.0,
							200.0,
							560.0,
							560.0
						],
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
										30.0,
										30.0,
										30.0
									],
									"comment": "key from route get"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "t s s",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										75.0,
										120.0,
										22.0
									],
									"comment": "R-to-L: store key (1st), check existence (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "v #0_getkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										155.0,
										105.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "prepend contains",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										105.0,
										96.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "dict #0_values",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										135.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "sel 1 0",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"bang",
										"bang",
										""
									],
									"patching_rect": [
										50.0,
										165.0,
										100.0,
										22.0
									],
									"comment": "1=found, 0=not found"
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "newobj",
									"text": "v #0_getkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										195.0,
										64.0,
										22.0
									],
									"comment": "found: check expiry"
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "newobj",
									"text": "prepend get",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										225.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "newobj",
									"text": "dict #0_expiry",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										255.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "newobj",
									"text": "t f b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"float",
										"bang"
									],
									"patching_rect": [
										50.0,
										285.0,
										80.0,
										22.0
									],
									"comment": "R-to-L: get cpuclock (1st), compare (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-11",
									"maxclass": "newobj",
									"text": "cpuclock",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										115.0,
										315.0,
										56.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-12",
									"maxclass": "newobj",
									"text": ">",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										50.0,
										345.0,
										30.0,
										22.0
									],
									"comment": "expiry > now? (still valid)"
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "newobj",
									"text": "sel 1 0",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"bang",
										"bang",
										""
									],
									"patching_rect": [
										50.0,
										375.0,
										100.0,
										22.0
									],
									"comment": "1=valid (hit), 0=expired (miss)"
								}
							},
							{
								"box": {
									"id": "obj-14",
									"maxclass": "newobj",
									"text": "v #0_getkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										405.0,
										64.0,
										22.0
									],
									"comment": "valid: get value"
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
										50.0,
										435.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-16",
									"maxclass": "newobj",
									"text": "dict #0_values",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										465.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-17",
									"maxclass": "newobj",
									"text": "t s s",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										495.0,
										48.0,
										22.0
									],
									"comment": "R-to-L: store value (1st), get key (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-17b",
									"maxclass": "newobj",
									"text": "v #0_getval",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										83.0,
										525.0,
										60.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-17c",
									"maxclass": "newobj",
									"text": "v #0_getkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										525.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-18",
									"maxclass": "newobj",
									"text": "t s s",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										555.0,
										48.0,
										22.0
									],
									"comment": "R-to-L: get value (1st), build output (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-18b",
									"maxclass": "newobj",
									"text": "v #0_getval",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										83.0,
										585.0,
										60.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-18c",
									"maxclass": "newobj",
									"text": "pack s s",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										615.0,
										48.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-18d",
									"maxclass": "newobj",
									"text": "prepend hit",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										645.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-19",
									"maxclass": "newobj",
									"text": "t b b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										135.0,
										405.0,
										48.0,
										22.0
									],
									"comment": "R-to-L: invalidate (1st), output miss (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-20",
									"maxclass": "newobj",
									"text": "v #0_getkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										168.0,
										435.0,
										64.0,
										22.0
									],
									"comment": "lazy delete expired entry"
								}
							},
							{
								"box": {
									"id": "obj-20b",
									"maxclass": "newobj",
									"text": "s #0_lazy_invalidate",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										168.0,
										465.0,
										72.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-21",
									"maxclass": "newobj",
									"text": "v #0_getkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										135.0,
										195.0,
										64.0,
										22.0
									],
									"comment": "not found: miss"
								}
							},
							{
								"box": {
									"id": "obj-22",
									"maxclass": "newobj",
									"text": "prepend miss",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										135.0,
										225.0,
										72.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-23",
									"maxclass": "newobj",
									"text": "v #0_getkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										135.0,
										435.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-24",
									"maxclass": "newobj",
									"text": "prepend miss",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										135.0,
										465.0,
										72.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-out1",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										675.0,
										30.0,
										30.0
									],
									"comment": "hit key value"
								}
							},
							{
								"box": {
									"id": "obj-out2",
									"maxclass": "outlet",
									"index": 2,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										135.0,
										675.0,
										30.0,
										30.0
									],
									"comment": "miss key"
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
										1
									],
									"destination": [
										"obj-3",
										0
									],
									"comment": "store key (fires 1st)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-2",
										0
									],
									"destination": [
										"obj-4",
										0
									],
									"comment": "check contains (fires 2nd)"
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
										"obj-7",
										0
									],
									"comment": "found: check expiry"
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
										1
									],
									"destination": [
										"obj-11",
										0
									],
									"comment": "get cpuclock (fires 1st)"
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
										1
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
										"obj-12",
										0
									],
									"comment": "compare expiry > now (fires 2nd)"
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
									],
									"comment": "valid: hit"
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
										"obj-17",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-17",
										1
									],
									"destination": [
										"obj-17b",
										0
									],
									"comment": "store value (fires 1st)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-17",
										0
									],
									"destination": [
										"obj-17c",
										0
									],
									"comment": "get key (fires 2nd)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-17c",
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
										1
									],
									"destination": [
										"obj-18b",
										0
									],
									"comment": "get value (fires 1st)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-18",
										0
									],
									"destination": [
										"obj-18c",
										0
									],
									"comment": "build output (fires 2nd)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-18b",
										0
									],
									"destination": [
										"obj-18c",
										1
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-18c",
										0
									],
									"destination": [
										"obj-18d",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-18d",
										0
									],
									"destination": [
										"obj-out1",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-13",
										1
									],
									"destination": [
										"obj-19",
										0
									],
									"comment": "expired: lazy delete + miss"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-19",
										1
									],
									"destination": [
										"obj-20",
										0
									],
									"comment": "invalidate (fires 1st)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-20",
										0
									],
									"destination": [
										"obj-20b",
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
										"obj-23",
										0
									],
									"comment": "output miss (fires 2nd)"
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
										"obj-24",
										0
									],
									"destination": [
										"obj-out2",
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
										"obj-21",
										0
									],
									"comment": "not found: miss"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-21",
										0
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
										"obj-22",
										0
									],
									"destination": [
										"obj-out2",
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
					"id": "obj-30",
					"maxclass": "comment",
					"text": "--- HAS ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						184.0,
						112.0,
						80.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "newobj",
					"text": "p HasCmd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						184.0,
						136.0,
						56.0,
						22.0
					],
					"patcher": {
						"fileversion": 1,
						"classnamespace": "box",
						"rect": [
							200.0,
							200.0,
							500.0,
							500.0
						],
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
										30.0,
										30.0,
										30.0
									],
									"comment": "key from route has"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "t s s",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										75.0,
										120.0,
										22.0
									],
									"comment": "R-to-L: store key (1st), check (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "v #0_haskey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										155.0,
										105.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "prepend contains",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										105.0,
										96.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "dict #0_values",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										135.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "sel 1 0",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"bang",
										"bang",
										""
									],
									"patching_rect": [
										50.0,
										165.0,
										100.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "newobj",
									"text": "v #0_haskey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										195.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "newobj",
									"text": "prepend get",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										225.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "newobj",
									"text": "dict #0_expiry",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										255.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "newobj",
									"text": "t f b",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"float",
										"bang"
									],
									"patching_rect": [
										50.0,
										285.0,
										80.0,
										22.0
									],
									"comment": "R-to-L: get cpuclock (1st), compare (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-11",
									"maxclass": "newobj",
									"text": "cpuclock",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										115.0,
										315.0,
										56.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-12",
									"maxclass": "newobj",
									"text": ">",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										50.0,
										345.0,
										30.0,
										22.0
									],
									"comment": "expiry > now?"
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "newobj",
									"text": "sel 1 0",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"bang",
										"bang",
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
									"maxclass": "message",
									"text": "1",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										405.0,
										25.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-15",
									"maxclass": "message",
									"text": "0",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										135.0,
										195.0,
										25.0,
										22.0
									]
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
										135.0,
										405.0,
										48.0,
										22.0
									],
									"comment": "R-to-L: lazy invalidate (1st), output 0 (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-17",
									"maxclass": "newobj",
									"text": "v #0_haskey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										168.0,
										435.0,
										64.0,
										22.0
									],
									"comment": "expired: lazy invalidate"
								}
							},
							{
								"box": {
									"id": "obj-18",
									"maxclass": "newobj",
									"text": "s #0_lazy_invalidate",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										168.0,
										465.0,
										72.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-19",
									"maxclass": "message",
									"text": "0",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										135.0,
										435.0,
										25.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-out",
									"maxclass": "outlet",
									"index": 1,
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										465.0,
										30.0,
										30.0
									],
									"comment": "1 or 0"
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
										"obj-2",
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
										1
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
										1
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
										"obj-out",
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
										"obj-15",
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
										"obj-out",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-13",
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
										"obj-16",
										1
									],
									"destination": [
										"obj-17",
										0
									],
									"comment": "lazy invalidate (fires 1st)"
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
										"obj-16",
										0
									],
									"destination": [
										"obj-19",
										0
									],
									"comment": "output 0 (fires 2nd)"
								}
							},
							{
								"patchline": {
									"source": [
										"obj-19",
										0
									],
									"destination": [
										"obj-out",
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
					"id": "obj-32",
					"maxclass": "comment",
					"text": "--- INVALIDATE ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						248.0,
						112.0,
						120.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "newobj",
					"text": "p InvalidateCmd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						248.0,
						184.0,
						88.0,
						22.0
					],
					"patcher": {
						"fileversion": 1,
						"classnamespace": "box",
						"rect": [
							200.0,
							200.0,
							400.0,
							300.0
						],
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
										30.0,
										30.0,
										30.0
									],
									"comment": "key to invalidate"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "t s s s",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"",
										"",
										""
									],
									"patching_rect": [
										50.0,
										75.0,
										150.0,
										22.0
									],
									"comment": "R-to-L: remove expiry (1st), remove values (2nd), output status (3rd)"
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "prepend remove",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										185.0,
										105.0,
										88.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "dict #0_expiry",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										185.0,
										135.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "prepend remove",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										115.0,
										105.0,
										88.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "dict #0_values",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										115.0,
										135.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "newobj",
									"text": "prepend invalidated",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										105.0,
										104.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-out",
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
									"comment": "invalidated key"
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
										2
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
										"obj-out",
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
					"id": "obj-60",
					"maxclass": "newobj",
					"text": "r #0_lazy_invalidate",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [""],
					"patching_rect": [296.0, 216.0, 110.0, 22.0],
					"comment": "lazy expiry from get/has/sweep (no status output)"
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "newobj",
					"text": "p SilentInvalidate",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [296.0, 240.0, 104.0, 22.0],
					"patcher": {
						"fileversion": 1,
						"classnamespace": "box",
						"rect": [200.0, 200.0, 400.0, 250.0],
						"gridsize": [15.0, 15.0],
						"boxes": [
							{
								"box": {
									"id": "obj-1",
									"maxclass": "inlet",
									"index": 1,
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [50.0, 40.0, 30.0, 30.0],
									"comment": "key to silently invalidate"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"text": "t s s",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": ["", ""],
									"patching_rect": [50.0, 90.0, 120.0, 22.0],
									"comment": "R-to-L: remove from expiry (first), remove from values (second)"
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "prepend remove",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [155.0, 120.0, 88.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "dict #0_expiry",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": ["", ""],
									"patching_rect": [155.0, 150.0, 80.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "newobj",
									"text": "prepend remove",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [""],
									"patching_rect": [50.0, 120.0, 88.0, 22.0]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "dict #0_values",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": ["", ""],
									"patching_rect": [50.0, 150.0, 80.0, 22.0]
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"source": ["obj-1", 0],
									"destination": ["obj-2", 0]
								}
							},
							{
								"patchline": {
									"source": ["obj-2", 1],
									"destination": ["obj-3", 0],
									"comment": "remove from expiry (fires first)"
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
									"source": ["obj-2", 0],
									"destination": ["obj-5", 0],
									"comment": "remove from values (fires second)"
								}
							},
							{
								"patchline": {
									"source": ["obj-5", 0],
									"destination": ["obj-6", 0]
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
					"id": "obj-35",
					"maxclass": "comment",
					"text": "--- CLEAR ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						344.0,
						112.0,
						90.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "newobj",
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						344.0,
						136.0,
						80.0,
						22.0
					],
					"comment": "R-to-L: clear dicts (1st), output status (2nd)"
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "message",
					"text": "clear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						408.0,
						160.0,
						32.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "newobj",
					"text": "t s s",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						408.0,
						184.0,
						48.0,
						22.0
					],
					"comment": "R-to-L: clear expiry (1st), clear values (2nd)"
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"text": "dict #0_values",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						408.0,
						208.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"text": "dict #0_expiry",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						440.0,
						208.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "message",
					"text": "cleared",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						344.0,
						160.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "comment",
					"text": "--- SWEEP ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						560.0,
						160.0,
						90.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"text": "r #0_sweep",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						560.0,
						184.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "newobj",
					"text": "p SweepCmd",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						560.0,
						208.0,
						72.0,
						22.0
					],
					"patcher": {
						"fileversion": 1,
						"classnamespace": "box",
						"rect": [
							200.0,
							200.0,
							520.0,
							480.0
						],
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
										30.0,
										30.0,
										30.0
									],
									"comment": "bang to sweep"
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
										75.0,
										200.0,
										22.0
									],
									"comment": "R-to-L: get cpuclock (1st), iterate keys (2nd), getsize (3rd)"
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"text": "cpuclock",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										235.0,
										105.0,
										56.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"text": "v #0_sweepnow",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										235.0,
										135.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "message",
									"text": "getkeys",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										130.0,
										105.0,
										48.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"text": "dict #0_expiry",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										130.0,
										135.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "newobj",
									"text": "route keys",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										130.0,
										165.0,
										64.0,
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
										130.0,
										195.0,
										56.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "newobj",
									"text": "t s s",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										130.0,
										225.0,
										80.0,
										22.0
									],
									"comment": "R-to-L: store key (1st), get expiry (2nd)"
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "newobj",
									"text": "v #0_sweepkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										195.0,
										255.0,
										72.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-11",
									"maxclass": "newobj",
									"text": "prepend get",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										130.0,
										255.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-12",
									"maxclass": "newobj",
									"text": "dict #0_expiry",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										130.0,
										285.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "newobj",
									"text": "v #0_sweepnow",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										130.0,
										315.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-14",
									"maxclass": "newobj",
									"text": ">",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										130.0,
										345.0,
										30.0,
										22.0
									],
									"comment": "expiry > now? still valid"
								}
							},
							{
								"box": {
									"id": "obj-15",
									"maxclass": "newobj",
									"text": "sel 0",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										130.0,
										375.0,
										36.0,
										22.0
									],
									"comment": "0 = expired, invalidate"
								}
							},
							{
								"box": {
									"id": "obj-16",
									"maxclass": "newobj",
									"text": "v #0_sweepkey",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										130.0,
										405.0,
										72.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-17",
									"maxclass": "newobj",
									"text": "s #0_lazy_invalidate",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										130.0,
										435.0,
										72.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-18",
									"maxclass": "message",
									"text": "getsize",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										105.0,
										48.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-19",
									"maxclass": "newobj",
									"text": "dict #0_values",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										135.0,
										80.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-20",
									"maxclass": "newobj",
									"text": "route size",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										165.0,
										64.0,
										22.0
									]
								}
							},
							{
								"box": {
									"id": "obj-21",
									"maxclass": "newobj",
									"text": "prepend size",
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
							},
							{
								"box": {
									"id": "obj-out",
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
									"comment": "size N"
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
										2
									],
									"destination": [
										"obj-3",
										0
									],
									"comment": "get cpuclock (fires 1st)"
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
										"obj-2",
										1
									],
									"destination": [
										"obj-5",
										0
									],
									"comment": "iterate keys (fires 2nd)"
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
										"obj-17",
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
										"obj-18",
										0
									],
									"comment": "getsize (fires 3rd/last)"
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
										"obj-21",
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
										"obj-out",
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
					"id": "obj-45",
					"maxclass": "comment",
					"text": "--- RESET ---",
					"fontface": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						760.0,
						208.0,
						90.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "newobj",
					"text": "r #0_reset",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						760.0,
						232.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						760.0,
						256.0,
						80.0,
						22.0
					],
					"comment": "R-to-L: restore default ttl (1st), clear (2nd)"
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "newobj",
					"text": "patcherargs 1000",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						824.0,
						280.0,
						96.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "newobj",
					"text": "v #0_ttl",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						824.0,
						304.0,
						48.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "message",
					"text": "clear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						760.0,
						280.0,
						32.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "newobj",
					"text": "t s s",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						760.0,
						304.0,
						48.0,
						22.0
					],
					"comment": "R-to-L: clear expiry (1st), clear values (2nd)"
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "newobj",
					"text": "dict #0_values",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						760.0,
						328.0,
						80.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "newobj",
					"text": "dict #0_expiry",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						792.0,
						328.0,
						80.0,
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
						"obj-25",
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
						"obj-27",
						0
					],
					"comment": "set"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						1
					],
					"destination": [
						"obj-29",
						0
					],
					"comment": "get"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						2
					],
					"destination": [
						"obj-31",
						0
					],
					"comment": "has"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						3
					],
					"destination": [
						"obj-34",
						0
					],
					"comment": "invalidate"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						4
					],
					"destination": [
						"obj-36",
						0
					],
					"comment": "clear"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-27",
						0
					],
					"destination": [
						"obj-4",
						0
					],
					"comment": "set -> ok status"
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
					],
					"comment": "get -> hit"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-29",
						1
					],
					"destination": [
						"obj-4",
						0
					],
					"comment": "get -> miss"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-31",
						0
					],
					"destination": [
						"obj-4",
						0
					],
					"comment": "has -> 1/0"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-61",
						0
					],
					"comment": "lazy expiry invalidation (silent, no status output)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-34",
						0
					],
					"destination": [
						"obj-4",
						0
					],
					"comment": "invalidated key"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-36",
						1
					],
					"destination": [
						"obj-37",
						0
					],
					"comment": "clear dicts (fires 1st)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-36",
						0
					],
					"destination": [
						"obj-41",
						0
					],
					"comment": "output cleared status (fires 2nd)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						0
					],
					"destination": [
						"obj-38",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						0
					],
					"destination": [
						"obj-39",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						1
					],
					"destination": [
						"obj-40",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						0
					],
					"destination": [
						"obj-4",
						0
					],
					"comment": "cleared status"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-2",
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
					],
					"comment": "ttl"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						1
					],
					"destination": [
						"obj-21",
						0
					],
					"comment": "bypass"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						2
					],
					"destination": [
						"obj-22",
						0
					],
					"comment": "sweep"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						3
					],
					"destination": [
						"obj-23",
						0
					],
					"comment": "reset"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-43",
						0
					],
					"destination": [
						"obj-44",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-44",
						0
					],
					"destination": [
						"obj-5",
						0
					],
					"comment": "sweep -> size diagnostics"
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
					],
					"comment": "prepend ttl to patcherargs -> control route"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-9",
						1
					],
					"destination": [
						"obj-11",
						0
					],
					"comment": "init defaults"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						0
					],
					"destination": [
						"obj-19",
						0
					],
					"comment": "send ttl from init"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-11",
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
						"obj-46",
						0
					],
					"destination": [
						"obj-47",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						1
					],
					"destination": [
						"obj-48",
						0
					],
					"comment": "restore default ttl (fires 1st)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						0
					],
					"destination": [
						"obj-50",
						0
					],
					"comment": "clear (fires 2nd)"
				}
			},
			{
				"patchline": {
					"source": [
						"obj-48",
						0
					],
					"destination": [
						"obj-49",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-50",
						0
					],
					"destination": [
						"obj-51",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-52",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						1
					],
					"destination": [
						"obj-53",
						0
					]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
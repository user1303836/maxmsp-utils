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
      800.0,
      720.0
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
    "description": "Signal-rate Schmitt trigger with hysteresis and edge bang outputs",
    "digest": "Threshold detector with hysteresis, state signal, and edge bangs",
    "tags": "utility signal threshold hysteresis edge schmitt",
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
            "signal"
          ],
          "patching_rect": [
            56.0,
            24.0,
            30.0,
            30.0
          ],
          "comment": "signal input"
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
            200.0,
            24.0,
            30.0,
            30.0
          ],
          "comment": "low threshold (float)"
        }
      },
      {
        "box": {
          "id": "obj-3",
          "maxclass": "inlet",
          "index": 3,
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            328.0,
            24.0,
            30.0,
            30.0
          ],
          "comment": "high threshold (float)"
        }
      },
      {
        "box": {
          "id": "obj-4",
          "maxclass": "inlet",
          "index": 4,
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480.0,
            24.0,
            30.0,
            30.0
          ],
          "comment": "control: low, high, init, reset, bypass"
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
            56.0,
            664.0,
            30.0,
            30.0
          ],
          "comment": "state signal (0. or 1.)"
        }
      },
      {
        "box": {
          "id": "obj-6",
          "maxclass": "outlet",
          "index": 2,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            200.0,
            664.0,
            30.0,
            30.0
          ],
          "comment": "rising-edge bang"
        }
      },
      {
        "box": {
          "id": "obj-7",
          "maxclass": "outlet",
          "index": 3,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            328.0,
            664.0,
            30.0,
            30.0
          ],
          "comment": "falling-edge bang"
        }
      },
      {
        "box": {
          "id": "obj-8",
          "maxclass": "outlet",
          "index": 4,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            480.0,
            664.0,
            30.0,
            30.0
          ],
          "comment": "status (state, thresholds)"
        }
      },
      {
        "box": {
          "id": "obj-10",
          "maxclass": "newobj",
          "text": "loadbang",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            "bang"
          ],
          "patching_rect": [
            200.0,
            64.0,
            52.0,
            20.0
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
            200.0,
            88.0,
            120.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-12",
          "maxclass": "message",
          "text": "1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            304.0,
            88.0,
            24.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-13",
          "maxclass": "newobj",
          "text": "s #0_sel",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            304.0,
            112.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-14",
          "maxclass": "newobj",
          "text": "patcherargs 0.4 0.6",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            200.0,
            112.0,
            112.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-15",
          "maxclass": "newobj",
          "text": "unpack f f",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "float",
            "float"
          ],
          "patching_rect": [
            200.0,
            136.0,
            144.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-16",
          "maxclass": "comment",
          "text": "-- init: patcherargs -> unpack low high --",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            360.0,
            136.0,
            248.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-20",
          "maxclass": "newobj",
          "text": "s #0_set_low",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            200.0,
            160.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-21",
          "maxclass": "newobj",
          "text": "s #0_set_high",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            328.0,
            160.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-25",
          "maxclass": "newobj",
          "text": "r #0_set_low",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200.0,
            200.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-26",
          "maxclass": "newobj",
          "text": "r #0_set_high",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            328.0,
            200.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-27",
          "maxclass": "newobj",
          "text": "t f f",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "float",
            "float"
          ],
          "patching_rect": [
            200.0,
            224.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-28",
          "maxclass": "newobj",
          "text": "sig~ 0.4",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            200.0,
            248.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-29",
          "maxclass": "newobj",
          "text": "v #0_low 0.4",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            264.0,
            248.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-30",
          "maxclass": "newobj",
          "text": "t f f",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "float",
            "float"
          ],
          "patching_rect": [
            328.0,
            224.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-31",
          "maxclass": "newobj",
          "text": "sig~ 0.6",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            328.0,
            248.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-32",
          "maxclass": "newobj",
          "text": "v #0_high 0.6",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            392.0,
            248.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-35",
          "maxclass": "comment",
          "text": "-- gen~ Schmitt trigger (per-sample hysteresis with threshold clamping) --",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            56.0,
            288.0,
            440.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-36",
          "maxclass": "newobj",
          "text": "gen~",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            56.0,
            312.0,
            288.0,
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
            "classnamespace": "dsp.gen",
            "rect": [
              200.0,
              200.0,
              500.0,
              360.0
            ],
            "bglocked": 0,
            "openinpresentation": 0,
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
                  "maxclass": "newobj",
                  "text": "in 1",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    30.0,
                    30.0,
                    22.0
                  ],
                  "comment": "signal input"
                }
              },
              {
                "box": {
                  "id": "obj-2",
                  "maxclass": "newobj",
                  "text": "in 2",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    195.0,
                    30.0,
                    30.0,
                    22.0
                  ],
                  "comment": "low threshold"
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "newobj",
                  "text": "in 3",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    360.0,
                    30.0,
                    30.0,
                    22.0
                  ],
                  "comment": "high threshold"
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "codebox",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    90.0,
                    345.0,
                    120.0
                  ],
                  "code": "History state(0);\n\n// clamp: ensure lo <= hi\nlo = min(in2, in3);\nhi = max(in2, in3);\n\n// Schmitt trigger logic\nabove_high = in1 > hi;\nbelow_low = in1 < lo;\nstate = above_high ? 1 : (below_low ? 0 : state);\n\nout1 = state;"
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "out 1",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    30.0,
                    240.0,
                    35.0,
                    22.0
                  ],
                  "comment": "state (0./1.)"
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
                    "obj-4",
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
                    1
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
                    2
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
              }
            ]
          }
        }
      },
      {
        "box": {
          "id": "obj-37",
          "maxclass": "newobj",
          "text": ">~ 0.5",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            152.0,
            312.0,
            48.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-38",
          "maxclass": "comment",
          "text": "bypass: simple >0.5 comparator",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            152.0,
            336.0,
            192.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-40",
          "maxclass": "newobj",
          "text": "selector~ 2",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            56.0,
            368.0,
            112.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-41",
          "maxclass": "comment",
          "text": "1=gen~ (normal), 2=bypass",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            176.0,
            368.0,
            160.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-42",
          "maxclass": "newobj",
          "text": "r #0_sel",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            56.0,
            344.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-45",
          "maxclass": "newobj",
          "text": "edge~",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "bang",
            "bang"
          ],
          "patching_rect": [
            200.0,
            424.0,
            144.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-46",
          "maxclass": "comment",
          "text": "-- rising / falling edge detection --",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            200.0,
            408.0,
            224.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-50",
          "maxclass": "newobj",
          "text": "t b b",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "bang",
            "bang"
          ],
          "patching_rect": [
            200.0,
            456.0,
            120.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-51",
          "maxclass": "newobj",
          "text": "t b b",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "bang",
            "bang"
          ],
          "patching_rect": [
            328.0,
            456.0,
            120.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-52",
          "maxclass": "message",
          "text": "state 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            304.0,
            488.0,
            48.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-53",
          "maxclass": "message",
          "text": "state 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            432.0,
            488.0,
            48.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-54",
          "maxclass": "newobj",
          "text": "s #0_status",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            304.0,
            512.0,
            72.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-55",
          "maxclass": "newobj",
          "text": "s #0_status",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            432.0,
            512.0,
            72.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-56",
          "maxclass": "newobj",
          "text": "r #0_status",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480.0,
            632.0,
            72.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-60",
          "maxclass": "newobj",
          "text": "route low high init reset bypass",
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
            480.0,
            64.0,
            192.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-61",
          "maxclass": "comment",
          "text": "-- control dispatch --",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            480.0,
            48.0,
            136.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-62",
          "maxclass": "newobj",
          "text": "s #0_set_low",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            480.0,
            96.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-63",
          "maxclass": "newobj",
          "text": "s #0_set_high",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            520.0,
            96.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-64",
          "maxclass": "newobj",
          "text": "t i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "int"
          ],
          "patching_rect": [
            560.0,
            96.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-65",
          "maxclass": "newobj",
          "text": "v #0_state",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            560.0,
            120.0,
            64.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-66",
          "maxclass": "newobj",
          "text": "prepend state",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            600.0,
            120.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-67",
          "maxclass": "newobj",
          "text": "s #0_status",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            600.0,
            144.0,
            72.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-70",
          "maxclass": "newobj",
          "text": "t b b b b b",
          "numinlets": 1,
          "numoutlets": 5,
          "outlettype": [
            "bang",
            "bang",
            "bang",
            "bang",
            "bang"
          ],
          "patching_rect": [
            616.0,
            96.0,
            112.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-71",
          "maxclass": "message",
          "text": "0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            616.0,
            120.0,
            24.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-72",
          "maxclass": "newobj",
          "text": "v #0_state",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            616.0,
            144.0,
            64.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-74",
          "maxclass": "newobj",
          "text": "s #0_set_low",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            656.0,
            144.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-76",
          "maxclass": "newobj",
          "text": "s #0_set_high",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            696.0,
            144.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-77",
          "maxclass": "message",
          "text": "0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            744.0,
            120.0,
            24.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-78",
          "maxclass": "newobj",
          "text": "v #0_bypass",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            744.0,
            144.0,
            72.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-80",
          "maxclass": "newobj",
          "text": "t i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "int"
          ],
          "patching_rect": [
            672.0,
            96.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-81",
          "maxclass": "newobj",
          "text": "v #0_bypass 0",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            672.0,
            120.0,
            88.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-82",
          "maxclass": "newobj",
          "text": "+ 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            704.0,
            120.0,
            32.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-83",
          "maxclass": "newobj",
          "text": "s #0_sel",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            704.0,
            144.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-85",
          "maxclass": "newobj",
          "text": "p ThresholdReport",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200.0,
            560.0,
            144.0,
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
              400.0,
              300.0
            ],
            "bglocked": 0,
            "openinpresentation": 0,
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
                    30.0,
                    30.0,
                    30.0,
                    30.0
                  ],
                  "comment": "low"
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
                    180.0,
                    30.0,
                    30.0,
                    30.0
                  ],
                  "comment": "high"
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
                    30.0,
                    225.0,
                    30.0,
                    30.0
                  ],
                  "comment": "thresholds low high"
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "pack f f",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    120.0,
                    165.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "prepend thresholds",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    165.0,
                    113.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "newobj",
                  "text": ">",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    240.0,
                    120.0,
                    30.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "sel 1",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "bang",
                    ""
                  ],
                  "patching_rect": [
                    240.0,
                    150.0,
                    36.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "message",
                  "text": "swapped",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    240.0,
                    180.0,
                    54.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-9",
                  "maxclass": "newobj",
                  "text": "t f f",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "float",
                    "float"
                  ],
                  "patching_rect": [
                    30.0,
                    75.0,
                    225.0,
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
                    "obj-4",
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
                    "obj-4",
                    1
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
                    "obj-6",
                    1
                  ],
                  "order": 0
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
                    "obj-3",
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
                    "obj-3",
                    0
                  ]
                }
              }
            ]
          }
        }
      },
      {
        "box": {
          "id": "obj-86",
          "maxclass": "comment",
          "text": "-- report thresholds + warn if swapped --",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            352.0,
            560.0,
            248.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-87",
          "maxclass": "newobj",
          "text": "v #0_init_low",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            656.0,
            120.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-88",
          "maxclass": "newobj",
          "text": "v #0_init_high",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            696.0,
            120.0,
            88.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-89",
          "maxclass": "newobj",
          "text": "v #0_init_low",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200.0,
            184.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-90",
          "maxclass": "newobj",
          "text": "v #0_init_high",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            328.0,
            184.0,
            88.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-91",
          "maxclass": "message",
          "text": "1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            792.0,
            120.0,
            24.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-92",
          "maxclass": "newobj",
          "text": "s #0_sel",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            792.0,
            144.0,
            56.0,
            20.0
          ]
        }
      }
    ],
    "lines": [
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
            "obj-2",
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
            "obj-3",
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
            "obj-25",
            0
          ],
          "destination": [
            "obj-27",
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
            "obj-30",
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
            "obj-28",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-27",
            1
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
            "obj-30",
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
            "obj-30",
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
            "obj-1",
            0
          ],
          "destination": [
            "obj-36",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "obj-1",
            0
          ],
          "destination": [
            "obj-37",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-28",
            0
          ],
          "destination": [
            "obj-36",
            1
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
            "obj-36",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-36",
            0
          ],
          "destination": [
            "obj-40",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-37",
            0
          ],
          "destination": [
            "obj-40",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-42",
            0
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
            "obj-40",
            0
          ],
          "destination": [
            "obj-5",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-40",
            0
          ],
          "destination": [
            "obj-45",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "obj-45",
            0
          ],
          "destination": [
            "obj-50",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-45",
            1
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
            "obj-50",
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
            "obj-50",
            1
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
            "obj-51",
            1
          ],
          "destination": [
            "obj-53",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            0
          ],
          "destination": [
            "obj-54",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-53",
            0
          ],
          "destination": [
            "obj-55",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-56",
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
            "obj-4",
            0
          ],
          "destination": [
            "obj-60",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-60",
            0
          ],
          "destination": [
            "obj-62",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-60",
            1
          ],
          "destination": [
            "obj-63",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-60",
            2
          ],
          "destination": [
            "obj-64",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-60",
            3
          ],
          "destination": [
            "obj-70",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-60",
            4
          ],
          "destination": [
            "obj-80",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-64",
            0
          ],
          "destination": [
            "obj-65",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-64",
            1
          ],
          "destination": [
            "obj-66",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-66",
            0
          ],
          "destination": [
            "obj-67",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-70",
            0
          ],
          "destination": [
            "obj-71",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-71",
            0
          ],
          "destination": [
            "obj-72",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-70",
            3
          ],
          "destination": [
            "obj-77",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-77",
            0
          ],
          "destination": [
            "obj-78",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-80",
            0
          ],
          "destination": [
            "obj-81",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-80",
            1
          ],
          "destination": [
            "obj-82",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-82",
            0
          ],
          "destination": [
            "obj-83",
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
            "obj-85",
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
            "obj-85",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-85",
            0
          ],
          "destination": [
            "obj-54",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-70",
            1
          ],
          "destination": [
            "obj-87",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-87",
            0
          ],
          "destination": [
            "obj-74",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-70",
            2
          ],
          "destination": [
            "obj-88",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-88",
            0
          ],
          "destination": [
            "obj-76",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-70",
            4
          ],
          "destination": [
            "obj-91",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-91",
            0
          ],
          "destination": [
            "obj-92",
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
            "obj-89",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "obj-15",
            0
          ],
          "destination": [
            "obj-20",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-15",
            1
          ],
          "destination": [
            "obj-90",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "obj-15",
            1
          ],
          "destination": [
            "obj-21",
            0
          ],
          "order": 0
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}

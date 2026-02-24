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
    "description": "Monophonic note-priority filter for MIDI note pairs",
    "digest": "Choose which held note sounds based on low/high/last priority",
    "tags": "midi note priority monophonic",
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
          "comment": "note pairs: pitch velocity"
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
            400.0,
            16.0,
            30.0,
            30.0
          ],
          "comment": "control: mode, reset, panic, bypass"
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
          "comment": "filtered note pairs: pitch velocity"
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
            680.0,
            744.0,
            30.0,
            30.0
          ],
          "comment": "state: active <pitch>, none"
        }
      },
      {
        "box": {
          "id": "obj-5",
          "maxclass": "comment",
          "text": "--- INIT ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            680.0,
            16.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-6",
          "maxclass": "newobj",
          "text": "loadbang",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            "bang"
          ],
          "patching_rect": [
            680.0,
            40.0,
            56.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-7",
          "maxclass": "newobj",
          "text": "patcherargs low",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            680.0,
            64.0,
            96.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-8",
          "maxclass": "newobj",
          "text": "t l b",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "patching_rect": [
            680.0,
            96.0,
            42.0,
            22.0
          ],
          "comment": "R-to-L: init defaults (first), send mode (second)"
        }
      },
      {
        "box": {
          "id": "obj-9",
          "maxclass": "newobj",
          "text": "prepend mode",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            680.0,
            128.0,
            72.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-10",
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
            760.0,
            96.0,
            62.0,
            22.0
          ],
          "comment": "R-to-L: bypass=0 (first), active=-1 (second), seq=0 (third)"
        }
      },
      {
        "box": {
          "id": "obj-11",
          "maxclass": "message",
          "text": "0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            760.0,
            128.0,
            25.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-12",
          "maxclass": "newobj",
          "text": "v #0_seq",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            760.0,
            152.0,
            48.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-13",
          "maxclass": "message",
          "text": "-1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            792.0,
            128.0,
            25.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-14",
          "maxclass": "newobj",
          "text": "v #0_active",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            792.0,
            152.0,
            64.0,
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
            824.0,
            128.0,
            25.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-16",
          "maxclass": "newobj",
          "text": "v #0_bypass",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            824.0,
            152.0,
            64.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-17",
          "maxclass": "comment",
          "text": "--- CONTROL ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            400.0,
            56.0,
            100.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-18",
          "maxclass": "newobj",
          "text": "route mode reset panic bypass",
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
            400.0,
            80.0,
            176.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-19",
          "maxclass": "newobj",
          "text": "v #0_mode",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            400.0,
            112.0,
            56.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-20",
          "maxclass": "newobj",
          "text": "s #0_reset",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            440.0,
            112.0,
            60.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-21",
          "maxclass": "newobj",
          "text": "s #0_panic",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            480.0,
            112.0,
            60.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-22",
          "maxclass": "newobj",
          "text": "v #0_bypass",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            552.0,
            144.0,
            64.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-69",
          "maxclass": "newobj",
          "text": "t i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "int"
          ],
          "patching_rect": [
            520.0,
            112.0,
            48.0,
            22.0
          ],
          "comment": "set bypass state, then panic if enabling"
        }
      },
      {
        "box": {
          "id": "obj-70",
          "maxclass": "newobj",
          "text": "sel 1",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "bang",
            ""
          ],
          "patching_rect": [
            520.0,
            144.0,
            36.0,
            22.0
          ],
          "comment": "bypass=1 triggers panic to clear stale state"
        }
      },
      {
        "box": {
          "id": "obj-71",
          "maxclass": "newobj",
          "text": "s #0_panic",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            520.0,
            168.0,
            60.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-23",
          "maxclass": "comment",
          "text": "--- BYPASS ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            56.0,
            56.0,
            100.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-24",
          "maxclass": "newobj",
          "text": "t l b",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "patching_rect": [
            56.0,
            80.0,
            80.0,
            22.0
          ],
          "comment": "R-to-L: bang gets bypass (first), list to gate (second)"
        }
      },
      {
        "box": {
          "id": "obj-25",
          "maxclass": "newobj",
          "text": "v #0_bypass",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            120.0,
            104.0,
            64.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-26",
          "maxclass": "newobj",
          "text": "+ 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            120.0,
            128.0,
            30.0,
            22.0
          ],
          "comment": "bypass=0 -> gate 1 (process), bypass=1 -> gate 2 (passthrough)"
        }
      },
      {
        "box": {
          "id": "obj-27",
          "maxclass": "newobj",
          "text": "gate 2 1",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            56.0,
            160.0,
            152.0,
            22.0
          ],
          "comment": "outlet 1=process, outlet 2=bypass"
        }
      },
      {
        "box": {
          "id": "obj-28",
          "maxclass": "comment",
          "text": "--- UNPACK NOTE ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            56.0,
            200.0,
            130.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-29",
          "maxclass": "newobj",
          "text": "unpack i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "int"
          ],
          "patching_rect": [
            56.0,
            224.0,
            64.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-30",
          "maxclass": "newobj",
          "text": "t i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "int"
          ],
          "patching_rect": [
            104.0,
            248.0,
            42.0,
            22.0
          ],
          "comment": "R-to-L: store vel (first), then test >0 (second)"
        }
      },
      {
        "box": {
          "id": "obj-31",
          "maxclass": "newobj",
          "text": "v #0_vel",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            128.0,
            272.0,
            48.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-32",
          "maxclass": "newobj",
          "text": "v #0_pitch",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            56.0,
            248.0,
            56.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-33",
          "maxclass": "newobj",
          "text": "> 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            104.0,
            296.0,
            30.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-34",
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
            104.0,
            320.0,
            56.0,
            22.0
          ],
          "comment": "1=note-on, 0=note-off"
        }
      },
      {
        "box": {
          "id": "obj-35",
          "maxclass": "comment",
          "text": "--- NOTE-ON PATH ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            56.0,
            352.0,
            130.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-36",
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
            56.0,
            376.0,
            152.0,
            22.0
          ],
          "comment": "R-to-L: record held+order (first), inc seq (second), find winner (third)"
        }
      },
      {
        "box": {
          "id": "obj-37",
          "maxclass": "newobj",
          "text": "p RecordNoteOn",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            192.0,
            400.0,
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
                  "comment": "bang to record"
                }
              },
              {
                "box": {
                  "id": "obj-2",
                  "maxclass": "newobj",
                  "text": "v #0_pitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    75.0,
                    56.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "newobj",
                  "text": "t i i",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    105.0,
                    80.0,
                    22.0
                  ],
                  "comment": "R-to-L: set order[pitch]=seq (first), set held[pitch]=1 (second)"
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "v #0_seq",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    115.0,
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
                  "text": "pack i i",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    115.0,
                    165.0,
                    56.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "newobj",
                  "text": "table #0_order",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    115.0,
                    195.0,
                    80.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "message",
                  "text": "$1 1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    135.0,
                    32.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "newobj",
                  "text": "table #0_held",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    50.0,
                    165.0,
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
                    1
                  ],
                  "destination": [
                    "obj-4",
                    0
                  ],
                  "order": 1
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
                    "obj-3",
                    1
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
                    "obj-3",
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
          "id": "obj-38",
          "maxclass": "newobj",
          "text": "p IncrementSeq",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            128.0,
            400.0,
            88.0,
            22.0
          ],
          "patcher": {
            "fileversion": 1,
            "classnamespace": "box",
            "rect": [
              200.0,
              200.0,
              300.0,
              200.0
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
                  "comment": "bang to increment"
                }
              },
              {
                "box": {
                  "id": "obj-2",
                  "maxclass": "newobj",
                  "text": "v #0_seq",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    75.0,
                    48.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "newobj",
                  "text": "+ 1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    105.0,
                    30.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "v #0_seq",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    135.0,
                    48.0,
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
          "id": "obj-39",
          "maxclass": "newobj",
          "text": "s #0_findwinner",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            56.0,
            400.0,
            72.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-40",
          "maxclass": "comment",
          "text": "--- NOTE-OFF PATH ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            296.0,
            432.0,
            140.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-41",
          "maxclass": "newobj",
          "text": "t b b",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "bang",
            "bang"
          ],
          "patching_rect": [
            296.0,
            456.0,
            112.0,
            22.0
          ],
          "comment": "R-to-L: clear held[pitch] (first), then find winner (second)"
        }
      },
      {
        "box": {
          "id": "obj-42",
          "maxclass": "newobj",
          "text": "p ClearNoteOff",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            392.0,
            480.0,
            80.0,
            22.0
          ],
          "patcher": {
            "fileversion": 1,
            "classnamespace": "box",
            "rect": [
              200.0,
              200.0,
              400.0,
              250.0
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
                  "comment": "bang to clear"
                }
              },
              {
                "box": {
                  "id": "obj-2",
                  "maxclass": "newobj",
                  "text": "v #0_pitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    75.0,
                    56.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "newobj",
                  "text": "t i i",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    105.0,
                    80.0,
                    22.0
                  ],
                  "comment": "R-to-L: clear order[pitch] (first), clear held[pitch] (second)"
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "message",
                  "text": "$1 0",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    115.0,
                    135.0,
                    32.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "table #0_order",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    115.0,
                    165.0,
                    80.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "message",
                  "text": "$1 0",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    135.0,
                    32.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "table #0_held",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    50.0,
                    165.0,
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
                    "obj-6",
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
          "id": "obj-43",
          "maxclass": "newobj",
          "text": "s #0_findwinner",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            296.0,
            480.0,
            72.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-44",
          "maxclass": "comment",
          "text": "--- FIND WINNER ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            56.0,
            440.0,
            130.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-45",
          "maxclass": "newobj",
          "text": "r #0_findwinner",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            56.0,
            464.0,
            72.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-46",
          "maxclass": "newobj",
          "text": "v #0_mode",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            56.0,
            488.0,
            56.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-47",
          "maxclass": "newobj",
          "text": "route low high last",
          "numinlets": 1,
          "numoutlets": 4,
          "outlettype": [
            "",
            "",
            "",
            ""
          ],
          "patching_rect": [
            56.0,
            512.0,
            128.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-48",
          "maxclass": "newobj",
          "text": "p FindLow",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            56.0,
            536.0,
            56.0,
            22.0
          ],
          "patcher": {
            "fileversion": 1,
            "classnamespace": "box",
            "rect": [
              200.0,
              200.0,
              480.0,
              360.0
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
                  "comment": "bang to scan"
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
                    75.0,
                    135.0,
                    22.0
                  ],
                  "comment": "R-to-L: init winner=-1 (first), start scan (second)"
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "message",
                  "text": "-1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    170.0,
                    105.0,
                    25.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    170.0,
                    135.0,
                    64.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "uzi 128 0",
                  "numinlets": 2,
                  "numoutlets": 3,
                  "outlettype": [
                    "bang",
                    "bang",
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    105.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "newobj",
                  "text": "t i i",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "int"
                  ],
                  "patching_rect": [
                    105.0,
                    135.0,
                    42.0,
                    22.0
                  ],
                  "comment": "R-to-L: store scanpitch (first), lookup held (second)"
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "v #0_scanpitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    130.0,
                    165.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "newobj",
                  "text": "table #0_held",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    105.0,
                    165.0,
                    80.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-9",
                  "maxclass": "newobj",
                  "text": "sel 1",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "bang",
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    195.0,
                    36.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    105.0,
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
                  "text": "sel -1",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "bang",
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    255.0,
                    36.0,
                    22.0
                  ],
                  "comment": "only set winner if none found yet (lowest first)"
                }
              },
              {
                "box": {
                  "id": "obj-12",
                  "maxclass": "newobj",
                  "text": "v #0_scanpitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    285.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-13",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    315.0,
                    64.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-14",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
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
                  "id": "obj-15",
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
                  "comment": "winner pitch or -1"
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
                    "obj-5",
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
                    "obj-14",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-5",
                    2
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
                    "obj-6",
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
          "id": "obj-49",
          "maxclass": "newobj",
          "text": "p FindHigh",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            104.0,
            536.0,
            64.0,
            22.0
          ],
          "patcher": {
            "fileversion": 1,
            "classnamespace": "box",
            "rect": [
              200.0,
              200.0,
              480.0,
              360.0
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
                  "comment": "bang to scan"
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
                    75.0,
                    135.0,
                    22.0
                  ],
                  "comment": "R-to-L: init winner=-1 (first), start scan (second)"
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "message",
                  "text": "-1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    170.0,
                    105.0,
                    25.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    170.0,
                    135.0,
                    64.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "uzi 128 0",
                  "numinlets": 2,
                  "numoutlets": 3,
                  "outlettype": [
                    "bang",
                    "bang",
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    105.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "newobj",
                  "text": "t i i",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "int"
                  ],
                  "patching_rect": [
                    105.0,
                    135.0,
                    42.0,
                    22.0
                  ],
                  "comment": "R-to-L: store scanpitch (first), lookup held (second)"
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "v #0_scanpitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    130.0,
                    165.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "newobj",
                  "text": "table #0_held",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    105.0,
                    165.0,
                    80.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-9",
                  "maxclass": "newobj",
                  "text": "sel 1",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "bang",
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    195.0,
                    36.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "maxclass": "newobj",
                  "text": "v #0_scanpitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    225.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-11",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    255.0,
                    64.0,
                    22.0
                  ],
                  "comment": "always overwrite: scanning low-to-high, last found is highest"
                }
              },
              {
                "box": {
                  "id": "obj-14",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
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
                  "id": "obj-15",
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
                  "comment": "winner pitch or -1"
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
                    "obj-5",
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
                    "obj-14",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-5",
                    2
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
                    "obj-6",
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
                    "obj-14",
                    0
                  ],
                  "destination": [
                    "obj-15",
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
          "id": "obj-50",
          "maxclass": "newobj",
          "text": "p FindLast",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            160.0,
            536.0,
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
              420.0
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
                  "comment": "bang to scan"
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
                    180.0,
                    22.0
                  ],
                  "comment": "R-to-L: init bestseq=-1 (first), init winner=-1 (second), start scan (third)"
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "message",
                  "text": "-1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    215.0,
                    105.0,
                    25.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "v #0_bestseq",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    215.0,
                    135.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "message",
                  "text": "-1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    170.0,
                    105.0,
                    25.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    170.0,
                    135.0,
                    64.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "uzi 128 0",
                  "numinlets": 2,
                  "numoutlets": 3,
                  "outlettype": [
                    "bang",
                    "bang",
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    105.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "newobj",
                  "text": "t i i",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "int"
                  ],
                  "patching_rect": [
                    105.0,
                    135.0,
                    42.0,
                    22.0
                  ],
                  "comment": "R-to-L: store scanpitch (first), lookup held (second)"
                }
              },
              {
                "box": {
                  "id": "obj-9",
                  "maxclass": "newobj",
                  "text": "v #0_scanpitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    130.0,
                    165.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "maxclass": "newobj",
                  "text": "table #0_held",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    105.0,
                    165.0,
                    80.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-11",
                  "maxclass": "newobj",
                  "text": "sel 1",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "bang",
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    195.0,
                    36.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-12",
                  "maxclass": "newobj",
                  "text": "v #0_scanpitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    225.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-13",
                  "maxclass": "newobj",
                  "text": "table #0_order",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    105.0,
                    255.0,
                    80.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-14",
                  "maxclass": "newobj",
                  "text": "t i i",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "int"
                  ],
                  "patching_rect": [
                    105.0,
                    285.0,
                    42.0,
                    22.0
                  ],
                  "comment": "R-to-L: get bestseq for compare (first), hold order val (second)"
                }
              },
              {
                "box": {
                  "id": "obj-15",
                  "maxclass": "newobj",
                  "text": "v #0_bestseq",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    130.0,
                    315.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-16",
                  "maxclass": "newobj",
                  "text": ">",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    105.0,
                    315.0,
                    30.0,
                    22.0
                  ],
                  "comment": "order > bestseq?"
                }
              },
              {
                "box": {
                  "id": "obj-17",
                  "maxclass": "newobj",
                  "text": "sel 1",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "bang",
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    345.0,
                    36.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-18",
                  "maxclass": "newobj",
                  "text": "t b b",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "bang",
                    "bang"
                  ],
                  "patching_rect": [
                    105.0,
                    375.0,
                    80.0,
                    22.0
                  ],
                  "comment": "R-to-L: update bestseq (first), update winner (second)"
                }
              },
              {
                "box": {
                  "id": "obj-19",
                  "maxclass": "newobj",
                  "text": "v #0_scanpitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    170.0,
                    405.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-20",
                  "maxclass": "newobj",
                  "text": "table #0_order",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    170.0,
                    435.0,
                    80.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-21",
                  "maxclass": "newobj",
                  "text": "v #0_bestseq",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    170.0,
                    465.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-22",
                  "maxclass": "newobj",
                  "text": "v #0_scanpitch",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    105.0,
                    405.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-23",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    105.0,
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
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
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
                  "id": "obj-25",
                  "maxclass": "outlet",
                  "index": 1,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    50.0,
                    375.0,
                    30.0,
                    30.0
                  ],
                  "comment": "winner pitch or -1"
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
                    "obj-24",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-7",
                    2
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
                    1
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
                    "obj-14",
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
                    "obj-18",
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
                    "obj-23",
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
                    "obj-25",
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
          "id": "obj-51",
          "maxclass": "comment",
          "text": "--- EMIT LOGIC ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            56.0,
            568.0,
            120.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-52",
          "maxclass": "newobj",
          "text": "p EmitNotes",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            56.0,
            592.0,
            72.0,
            22.0
          ],
          "patcher": {
            "fileversion": 1,
            "classnamespace": "box",
            "rect": [
              200.0,
              200.0,
              640.0,
              520.0
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
                  "comment": "winner pitch (or -1 for none)"
                }
              },
              {
                "box": {
                  "id": "obj-2",
                  "maxclass": "newobj",
                  "text": "t i b",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    50.0,
                    75.0,
                    100.0,
                    22.0
                  ],
                  "comment": "R-to-L: get old active (first), then process winner (second)"
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "newobj",
                  "text": "v #0_active",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    135.0,
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
                  "text": "v #0_oldactive",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    135.0,
                    135.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    105.0,
                    64.0,
                    22.0
                  ],
                  "comment": "store winner"
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "newobj",
                  "text": "v #0_oldactive",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90.0,
                    105.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "==",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    135.0,
                    56.0,
                    22.0
                  ],
                  "comment": "winner == oldactive? no change needed"
                }
              },
              {
                "box": {
                  "id": "obj-8",
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
                    195.0,
                    36.0,
                    22.0
                  ],
                  "comment": "0 = different, proceed"
                }
              },
              {
                "box": {
                  "id": "obj-9",
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
                    225.0,
                    200.0,
                    22.0
                  ],
                  "comment": "R-to-L: note-off old (first), note-on new (second), update active+status (third)"
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "maxclass": "newobj",
                  "text": "v #0_oldactive",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    235.0,
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
                  "text": "!= -1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    235.0,
                    285.0,
                    36.0,
                    22.0
                  ],
                  "comment": "had an old active?"
                }
              },
              {
                "box": {
                  "id": "obj-12",
                  "maxclass": "newobj",
                  "text": "gate 1 0",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    235.0,
                    315.0,
                    56.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-13",
                  "maxclass": "newobj",
                  "text": "v #0_oldactive",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    275.0,
                    315.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-14",
                  "maxclass": "newobj",
                  "text": "pack i 0",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    235.0,
                    345.0,
                    56.0,
                    22.0
                  ],
                  "comment": "pitch 0 = note-off"
                }
              },
              {
                "box": {
                  "id": "obj-15",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    255.0,
                    64.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-16",
                  "maxclass": "newobj",
                  "text": "!= -1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    285.0,
                    36.0,
                    22.0
                  ],
                  "comment": "is winner valid?"
                }
              },
              {
                "box": {
                  "id": "obj-17",
                  "maxclass": "newobj",
                  "text": "gate 1 0",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    315.0,
                    56.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-18",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90.0,
                    315.0,
                    64.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-19",
                  "maxclass": "newobj",
                  "text": "v #0_vel",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90.0,
                    345.0,
                    48.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-20",
                  "maxclass": "newobj",
                  "text": "pack i i",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    375.0,
                    56.0,
                    22.0
                  ],
                  "comment": "pitch vel = note-on"
                }
              },
              {
                "box": {
                  "id": "obj-21",
                  "maxclass": "newobj",
                  "text": "v #0_winner",
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
                  "comment": "update active = winner"
                }
              },
              {
                "box": {
                  "id": "obj-22",
                  "maxclass": "newobj",
                  "text": "v #0_active",
                  "numinlets": 1,
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
                  "id": "obj-23",
                  "maxclass": "newobj",
                  "text": "!= -1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    465.0,
                    36.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-24",
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
                    495.0,
                    56.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-25",
                  "maxclass": "newobj",
                  "text": "v #0_active",
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
                  "id": "obj-26",
                  "maxclass": "newobj",
                  "text": "prepend active",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    555.0,
                    80.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-27",
                  "maxclass": "message",
                  "text": "none",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    95.0,
                    525.0,
                    36.0,
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
                    140.0,
                    405.0,
                    30.0,
                    30.0
                  ],
                  "comment": "note pairs out"
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
                    50.0,
                    585.0,
                    30.0,
                    30.0
                  ],
                  "comment": "state out"
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
                  ],
                  "order": 1,
                  "comment": "get oldactive into == right inlet (fires first)"
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
                  ],
                  "comment": "oldactive to right inlet (cold)"
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-5",
                    0
                  ],
                  "destination": [
                    "obj-7",
                    0
                  ],
                  "order": 0,
                  "comment": "winner to left inlet (hot, triggers compare, fires second)"
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
                    2
                  ],
                  "destination": [
                    "obj-10",
                    0
                  ],
                  "comment": "note-off old (fires first)"
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
                    "obj-out1",
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
                    "obj-15",
                    0
                  ],
                  "comment": "note-on new (fires second)"
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
                    0
                  ],
                  "destination": [
                    "obj-18",
                    0
                  ],
                  "order": 1,
                  "comment": "get winner pitch (fires first)"
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
                    "obj-20",
                    0
                  ],
                  "order": 0,
                  "comment": "set pack pitch (fires second, vel already set)"
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-20",
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
                    "obj-9",
                    0
                  ],
                  "destination": [
                    "obj-21",
                    0
                  ],
                  "comment": "update active+status (fires last)"
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
                    "obj-24",
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
                    "obj-26",
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
                    "obj-out2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-24",
                    1
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
                    "obj-27",
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
          "id": "obj-53",
          "maxclass": "comment",
          "text": "--- PANIC/RESET ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            480.0,
            440.0,
            130.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-54",
          "maxclass": "newobj",
          "text": "r #0_panic",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480.0,
            464.0,
            60.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-55",
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
            480.0,
            488.0,
            200.0,
            22.0
          ],
          "comment": "R-to-L: clear tables (first), emit note-off for active (second), set active=-1 and status (third)"
        }
      },
      {
        "box": {
          "id": "obj-56",
          "maxclass": "newobj",
          "text": "p ClearTables",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            664.0,
            512.0,
            80.0,
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
                  "comment": "bang to clear"
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
                    75.0,
                    80.0,
                    22.0
                  ],
                  "comment": "R-to-L: reset seq (first), clear tables (second)"
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
                    115.0,
                    105.0,
                    25.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "v #0_seq",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    115.0,
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
                  "text": "uzi 128 0",
                  "numinlets": 2,
                  "numoutlets": 3,
                  "outlettype": [
                    "bang",
                    "bang",
                    "int"
                  ],
                  "patching_rect": [
                    50.0,
                    105.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "message",
                  "text": "$1 0",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    135.0,
                    32.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "t l l",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    165.0,
                    80.0,
                    22.0
                  ],
                  "comment": "R-to-L: clear order (first), clear held (second)"
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "newobj",
                  "text": "table #0_held",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    50.0,
                    195.0,
                    80.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-9",
                  "maxclass": "newobj",
                  "text": "table #0_order",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    "bang"
                  ],
                  "patching_rect": [
                    115.0,
                    195.0,
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
                    "obj-5",
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
                    2
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
                    "obj-7",
                    1
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
          "id": "obj-57",
          "maxclass": "newobj",
          "text": "v #0_active",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            576.0,
            512.0,
            64.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-58",
          "maxclass": "newobj",
          "text": "t i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "int"
          ],
          "patching_rect": [
            576.0,
            536.0,
            48.0,
            22.0
          ],
          "comment": "R-to-L: check !=-1 for gate (first), hold pitch for pack (second)"
        }
      },
      {
        "box": {
          "id": "obj-59",
          "maxclass": "newobj",
          "text": "!= -1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            608.0,
            560.0,
            36.0,
            22.0
          ],
          "comment": "was there an active note?"
        }
      },
      {
        "box": {
          "id": "obj-60",
          "maxclass": "newobj",
          "text": "gate 1 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            576.0,
            592.0,
            56.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-62",
          "maxclass": "newobj",
          "text": "pack i 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            576.0,
            624.0,
            56.0,
            22.0
          ],
          "comment": "pitch 0 = note-off"
        }
      },
      {
        "box": {
          "id": "obj-63",
          "maxclass": "newobj",
          "text": "t b b",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "bang",
            "bang"
          ],
          "patching_rect": [
            480.0,
            512.0,
            48.0,
            22.0
          ],
          "comment": "R-to-L: set active=-1 (first), status none (second)"
        }
      },
      {
        "box": {
          "id": "obj-64",
          "maxclass": "message",
          "text": "-1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            512.0,
            536.0,
            25.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-65",
          "maxclass": "newobj",
          "text": "v #0_active",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            512.0,
            560.0,
            64.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-66",
          "maxclass": "message",
          "text": "none",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480.0,
            536.0,
            36.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-67",
          "maxclass": "newobj",
          "text": "r #0_reset",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            760.0,
            464.0,
            60.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-68",
          "maxclass": "newobj",
          "text": "s #0_panic",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            760.0,
            488.0,
            60.0,
            22.0
          ],
          "comment": "reset triggers panic first"
        }
      },
      {
        "box": {
          "id": "obj-72",
          "maxclass": "newobj",
          "text": "v #0_pitch",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            296.0,
            352.0,
            56.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-73",
          "maxclass": "newobj",
          "text": "table #0_held",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "bang"
          ],
          "patching_rect": [
            296.0,
            376.0,
            80.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-74",
          "maxclass": "newobj",
          "text": "sel 0",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "bang",
            ""
          ],
          "patching_rect": [
            296.0,
            400.0,
            32.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-75",
          "maxclass": "newobj",
          "text": "v #0_pitch",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            344.0,
            432.0,
            56.0,
            22.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-76",
          "maxclass": "newobj",
          "text": "pack i 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            344.0,
            456.0,
            56.0,
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
            "obj-24",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-24",
            1
          ],
          "destination": [
            "obj-25",
            0
          ],
          "comment": "bang: get bypass state (fires first)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-24",
            0
          ],
          "destination": [
            "obj-27",
            1
          ],
          "comment": "list: msg to bypass gate (fires second)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-25",
            0
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
            "obj-26",
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
            "obj-27",
            1
          ],
          "destination": [
            "obj-3",
            0
          ],
          "comment": "bypass passthrough"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-27",
            0
          ],
          "destination": [
            "obj-29",
            0
          ],
          "comment": "to note processing"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-29",
            0
          ],
          "destination": [
            "obj-32",
            0
          ],
          "comment": "store pitch"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-29",
            1
          ],
          "destination": [
            "obj-30",
            0
          ],
          "comment": "velocity to processing"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-30",
            1
          ],
          "destination": [
            "obj-31",
            0
          ],
          "comment": "store velocity (fires first)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-30",
            0
          ],
          "destination": [
            "obj-33",
            0
          ],
          "comment": "test vel > 0 (fires second)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-33",
            0
          ],
          "destination": [
            "obj-34",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-34",
            0
          ],
          "destination": [
            "obj-36",
            0
          ],
          "comment": "note-on path"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-36",
            2
          ],
          "destination": [
            "obj-37",
            0
          ],
          "comment": "record held+order (fires first)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-36",
            1
          ],
          "destination": [
            "obj-38",
            0
          ],
          "comment": "increment seq (fires second)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-36",
            0
          ],
          "destination": [
            "obj-39",
            0
          ],
          "comment": "find winner (fires last)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-41",
            1
          ],
          "destination": [
            "obj-42",
            0
          ],
          "comment": "clear held[pitch] (fires first)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-41",
            0
          ],
          "destination": [
            "obj-43",
            0
          ],
          "comment": "find winner (fires second/last)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-45",
            0
          ],
          "destination": [
            "obj-46",
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
            0
          ],
          "destination": [
            "obj-48",
            0
          ],
          "comment": "low mode"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-47",
            1
          ],
          "destination": [
            "obj-49",
            0
          ],
          "comment": "high mode"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-47",
            2
          ],
          "destination": [
            "obj-50",
            0
          ],
          "comment": "last mode"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-48",
            0
          ],
          "destination": [
            "obj-52",
            0
          ],
          "comment": "low winner to emit"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-49",
            0
          ],
          "destination": [
            "obj-52",
            0
          ],
          "comment": "high winner to emit"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-50",
            0
          ],
          "destination": [
            "obj-52",
            0
          ],
          "comment": "last winner to emit"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            0
          ],
          "destination": [
            "obj-3",
            0
          ],
          "comment": "note pairs output"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            1
          ],
          "destination": [
            "obj-4",
            0
          ],
          "comment": "state output"
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
          ],
          "comment": "mode"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-18",
            1
          ],
          "destination": [
            "obj-20",
            0
          ],
          "comment": "reset"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-18",
            2
          ],
          "destination": [
            "obj-21",
            0
          ],
          "comment": "panic"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-18",
            3
          ],
          "destination": [
            "obj-69",
            0
          ],
          "comment": "bypass value to trigger"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-69",
            1
          ],
          "destination": [
            "obj-22",
            0
          ],
          "comment": "set bypass state (fires first)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-69",
            0
          ],
          "destination": [
            "obj-70",
            0
          ],
          "comment": "check if bypass=1 (fires second)"
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
          ],
          "comment": "bypass=1: panic to clear stale state"
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
          ],
          "comment": "prepend mode to patcherargs"
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
          ],
          "comment": "init defaults"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-9",
            0
          ],
          "destination": [
            "obj-18",
            0
          ],
          "comment": "send mode from init"
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
            "obj-10",
            1
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
            "obj-10",
            2
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
            "obj-54",
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
            "obj-55",
            2
          ],
          "destination": [
            "obj-56",
            0
          ],
          "comment": "clear tables (fires first)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-55",
            1
          ],
          "destination": [
            "obj-57",
            0
          ],
          "comment": "get active for note-off (fires second)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-55",
            0
          ],
          "destination": [
            "obj-63",
            0
          ],
          "comment": "set active=-1 and status (fires last)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-57",
            0
          ],
          "destination": [
            "obj-58",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-58",
            1
          ],
          "destination": [
            "obj-59",
            0
          ],
          "comment": "check !=-1 for gate (fires first)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            0
          ],
          "destination": [
            "obj-60",
            0
          ],
          "comment": "set gate control"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-58",
            0
          ],
          "destination": [
            "obj-60",
            1
          ],
          "comment": "pitch to gate data inlet (fires second)"
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
          ],
          "comment": "pitch through gate to pack"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-62",
            0
          ],
          "destination": [
            "obj-3",
            0
          ],
          "comment": "panic note-off"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-63",
            1
          ],
          "destination": [
            "obj-64",
            0
          ],
          "comment": "set active=-1 (fires first)"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-63",
            0
          ],
          "destination": [
            "obj-66",
            0
          ],
          "comment": "status none (fires second)"
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
            "obj-66",
            0
          ],
          "destination": [
            "obj-4",
            0
          ],
          "comment": "status: none"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-67",
            0
          ],
          "destination": [
            "obj-68",
            0
          ],
          "comment": "reset triggers panic"
        }
      },
      {
        "patchline": {
          "source": [
            "obj-34",
            1
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
            "obj-72",
            0
          ],
          "destination": [
            "obj-73",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-73",
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
            "obj-74",
            1
          ],
          "destination": [
            "obj-41",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-74",
            0
          ],
          "destination": [
            "obj-75",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-75",
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
            "obj-76",
            0
          ],
          "destination": [
            "obj-3",
            0
          ]
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}

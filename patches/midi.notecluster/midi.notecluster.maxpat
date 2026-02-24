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
      900.0,
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
    "description": "Group note-ons within a time window and emit chord cluster metadata",
    "digest": "MIDI note clustering for chord detection",
    "tags": "midi chord cluster note grouping",
    "style": "",
    "subpatcher_template": "",
    "assistshowspatchername": 0,
    "autosave": 0,
    "boxes": [
      {
        "box": {
          "id": "obj-1",
          "maxclass": "inlet",
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
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480.0,
            16.0,
            30.0,
            30.0
          ],
          "comment": "control: window, sort, unique, flush, reset, bypass"
        }
      },
      {
        "box": {
          "id": "obj-3",
          "maxclass": "outlet",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            56.0,
            720.0,
            30.0,
            30.0
          ],
          "comment": "cluster output: cluster p1 p2 ..."
        }
      },
      {
        "box": {
          "id": "obj-4",
          "maxclass": "outlet",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            280.0,
            720.0,
            30.0,
            30.0
          ],
          "comment": "metadata: count, lowest, highest, single, done"
        }
      },
      {
        "box": {
          "id": "obj-5",
          "maxclass": "outlet",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            504.0,
            720.0,
            30.0,
            30.0
          ],
          "comment": "note-off passthrough: pitch 0"
        }
      },
      {
        "box": {
          "id": "obj-6",
          "maxclass": "comment",
          "text": "--- midi.notecluster ---\nGroup note-ons within a time window,\nemit cluster + metadata",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            640.0,
            16.0,
            200.0,
            42.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-10",
          "maxclass": "newobj",
          "text": "route window sort unique flush reset bypass",
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
            480.0,
            64.0,
            320.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-11",
          "maxclass": "newobj",
          "text": "v #0_window 5",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
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
          "id": "obj-12",
          "maxclass": "newobj",
          "text": "v #0_sort 1",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            568.0,
            96.0,
            72.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-13",
          "maxclass": "newobj",
          "text": "v #0_unique 1",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            648.0,
            96.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-14",
          "maxclass": "newobj",
          "text": "s #0_flush",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            736.0,
            96.0,
            64.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-15",
          "maxclass": "newobj",
          "text": "t b b",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "bang",
            "bang"
          ],
          "patching_rect": [
            800.0,
            88.0,
            40.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-16",
          "maxclass": "newobj",
          "text": "s #0_reset_cluster",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            800.0,
            128.0,
            104.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-17",
          "maxclass": "newobj",
          "text": "s #0_stop_timer",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            824.0,
            112.0,
            88.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-18",
          "maxclass": "newobj",
          "text": "v #0_bypass 0",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            480.0,
            152.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-20",
          "maxclass": "newobj",
          "text": "t l l",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            56.0,
            72.0,
            80.0,
            20.0
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
            "int"
          ],
          "patching_rect": [
            120.0,
            96.0,
            72.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-22",
          "maxclass": "newobj",
          "text": "gate 2",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            56.0,
            152.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-23",
          "maxclass": "newobj",
          "text": "t i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "int"
          ],
          "patching_rect": [
            120.0,
            120.0,
            40.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-24",
          "maxclass": "newobj",
          "text": "!- 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            120.0,
            144.0,
            32.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-25",
          "maxclass": "comment",
          "text": "bypass=1 -> outlet 2 -> passthrough",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            200.0,
            152.0,
            192.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-30",
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
            200.0,
            64.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-31",
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
            232.0,
            40.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-32",
          "maxclass": "newobj",
          "text": "> 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            104.0,
            256.0,
            32.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-33",
          "maxclass": "newobj",
          "text": "gate 2",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            56.0,
            296.0,
            80.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-34",
          "maxclass": "comment",
          "text": "gate 1=off 2=on",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            144.0,
            296.0,
            96.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-35",
          "maxclass": "newobj",
          "text": "+ 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            104.0,
            272.0,
            32.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-40",
          "maxclass": "newobj",
          "text": "pack i 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            504.0,
            360.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-41",
          "maxclass": "comment",
          "text": "note-off passthrough: pitch 0",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            568.0,
            360.0,
            168.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-50",
          "maxclass": "newobj",
          "text": "p ClusterAccumulate",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            120.0,
            360.0,
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
              550.0,
              400.0
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
                    30.0,
                    30.0,
                    30.0
                  ],
                  "comment": "pitch (note-on)"
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
                    40.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "newobj",
                  "text": "zl group 128",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    105.0,
                    78.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "r #0_emit_cluster",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    200.0,
                    30.0,
                    98.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "r #0_reset_cluster",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    350.0,
                    30.0,
                    105.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "message",
                  "text": "zlclear",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    350.0,
                    60.0,
                    48.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
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
                    60.0,
                    40.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "message",
                  "text": "zlclear",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    200.0,
                    90.0,
                    48.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "maxclass": "newobj",
                  "text": "s #0_start_timer",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    75.0,
                    165.0,
                    95.0,
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
                    225.0,
                    30.0,
                    30.0
                  ],
                  "comment": "accumulated cluster list on emit"
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
                    "obj-2",
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
                    "obj-3",
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
                    "obj-3",
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
                    "obj-3",
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
          "id": "obj-55",
          "maxclass": "newobj",
          "text": "p ClusterTimer",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            "bang"
          ],
          "patching_rect": [
            56.0,
            408.0,
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
              500.0,
              400.0
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
                  "id": "obj-2",
                  "maxclass": "newobj",
                  "text": "r #0_start_timer",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    30.0,
                    95.0,
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
                    50.0,
                    60.0,
                    40.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "newobj",
                  "text": "v #0_window",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    75.0,
                    90.0,
                    75.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "delay 5",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "bang"
                  ],
                  "patching_rect": [
                    50.0,
                    120.0,
                    50.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "r #0_stop_timer",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    200.0,
                    30.0,
                    88.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "message",
                  "text": "stop",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    200.0,
                    60.0,
                    35.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "r #0_flush",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    180.0,
                    70.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "outlet",
                  "index": 1,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    50.0,
                    270.0,
                    30.0,
                    30.0
                  ],
                  "comment": "bang when window closes or flush"
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
                    50.0,
                    210.0,
                    40.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "maxclass": "message",
                  "text": "stop",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    75.0,
                    240.0,
                    35.0,
                    22.0
                  ]
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "obj-2",
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
                    "obj-4",
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
                    1
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
                    "obj-7",
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
                    "obj-8",
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
                    "obj-10",
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
          "id": "obj-56",
          "maxclass": "newobj",
          "text": "s #0_emit_cluster",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            56.0,
            432.0,
            96.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-60",
          "maxclass": "newobj",
          "text": "p ClusterShape",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            56.0,
            496.0,
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
              600.0,
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
                    30.0,
                    30.0,
                    30.0
                  ],
                  "comment": "raw cluster list"
                }
              },
              {
                "box": {
                  "id": "obj-2",
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
                    75.0,
                    40.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-3",
                  "maxclass": "newobj",
                  "text": "v #0_sort",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    75.0,
                    105.0,
                    60.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "gate",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    135.0,
                    44.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "zl sort",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    165.0,
                    48.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-11",
                  "maxclass": "newobj",
                  "text": "!- 1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    170.0,
                    105.0,
                    32.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-12",
                  "maxclass": "newobj",
                  "text": "gate",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    155.0,
                    135.0,
                    44.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
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
                    210.0,
                    40.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "v #0_unique",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    75.0,
                    240.0,
                    72.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "newobj",
                  "text": "gate",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    270.0,
                    44.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-9",
                  "maxclass": "newobj",
                  "text": "zl unique",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    300.0,
                    60.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-13",
                  "maxclass": "newobj",
                  "text": "!- 1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    170.0,
                    240.0,
                    32.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-14",
                  "maxclass": "newobj",
                  "text": "gate",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    155.0,
                    270.0,
                    44.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "maxclass": "outlet",
                  "index": 1,
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    50.0,
                    360.0,
                    30.0,
                    30.0
                  ],
                  "comment": "shaped cluster list"
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
                    "obj-12",
                    1
                  ],
                  "order": 0
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
                    "obj-11",
                    0
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
                    "obj-6",
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
                    "obj-8",
                    1
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-6",
                    0
                  ],
                  "destination": [
                    "obj-14",
                    1
                  ],
                  "order": 0
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
                    "obj-13",
                    0
                  ],
                  "order": 0
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
                    "obj-10",
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
          "id": "obj-70",
          "maxclass": "newobj",
          "text": "p ClusterEmit",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            56.0,
            544.0,
            248.0,
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
                    30.0,
                    30.0,
                    30.0
                  ],
                  "comment": "shaped cluster list"
                }
              },
              {
                "box": {
                  "id": "obj-2",
                  "maxclass": "newobj",
                  "text": "zl len",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    75.0,
                    44.0,
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
                    56.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-4",
                  "maxclass": "newobj",
                  "text": "> 0",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
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
                  "id": "obj-5",
                  "maxclass": "newobj",
                  "text": "gate",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    165.0,
                    44.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-6",
                  "maxclass": "newobj",
                  "text": "t l l l l l",
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
                    50.0,
                    195.0,
                    400.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-7",
                  "maxclass": "newobj",
                  "text": "zl len",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "int",
                    ""
                  ],
                  "patching_rect": [
                    140.0,
                    225.0,
                    44.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-8",
                  "maxclass": "newobj",
                  "text": "zl nth 1",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    230.0,
                    225.0,
                    56.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-9",
                  "maxclass": "newobj",
                  "text": "zl rev",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    320.0,
                    225.0,
                    44.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-10",
                  "maxclass": "newobj",
                  "text": "zl nth 1",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    320.0,
                    255.0,
                    56.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-11",
                  "maxclass": "newobj",
                  "text": "prepend cluster",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50.0,
                    300.0,
                    90.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-12",
                  "maxclass": "newobj",
                  "text": "prepend count",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    140.0,
                    300.0,
                    85.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-13",
                  "maxclass": "newobj",
                  "text": "prepend lowest",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    230.0,
                    300.0,
                    90.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-14",
                  "maxclass": "newobj",
                  "text": "prepend highest",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    320.0,
                    300.0,
                    95.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-15",
                  "maxclass": "newobj",
                  "text": "== 1",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "int"
                  ],
                  "patching_rect": [
                    140.0,
                    255.0,
                    38.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-16",
                  "maxclass": "newobj",
                  "text": "sel 1",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "bang",
                    ""
                  ],
                  "patching_rect": [
                    140.0,
                    280.0,
                    38.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-17",
                  "maxclass": "message",
                  "text": "single",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    140.0,
                    330.0,
                    44.0,
                    22.0
                  ]
                }
              },
              {
                "box": {
                  "id": "obj-18",
                  "maxclass": "message",
                  "text": "done",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    410.0,
                    225.0,
                    38.0,
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
                    405.0,
                    30.0,
                    30.0
                  ],
                  "comment": "cluster output"
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
                    230.0,
                    405.0,
                    30.0,
                    30.0
                  ],
                  "comment": "metadata output"
                }
              },
              {
                "box": {
                  "id": "obj-21",
                  "maxclass": "newobj",
                  "text": "s #0_reset_cluster",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    91.0,
                    135.0,
                    105.0,
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
                    "obj-11",
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
                    "obj-6",
                    3
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
                    4
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
                    "obj-7",
                    0
                  ],
                  "destination": [
                    "obj-12",
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
                    "obj-15",
                    0
                  ],
                  "order": 0
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
                    "obj-14",
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
                    "obj-19",
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
                    "obj-20",
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
                    "obj-20",
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
                    "obj-20",
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
                    "obj-18",
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
                    1
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
                    "obj-2",
                    1
                  ],
                  "destination": [
                    "obj-5",
                    1
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
          "id": "obj-80",
          "maxclass": "comment",
          "text": "inlet 1: note pairs (pitch velocity)",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            88.0,
            24.0,
            200.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-81",
          "maxclass": "comment",
          "text": "inlet 2: control messages",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            512.0,
            24.0,
            136.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-82",
          "maxclass": "comment",
          "text": "outlet 1: cluster",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            88.0,
            728.0,
            104.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-83",
          "maxclass": "comment",
          "text": "outlet 2: metadata",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            312.0,
            728.0,
            104.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-84",
          "maxclass": "comment",
          "text": "outlet 3: note-off passthrough",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            536.0,
            728.0,
            168.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-85",
          "maxclass": "newobj",
          "text": "loadbang",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            "bang"
          ],
          "patching_rect": [
            480.0,
            200.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-86",
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
            224.0,
            56.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-87",
          "maxclass": "message",
          "text": "5",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480.0,
            248.0,
            32.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-88",
          "maxclass": "newobj",
          "text": "v #0_window",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            480.0,
            272.0,
            72.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-89",
          "maxclass": "message",
          "text": "1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            520.0,
            248.0,
            32.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-90",
          "maxclass": "newobj",
          "text": "v #0_sort",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            520.0,
            272.0,
            56.0,
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
            560.0,
            248.0,
            32.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "id": "obj-92",
          "maxclass": "newobj",
          "text": "v #0_unique",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            560.0,
            272.0,
            72.0,
            20.0
          ]
        }
      }
    ],
    "lines": [
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
            "obj-12",
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
            "obj-13",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-10",
            3
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
            4
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
            "obj-10",
            5
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
            0
          ],
          "destination": [
            "obj-17",
            0
          ],
          "order": 0
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
            "obj-22",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-20",
            1
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
            "obj-22",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-23",
            1
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
            "obj-22",
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
            "obj-22",
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
            "obj-30",
            0
          ],
          "destination": [
            "obj-33",
            1
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
            "obj-31",
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
            "obj-32",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-31",
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
            "obj-32",
            0
          ],
          "destination": [
            "obj-35",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-35",
            0
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
            "obj-33",
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
            "obj-33",
            1
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
            "obj-40",
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
            "obj-55",
            0
          ],
          "destination": [
            "obj-56",
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
            "obj-70",
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
            "obj-3",
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
            "obj-4",
            0
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
            "obj-86",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-86",
            0
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
            "obj-86",
            1
          ],
          "destination": [
            "obj-89",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-86",
            2
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
            "obj-87",
            0
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
            "obj-89",
            0
          ],
          "destination": [
            "obj-90",
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
      }
    ],
    "dependency_cache": []
  }
}

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
   85.0,
   104.0,
   750.0,
   600.0
  ],
  "bglocked": 0,
  "openinpresentation": 1,
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
     "patching_rect": [
      16.0,
      16.0,
      120.0,
      21.0
     ],
     "presentation": 1,
     "presentation_rect": [
      8.0,
      4.0,
      120.0,
      21.0
     ]
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
     "patching_rect": [
      16.0,
      40.0,
      200.0,
      18.0
     ],
     "presentation": 1,
     "presentation_rect": [
      8.0,
      24.0,
      200.0,
      18.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "newobj",
     "text": "midiin",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      560.0,
      72.0,
      44.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "newobj",
     "text": "midiout",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      560.0,
      528.0,
      48.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "newobj",
     "text": "live.thisdevice",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      640.0,
      72.0,
      84.0,
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
      640.0,
      104.0,
      56.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-7",
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
      640.0,
      128.0,
      32.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "newobj",
     "text": "v8 config-manager.js",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      640.0,
      176.0,
      120.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "newobj",
     "text": "route pitches_trk1 pitches_trk2 pulses_trk1 pulses_trk2 gatetypes_trk1 gatetypes_trk2 gatelength_trk1 gatelength_trk2 gatescale_trk1 gatescale_trk2 gatestretching_trk1 gatestretching_trk2 pulsecountdiv_trk1 pulsecountdiv_trk2 velocity_trk1 velocity_trk2 gateoverrides_trk1 gateoverrides_trk2 restpitch_trk1 restpitch_trk2 ratchets_trk1 ratchets_trk2 probability_trk1 probability_trk2 probtarget_trk1 probtarget_trk2 slidetoggles_trk1 slidetoggles_trk2 slideamount_trk1 slideamount_trk2 slidetype_trk1 slidetype_trk2 ratchetmode_trk1 ratchetmode_trk2 accumvalues_trk1 accumvalues_trk2 accumtriggers_trk1 accumtriggers_trk2 accumconfig_trk1 accumconfig_trk2 degreelut_trk1 degreelut_trk2 scalenames",
     "numinlets": 1,
     "numoutlets": 44,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      640.0,
      208.0,
      200.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "newobj",
     "text": "prepend init",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      640.0,
      152.0,
      68.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      640.0,
      240.0,
      90.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      640.0,
      272.0,
      90.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "newobj",
     "text": "prepend seq",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      640.0,
      304.0,
      68.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "newobj",
     "text": "prepend seq",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      640.0,
      336.0,
      68.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      640.0,
      368.0,
      90.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-16",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      640.0,
      400.0,
      90.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "newobj",
     "text": "i 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      480.0,
      312.0,
      24.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "newobj",
     "text": "p ClockEngine",
     "numinlets": 4,
     "numoutlets": 5,
     "outlettype": [
      "signal",
      "signal",
      "signal",
      "signal",
      "signal"
     ],
     "patching_rect": [
      16.0,
      184.0,
      200.0,
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
       100.0,
       100.0,
       900.0,
       700.0
      ],
      "bglocked": 0,
      "openinpresentation": 0,
      "default_fontsize": 12.0,
      "default_fontface": 0,
      "default_fontname": "Arial",
      "gridonopen": 1,
      "gridsize": [
       15.0,
       15.0
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
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          200.0,
          60.0,
          120.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-2",
         "maxclass": "newobj",
         "text": "plugsync~",
         "numinlets": 0,
         "numoutlets": 9,
         "outlettype": [
          "signal",
          "signal",
          "signal",
          "signal",
          "signal",
          "signal",
          "signal",
          "signal",
          "signal"
         ],
         "patching_rect": [
          400.0,
          60.0,
          200.0,
          22.0
         ]
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
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          30.0,
          30.0,
          30.0
         ]
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
         "outlettype": [
          ""
         ],
         "patching_rect": [
          80.0,
          30.0,
          30.0,
          30.0
         ]
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
         "outlettype": [
          ""
         ],
         "patching_rect": [
          130.0,
          30.0,
          30.0,
          30.0
         ]
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
         "outlettype": [
          ""
         ],
         "patching_rect": [
          180.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-10",
         "maxclass": "newobj",
         "text": "sig~ 1",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          90.0,
          42.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-11",
         "maxclass": "newobj",
         "text": "sig~ 50",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          80.0,
          90.0,
          48.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-12",
         "maxclass": "newobj",
         "text": "sig~ 1",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          130.0,
          90.0,
          42.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-13",
         "maxclass": "newobj",
         "text": "sig~ 50",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          180.0,
          90.0,
          48.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-20",
         "maxclass": "newobj",
         "text": "gen~ @title ClockDivTRK1",
         "numinlets": 3,
         "numoutlets": 2,
         "outlettype": [
          "signal",
          "signal"
         ],
         "patching_rect": [
          30.0,
          150.0,
          160.0,
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
          "classnamespace": "dsp.gen",
          "rect": [
           100.0,
           100.0,
           640.0,
           480.0
          ],
          "bglocked": 0,
          "openinpresentation": 0,
          "default_fontsize": 12.0,
          "default_fontface": 0,
          "default_fontname": "Arial",
          "gridonopen": 1,
          "gridsize": [
           15.0,
           15.0
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
             "outlettype": [
              ""
             ],
             "patching_rect": [
              30.0,
              30.0,
              30.0,
              22.0
             ]
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
              150.0,
              30.0,
              30.0,
              22.0
             ]
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
              270.0,
              30.0,
              30.0,
              22.0
             ]
            }
           },
           {
            "box": {
             "id": "obj-4",
             "maxclass": "newobj",
             "text": "codebox",
             "numinlets": 3,
             "numoutlets": 2,
             "outlettype": [
              "",
              ""
             ],
             "patching_rect": [
              30.0,
              90.0,
              400.0,
              200.0
             ],
             "code": "// Clock divider with swing\n// in1=phasor in2=division(1-64) in3=swing(50-78)\n// out1=divided phasor out2=edge trigger\n// Swing delays even-numbered pulses (per Metropolix manual)\n\nHistory prev(0);\nHistory count(0);\n\nmaster = in1;\ndiv = max(in2, 1);\nswing = clamp(in3, 50, 78) / 100.0;\n\nedge = (master < 0.5) && (prev >= 0.5);\nif (edge) { count = wrap(count + 1, 0, div); }\n\nraw = wrap((count + master) / div, 0, 1);\n\n// Even pulses (0-indexed) are delayed by the swing amount\neven = 1 - (floor(raw * 2) % 2);\nswung = raw;\nif (even > 0.5) {\n    swung = swing + (raw - 0.5) * 2 * (1 - swing);\n} else {\n    swung = raw * 2 * swing;\n}\n\nHistory pd(0);\nde = (swung < pd - 0.5);\npd = swung;\nprev = master;\n\nout1 = swung;\nout2 = de;"
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
              330.0,
              34.0,
              22.0
             ]
            }
           },
           {
            "box": {
             "id": "obj-6",
             "maxclass": "newobj",
             "text": "out 2",
             "numinlets": 1,
             "numoutlets": 0,
             "patching_rect": [
              270.0,
              330.0,
              34.0,
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
           },
           {
            "patchline": {
             "source": [
              "obj-4",
              1
             ],
             "destination": [
              "obj-6",
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
         "id": "obj-21",
         "maxclass": "newobj",
         "text": "gen~ @title ClockDivTRK2",
         "numinlets": 3,
         "numoutlets": 2,
         "outlettype": [
          "signal",
          "signal"
         ],
         "patching_rect": [
          300.0,
          150.0,
          160.0,
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
          "classnamespace": "dsp.gen",
          "rect": [
           100.0,
           100.0,
           640.0,
           480.0
          ],
          "bglocked": 0,
          "openinpresentation": 0,
          "default_fontsize": 12.0,
          "default_fontface": 0,
          "default_fontname": "Arial",
          "gridonopen": 1,
          "gridsize": [
           15.0,
           15.0
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
             "outlettype": [
              ""
             ],
             "patching_rect": [
              30.0,
              30.0,
              30.0,
              22.0
             ]
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
              150.0,
              30.0,
              30.0,
              22.0
             ]
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
              270.0,
              30.0,
              30.0,
              22.0
             ]
            }
           },
           {
            "box": {
             "id": "obj-4",
             "maxclass": "newobj",
             "text": "codebox",
             "numinlets": 3,
             "numoutlets": 2,
             "outlettype": [
              "",
              ""
             ],
             "patching_rect": [
              30.0,
              90.0,
              400.0,
              200.0
             ],
             "code": "// Clock divider with swing (TRK2)\n// Swing delays even-numbered pulses (per Metropolix manual)\nHistory prev(0);\nHistory count(0);\n\nmaster = in1;\ndiv = max(in2, 1);\nswing = clamp(in3, 50, 78) / 100.0;\n\nedge = (master < 0.5) && (prev >= 0.5);\nif (edge) { count = wrap(count + 1, 0, div); }\n\nraw = wrap((count + master) / div, 0, 1);\n\neven = 1 - (floor(raw * 2) % 2);\nswung = raw;\nif (even > 0.5) {\n    swung = swing + (raw - 0.5) * 2 * (1 - swing);\n} else {\n    swung = raw * 2 * swing;\n}\n\nHistory pd(0);\nde = (swung < pd - 0.5);\npd = swung;\nprev = master;\n\nout1 = swung;\nout2 = de;"
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
              330.0,
              34.0,
              22.0
             ]
            }
           },
           {
            "box": {
             "id": "obj-6",
             "maxclass": "newobj",
             "text": "out 2",
             "numinlets": 1,
             "numoutlets": 0,
             "patching_rect": [
              270.0,
              330.0,
              34.0,
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
           },
           {
            "patchline": {
             "source": [
              "obj-4",
              1
             ],
             "destination": [
              "obj-6",
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
         "id": "obj-30",
         "maxclass": "newobj",
         "text": ">~ 0.5",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          400.0,
          110.0,
          42.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-31",
         "maxclass": "newobj",
         "text": "*~",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          210.0,
          30.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-32",
         "maxclass": "newobj",
         "text": "*~",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          300.0,
          210.0,
          30.0,
          22.0
         ]
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
         "patching_rect": [
          30.0,
          270.0,
          30.0,
          30.0
         ]
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
         "patching_rect": [
          130.0,
          270.0,
          30.0,
          30.0
         ]
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
         "patching_rect": [
          300.0,
          270.0,
          30.0,
          30.0
         ]
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
         "patching_rect": [
          400.0,
          270.0,
          30.0,
          30.0
         ]
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
         "patching_rect": [
          500.0,
          270.0,
          30.0,
          30.0
         ]
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "source": [
          "obj-3",
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
          "obj-4",
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
          "obj-5",
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
          "obj-6",
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
          "obj-1",
          0
         ],
         "destination": [
          "obj-20",
          0
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-10",
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
          "obj-11",
          0
         ],
         "destination": [
          "obj-20",
          2
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
          "obj-21",
          0
         ],
         "order": 0
        }
       },
       {
        "patchline": {
         "source": [
          "obj-12",
          0
         ],
         "destination": [
          "obj-21",
          1
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
          "obj-21",
          2
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
          "obj-30",
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
          "obj-31",
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
          1
         ],
         "order": 2
        }
       },
       {
        "patchline": {
         "source": [
          "obj-21",
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
          "obj-30",
          0
         ],
         "destination": [
          "obj-32",
          1
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-31",
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
          "obj-20",
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
          "obj-32",
          0
         ],
         "destination": [
          "obj-42",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-21",
          1
         ],
         "destination": [
          "obj-43",
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
          "obj-44",
          0
         ],
         "order": 0
        }
       }
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
     "numinlets": 40,
     "numoutlets": 12,
     "outlettype": [
      "signal",
      "signal",
      "",
      "signal",
      "signal",
      "",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal"
     ],
     "patching_rect": [
      16.0,
      264.0,
      400.0,
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
       100.0,
       100.0,
       960.0,
       750.0
      ],
      "bglocked": 0,
      "openinpresentation": 0,
      "default_fontsize": 12.0,
      "default_fontface": 0,
      "default_fontname": "Arial",
      "gridonopen": 1,
      "gridsize": [
       15.0,
       15.0
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
         "maxclass": "inlet",
         "index": 1,
         "comment": "TRK1 phasor",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-2",
         "maxclass": "inlet",
         "index": 2,
         "comment": "TRK2 phasor",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          480.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-3",
         "maxclass": "inlet",
         "index": 3,
         "comment": "TRK1 pulse counts (seq msg)",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          120.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-4",
         "maxclass": "inlet",
         "index": 4,
         "comment": "TRK2 pulse counts (seq msg)",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          570.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-5",
         "maxclass": "inlet",
         "index": 5,
         "comment": "TRK1 pitches (pattern msg)",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          210.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-6",
         "maxclass": "inlet",
         "index": 6,
         "comment": "TRK2 pitches (pattern msg)",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          660.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-7",
         "maxclass": "inlet",
         "index": 7,
         "comment": "TRK1 gate types (pattern msg)",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          300.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-8",
         "maxclass": "inlet",
         "index": 8,
         "comment": "TRK2 gate types (pattern msg)",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          750.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-9",
         "maxclass": "inlet",
         "index": 9,
         "comment": "TRK1 gate len",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          390.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-10",
         "maxclass": "inlet",
         "index": 10,
         "comment": "TRK2 gate len",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          840.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-20",
         "maxclass": "newobj",
         "text": "stepcounter~ @seq 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          120.0,
          240.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-22",
         "maxclass": "newobj",
         "text": "stepdiv~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          180.0,
          240.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-23",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 60 60 60 60 60 60 60 60",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          240.0,
          280.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-25",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          300.0,
          240.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-27",
         "maxclass": "newobj",
         "text": "sig~ 0.5",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          390.0,
          90.0,
          52.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-28",
         "maxclass": "newobj",
         "text": "gen~ @title GateGenT1",
         "numinlets": 13,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          360.0,
          300.0,
          22.0
         ],
         "patcher": {
          "fileversion": 1,
          "classnamespace": "dsp.gen",
          "rect": [
           0,
           0,
           800,
           400
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
              30,
              30,
              30,
              22
             ]
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
              90,
              30,
              30,
              22
             ]
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
              150,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-4",
             "maxclass": "newobj",
             "text": "in 4",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              210,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-5",
             "maxclass": "newobj",
             "text": "in 5",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              270,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-6",
             "maxclass": "newobj",
             "text": "in 6",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              330,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-7",
             "maxclass": "newobj",
             "text": "in 7",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              390,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-8",
             "maxclass": "newobj",
             "text": "in 8",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              450,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-9",
             "maxclass": "newobj",
             "text": "in 9",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              510,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-10",
             "maxclass": "newobj",
             "text": "in 10",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              570,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-11",
             "maxclass": "newobj",
             "text": "in 11",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              630,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-12",
             "maxclass": "newobj",
             "text": "in 12",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              690,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-13",
             "maxclass": "newobj",
             "text": "in 13",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              750,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-20",
             "maxclass": "newobj",
             "text": "codebox",
             "numinlets": 13,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              30,
              120,
              740,
              200
             ],
             "code": "// Full gate generator - Stage 3\n// in1=step phasor  in2=gate type(0-3)  in3=gate length(0.01-1.0)\n// in4=stepcounter  in5=gate scale(0.01-2.0)  in6=gate stretching(0/1)\n// in7=pulse count div(1-8)  in8=gate override(-1=OFF, 0=Rest, 0.01-1.0)\n// in9=pulse count for current stage (1-8)\n// in10=ratchet count (1-8)  in11=ratchet mode (0=Multiply, 1=Pulse, 2=Gated)\n// in12=probability (0.0-1.0)  in13=prob target (0=Stage, 1=Pulse)\n//\n// Gate types: 0=Rest, 1=Single, 2=Multi, 3=Hold\n// Gate override encoding: -1=OFF (use track gate), 0=Rest, 0.01-0.99=%, 1.0=Hold\n\nHistory prev_counter(-1);\nHistory pulse_in_stage(0);\nHistory stage_prob_pass(1);\nHistory prev_phasor(1);\nHistory rng_state(12345);\n\n// Simple LCG PRNG (deterministic per sample)\nrng_state = (rng_state * 1103515245 + 12345) % 2147483648;\nrng_val = abs(rng_state) / 2147483647.0;\n\nphasor = in1;\ngt = in2;\nraw_gl = clamp(in3, 0.01, 1.0);\ncounter = in4;\ngscale = clamp(in5, 0.01, 2.0);\nstretching = in6 >= 0.5;\npcdiv = max(floor(in7), 1);\ngate_ovr = in8;\ntotal_pulses = max(floor(in9), 1);\nratchet_count = max(floor(in10), 1);\nratchet_mode = floor(in11);\nprob = clamp(in12, 0.0, 1.0);\nprob_target = floor(in13);\n\n// Detect stage boundary and pulse boundary via edge detection\nnew_stage = (counter != prev_counter);\nnew_pulse = (prev_phasor > 0.5 && phasor < 0.5);  // falling edge of phasor wrap\nif (new_stage) {\n    pulse_in_stage = 0;\n    // Stage probability: roll once on stage entry\n    if (prob_target < 0.5) {\n        stage_prob_pass = rng_val <= prob;\n    } else {\n        stage_prob_pass = 1;\n    }\n} else if (new_pulse) {\n    pulse_in_stage = pulse_in_stage + 1;\n}\nprev_counter = counter;\nprev_phasor = phasor;\n\n// Pulse probability: roll each pulse\npulse_prob_pass = 1;\nif (prob_target >= 0.5 && new_pulse) {\n    pulse_prob_pass = rng_val <= prob;\n}\n\n// Combined probability check\nprob_pass = stage_prob_pass;\nif (prob_target >= 0.5) {\n    prob_pass = pulse_prob_pass;\n}\n\n// Gate override: replaces track gate length when active\neff_gl = raw_gl;\nif (gate_ovr > -0.5) {\n    if (gate_ovr < 0.005) {\n        gt = 0;\n    } else if (gate_ovr > 0.995) {\n        gt = 3;\n    } else {\n        eff_gl = clamp(gate_ovr, 0.01, 1.0);\n    }\n}\n\n// Apply gate scale\ngl = clamp(eff_gl * gscale, 0.01, 1.0);\n\n// Helper: compute ratchet sub-gate from a phase and count\n// Returns 1 if within a ratchet sub-gate, 0 otherwise\n// ratch_phase is 0..1 over the ratchet period, ratch_n is count\n// Each sub-gate gets gl fraction of its sub-period\n\n// === GATE GENERATION ===\ngate = 0;\n\nif (gt < 0.5) {\n    // Rest: no gate\n    gate = 0;\n\n} else if (gt < 1.5) {\n    // Single: gate on first pulse only\n    if (stretching) {\n        // Gate Stretching ON\n        stage_pos = (pulse_in_stage + phasor) / total_pulses;\n        trunc = 1.0 - (1.0 / (96.0 * total_pulses));\n        stretched_gl = min(gl, trunc);\n\n        if (ratchet_count > 1 && ratchet_mode < 0.5) {\n            // Multiply: ratchets span entire stage\n            sub_phase = fract(stage_pos * ratchet_count);\n            gate = sub_phase < gl && stage_pos < trunc;\n        } else if (ratchet_count > 1 && ratchet_mode < 1.5) {\n            // Pulse: ratchets within first pulse only\n            if (pulse_in_stage < 0.5) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl;\n            }\n        } else if (ratchet_count > 1 && ratchet_mode < 2.5) {\n            // Gated: ratchets within first pulse, cut by gate length\n            if (pulse_in_stage < 0.5) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl && phasor < stretched_gl * total_pulses;\n            }\n        } else {\n            gate = stage_pos < stretched_gl;\n        }\n    } else {\n        // Gate Stretching OFF\n        if (pulse_in_stage < 0.5) {\n            if (ratchet_count > 1) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl;\n            } else {\n                gate = phasor < gl;\n            }\n        }\n    }\n\n} else if (gt < 2.5) {\n    // Multi with pulse count division\n    if (stretching) {\n        stage_pos = (pulse_in_stage + phasor) / total_pulses;\n        trunc = 1.0 - (1.0 / (96.0 * total_pulses));\n\n        if (pcdiv < 1.5) {\n            if (ratchet_count > 1 && ratchet_mode < 0.5) {\n                sub_phase = fract(stage_pos * ratchet_count);\n                gate = sub_phase < gl && stage_pos < trunc;\n            } else if (ratchet_count > 1 && ratchet_mode < 1.5) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl;\n            } else if (ratchet_count > 1 && ratchet_mode < 2.5) {\n                stretched_gl = min(gl, trunc);\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl && stage_pos < stretched_gl;\n            } else {\n                gate = stage_pos < min(gl, trunc);\n            }\n        } else {\n            group_idx = floor(pulse_in_stage / pcdiv);\n            group_start = group_idx * pcdiv;\n            remaining = total_pulses - group_start;\n            group_size = min(pcdiv, remaining);\n            group_pos_in = pulse_in_stage - group_start;\n            group_frac = (group_pos_in + phasor) / group_size;\n            group_trunc = 1.0 - (1.0 / (96.0 * group_size));\n\n            if (ratchet_count > 1) {\n                // Ratchets within each group\n                sub_phase = fract(group_frac * ratchet_count);\n                gate = sub_phase < gl && group_frac < group_trunc;\n            } else {\n                gate = group_frac < min(gl, group_trunc);\n            }\n        }\n    } else {\n        // Gate Stretching OFF\n        if (pcdiv < 1.5) {\n            if (ratchet_count > 1) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl;\n            } else {\n                gate = phasor < gl;\n            }\n        } else {\n            group_idx = floor(pulse_in_stage / pcdiv);\n            group_start = group_idx * pcdiv;\n            remaining = total_pulses - group_start;\n            group_size = min(pcdiv, remaining);\n            group_pos = pulse_in_stage - group_start;\n            if (group_pos >= group_size - 1) {\n                // Last pulse in group: apply gate length\n                if (ratchet_count > 1) {\n                    sub_phase = fract(phasor * ratchet_count);\n                    gate = sub_phase < gl;\n                } else {\n                    gate = phasor < gl;\n                }\n            } else {\n                // Interior pulse: gate is full on\n                if (ratchet_count > 1) {\n                    sub_phase = fract(phasor * ratchet_count);\n                    gate = sub_phase < gl;\n                } else {\n                    gate = 1;\n                }\n            }\n        }\n    }\n\n} else {\n    // Hold: always on (legato)\n    gate = 1;\n}\n\n// Apply probability\nif (!prob_pass) {\n    gate = 0;\n}\n\nout1 = gate;\n"
            }
           },
           {
            "box": {
             "id": "obj-30",
             "maxclass": "newobj",
             "text": "out 1",
             "numinlets": 1,
             "numoutlets": 0,
             "outlettype": [],
             "patching_rect": [
              350,
              350,
              35,
              22
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
              "obj-20",
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
              "obj-20",
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
              "obj-20",
              3
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
              "obj-20",
              4
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
              "obj-20",
              5
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
              "obj-20",
              6
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
              "obj-20",
              7
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
              "obj-20",
              8
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
              "obj-20",
              9
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
              "obj-20",
              10
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
              11
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
              12
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
              "obj-30",
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
         "id": "obj-29",
         "maxclass": "newobj",
         "text": "snapshot~ 30",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          300.0,
          150.0,
          75.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-50",
         "maxclass": "newobj",
         "text": "stepcounter~ @seq 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          480.0,
          120.0,
          240.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-52",
         "maxclass": "newobj",
         "text": "stepdiv~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          480.0,
          180.0,
          240.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-53",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 60 60 60 60 60 60 60 60",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          480.0,
          240.0,
          280.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-55",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          480.0,
          300.0,
          240.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-57",
         "maxclass": "newobj",
         "text": "sig~ 0.5",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          840.0,
          90.0,
          52.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-58",
         "maxclass": "newobj",
         "text": "gen~ @title GateGenT2",
         "numinlets": 13,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          480.0,
          360.0,
          300.0,
          22.0
         ],
         "patcher": {
          "fileversion": 1,
          "classnamespace": "dsp.gen",
          "rect": [
           0,
           0,
           800,
           400
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
              30,
              30,
              30,
              22
             ]
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
              90,
              30,
              30,
              22
             ]
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
              150,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-4",
             "maxclass": "newobj",
             "text": "in 4",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              210,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-5",
             "maxclass": "newobj",
             "text": "in 5",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              270,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-6",
             "maxclass": "newobj",
             "text": "in 6",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              330,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-7",
             "maxclass": "newobj",
             "text": "in 7",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              390,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-8",
             "maxclass": "newobj",
             "text": "in 8",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              450,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-9",
             "maxclass": "newobj",
             "text": "in 9",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              510,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-10",
             "maxclass": "newobj",
             "text": "in 10",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              570,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-11",
             "maxclass": "newobj",
             "text": "in 11",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              630,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-12",
             "maxclass": "newobj",
             "text": "in 12",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              690,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-13",
             "maxclass": "newobj",
             "text": "in 13",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              750,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-20",
             "maxclass": "newobj",
             "text": "codebox",
             "numinlets": 13,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              30,
              120,
              740,
              200
             ],
             "code": "// Full gate generator - Stage 3\n// in1=step phasor  in2=gate type(0-3)  in3=gate length(0.01-1.0)\n// in4=stepcounter  in5=gate scale(0.01-2.0)  in6=gate stretching(0/1)\n// in7=pulse count div(1-8)  in8=gate override(-1=OFF, 0=Rest, 0.01-1.0)\n// in9=pulse count for current stage (1-8)\n// in10=ratchet count (1-8)  in11=ratchet mode (0=Multiply, 1=Pulse, 2=Gated)\n// in12=probability (0.0-1.0)  in13=prob target (0=Stage, 1=Pulse)\n//\n// Gate types: 0=Rest, 1=Single, 2=Multi, 3=Hold\n// Gate override encoding: -1=OFF (use track gate), 0=Rest, 0.01-0.99=%, 1.0=Hold\n\nHistory prev_counter(-1);\nHistory pulse_in_stage(0);\nHistory stage_prob_pass(1);\nHistory prev_phasor(1);\nHistory rng_state(67890);\n\n// Simple LCG PRNG (deterministic per sample)\nrng_state = (rng_state * 1103515245 + 12345) % 2147483648;\nrng_val = abs(rng_state) / 2147483647.0;\n\nphasor = in1;\ngt = in2;\nraw_gl = clamp(in3, 0.01, 1.0);\ncounter = in4;\ngscale = clamp(in5, 0.01, 2.0);\nstretching = in6 >= 0.5;\npcdiv = max(floor(in7), 1);\ngate_ovr = in8;\ntotal_pulses = max(floor(in9), 1);\nratchet_count = max(floor(in10), 1);\nratchet_mode = floor(in11);\nprob = clamp(in12, 0.0, 1.0);\nprob_target = floor(in13);\n\n// Detect stage boundary and pulse boundary via edge detection\nnew_stage = (counter != prev_counter);\nnew_pulse = (prev_phasor > 0.5 && phasor < 0.5);  // falling edge of phasor wrap\nif (new_stage) {\n    pulse_in_stage = 0;\n    // Stage probability: roll once on stage entry\n    if (prob_target < 0.5) {\n        stage_prob_pass = rng_val <= prob;\n    } else {\n        stage_prob_pass = 1;\n    }\n} else if (new_pulse) {\n    pulse_in_stage = pulse_in_stage + 1;\n}\nprev_counter = counter;\nprev_phasor = phasor;\n\n// Pulse probability: roll each pulse\npulse_prob_pass = 1;\nif (prob_target >= 0.5 && new_pulse) {\n    pulse_prob_pass = rng_val <= prob;\n}\n\n// Combined probability check\nprob_pass = stage_prob_pass;\nif (prob_target >= 0.5) {\n    prob_pass = pulse_prob_pass;\n}\n\n// Gate override: replaces track gate length when active\neff_gl = raw_gl;\nif (gate_ovr > -0.5) {\n    if (gate_ovr < 0.005) {\n        gt = 0;\n    } else if (gate_ovr > 0.995) {\n        gt = 3;\n    } else {\n        eff_gl = clamp(gate_ovr, 0.01, 1.0);\n    }\n}\n\n// Apply gate scale\ngl = clamp(eff_gl * gscale, 0.01, 1.0);\n\n// Helper: compute ratchet sub-gate from a phase and count\n// Returns 1 if within a ratchet sub-gate, 0 otherwise\n// ratch_phase is 0..1 over the ratchet period, ratch_n is count\n// Each sub-gate gets gl fraction of its sub-period\n\n// === GATE GENERATION ===\ngate = 0;\n\nif (gt < 0.5) {\n    // Rest: no gate\n    gate = 0;\n\n} else if (gt < 1.5) {\n    // Single: gate on first pulse only\n    if (stretching) {\n        // Gate Stretching ON\n        stage_pos = (pulse_in_stage + phasor) / total_pulses;\n        trunc = 1.0 - (1.0 / (96.0 * total_pulses));\n        stretched_gl = min(gl, trunc);\n\n        if (ratchet_count > 1 && ratchet_mode < 0.5) {\n            // Multiply: ratchets span entire stage\n            sub_phase = fract(stage_pos * ratchet_count);\n            gate = sub_phase < gl && stage_pos < trunc;\n        } else if (ratchet_count > 1 && ratchet_mode < 1.5) {\n            // Pulse: ratchets within first pulse only\n            if (pulse_in_stage < 0.5) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl;\n            }\n        } else if (ratchet_count > 1 && ratchet_mode < 2.5) {\n            // Gated: ratchets within first pulse, cut by gate length\n            if (pulse_in_stage < 0.5) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl && phasor < stretched_gl * total_pulses;\n            }\n        } else {\n            gate = stage_pos < stretched_gl;\n        }\n    } else {\n        // Gate Stretching OFF\n        if (pulse_in_stage < 0.5) {\n            if (ratchet_count > 1) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl;\n            } else {\n                gate = phasor < gl;\n            }\n        }\n    }\n\n} else if (gt < 2.5) {\n    // Multi with pulse count division\n    if (stretching) {\n        stage_pos = (pulse_in_stage + phasor) / total_pulses;\n        trunc = 1.0 - (1.0 / (96.0 * total_pulses));\n\n        if (pcdiv < 1.5) {\n            if (ratchet_count > 1 && ratchet_mode < 0.5) {\n                sub_phase = fract(stage_pos * ratchet_count);\n                gate = sub_phase < gl && stage_pos < trunc;\n            } else if (ratchet_count > 1 && ratchet_mode < 1.5) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl;\n            } else if (ratchet_count > 1 && ratchet_mode < 2.5) {\n                stretched_gl = min(gl, trunc);\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl && stage_pos < stretched_gl;\n            } else {\n                gate = stage_pos < min(gl, trunc);\n            }\n        } else {\n            group_idx = floor(pulse_in_stage / pcdiv);\n            group_start = group_idx * pcdiv;\n            remaining = total_pulses - group_start;\n            group_size = min(pcdiv, remaining);\n            group_pos_in = pulse_in_stage - group_start;\n            group_frac = (group_pos_in + phasor) / group_size;\n            group_trunc = 1.0 - (1.0 / (96.0 * group_size));\n\n            if (ratchet_count > 1) {\n                // Ratchets within each group\n                sub_phase = fract(group_frac * ratchet_count);\n                gate = sub_phase < gl && group_frac < group_trunc;\n            } else {\n                gate = group_frac < min(gl, group_trunc);\n            }\n        }\n    } else {\n        // Gate Stretching OFF\n        if (pcdiv < 1.5) {\n            if (ratchet_count > 1) {\n                sub_phase = fract(phasor * ratchet_count);\n                gate = sub_phase < gl;\n            } else {\n                gate = phasor < gl;\n            }\n        } else {\n            group_idx = floor(pulse_in_stage / pcdiv);\n            group_start = group_idx * pcdiv;\n            remaining = total_pulses - group_start;\n            group_size = min(pcdiv, remaining);\n            group_pos = pulse_in_stage - group_start;\n            if (group_pos >= group_size - 1) {\n                // Last pulse in group: apply gate length\n                if (ratchet_count > 1) {\n                    sub_phase = fract(phasor * ratchet_count);\n                    gate = sub_phase < gl;\n                } else {\n                    gate = phasor < gl;\n                }\n            } else {\n                // Interior pulse: gate is full on\n                if (ratchet_count > 1) {\n                    sub_phase = fract(phasor * ratchet_count);\n                    gate = sub_phase < gl;\n                } else {\n                    gate = 1;\n                }\n            }\n        }\n    }\n\n} else {\n    // Hold: always on (legato)\n    gate = 1;\n}\n\n// Apply probability\nif (!prob_pass) {\n    gate = 0;\n}\n\nout1 = gate;\n"
            }
           },
           {
            "box": {
             "id": "obj-30",
             "maxclass": "newobj",
             "text": "out 1",
             "numinlets": 1,
             "numoutlets": 0,
             "outlettype": [],
             "patching_rect": [
              350,
              350,
              35,
              22
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
              "obj-20",
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
              "obj-20",
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
              "obj-20",
              3
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
              "obj-20",
              4
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
              "obj-20",
              5
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
              "obj-20",
              6
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
              "obj-20",
              7
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
              "obj-20",
              8
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
              "obj-20",
              9
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
              "obj-20",
              10
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
              11
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
              12
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
              "obj-30",
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
         "id": "obj-59",
         "maxclass": "newobj",
         "text": "snapshot~ 30",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          750.0,
          150.0,
          75.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-70",
         "maxclass": "outlet",
         "index": 1,
         "comment": "TRK1 pitch",
         "numinlets": 1,
         "numoutlets": 0,
         "patching_rect": [
          30.0,
          420.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-71",
         "maxclass": "outlet",
         "index": 2,
         "comment": "TRK1 gate",
         "numinlets": 1,
         "numoutlets": 0,
         "patching_rect": [
          120.0,
          420.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-72",
         "maxclass": "outlet",
         "index": 3,
         "comment": "TRK1 stage idx",
         "numinlets": 1,
         "numoutlets": 0,
         "patching_rect": [
          300.0,
          420.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-73",
         "maxclass": "outlet",
         "index": 4,
         "comment": "TRK2 pitch",
         "numinlets": 1,
         "numoutlets": 0,
         "patching_rect": [
          480.0,
          420.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-74",
         "maxclass": "outlet",
         "index": 5,
         "comment": "TRK2 gate",
         "numinlets": 1,
         "numoutlets": 0,
         "patching_rect": [
          570.0,
          420.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-75",
         "maxclass": "outlet",
         "index": 6,
         "comment": "TRK2 stage idx",
         "numinlets": 1,
         "numoutlets": 0,
         "patching_rect": [
          750.0,
          420.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-76",
         "maxclass": "outlet",
         "index": 7,
         "comment": "TRK1 step phasor",
         "numinlets": 1,
         "numoutlets": 0,
         "patching_rect": [
          210.0,
          420.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-77",
         "maxclass": "outlet",
         "index": 8,
         "comment": "TRK2 step phasor",
         "numinlets": 1,
         "numoutlets": 0,
         "patching_rect": [
          660.0,
          420.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-80",
         "maxclass": "inlet",
         "index": 11,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          700,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-81",
         "maxclass": "inlet",
         "index": 12,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          740,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-82",
         "maxclass": "inlet",
         "index": 13,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          780,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-83",
         "maxclass": "inlet",
         "index": 14,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          820,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-84",
         "maxclass": "inlet",
         "index": 15,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          860,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-85",
         "maxclass": "inlet",
         "index": 16,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          900,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-86",
         "maxclass": "inlet",
         "index": 17,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          940,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-87",
         "maxclass": "inlet",
         "index": 18,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          980,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-88",
         "maxclass": "inlet",
         "index": 19,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1020,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-89",
         "maxclass": "inlet",
         "index": 20,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1060,
          30,
          30,
          30
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "obj-26",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern -1 -1 -1 -1 -1 -1 -1 -1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          940,
          150,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-56",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern -1 -1 -1 -1 -1 -1 -1 -1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          940,
          350,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-90",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          1100,
          150,
          220,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-91",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          1100,
          350,
          220,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-100",
         "maxclass": "inlet",
         "index": 21,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30,
          500,
          30,
          30
         ],
         "comment": "Ratchets T1 pattern"
        }
       },
       {
        "box": {
         "id": "obj-101",
         "maxclass": "inlet",
         "index": 22,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          70,
          500,
          30,
          30
         ],
         "comment": "Ratchets T2 pattern"
        }
       },
       {
        "box": {
         "id": "obj-102",
         "maxclass": "inlet",
         "index": 23,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          110,
          500,
          30,
          30
         ],
         "comment": "Probability T1 pattern"
        }
       },
       {
        "box": {
         "id": "obj-103",
         "maxclass": "inlet",
         "index": 24,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          150,
          500,
          30,
          30
         ],
         "comment": "Probability T2 pattern"
        }
       },
       {
        "box": {
         "id": "obj-104",
         "maxclass": "inlet",
         "index": 25,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          190,
          500,
          30,
          30
         ],
         "comment": "ProbTarget T1 pattern"
        }
       },
       {
        "box": {
         "id": "obj-105",
         "maxclass": "inlet",
         "index": 26,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          230,
          500,
          30,
          30
         ],
         "comment": "ProbTarget T2 pattern"
        }
       },
       {
        "box": {
         "id": "obj-106",
         "maxclass": "inlet",
         "index": 27,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          270,
          500,
          30,
          30
         ],
         "comment": "SlideToggle T1 pattern"
        }
       },
       {
        "box": {
         "id": "obj-107",
         "maxclass": "inlet",
         "index": 28,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          310,
          500,
          30,
          30
         ],
         "comment": "SlideToggle T2 pattern"
        }
       },
       {
        "box": {
         "id": "obj-108",
         "maxclass": "inlet",
         "index": 29,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          350,
          500,
          30,
          30
         ],
         "comment": "RatchetMode T1"
        }
       },
       {
        "box": {
         "id": "obj-109",
         "maxclass": "inlet",
         "index": 30,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          390,
          500,
          30,
          30
         ],
         "comment": "RatchetMode T2"
        }
       },
       {
        "box": {
         "id": "obj-120",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30,
          580,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-121",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30,
          680,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-122",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          280,
          580,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-123",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 1 1 1 1 1 1 1 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          280,
          680,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-124",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 0 0 0 0 0 0 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          530,
          580,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-125",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 0 0 0 0 0 0 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          530,
          680,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-126",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 0 0 0 0 0 0 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          780,
          580,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-127",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 0 0 0 0 0 0 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          780,
          680,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-128",
         "maxclass": "outlet",
         "index": 9,
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          780,
          760,
          30,
          30
         ],
         "comment": "SlideToggle T1"
        }
       },
       {
        "box": {
         "id": "obj-129",
         "maxclass": "outlet",
         "index": 10,
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          820,
          760,
          30,
          30
         ],
         "comment": "SlideToggle T2"
        }
       },
       {
        "box": {
         "id": "obj-130",
         "maxclass": "inlet",
         "index": 31,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30,
          800,
          30,
          30
         ],
         "comment": "AccumValues T1"
        }
       },
       {
        "box": {
         "id": "obj-131",
         "maxclass": "inlet",
         "index": 32,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          70,
          800,
          30,
          30
         ],
         "comment": "AccumValues T2"
        }
       },
       {
        "box": {
         "id": "obj-132",
         "maxclass": "inlet",
         "index": 33,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          110,
          800,
          30,
          30
         ],
         "comment": "AccumTriggers T1"
        }
       },
       {
        "box": {
         "id": "obj-133",
         "maxclass": "inlet",
         "index": 34,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          150,
          800,
          30,
          30
         ],
         "comment": "AccumTriggers T2"
        }
       },
       {
        "box": {
         "id": "obj-134",
         "maxclass": "inlet",
         "index": 35,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          200,
          800,
          30,
          30
         ],
         "comment": "AccumMode T1"
        }
       },
       {
        "box": {
         "id": "obj-135",
         "maxclass": "inlet",
         "index": 36,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          240,
          800,
          30,
          30
         ],
         "comment": "AccumOrder T1"
        }
       },
       {
        "box": {
         "id": "obj-136",
         "maxclass": "inlet",
         "index": 37,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          280,
          800,
          30,
          30
         ],
         "comment": "AccumPolarity T1"
        }
       },
       {
        "box": {
         "id": "obj-137",
         "maxclass": "inlet",
         "index": 38,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          320,
          800,
          30,
          30
         ],
         "comment": "AccumLimitPos T1"
        }
       },
       {
        "box": {
         "id": "obj-138",
         "maxclass": "inlet",
         "index": 39,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          360,
          800,
          30,
          30
         ],
         "comment": "AccumLimitNeg T1"
        }
       },
       {
        "box": {
         "id": "obj-139",
         "maxclass": "inlet",
         "index": 40,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          400,
          800,
          30,
          30
         ],
         "comment": "AccumReset T1"
        }
       },
       {
        "box": {
         "id": "obj-140",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 0 0 0 0 0 0 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30,
          880,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-141",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 0 0 0 0 0 0 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30,
          940,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-142",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 0 0 0 0 0 0 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          280,
          880,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-143",
         "maxclass": "newobj",
         "text": "stepfun~ @pattern 0 0 0 0 0 0 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          280,
          940,
          230,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-150",
         "maxclass": "newobj",
         "text": "gen~ @title AccumT1",
         "numinlets": 11,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30,
          1020,
          250,
          22
         ],
         "patcher": {
          "fileversion": 1,
          "classnamespace": "dsp.gen",
          "rect": [
           0,
           0,
           800,
           500
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
              30,
              30,
              30,
              22
             ]
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
              80,
              30,
              30,
              22
             ]
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
              130,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-4",
             "maxclass": "newobj",
             "text": "in 4",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              180,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-5",
             "maxclass": "newobj",
             "text": "in 5",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              230,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-6",
             "maxclass": "newobj",
             "text": "in 6",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              280,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-7",
             "maxclass": "newobj",
             "text": "in 7",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              330,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-8",
             "maxclass": "newobj",
             "text": "in 8",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              380,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-9",
             "maxclass": "newobj",
             "text": "in 9",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              430,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-10",
             "maxclass": "newobj",
             "text": "in 10",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              480,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-11",
             "maxclass": "newobj",
             "text": "in 11",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              530,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-20",
             "maxclass": "newobj",
             "text": "codebox",
             "numinlets": 11,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              30,
              100,
              550,
              300
             ],
             "code": "// Accumulator State Machine\n// in1=stepcounter  in2=gate signal  in3=accum value (from stepfun~)\n// in4=accum trigger (0=Stage,1=Pulse,2=Ratchet)\n// in5=accum mode (0=Stage,1=Track)  in6=accum order (0=Wrap,1=Pend,2=Rand,3=Hold)\n// in7=accum polarity (0=Uni,1=Bi)  in8=limit+  in9=limit-\n// in10=reset trigger  in11=gate type (0=Rest,1=Single,2=Multi,3=Hold)\n// out1=accumulated degree offset\n\nData accum_degrees(8);\nHistory track_accum(0);\nData accum_dir(8);\nHistory track_dir(1);\nHistory prev_counter(-1);\nHistory prev_gate(0);\nHistory rng_state(54321);\n\nrng_state = (rng_state * 1103515245 + 12345) % 2147483648;\nrng = abs(rng_state) / 2147483647.0;\n\ncounter = in1;\ngate = in2 >= 0.5;\naccum_val = floor(in3);\naccum_trigger = floor(in4);\naccum_mode = floor(in5);\naccum_order = floor(in6);\naccum_polarity = floor(in7);\nlimit_pos = max(floor(in8), 1);\nlimit_neg = max(floor(in9), 1);\nreset_trig = in10 >= 0.5;\ngate_type = floor(in11);\n\nlo_limit = 0;\nhi_limit = limit_pos;\nif (accum_polarity > 0.5) {\n    lo_limit = -limit_neg;\n}\n\nnew_stage = (counter != prev_counter);\ngate_rise = (gate && !prev_gate);\n\nif (reset_trig) {\n    for (i = 0; i < 8; i += 1) {\n        poke(accum_degrees, 0, i);\n        poke(accum_dir, 1, i);\n    }\n    track_accum = 0;\n    track_dir = 1;\n}\n\nshould_accum = 0;\nif (gate_type > 0.5) {\n    if (accum_trigger < 0.5) {\n        should_accum = new_stage;\n    } else if (accum_trigger < 1.5) {\n        if (gate_type > 2.5) { should_accum = new_stage; }\n        else if (gate_type < 1.5) { should_accum = new_stage; }\n        else { should_accum = gate_rise; }\n    } else {\n        if (gate_type > 2.5) { should_accum = new_stage; }\n        else { should_accum = gate_rise; }\n    }\n}\n\nstage_idx = clamp(floor(counter) % 8, 0, 7);\n\nif (should_accum && abs(accum_val) > 0) {\n    current = 0; dir = 1;\n    if (accum_mode < 0.5) {\n        current = peek(accum_degrees, stage_idx);\n        dir = peek(accum_dir, stage_idx);\n    } else {\n        current = track_accum; dir = track_dir;\n    }\n\n    new_val = current;\n    if (accum_order < 0.5) {\n        new_val = current + accum_val * dir;\n        if (new_val > hi_limit) { new_val = lo_limit + (new_val - hi_limit - 1); }\n        if (new_val < lo_limit) { new_val = hi_limit - (lo_limit - new_val - 1); }\n        new_val = clamp(new_val, lo_limit, hi_limit);\n    } else if (accum_order < 1.5) {\n        new_val = current + accum_val * dir;\n        if (new_val > hi_limit) { new_val = hi_limit - (new_val - hi_limit); dir = -1; }\n        if (new_val < lo_limit) { new_val = lo_limit + (lo_limit - new_val); dir = 1; }\n        new_val = clamp(new_val, lo_limit, hi_limit);\n    } else if (accum_order < 2.5) {\n        rand_step = 0;\n        if (rng < 0.5) { rand_step = accum_val; }\n        else if (rng < 0.8) { rand_step = -accum_val; }\n        mag = max(1, abs(rand_step));\n        if (mag > 1) { mag = ceil(rng * mag); }\n        if (rand_step < 0) { mag = -mag; }\n        new_val = clamp(current + mag, lo_limit, hi_limit);\n    } else {\n        new_val = clamp(current + accum_val * dir, lo_limit, hi_limit);\n    }\n\n    if (accum_mode < 0.5) {\n        poke(accum_degrees, new_val, stage_idx);\n        poke(accum_dir, dir, stage_idx);\n    } else {\n        track_accum = new_val; track_dir = dir;\n    }\n}\n\naccum_out = 0;\nif (accum_mode < 0.5) {\n    accum_out = peek(accum_degrees, stage_idx);\n} else {\n    accum_out = track_accum;\n}\n\nprev_counter = counter;\nprev_gate = gate;\nout1 = accum_out;\n"
            }
           },
           {
            "box": {
             "id": "obj-30",
             "maxclass": "newobj",
             "text": "out 1",
             "numinlets": 1,
             "numoutlets": 0,
             "outlettype": [],
             "patching_rect": [
              250,
              430,
              35,
              22
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
              "obj-20",
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
              "obj-20",
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
              "obj-20",
              3
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
              "obj-20",
              4
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
              "obj-20",
              5
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
              "obj-20",
              6
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
              "obj-20",
              7
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
              "obj-20",
              8
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
              "obj-20",
              9
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
              "obj-20",
              10
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
              "obj-30",
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
         "id": "obj-151",
         "maxclass": "newobj",
         "text": "gen~ @title AccumT2",
         "numinlets": 11,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          350,
          1020,
          250,
          22
         ],
         "patcher": {
          "fileversion": 1,
          "classnamespace": "dsp.gen",
          "rect": [
           0,
           0,
           800,
           500
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
              30,
              30,
              30,
              22
             ]
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
              80,
              30,
              30,
              22
             ]
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
              130,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-4",
             "maxclass": "newobj",
             "text": "in 4",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              180,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-5",
             "maxclass": "newobj",
             "text": "in 5",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              230,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-6",
             "maxclass": "newobj",
             "text": "in 6",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              280,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-7",
             "maxclass": "newobj",
             "text": "in 7",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              330,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-8",
             "maxclass": "newobj",
             "text": "in 8",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              380,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-9",
             "maxclass": "newobj",
             "text": "in 9",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              430,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-10",
             "maxclass": "newobj",
             "text": "in 10",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              480,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-11",
             "maxclass": "newobj",
             "text": "in 11",
             "numinlets": 0,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              530,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-20",
             "maxclass": "newobj",
             "text": "codebox",
             "numinlets": 11,
             "numoutlets": 1,
             "outlettype": [
              ""
             ],
             "patching_rect": [
              30,
              100,
              550,
              300
             ],
             "code": "// Accumulator State Machine\n// in1=stepcounter  in2=gate signal  in3=accum value (from stepfun~)\n// in4=accum trigger (0=Stage,1=Pulse,2=Ratchet)\n// in5=accum mode (0=Stage,1=Track)  in6=accum order (0=Wrap,1=Pend,2=Rand,3=Hold)\n// in7=accum polarity (0=Uni,1=Bi)  in8=limit+  in9=limit-\n// in10=reset trigger  in11=gate type (0=Rest,1=Single,2=Multi,3=Hold)\n// out1=accumulated degree offset\n\nData accum_degrees(8);\nHistory track_accum(0);\nData accum_dir(8);\nHistory track_dir(1);\nHistory prev_counter(-1);\nHistory prev_gate(0);\nHistory rng_state(54321);\n\nrng_state = (rng_state * 1103515245 + 12345) % 2147483648;\nrng = abs(rng_state) / 2147483647.0;\n\ncounter = in1;\ngate = in2 >= 0.5;\naccum_val = floor(in3);\naccum_trigger = floor(in4);\naccum_mode = floor(in5);\naccum_order = floor(in6);\naccum_polarity = floor(in7);\nlimit_pos = max(floor(in8), 1);\nlimit_neg = max(floor(in9), 1);\nreset_trig = in10 >= 0.5;\ngate_type = floor(in11);\n\nlo_limit = 0;\nhi_limit = limit_pos;\nif (accum_polarity > 0.5) {\n    lo_limit = -limit_neg;\n}\n\nnew_stage = (counter != prev_counter);\ngate_rise = (gate && !prev_gate);\n\nif (reset_trig) {\n    for (i = 0; i < 8; i += 1) {\n        poke(accum_degrees, 0, i);\n        poke(accum_dir, 1, i);\n    }\n    track_accum = 0;\n    track_dir = 1;\n}\n\nshould_accum = 0;\nif (gate_type > 0.5) {\n    if (accum_trigger < 0.5) {\n        should_accum = new_stage;\n    } else if (accum_trigger < 1.5) {\n        if (gate_type > 2.5) { should_accum = new_stage; }\n        else if (gate_type < 1.5) { should_accum = new_stage; }\n        else { should_accum = gate_rise; }\n    } else {\n        if (gate_type > 2.5) { should_accum = new_stage; }\n        else { should_accum = gate_rise; }\n    }\n}\n\nstage_idx = clamp(floor(counter) % 8, 0, 7);\n\nif (should_accum && abs(accum_val) > 0) {\n    current = 0; dir = 1;\n    if (accum_mode < 0.5) {\n        current = peek(accum_degrees, stage_idx);\n        dir = peek(accum_dir, stage_idx);\n    } else {\n        current = track_accum; dir = track_dir;\n    }\n\n    new_val = current;\n    if (accum_order < 0.5) {\n        new_val = current + accum_val * dir;\n        if (new_val > hi_limit) { new_val = lo_limit + (new_val - hi_limit - 1); }\n        if (new_val < lo_limit) { new_val = hi_limit - (lo_limit - new_val - 1); }\n        new_val = clamp(new_val, lo_limit, hi_limit);\n    } else if (accum_order < 1.5) {\n        new_val = current + accum_val * dir;\n        if (new_val > hi_limit) { new_val = hi_limit - (new_val - hi_limit); dir = -1; }\n        if (new_val < lo_limit) { new_val = lo_limit + (lo_limit - new_val); dir = 1; }\n        new_val = clamp(new_val, lo_limit, hi_limit);\n    } else if (accum_order < 2.5) {\n        rand_step = 0;\n        if (rng < 0.5) { rand_step = accum_val; }\n        else if (rng < 0.8) { rand_step = -accum_val; }\n        mag = max(1, abs(rand_step));\n        if (mag > 1) { mag = ceil(rng * mag); }\n        if (rand_step < 0) { mag = -mag; }\n        new_val = clamp(current + mag, lo_limit, hi_limit);\n    } else {\n        new_val = clamp(current + accum_val * dir, lo_limit, hi_limit);\n    }\n\n    if (accum_mode < 0.5) {\n        poke(accum_degrees, new_val, stage_idx);\n        poke(accum_dir, dir, stage_idx);\n    } else {\n        track_accum = new_val; track_dir = dir;\n    }\n}\n\naccum_out = 0;\nif (accum_mode < 0.5) {\n    accum_out = peek(accum_degrees, stage_idx);\n} else {\n    accum_out = track_accum;\n}\n\nprev_counter = counter;\nprev_gate = gate;\nout1 = accum_out;\n"
            }
           },
           {
            "box": {
             "id": "obj-30",
             "maxclass": "newobj",
             "text": "out 1",
             "numinlets": 1,
             "numoutlets": 0,
             "outlettype": [],
             "patching_rect": [
              250,
              430,
              35,
              22
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
              "obj-20",
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
              "obj-20",
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
              "obj-20",
              3
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
              "obj-20",
              4
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
              "obj-20",
              5
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
              "obj-20",
              6
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
              "obj-20",
              7
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
              "obj-20",
              8
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
              "obj-20",
              9
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
              "obj-20",
              10
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
              "obj-30",
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
         "id": "obj-144",
         "maxclass": "outlet",
         "index": 11,
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          530,
          1100,
          30,
          30
         ],
         "comment": "AccumDeg T1"
        }
       },
       {
        "box": {
         "id": "obj-145",
         "maxclass": "outlet",
         "index": 12,
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          570,
          1100,
          30,
          30
         ],
         "comment": "AccumDeg T2"
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
          "obj-20",
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
          "obj-20",
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
          "obj-22",
          0
         ],
         "order": 0
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
         ],
         "order": 2
        }
       },
       {
        "patchline": {
         "source": [
          "obj-20",
          0
         ],
         "destination": [
          "obj-29",
          0
         ],
         "order": 0
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
         ],
         "order": 3
        }
       },
       {
        "patchline": {
         "source": [
          "obj-5",
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
          "obj-22",
          0
         ],
         "destination": [
          "obj-25",
          0
         ],
         "order": 2
        }
       },
       {
        "patchline": {
         "source": [
          "obj-7",
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
          "obj-9",
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
          "obj-22",
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
          "obj-25",
          0
         ],
         "destination": [
          "obj-28",
          1
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
          2
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
          "obj-28",
          3
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
          "obj-50",
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
          "obj-50",
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
          "obj-52",
          0
         ],
         "order": 0
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
          1
         ],
         "order": 2
        }
       },
       {
        "patchline": {
         "source": [
          "obj-50",
          0
         ],
         "destination": [
          "obj-59",
          0
         ],
         "order": 0
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-53",
          0
         ],
         "order": 3
        }
       },
       {
        "patchline": {
         "source": [
          "obj-6",
          0
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
          "obj-55",
          0
         ],
         "order": 2
        }
       },
       {
        "patchline": {
         "source": [
          "obj-8",
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
          "obj-10",
          0
         ],
         "destination": [
          "obj-57",
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
          "obj-58",
          0
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-55",
          0
         ],
         "destination": [
          "obj-58",
          1
         ]
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
          2
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
          "obj-58",
          3
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-23",
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
          "obj-28",
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
          "obj-29",
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
          "obj-53",
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
          "obj-58",
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
          "obj-59",
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
          "obj-22",
          0
         ],
         "destination": [
          "obj-76",
          0
         ],
         "order": 0
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-77",
          0
         ],
         "order": 0
        }
       },
       {
        "patchline": {
         "source": [
          "obj-22",
          0
         ],
         "destination": [
          "obj-26",
          0
         ],
         "order": 5
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-56",
          0
         ],
         "order": 5
        }
       },
       {
        "patchline": {
         "source": [
          "obj-86",
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
          "obj-87",
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
          "obj-22",
          0
         ],
         "destination": [
          "obj-90",
          0
         ],
         "order": 4
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-91",
          0
         ],
         "order": 4
        }
       },
       {
        "patchline": {
         "source": [
          "obj-88",
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
          "obj-89",
          0
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
          "obj-80",
          0
         ],
         "destination": [
          "obj-28",
          4
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
          "obj-28",
          5
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-84",
          0
         ],
         "destination": [
          "obj-28",
          6
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
          "obj-28",
          7
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-90",
          0
         ],
         "destination": [
          "obj-28",
          8
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-81",
          0
         ],
         "destination": [
          "obj-58",
          4
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-83",
          0
         ],
         "destination": [
          "obj-58",
          5
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
          "obj-58",
          6
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
          "obj-58",
          7
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
          "obj-58",
          8
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
          "obj-120",
          0
         ],
         "order": 6
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-121",
          0
         ],
         "order": 6
        }
       },
       {
        "patchline": {
         "source": [
          "obj-100",
          0
         ],
         "destination": [
          "obj-120",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-101",
          0
         ],
         "destination": [
          "obj-121",
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
          "obj-122",
          0
         ],
         "order": 7
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-123",
          0
         ],
         "order": 7
        }
       },
       {
        "patchline": {
         "source": [
          "obj-102",
          0
         ],
         "destination": [
          "obj-122",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-103",
          0
         ],
         "destination": [
          "obj-123",
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
          "obj-124",
          0
         ],
         "order": 8
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-125",
          0
         ],
         "order": 8
        }
       },
       {
        "patchline": {
         "source": [
          "obj-104",
          0
         ],
         "destination": [
          "obj-124",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-105",
          0
         ],
         "destination": [
          "obj-125",
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
          "obj-126",
          0
         ],
         "order": 9
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-127",
          0
         ],
         "order": 9
        }
       },
       {
        "patchline": {
         "source": [
          "obj-106",
          0
         ],
         "destination": [
          "obj-126",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-107",
          0
         ],
         "destination": [
          "obj-127",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-120",
          0
         ],
         "destination": [
          "obj-28",
          9
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-108",
          0
         ],
         "destination": [
          "obj-28",
          10
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-122",
          0
         ],
         "destination": [
          "obj-28",
          11
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-124",
          0
         ],
         "destination": [
          "obj-28",
          12
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-121",
          0
         ],
         "destination": [
          "obj-58",
          9
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-109",
          0
         ],
         "destination": [
          "obj-58",
          10
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-123",
          0
         ],
         "destination": [
          "obj-58",
          11
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-125",
          0
         ],
         "destination": [
          "obj-58",
          12
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-126",
          0
         ],
         "destination": [
          "obj-128",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-127",
          0
         ],
         "destination": [
          "obj-129",
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
          "obj-140",
          0
         ],
         "order": 10
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-141",
          0
         ],
         "order": 10
        }
       },
       {
        "patchline": {
         "source": [
          "obj-130",
          0
         ],
         "destination": [
          "obj-140",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-131",
          0
         ],
         "destination": [
          "obj-141",
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
          "obj-142",
          0
         ],
         "order": 11
        }
       },
       {
        "patchline": {
         "source": [
          "obj-52",
          0
         ],
         "destination": [
          "obj-143",
          0
         ],
         "order": 11
        }
       },
       {
        "patchline": {
         "source": [
          "obj-132",
          0
         ],
         "destination": [
          "obj-142",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-133",
          0
         ],
         "destination": [
          "obj-143",
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
          "obj-150",
          0
         ],
         "order": 3
        }
       },
       {
        "patchline": {
         "source": [
          "obj-28",
          0
         ],
         "destination": [
          "obj-150",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-140",
          0
         ],
         "destination": [
          "obj-150",
          2
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-142",
          0
         ],
         "destination": [
          "obj-150",
          3
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-134",
          0
         ],
         "destination": [
          "obj-150",
          4
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-135",
          0
         ],
         "destination": [
          "obj-150",
          5
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-136",
          0
         ],
         "destination": [
          "obj-150",
          6
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-137",
          0
         ],
         "destination": [
          "obj-150",
          7
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-138",
          0
         ],
         "destination": [
          "obj-150",
          8
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-139",
          0
         ],
         "destination": [
          "obj-150",
          9
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
          "obj-150",
          10
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
          "obj-151",
          0
         ],
         "order": 3
        }
       },
       {
        "patchline": {
         "source": [
          "obj-58",
          0
         ],
         "destination": [
          "obj-151",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-141",
          0
         ],
         "destination": [
          "obj-151",
          2
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-143",
          0
         ],
         "destination": [
          "obj-151",
          3
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-134",
          0
         ],
         "destination": [
          "obj-151",
          4
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-135",
          0
         ],
         "destination": [
          "obj-151",
          5
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-136",
          0
         ],
         "destination": [
          "obj-151",
          6
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-137",
          0
         ],
         "destination": [
          "obj-151",
          7
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-138",
          0
         ],
         "destination": [
          "obj-151",
          8
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-139",
          0
         ],
         "destination": [
          "obj-151",
          9
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
          "obj-151",
          10
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-150",
          0
         ],
         "destination": [
          "obj-144",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-151",
          0
         ],
         "destination": [
          "obj-145",
          0
         ]
        }
       }
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
     "numinlets": 7,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      16.0,
      344.0,
      200.0,
      20.0
     ],
     "patcher": {
      "fileversion": 1,
      "classnamespace": "box",
      "rect": [
       0,
       0,
       900,
       700
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
          "signal"
         ],
         "patching_rect": [
          50,
          40,
          30,
          30
         ],
         "comment": "Pitch"
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
          "signal"
         ],
         "patching_rect": [
          150,
          40,
          30,
          30
         ],
         "comment": "Gate"
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
          350,
          40,
          30,
          30
         ],
         "comment": "Velocity"
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
          450,
          40,
          30,
          30
         ],
         "comment": "Channel"
        }
       },
       {
        "box": {
         "id": "obj-5",
         "maxclass": "inlet",
         "index": 5,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          600,
          40,
          30,
          30
         ],
         "comment": "MIDI thru"
        }
       },
       {
        "box": {
         "id": "obj-6",
         "maxclass": "inlet",
         "index": 6,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          700,
          40,
          30,
          30
         ],
         "comment": "Panic"
        }
       },
       {
        "box": {
         "id": "obj-10",
         "maxclass": "newobj",
         "text": "gen~ @title NoteEdgeDetect",
         "numinlets": 2,
         "numoutlets": 5,
         "outlettype": [
          "signal",
          "signal",
          "signal",
          "signal",
          "signal"
         ],
         "patching_rect": [
          50,
          90,
          200,
          22
         ],
         "patcher": {
          "fileversion": 1,
          "classnamespace": "dsp.gen",
          "rect": [
           0,
           0,
           500,
           400
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
              30,
              30,
              30,
              22
             ]
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
              150,
              30,
              30,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-3",
             "maxclass": "newobj",
             "text": "codebox",
             "numinlets": 2,
             "numoutlets": 5,
             "outlettype": [
              "",
              "",
              "",
              "",
              ""
             ],
             "patching_rect": [
              30,
              100,
              400,
              180
             ],
             "code": "// Edge detect with HOLD legato support\n// in1=pitch  in2=gate(0/1)\n// out1=note_on  out2=note_off  out3=held_pitch  out4=prev_pitch  out5=legato\n//\n// Legato (Hold): when pitch changes while gate is sustained,\n// outputs note_on=1 with legato=1. note_off is NOT fired during legato.\n// Downstream handles legato note-off via the legato detection path,\n// guaranteeing note-on(new) fires before note-off(old).\n\nHistory prev_gate(0);\nHistory prev_pitch(0);\nHistory held_pitch(60);\nHistory prev_held(60);\n\npitch = in1;\ngate = in2 >= 0.5;\nnote_on = 0; note_off = 0; legato = 0;\n\nif (gate && !prev_gate) {\n    note_on = 1;\n    prev_held = held_pitch;\n    held_pitch = pitch;\n} else if (!gate && prev_gate) {\n    note_off = 1;\n} else if (gate && prev_gate && (pitch != prev_pitch)) {\n    note_on = 1;\n    legato = 1;\n    prev_held = held_pitch;\n    held_pitch = pitch;\n}\n\nprev_gate = gate;\nprev_pitch = pitch;\n\nout1 = note_on;\nout2 = note_off;\nout3 = held_pitch;\nout4 = prev_held;\nout5 = legato;\n"
            }
           },
           {
            "box": {
             "id": "obj-4",
             "maxclass": "newobj",
             "text": "out 1",
             "numinlets": 1,
             "numoutlets": 0,
             "outlettype": [],
             "patching_rect": [
              30,
              330,
              35,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-5",
             "maxclass": "newobj",
             "text": "out 2",
             "numinlets": 1,
             "numoutlets": 0,
             "outlettype": [],
             "patching_rect": [
              110,
              330,
              35,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-6",
             "maxclass": "newobj",
             "text": "out 3",
             "numinlets": 1,
             "numoutlets": 0,
             "outlettype": [],
             "patching_rect": [
              190,
              330,
              35,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-7",
             "maxclass": "newobj",
             "text": "out 4",
             "numinlets": 1,
             "numoutlets": 0,
             "outlettype": [],
             "patching_rect": [
              270,
              330,
              35,
              22
             ]
            }
           },
           {
            "box": {
             "id": "obj-8",
             "maxclass": "newobj",
             "text": "out 5",
             "numinlets": 1,
             "numoutlets": 0,
             "outlettype": [],
             "patching_rect": [
              350,
              330,
              35,
              22
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
              "obj-3",
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
              "obj-5",
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
              "obj-6",
              0
             ]
            }
           },
           {
            "patchline": {
             "source": [
              "obj-3",
              3
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
              4
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
         "id": "obj-11",
         "maxclass": "newobj",
         "text": "edge~",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "bang",
          "bang"
         ],
         "patching_rect": [
          50,
          140,
          40,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-12",
         "maxclass": "newobj",
         "text": "edge~",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "bang",
          "bang"
         ],
         "patching_rect": [
          300,
          140,
          40,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-13",
         "maxclass": "newobj",
         "text": "snapshot~ 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          50,
          240,
          70,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-14",
         "maxclass": "newobj",
         "text": "snapshot~ 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          150,
          240,
          70,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-15",
         "maxclass": "newobj",
         "text": "snapshot~ 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          250,
          240,
          70,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-16",
         "maxclass": "newobj",
         "text": "i 100",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          350,
          190,
          35,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-17",
         "maxclass": "newobj",
         "text": "i 1",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          450,
          190,
          35,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-20",
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
          50,
          190,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-21",
         "maxclass": "newobj",
         "text": "int",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          50,
          340,
          30,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-22",
         "maxclass": "newobj",
         "text": "int",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          150,
          390,
          30,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-23",
         "maxclass": "newobj",
         "text": "int",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          250,
          340,
          30,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-24",
         "maxclass": "newobj",
         "text": "t i i",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "int",
          "int"
         ],
         "patching_rect": [
          50,
          390,
          40,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-25",
         "maxclass": "newobj",
         "text": "i 60",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          50,
          440,
          35,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-30",
         "maxclass": "newobj",
         "text": "pack 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          50,
          490,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-31",
         "maxclass": "newobj",
         "text": "schedule",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          50,
          540,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-32",
         "maxclass": "newobj",
         "text": "midiformat",
         "numinlets": 7,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          50,
          590,
          70,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-33",
         "maxclass": "newobj",
         "text": "sel 0",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "bang",
          ""
         ],
         "patching_rect": [
          250,
          390,
          40,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-34",
         "maxclass": "newobj",
         "text": "pack 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          180,
          490,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-35",
         "maxclass": "message",
         "text": "0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          230,
          440,
          20,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-36",
         "maxclass": "newobj",
         "text": "schedule",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          180,
          540,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-37",
         "maxclass": "newobj",
         "text": "midiformat",
         "numinlets": 7,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          180,
          590,
          70,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-40",
         "maxclass": "newobj",
         "text": "t b b",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "bang",
          "bang"
         ],
         "patching_rect": [
          300,
          190,
          45,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-41",
         "maxclass": "newobj",
         "text": "pack 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          300,
          490,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-42",
         "maxclass": "message",
         "text": "0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          360,
          440,
          20,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-43",
         "maxclass": "newobj",
         "text": "schedule",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          300,
          540,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-44",
         "maxclass": "newobj",
         "text": "midiformat",
         "numinlets": 7,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          300,
          590,
          70,
          22
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
          700,
          190,
          45,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-51",
         "maxclass": "newobj",
         "text": "i 60",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          700,
          290,
          35,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-52",
         "maxclass": "newobj",
         "text": "pack 0 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          700,
          390,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-53",
         "maxclass": "message",
         "text": "0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          750,
          340,
          20,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-54",
         "maxclass": "message",
         "text": "123 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          800,
          290,
          45,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-55",
         "maxclass": "newobj",
         "text": "schedule",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          700,
          440,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-56",
         "maxclass": "newobj",
         "text": "schedule",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          800,
          440,
          55,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-57",
         "maxclass": "newobj",
         "text": "midiformat",
         "numinlets": 7,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          700,
          490,
          70,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-58",
         "maxclass": "newobj",
         "text": "midiformat",
         "numinlets": 7,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          800,
          490,
          70,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-90",
         "maxclass": "outlet",
         "index": 1,
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          400,
          640,
          30,
          30
         ],
         "comment": "MIDI output"
        }
       },
       {
        "box": {
         "id": "obj-60",
         "maxclass": "newobj",
         "text": "change",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          "int"
         ],
         "patching_rect": [
          450,
          240,
          50,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-61",
         "maxclass": "newobj",
         "text": "t i b",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "int",
          "bang"
         ],
         "patching_rect": [
          450,
          290,
          45,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-70",
         "maxclass": "inlet",
         "index": 7,
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          800,
          40,
          30,
          30
         ],
         "comment": "Pitch Bend"
        }
       },
       {
        "box": {
         "id": "obj-71",
         "maxclass": "newobj",
         "text": "snapshot~ 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          800,
          140,
          70,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-72",
         "maxclass": "newobj",
         "text": "int",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          800,
          190,
          30,
          22
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
          "obj-10",
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
          "obj-3",
          0
         ],
         "destination": [
          "obj-16",
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
          "obj-32",
          6
         ],
         "order": 0
        }
       },
       {
        "patchline": {
         "source": [
          "obj-17",
          0
         ],
         "destination": [
          "obj-37",
          6
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-17",
          0
         ],
         "destination": [
          "obj-44",
          6
         ],
         "order": 2
        }
       },
       {
        "patchline": {
         "source": [
          "obj-17",
          0
         ],
         "destination": [
          "obj-57",
          6
         ],
         "order": 3
        }
       },
       {
        "patchline": {
         "source": [
          "obj-17",
          0
         ],
         "destination": [
          "obj-58",
          6
         ],
         "order": 4
        }
       },
       {
        "patchline": {
         "source": [
          "obj-11",
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
          2
         ],
         "destination": [
          "obj-15",
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
          "obj-14",
          1
         ],
         "order": 0
        }
       },
       {
        "patchline": {
         "source": [
          "obj-20",
          1
         ],
         "destination": [
          "obj-13",
          1
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-20",
          0
         ],
         "destination": [
          "obj-16",
          0
         ],
         "order": 2
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
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-20",
          0
         ],
         "destination": [
          "obj-23",
          0
         ],
         "order": 0
        }
       },
       {
        "patchline": {
         "source": [
          "obj-13",
          0
         ],
         "destination": [
          "obj-21",
          1
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
          "obj-22",
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
          "obj-23",
          1
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
          1
         ],
         "order": 0
        }
       },
       {
        "patchline": {
         "source": [
          "obj-24",
          1
         ],
         "destination": [
          "obj-51",
          1
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-24",
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
          "obj-16",
          0
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
          "obj-32",
          0
         ],
         "destination": [
          "obj-90",
          0
         ],
         "order": 5
        }
       },
       {
        "patchline": {
         "source": [
          "obj-23",
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
          1
         ],
         "destination": [
          "obj-35",
          0
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-33",
          1
         ],
         "destination": [
          "obj-22",
          0
         ],
         "order": 0
        }
       },
       {
        "patchline": {
         "source": [
          "obj-22",
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
          "obj-35",
          0
         ],
         "destination": [
          "obj-34",
          1
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
          "obj-37",
          0
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
          "obj-90",
          0
         ],
         "order": 3
        }
       },
       {
        "patchline": {
         "source": [
          "obj-12",
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
          1
         ],
         "destination": [
          "obj-42",
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
          "obj-41",
          0
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
          "obj-41",
          1
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
          "obj-43",
          0
         ]
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
          "obj-90",
          0
         ],
         "order": 4
        }
       },
       {
        "patchline": {
         "source": [
          "obj-6",
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
          "obj-50",
          1
         ],
         "destination": [
          "obj-53",
          0
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-50",
          1
         ],
         "destination": [
          "obj-51",
          0
         ],
         "order": 0
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
          "obj-53",
          0
         ],
         "destination": [
          "obj-52",
          1
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
          "obj-55",
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
          "obj-57",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-57",
          0
         ],
         "destination": [
          "obj-90",
          0
         ],
         "order": 2
        }
       },
       {
        "patchline": {
         "source": [
          "obj-50",
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
          "obj-54",
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
          "obj-56",
          0
         ],
         "destination": [
          "obj-58",
          2
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-58",
          0
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
          "obj-5",
          0
         ],
         "destination": [
          "obj-90",
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
          "obj-61",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-61",
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
          "obj-61",
          0
         ],
         "destination": [
          "obj-17",
          1
         ],
         "order": 1
        }
       },
       {
        "patchline": {
         "source": [
          "obj-61",
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
          "obj-72",
          0
         ],
         "destination": [
          "obj-32",
          4
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
          "obj-37",
          4
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
          "obj-44",
          4
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
          "obj-71",
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
     "id": "obj-50",
     "maxclass": "newobj",
     "text": "p Track2Output",
     "numinlets": 3,
     "numoutlets": 0,
     "patching_rect": [
      280.0,
      344.0,
      200.0,
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
       100.0,
       100.0,
       500.0,
       400.0
      ],
      "bglocked": 0,
      "openinpresentation": 0,
      "default_fontsize": 12.0,
      "default_fontface": 0,
      "default_fontname": "Arial",
      "gridonopen": 1,
      "gridsize": [
       15.0,
       15.0
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
         "maxclass": "inlet",
         "index": 1,
         "comment": "TRK2 pitch signal",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-2",
         "maxclass": "inlet",
         "index": 2,
         "comment": "TRK2 gate signal",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          150.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-3",
         "maxclass": "inlet",
         "index": 3,
         "comment": "TRK2 velocity",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          270.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-10",
         "maxclass": "newobj",
         "text": "snapshot~ 30",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          30.0,
          90.0,
          75.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-11",
         "maxclass": "newobj",
         "text": "snapshot~ 30",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          150.0,
          90.0,
          75.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-12",
         "maxclass": "newobj",
         "text": "/ 127.",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          30.0,
          120.0,
          38.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-13",
         "maxclass": "newobj",
         "text": "/ 127.",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          270.0,
          90.0,
          38.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-14",
         "maxclass": "newobj",
         "text": "clip 0. 1.",
         "numinlets": 3,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          150.0,
          60.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-15",
         "maxclass": "newobj",
         "text": "clip 0. 1.",
         "numinlets": 3,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          270.0,
          120.0,
          60.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-20",
         "maxclass": "live.dial",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          "float"
         ],
         "parameter_enable": 1,
         "patching_rect": [
          30.0,
          195.0,
          44.0,
          48.0
         ],
         "saved_attribute_attributes": {
          "valueof": {
           "parameter_longname": "TRK2 Pitch",
           "parameter_shortname": "T2 Pitch",
           "parameter_type": 0,
           "parameter_mmax": 1.0,
           "parameter_mmin": 0.0,
           "parameter_initial_enable": 1,
           "parameter_initial": [
            0.0
           ],
           "parameter_unitstyle": 1,
           "parameter_linknames": 1
          }
         },
         "varname": "TRK2 Pitch"
        }
       },
       {
        "box": {
         "id": "obj-21",
         "maxclass": "live.dial",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          "float"
         ],
         "parameter_enable": 1,
         "patching_rect": [
          150.0,
          195.0,
          44.0,
          48.0
         ],
         "saved_attribute_attributes": {
          "valueof": {
           "parameter_longname": "TRK2 Gate",
           "parameter_shortname": "T2 Gate",
           "parameter_type": 0,
           "parameter_mmax": 1.0,
           "parameter_mmin": 0.0,
           "parameter_initial_enable": 1,
           "parameter_initial": [
            0.0
           ],
           "parameter_unitstyle": 1,
           "parameter_linknames": 1
          }
         },
         "varname": "TRK2 Gate"
        }
       },
       {
        "box": {
         "id": "obj-22",
         "maxclass": "live.dial",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          "float"
         ],
         "parameter_enable": 1,
         "patching_rect": [
          270.0,
          195.0,
          44.0,
          48.0
         ],
         "saved_attribute_attributes": {
          "valueof": {
           "parameter_longname": "TRK2 Velocity",
           "parameter_shortname": "T2 Vel",
           "parameter_type": 0,
           "parameter_mmax": 1.0,
           "parameter_mmin": 0.0,
           "parameter_initial_enable": 1,
           "parameter_initial": [
            0.0
           ],
           "parameter_unitstyle": 1,
           "parameter_linknames": 1
          }
         },
         "varname": "TRK2 Velocity"
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
          "obj-10",
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
          "obj-11",
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
          "obj-14",
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
          "obj-20",
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
          "obj-21",
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
          "obj-22",
          0
         ]
        }
       }
      ],
      "saved_object_attributes": {
       "globalpatchername": ""
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-60",
     "maxclass": "newobj",
     "text": "p TransportStop",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "bang"
     ],
     "patching_rect": [
      16.0,
      392.0,
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
       100.0,
       100.0,
       400.0,
       300.0
      ],
      "bglocked": 0,
      "openinpresentation": 0,
      "default_fontsize": 12.0,
      "default_fontface": 0,
      "default_fontname": "Arial",
      "gridonopen": 1,
      "gridsize": [
       15.0,
       15.0
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
      "description": "Sends CC 123 (All Notes Off) when transport stops",
      "digest": "",
      "tags": "",
      "style": "",
      "subpatcher_template": "",
      "assistshowspatchername": 0,
      "boxes": [
       {
        "box": {
         "id": "obj-1",
         "maxclass": "inlet",
         "index": 1,
         "comment": "Transport state (signal)",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "signal"
         ],
         "patching_rect": [
          30.0,
          30.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-2",
         "maxclass": "newobj",
         "text": "snapshot~ 30",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          "float"
         ],
         "patching_rect": [
          30.0,
          90.0,
          75.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-3",
         "maxclass": "newobj",
         "text": "change",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          "int"
         ],
         "patching_rect": [
          30.0,
          120.0,
          46.0,
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
          30.0,
          150.0,
          36.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-5",
         "maxclass": "message",
         "text": "123 0",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          180.0,
          42.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-6",
         "maxclass": "newobj",
         "text": "midiformat",
         "numinlets": 7,
         "numoutlets": 1,
         "outlettype": [
          "int"
         ],
         "patching_rect": [
          30.0,
          210.0,
          100.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-7",
         "maxclass": "outlet",
         "index": 1,
         "comment": "MIDI CC123 All Notes Off",
         "numinlets": 1,
         "numoutlets": 0,
         "patching_rect": [
          30.0,
          250.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "obj-8",
         "maxclass": "outlet",
         "index": 2,
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          200,
          300,
          30,
          30
         ],
         "comment": "Panic"
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
         ],
         "order": 1
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
          2
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
          "obj-4",
          0
         ],
         "destination": [
          "obj-8",
          0
         ],
         "order": 0
        }
       }
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      16.0,
      448.0,
      40.0,
      95.0
     ],
     "presentation": 1,
     "presentation_rect": [
      8.0,
      48.0,
      36.0,
      95.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Stage 1 Pitch",
       "parameter_shortname": "1",
       "parameter_type": 0,
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.5
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      64.0,
      448.0,
      40.0,
      95.0
     ],
     "presentation": 1,
     "presentation_rect": [
      52.0,
      48.0,
      36.0,
      95.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Stage 2 Pitch",
       "parameter_shortname": "2",
       "parameter_type": 0,
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.5
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      112.0,
      448.0,
      40.0,
      95.0
     ],
     "presentation": 1,
     "presentation_rect": [
      96.0,
      48.0,
      36.0,
      95.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Stage 3 Pitch",
       "parameter_shortname": "3",
       "parameter_type": 0,
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.5
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      160.0,
      448.0,
      40.0,
      95.0
     ],
     "presentation": 1,
     "presentation_rect": [
      140.0,
      48.0,
      36.0,
      95.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Stage 4 Pitch",
       "parameter_shortname": "4",
       "parameter_type": 0,
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.5
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      208.0,
      448.0,
      40.0,
      95.0
     ],
     "presentation": 1,
     "presentation_rect": [
      184.0,
      48.0,
      36.0,
      95.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Stage 5 Pitch",
       "parameter_shortname": "5",
       "parameter_type": 0,
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.5
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      256.0,
      448.0,
      40.0,
      95.0
     ],
     "presentation": 1,
     "presentation_rect": [
      228.0,
      48.0,
      36.0,
      95.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Stage 6 Pitch",
       "parameter_shortname": "6",
       "parameter_type": 0,
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.5
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      304.0,
      448.0,
      40.0,
      95.0
     ],
     "presentation": 1,
     "presentation_rect": [
      272.0,
      48.0,
      36.0,
      95.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Stage 7 Pitch",
       "parameter_shortname": "7",
       "parameter_type": 0,
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.5
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      352.0,
      448.0,
      40.0,
      95.0
     ],
     "presentation": 1,
     "presentation_rect": [
      316.0,
      48.0,
      36.0,
      95.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Stage 8 Pitch",
       "parameter_shortname": "8",
       "parameter_type": 0,
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.5
       ],
       "parameter_unitstyle": 1,
       "parameter_linknames": 1
      }
     },
     "varname": "Stage 8 Pitch"
    }
   },
   {
    "box": {
     "id": "obj-108",
     "maxclass": "newobj",
     "text": "pak 0. 0. 0. 0. 0. 0. 0. 0.",
     "numinlets": 8,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      16.0,
      560.0,
      376.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-109",
     "maxclass": "newobj",
     "text": "prepend update_pitches",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      16.0,
      584.0,
      130.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-110",
     "maxclass": "live.tab",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      424.0,
      448.0,
      100.0,
      20.0
     ],
     "presentation": 1,
     "presentation_rect": [
      368.0,
      48.0,
      100.0,
      20.0
     ],
     "num_lines_patching": 1,
     "num_lines_presentation": 1,
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Track Select",
       "parameter_shortname": "Track",
       "parameter_type": 2,
       "parameter_enum": [
        "TRK1",
        "TRK2"
       ],
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0
       ],
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
     "outlettype": [
      "",
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      424.0,
      480.0,
      100.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      368.0,
      80.0,
      100.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Playback Order",
       "parameter_shortname": "Order",
       "parameter_type": 2,
       "parameter_enum": [
        "Linear",
        "Ping Pong",
        "Pendulum",
        "Random (P2)",
        "Shuffle (P2)",
        "Brownian (P2)",
        "Converge",
        "Diverge",
        "Pedal Point",
        "Hopscotch"
       ],
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      424.0,
      504.0,
      44.0,
      48.0
     ],
     "presentation": 1,
     "presentation_rect": [
      368.0,
      104.0,
      44.0,
      48.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Clock Division",
       "parameter_shortname": "Div",
       "parameter_type": 1,
       "parameter_mmax": 64.0,
       "parameter_mmin": 1.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        1
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      480.0,
      504.0,
      44.0,
      48.0
     ],
     "presentation": 1,
     "presentation_rect": [
      424.0,
      104.0,
      44.0,
      48.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Swing",
       "parameter_shortname": "Swing",
       "parameter_type": 1,
       "parameter_mmax": 78.0,
       "parameter_mmin": 50.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        50
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      536.0,
      504.0,
      44.0,
      48.0
     ],
     "presentation": 1,
     "presentation_rect": [
      480.0,
      104.0,
      44.0,
      48.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Stages Length",
       "parameter_shortname": "Len",
       "parameter_type": 1,
       "parameter_mmax": 8.0,
       "parameter_mmin": 1.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        8
       ],
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
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      424.0,
      560.0,
      44.0,
      48.0
     ],
     "presentation": 1,
     "presentation_rect": [
      536.0,
      104.0,
      44.0,
      48.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Gate Length",
       "parameter_shortname": "Gate",
       "parameter_type": 1,
       "parameter_mmax": 100.0,
       "parameter_mmin": 1.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        50
       ],
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
     "outlettype": [
      "",
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      480.0,
      560.0,
      100.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      592.0,
      104.0,
      100.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Root Note",
       "parameter_shortname": "Root",
       "parameter_type": 2,
       "parameter_enum": [
        "C",
        "C#",
        "D",
        "D#",
        "E",
        "F",
        "F#",
        "G",
        "G#",
        "A",
        "A#",
        "B"
       ],
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0
       ],
       "parameter_linknames": 1
      }
     },
     "varname": "Root Note"
    }
   },
   {
    "box": {
     "id": "obj-118",
     "maxclass": "newobj",
     "text": "append 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      160.0,
      560.0,
      56.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-119",
     "maxclass": "newobj",
     "text": "prepend update_stages_length",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      536.0,
      560.0,
      168.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-120",
     "maxclass": "newobj",
     "text": "prepend update_playback_order",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      424.0,
      496.0,
      172.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-121",
     "maxclass": "newobj",
     "text": "prepend update_root_note",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      600.0,
      560.0,
      148.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-122",
     "maxclass": "newobj",
     "text": "append 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      536.0,
      584.0,
      56.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-123",
     "maxclass": "newobj",
     "text": "append 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      280.0,
      520.0,
      56.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-200",
     "maxclass": "newobj",
     "text": "sig~ 0.5",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      500,
      300,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-201",
     "maxclass": "newobj",
     "text": "sig~ 0.5",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      570,
      300,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-202",
     "maxclass": "newobj",
     "text": "sig~ 1.0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      640,
      300,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-203",
     "maxclass": "newobj",
     "text": "sig~ 1.0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      710,
      300,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-204",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      780,
      300,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-205",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      850,
      300,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-206",
     "maxclass": "newobj",
     "text": "sig~ 1",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      920,
      300,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-207",
     "maxclass": "newobj",
     "text": "sig~ 1",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      990,
      300,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-208",
     "maxclass": "newobj",
     "text": "i 127",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      500,
      250,
      40,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-209",
     "maxclass": "newobj",
     "text": "i 127",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      550,
      250,
      40,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-210",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      940,
      250,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-211",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1050,
      250,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-212",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1160,
      250,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-213",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1270,
      250,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-220",
     "maxclass": "newobj",
     "text": "prepend update_gate_length",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      500,
      500,
      140,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-221",
     "maxclass": "newobj",
     "text": "append 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      500,
      530,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-230",
     "maxclass": "newobj",
     "text": "prepend update_velocity",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      700,
      500,
      120,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-231",
     "maxclass": "newobj",
     "text": "append 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      700,
      530,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-232",
     "maxclass": "newobj",
     "text": "prepend update_gate_scale",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      500,
      570,
      130,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-233",
     "maxclass": "newobj",
     "text": "append 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      500,
      600,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-234",
     "maxclass": "newobj",
     "text": "prepend update_gate_stretching",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      700,
      570,
      150,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-235",
     "maxclass": "newobj",
     "text": "append 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      700,
      600,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-236",
     "maxclass": "newobj",
     "text": "prepend update_pulse_count_div",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      500,
      640,
      150,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-237",
     "maxclass": "newobj",
     "text": "append 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      500,
      670,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-130",
     "maxclass": "live.menu",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      700,
      450,
      80,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      700,
      450,
      80,
      22
     ],
     "varname": "Velocity",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Velocity",
       "parameter_shortname": "Vel",
       "parameter_type": 2,
       "parameter_enum": [
        "50%",
        "75%",
        "100%",
        "Track CV"
       ],
       "parameter_initial_enable": 1,
       "parameter_initial": [
        2.0
       ],
       "parameter_linknames": 1
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-131",
     "maxclass": "live.dial",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      500,
      450,
      44,
      48
     ],
     "presentation": 1,
     "presentation_rect": [
      500,
      450,
      44,
      48
     ],
     "varname": "Gate Scale",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Gate Scale",
       "parameter_shortname": "G.Scale",
       "parameter_type": 1,
       "parameter_mmin": 1.0,
       "parameter_mmax": 200.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        100.0
       ],
       "parameter_linknames": 1
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-132",
     "maxclass": "live.toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "parameter_enable": 1,
     "patching_rect": [
      600,
      450,
      20,
      20
     ],
     "presentation": 1,
     "presentation_rect": [
      600,
      450,
      20,
      20
     ],
     "varname": "Gate Stretch",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Gate Stretch",
       "parameter_shortname": "G.Str",
       "parameter_type": 2,
       "parameter_enum": [
        "Off",
        "On"
       ],
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.0
       ],
       "parameter_linknames": 1
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-133",
     "maxclass": "live.dial",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      650,
      450,
      44,
      48
     ],
     "presentation": 1,
     "presentation_rect": [
      650,
      450,
      44,
      48
     ],
     "varname": "Pulse Count Div",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Pulse Count Div",
       "parameter_shortname": "PC Div",
       "parameter_type": 1,
       "parameter_mmin": 1.0,
       "parameter_mmax": 8.0,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        1.0
       ],
       "parameter_linknames": 1
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-240",
     "maxclass": "live.menu",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      800,
      450,
      80,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      600,
      80,
      80,
      15
     ],
     "varname": "Rest Pitch",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Rest Pitch",
       "parameter_shortname": "RestP",
       "parameter_type": 2,
       "parameter_enum": [
        "Hold",
        "Update"
       ],
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0
       ],
       "parameter_linknames": 1
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-241",
     "maxclass": "newobj",
     "text": "prepend update_rest_pitch",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      800,
      500,
      140,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-242",
     "maxclass": "newobj",
     "text": "append 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      800,
      530,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-243",
     "maxclass": "multislider",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      900,
      450,
      120,
      60
     ],
     "presentation": 1,
     "presentation_rect": [
      600,
      100,
      120,
      40
     ],
     "size": 8,
     "setminmax": [
      -1.0,
      1.0
     ],
     "slidercolor": [
      0.5,
      0.5,
      0.5,
      1.0
     ],
     "candicane2": [
      0.145,
      0.435,
      0.718,
      1.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-244",
     "maxclass": "newobj",
     "text": "prepend update_gate_overrides",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      900,
      530,
      160,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-300",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30,
      750,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-301",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      140,
      750,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-302",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      250,
      750,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-303",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      360,
      750,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-304",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      470,
      750,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-305",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      580,
      750,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-306",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      690,
      750,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-307",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      800,
      750,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-310",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      30,
      820,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-311",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      100,
      820,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-312",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      170,
      820,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-313",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      240,
      820,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-314",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      310,
      820,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-315",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      380,
      820,
      55,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-320",
     "maxclass": "newobj",
     "text": "gen~ @title SlideEngineT1",
     "numinlets": 4,
     "numoutlets": 2,
     "outlettype": [
      "signal",
      "signal"
     ],
     "patching_rect": [
      30,
      450,
      200,
      22
     ],
     "patcher": {
      "fileversion": 1,
      "classnamespace": "dsp.gen",
      "rect": [
       0,
       0,
       600,
       400
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
          30,
          30,
          30,
          22
         ]
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
          100,
          30,
          30,
          22
         ]
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
          170,
          30,
          30,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-4",
         "maxclass": "newobj",
         "text": "in 4",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          240,
          30,
          30,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-10",
         "maxclass": "newobj",
         "text": "codebox",
         "numinlets": 4,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30,
          100,
          400,
          200
         ],
         "code": "\n// Slide/Portamento Engine\n// in1=current pitch  in2=slide toggle (0/1 for current stage)\n// in3=slide amount (0.0-1.0)  in4=slide type (0=Analog, 1=Tempo, 2=Acid)\n// out1=pitch (may be same as input)  out2=pitch bend (0-16383, center=8192)\n\nHistory target_pitch(60);\nHistory current_pitch(60);\nHistory slide_active(0);\nHistory prev_slide_toggle(0);\n\npitch = in1;\nslide_toggle = in2 >= 0.5;\namount = clamp(in3, 0.0, 1.0);\nslide_type = floor(in4);\n\n// Detect new note (pitch change)\nnew_note = pitch != target_pitch;\ntarget_pitch = pitch;\n\n// Slide is active when: slide toggle is ON for current stage AND amount > 0\ndo_slide = slide_toggle && amount > 0.001 && new_note;\n\nif (do_slide) {\n    // Calculate slide rate based on type\n    rate = 0;\n    if (slide_type < 0.5) {\n        // Analog: constant time, independent of tempo\n        // amount maps to slide time: 0=instant, 1=slow (rate=0.999)\n        rate = 1.0 - pow(1.0 - amount, 3) * 0.05;\n    } else if (slide_type < 1.5) {\n        // Tempo: same as analog for now (tempo scaling requires plugsync~)\n        rate = 1.0 - pow(1.0 - amount, 3) * 0.05;\n    } else {\n        // Acid: same rate but applied differently (gate held through transition)\n        rate = 1.0 - pow(1.0 - amount, 3) * 0.05;\n    }\n    // Exponential slide toward target\n    current_pitch = current_pitch + (target_pitch - current_pitch) * (1.0 - rate);\n} else if (new_note || !slide_toggle) {\n    current_pitch = target_pitch;\n}\n\n// Calculate pitch bend from difference\n// \u00b12 semitones = full bend range (0-16383, center=8192)\nbend_semitones = current_pitch - target_pitch;\nbend_normalized = clamp(bend_semitones / 2.0, -1.0, 1.0);\nbend_value = floor(8192 + bend_normalized * 8191);\nbend_value = clamp(bend_value, 0, 16383);\n\nout1 = target_pitch;\nout2 = bend_value;\n"
        }
       },
       {
        "box": {
         "id": "obj-20",
         "maxclass": "newobj",
         "text": "out 1",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          100,
          330,
          35,
          22
         ]
        }
       },
       {
        "box": {
         "id": "obj-21",
         "maxclass": "newobj",
         "text": "out 2",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          250,
          330,
          35,
          22
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
          "obj-10",
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
          "obj-10",
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
          "obj-10",
          3
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
          "obj-20",
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
          "obj-21",
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
     "id": "obj-340",
     "maxclass": "newobj",
     "text": "unpack 7 7 0 0 0 0",
     "numinlets": 1,
     "numoutlets": 6,
     "outlettype": [
      "int",
      "int",
      "int",
      "int",
      "int",
      "int"
     ],
     "patching_rect": [
      30,
      880,
      200,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-341",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      30,
      920,
      45,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-342",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      80,
      920,
      45,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-343",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      130,
      920,
      45,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-344",
     "maxclass": "newobj",
     "text": "sig~ 7",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      180,
      920,
      45,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-345",
     "maxclass": "newobj",
     "text": "sig~ 7",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      230,
      920,
      45,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-346",
     "maxclass": "newobj",
     "text": "sig~ 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      280,
      920,
      45,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-350",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      450,
      880,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-351",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      560,
      880,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-352",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      670,
      880,
      100,
      22
     ]
    }
   },
   {
    "box": {
     "id": "obj-353",
     "maxclass": "newobj",
     "text": "prepend pattern",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      780,
      880,
      100,
      22
     ]
    }
   }
  ],
  "lines": [
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
      "obj-10",
      0
     ],
     "order": 0
    }
   },
   {
    "patchline": {
     "source": [
      "obj-7",
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
      "obj-10",
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
      "obj-12",
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
      "obj-13",
      0
     ],
     "order": 1
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      3
     ],
     "destination": [
      "obj-14",
      0
     ],
     "order": 1
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
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
      "obj-9",
      5
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
      "obj-11",
      0
     ],
     "destination": [
      "obj-30",
      4
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
      "obj-30",
      5
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
      "obj-30",
      2
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
      "obj-30",
      3
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
      "obj-30",
      6
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
      "obj-30",
      7
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-112",
      0
     ],
     "destination": [
      "obj-20",
      0
     ],
     "order": 1
    }
   },
   {
    "patchline": {
     "source": [
      "obj-113",
      0
     ],
     "destination": [
      "obj-20",
      1
     ],
     "order": 1
    }
   },
   {
    "patchline": {
     "source": [
      "obj-112",
      0
     ],
     "destination": [
      "obj-20",
      2
     ],
     "order": 0
    }
   },
   {
    "patchline": {
     "source": [
      "obj-113",
      0
     ],
     "destination": [
      "obj-20",
      3
     ],
     "order": 0
    }
   },
   {
    "patchline": {
     "source": [
      "obj-20",
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
      "obj-20",
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
      "obj-30",
      3
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
      "obj-30",
      4
     ],
     "destination": [
      "obj-50",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-20",
      4
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
      "obj-4",
      0
     ],
     "order": 0
    }
   },
   {
    "patchline": {
     "source": [
      "obj-100",
      0
     ],
     "destination": [
      "obj-108",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-101",
      0
     ],
     "destination": [
      "obj-108",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-102",
      0
     ],
     "destination": [
      "obj-108",
      2
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-103",
      0
     ],
     "destination": [
      "obj-108",
      3
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-104",
      0
     ],
     "destination": [
      "obj-108",
      4
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-105",
      0
     ],
     "destination": [
      "obj-108",
      5
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-106",
      0
     ],
     "destination": [
      "obj-108",
      6
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-107",
      0
     ],
     "destination": [
      "obj-108",
      7
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-109",
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
      "obj-7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-108",
      0
     ],
     "destination": [
      "obj-118",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-118",
      1
     ],
     "order": 9
    }
   },
   {
    "patchline": {
     "source": [
      "obj-118",
      0
     ],
     "destination": [
      "obj-109",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-114",
      0
     ],
     "destination": [
      "obj-119",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-111",
      0
     ],
     "destination": [
      "obj-120",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-116",
      0
     ],
     "destination": [
      "obj-121",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-121",
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
      "obj-119",
      0
     ],
     "destination": [
      "obj-122",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-122",
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
      "obj-120",
      0
     ],
     "destination": [
      "obj-123",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-123",
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
      "obj-110",
      0
     ],
     "destination": [
      "obj-122",
      1
     ],
     "order": 8
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-123",
      1
     ],
     "order": 7
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      6
     ],
     "destination": [
      "obj-200",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      7
     ],
     "destination": [
      "obj-201",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      8
     ],
     "destination": [
      "obj-202",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      9
     ],
     "destination": [
      "obj-203",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      10
     ],
     "destination": [
      "obj-204",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      11
     ],
     "destination": [
      "obj-205",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      12
     ],
     "destination": [
      "obj-206",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      13
     ],
     "destination": [
      "obj-207",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      14
     ],
     "destination": [
      "obj-208",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      15
     ],
     "destination": [
      "obj-209",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      16
     ],
     "destination": [
      "obj-210",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      17
     ],
     "destination": [
      "obj-211",
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
      "obj-212",
      0
     ],
     "order": 0
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      3
     ],
     "destination": [
      "obj-213",
      0
     ],
     "order": 0
    }
   },
   {
    "patchline": {
     "source": [
      "obj-200",
      0
     ],
     "destination": [
      "obj-30",
      8
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-201",
      0
     ],
     "destination": [
      "obj-30",
      9
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-202",
      0
     ],
     "destination": [
      "obj-30",
      10
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-203",
      0
     ],
     "destination": [
      "obj-30",
      11
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-204",
      0
     ],
     "destination": [
      "obj-30",
      12
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-205",
      0
     ],
     "destination": [
      "obj-30",
      13
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-206",
      0
     ],
     "destination": [
      "obj-30",
      14
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-207",
      0
     ],
     "destination": [
      "obj-30",
      15
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-210",
      0
     ],
     "destination": [
      "obj-30",
      16
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-211",
      0
     ],
     "destination": [
      "obj-30",
      17
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-212",
      0
     ],
     "destination": [
      "obj-30",
      18
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-213",
      0
     ],
     "destination": [
      "obj-30",
      19
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
      "obj-40",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-208",
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
      "obj-18",
      0
     ],
     "destination": [
      "obj-40",
      3
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
      "obj-40",
      4
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
      "obj-40",
      5
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
      "obj-4",
      0
     ],
     "order": 1
    }
   },
   {
    "patchline": {
     "source": [
      "obj-115",
      0
     ],
     "destination": [
      "obj-220",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-220",
      0
     ],
     "destination": [
      "obj-221",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-221",
      1
     ],
     "order": 6
    }
   },
   {
    "patchline": {
     "source": [
      "obj-221",
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
      "obj-130",
      0
     ],
     "destination": [
      "obj-230",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-230",
      0
     ],
     "destination": [
      "obj-231",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-231",
      1
     ],
     "order": 5
    }
   },
   {
    "patchline": {
     "source": [
      "obj-231",
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
      "obj-131",
      0
     ],
     "destination": [
      "obj-232",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-232",
      0
     ],
     "destination": [
      "obj-233",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-233",
      1
     ],
     "order": 4
    }
   },
   {
    "patchline": {
     "source": [
      "obj-233",
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
      "obj-132",
      0
     ],
     "destination": [
      "obj-234",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-234",
      0
     ],
     "destination": [
      "obj-235",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-235",
      1
     ],
     "order": 3
    }
   },
   {
    "patchline": {
     "source": [
      "obj-235",
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
      "obj-133",
      0
     ],
     "destination": [
      "obj-236",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-236",
      0
     ],
     "destination": [
      "obj-237",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-237",
      1
     ],
     "order": 2
    }
   },
   {
    "patchline": {
     "source": [
      "obj-237",
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
      "obj-240",
      0
     ],
     "destination": [
      "obj-241",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-241",
      0
     ],
     "destination": [
      "obj-242",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-242",
      1
     ],
     "order": 1
    }
   },
   {
    "patchline": {
     "source": [
      "obj-242",
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
      "obj-243",
      0
     ],
     "destination": [
      "obj-244",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-244",
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
      20
     ],
     "destination": [
      "obj-300",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      21
     ],
     "destination": [
      "obj-301",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      22
     ],
     "destination": [
      "obj-302",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      23
     ],
     "destination": [
      "obj-303",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      24
     ],
     "destination": [
      "obj-304",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      25
     ],
     "destination": [
      "obj-305",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      26
     ],
     "destination": [
      "obj-306",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      27
     ],
     "destination": [
      "obj-307",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      28
     ],
     "destination": [
      "obj-310",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      29
     ],
     "destination": [
      "obj-311",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      30
     ],
     "destination": [
      "obj-312",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      31
     ],
     "destination": [
      "obj-313",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      32
     ],
     "destination": [
      "obj-314",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      33
     ],
     "destination": [
      "obj-315",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-300",
      0
     ],
     "destination": [
      "obj-30",
      20
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-301",
      0
     ],
     "destination": [
      "obj-30",
      21
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-302",
      0
     ],
     "destination": [
      "obj-30",
      22
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-303",
      0
     ],
     "destination": [
      "obj-30",
      23
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-304",
      0
     ],
     "destination": [
      "obj-30",
      24
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-305",
      0
     ],
     "destination": [
      "obj-30",
      25
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-306",
      0
     ],
     "destination": [
      "obj-30",
      26
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-307",
      0
     ],
     "destination": [
      "obj-30",
      27
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-314",
      0
     ],
     "destination": [
      "obj-30",
      28
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-315",
      0
     ],
     "destination": [
      "obj-30",
      29
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
      "obj-320",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-30",
      8
     ],
     "destination": [
      "obj-320",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-310",
      0
     ],
     "destination": [
      "obj-320",
      2
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-312",
      0
     ],
     "destination": [
      "obj-320",
      3
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-320",
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
      "obj-320",
      1
     ],
     "destination": [
      "obj-40",
      6
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      38
     ],
     "destination": [
      "obj-340",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-340",
      2
     ],
     "destination": [
      "obj-341",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-340",
      3
     ],
     "destination": [
      "obj-342",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-340",
      4
     ],
     "destination": [
      "obj-343",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-340",
      0
     ],
     "destination": [
      "obj-344",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-340",
      1
     ],
     "destination": [
      "obj-345",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-340",
      5
     ],
     "destination": [
      "obj-346",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      34
     ],
     "destination": [
      "obj-350",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      35
     ],
     "destination": [
      "obj-351",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      36
     ],
     "destination": [
      "obj-352",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      37
     ],
     "destination": [
      "obj-353",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-350",
      0
     ],
     "destination": [
      "obj-30",
      30
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-351",
      0
     ],
     "destination": [
      "obj-30",
      31
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-352",
      0
     ],
     "destination": [
      "obj-30",
      32
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-353",
      0
     ],
     "destination": [
      "obj-30",
      33
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-341",
      0
     ],
     "destination": [
      "obj-30",
      34
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-342",
      0
     ],
     "destination": [
      "obj-30",
      35
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-343",
      0
     ],
     "destination": [
      "obj-30",
      36
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-344",
      0
     ],
     "destination": [
      "obj-30",
      37
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-345",
      0
     ],
     "destination": [
      "obj-30",
      38
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-346",
      0
     ],
     "destination": [
      "obj-30",
      39
     ]
    }
   }
  ],
  "parameters": {
   "obj-100": [
    "Stage 1 Pitch",
    "1",
    0
   ],
   "obj-101": [
    "Stage 2 Pitch",
    "2",
    0
   ],
   "obj-102": [
    "Stage 3 Pitch",
    "3",
    0
   ],
   "obj-103": [
    "Stage 4 Pitch",
    "4",
    0
   ],
   "obj-104": [
    "Stage 5 Pitch",
    "5",
    0
   ],
   "obj-105": [
    "Stage 6 Pitch",
    "6",
    0
   ],
   "obj-106": [
    "Stage 7 Pitch",
    "7",
    0
   ],
   "obj-107": [
    "Stage 8 Pitch",
    "8",
    0
   ],
   "obj-110": [
    "Track Select",
    "Track",
    0
   ],
   "obj-111": [
    "Playback Order",
    "Order",
    0
   ],
   "obj-112": [
    "Clock Division",
    "Div",
    0
   ],
   "obj-113": [
    "Swing",
    "Swing",
    0
   ],
   "obj-114": [
    "Stages Length",
    "Len",
    0
   ],
   "obj-115": [
    "Gate Length",
    "Gate",
    0
   ],
   "obj-116": [
    "Root Note",
    "Root",
    0
   ],
   "parameterbanks": {},
   "obj-130": [
    "Velocity",
    "Vel",
    0
   ],
   "obj-131": [
    "Gate Scale",
    "G.Scale",
    0
   ],
   "obj-132": [
    "Gate Stretch",
    "G.Str",
    0
   ],
   "obj-133": [
    "Pulse Count Div",
    "PC Div",
    0
   ],
   "obj-240": [
    "Rest Pitch",
    "RestP",
    0
   ]
  },
  "dependency_cache": [],
  "autosave": 0
 }
}
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
    "rect": [100.0, 100.0, 860.0, 620.0],
    "bglocked": 0,
    "openinpresentation": 0,
    "default_fontsize": 12.0,
    "default_fontface": 0,
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
    "devicewidth": 0.0,
    "description": "Passes only the lowest note from simultaneously played chords",
    "digest": "Lowest note MIDI filter",
    "tags": "MIDI filter lowest note chord",
    "style": "",
    "subpatcher_template": "",
    "assistshowspatchername": 0,
    "boxes": [
      {
        "box": {
          "id": "obj-1",
          "maxclass": "comment",
          "text": "Lowest Note Filter",
          "fontface": 1,
          "fontsize": 14.0,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [24.0, 16.0, 200.0, 23.0]
        }
      },
      {
        "box": {
          "id": "obj-2",
          "maxclass": "comment",
          "text": "Only the lowest note from simultaneous note-ons passes through. All other MIDI (CC, bend, etc.) is passed through unchanged.",
          "linecount": 2,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [24.0, 40.0, 480.0, 34.0]
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
          "patching_rect": [160.0, 88.0, 44.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-4",
          "maxclass": "newobj",
          "text": "midiparse",
          "numinlets": 1,
          "numoutlets": 7,
          "outlettype": ["", "", "", "", "", "", ""],
          "patching_rect": [160.0, 128.0, 136.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-5",
          "maxclass": "newobj",
          "text": "unpack i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["int", "int"],
          "patching_rect": [160.0, 168.0, 72.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-6",
          "maxclass": "newobj",
          "text": "> 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [248.0, 168.0, 31.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-7",
          "maxclass": "newobj",
          "text": "sel 1 0",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": ["bang", "bang", ""],
          "patching_rect": [296.0, 168.0, 50.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-8",
          "maxclass": "newobj",
          "text": "i",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [160.0, 208.0, 30.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-9",
          "maxclass": "newobj",
          "text": "i",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [208.0, 208.0, 30.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-10",
          "maxclass": "newobj",
          "text": "t b b",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["bang", "bang"],
          "patching_rect": [296.0, 208.0, 42.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-11",
          "maxclass": "newobj",
          "text": "pack i i",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [160.0, 248.0, 60.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-12",
          "maxclass": "newobj",
          "text": "t b b l",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": ["bang", "bang", ""],
          "patching_rect": [160.0, 288.0, 58.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-13",
          "maxclass": "newobj",
          "text": "prepend store",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [240.0, 288.0, 92.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-14",
          "maxclass": "newobj",
          "text": "coll #0_temp",
          "numinlets": 1,
          "numoutlets": 4,
          "patching_rect": [352.0, 288.0, 80.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-15",
          "maxclass": "newobj",
          "text": "delay 5",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["bang"],
          "patching_rect": [240.0, 336.0, 52.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-16",
          "maxclass": "message",
          "text": "stop",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [304.0, 336.0, 35.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-17",
          "maxclass": "newobj",
          "text": "t i i i",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": ["int", "int", "int"],
          "patching_rect": [160.0, 336.0, 48.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-18",
          "maxclass": "newobj",
          "text": "i",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [160.0, 368.0, 30.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-19",
          "maxclass": "newobj",
          "text": "prepend remove",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [224.0, 368.0, 102.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-20",
          "maxclass": "newobj",
          "text": "table #0_sent 128",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [592.0, 432.0, 108.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-21",
          "maxclass": "newobj",
          "text": "> 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [352.0, 368.0, 31.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-22",
          "maxclass": "newobj",
          "text": "sel 1",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["bang", ""],
          "patching_rect": [392.0, 368.0, 36.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-23",
          "maxclass": "newobj",
          "text": "pack i 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [160.0, 400.0, 60.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-24",
          "maxclass": "newobj",
          "text": "t b l",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["bang", ""],
          "patching_rect": [352.0, 496.0, 40.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-25",
          "maxclass": "newobj",
          "text": "gate 1 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [408.0, 496.0, 56.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-26",
          "maxclass": "message",
          "text": "0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [352.0, 528.0, 30.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-27",
          "maxclass": "newobj",
          "text": "t l l",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["", ""],
          "patching_rect": [480.0, 496.0, 36.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-28",
          "maxclass": "newobj",
          "text": "unpack i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["int", "int"],
          "patching_rect": [528.0, 496.0, 72.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-29",
          "maxclass": "newobj",
          "text": "pack i 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [528.0, 528.0, 60.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-30",
          "maxclass": "newobj",
          "text": "t b b b",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": ["bang", "bang", "bang"],
          "patching_rect": [240.0, 400.0, 50.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-31",
          "maxclass": "message",
          "text": "1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [304.0, 400.0, 30.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-32",
          "maxclass": "message",
          "text": "dump",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [344.0, 400.0, 42.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-33",
          "maxclass": "newobj",
          "text": "delay 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["bang"],
          "patching_rect": [400.0, 400.0, 52.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-34",
          "maxclass": "message",
          "text": "clear",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [464.0, 400.0, 39.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-35",
          "maxclass": "newobj",
          "text": "live.thisdevice",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["", "int"],
          "patching_rect": [24.0, 128.0, 96.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-36",
          "maxclass": "message",
          "text": "reset",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [24.0, 200.0, 40.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-37",
          "maxclass": "newobj",
          "text": "sel 0",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["bang", ""],
          "patching_rect": [72.0, 168.0, 40.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-38",
          "maxclass": "comment",
          "text": "5ms chord detection window",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [296.0, 336.0, 168.0, 20.0]
        }
      },
      {
        "box": {
          "id": "obj-39",
          "maxclass": "comment",
          "text": "Non-note MIDI passes through unchanged",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [320.0, 560.0, 240.0, 20.0]
        }
      },
      {
        "box": {
          "id": "obj-40",
          "maxclass": "comment",
          "text": "Init on load + reset on bypass/deactivation",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [24.0, 104.0, 260.0, 20.0]
        }
      },
      {
        "box": {
          "id": "obj-41",
          "maxclass": "newobj",
          "text": "t b b b b",
          "numinlets": 1,
          "numoutlets": 4,
          "outlettype": ["bang", "bang", "bang", "bang"],
          "patching_rect": [24.0, 240.0, 66.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-42",
          "maxclass": "newobj",
          "text": "uzi 128",
          "numinlets": 2,
          "numoutlets": 3,
          "outlettype": ["bang", "int", "bang"],
          "patching_rect": [24.0, 272.0, 48.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-43",
          "maxclass": "newobj",
          "text": "- 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [88.0, 272.0, 30.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-44",
          "maxclass": "newobj",
          "text": "t i i",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["int", "int"],
          "patching_rect": [128.0, 272.0, 36.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-45",
          "maxclass": "newobj",
          "text": "i",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [176.0, 272.0, 30.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-46",
          "maxclass": "newobj",
          "text": "> 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [216.0, 272.0, 31.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-47",
          "maxclass": "newobj",
          "text": "sel 1",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": ["bang", ""],
          "patching_rect": [256.0, 272.0, 36.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-48",
          "maxclass": "newobj",
          "text": "pack i 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [304.0, 272.0, 60.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-49",
          "maxclass": "comment",
          "text": "Native Max implementation (no v8/js)",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [24.0, 72.0, 240.0, 20.0]
        }
      },
      {
        "box": {
          "id": "obj-50",
          "maxclass": "newobj",
          "text": "midiformat",
          "numinlets": 7,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [160.0, 560.0, 136.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-51",
          "maxclass": "newobj",
          "text": "midiout",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [160.0, 592.0, 52.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-52",
          "maxclass": "newobj",
          "text": "table #0_sent 128",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [592.0, 464.0, 108.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-53",
          "maxclass": "newobj",
          "text": "table #0_sent 128",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [352.0, 336.0, 108.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-54",
          "maxclass": "newobj",
          "text": "coll #0_temp",
          "numinlets": 1,
          "numoutlets": 4,
          "patching_rect": [352.0, 464.0, 80.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-55",
          "maxclass": "newobj",
          "text": "i",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["int"],
          "patching_rect": [112.0, 208.0, 30.0, 22.0]
        }
      }
    ],
    "lines": [
      { "patchline": { "source": ["obj-3", 0], "destination": ["obj-4", 0] } },
      { "patchline": { "source": ["obj-4", 0], "destination": ["obj-5", 0] } },
      { "patchline": { "source": ["obj-5", 0], "destination": ["obj-8", 1], "order": 1 } },
      { "patchline": { "source": ["obj-5", 0], "destination": ["obj-55", 1], "order": 0 } },
      { "patchline": { "source": ["obj-5", 1], "destination": ["obj-9", 1], "order": 1 } },
      { "patchline": { "source": ["obj-5", 1], "destination": ["obj-6", 0], "order": 0 } },
      { "patchline": { "source": ["obj-6", 0], "destination": ["obj-7", 0] } },
      { "patchline": { "source": ["obj-7", 0], "destination": ["obj-10", 0] } },
      { "patchline": { "source": ["obj-10", 1], "destination": ["obj-9", 0] } },
      { "patchline": { "source": ["obj-9", 0], "destination": ["obj-11", 1] } },
      { "patchline": { "source": ["obj-10", 0], "destination": ["obj-8", 0] } },
      { "patchline": { "source": ["obj-8", 0], "destination": ["obj-11", 0] } },
      { "patchline": { "source": ["obj-11", 0], "destination": ["obj-12", 0] } },
      { "patchline": { "source": ["obj-12", 2], "destination": ["obj-13", 0] } },
      { "patchline": { "source": ["obj-13", 0], "destination": ["obj-14", 0] } },
      { "patchline": { "source": ["obj-12", 1], "destination": ["obj-16", 0] } },
      { "patchline": { "source": ["obj-16", 0], "destination": ["obj-15", 1] } },
      { "patchline": { "source": ["obj-12", 0], "destination": ["obj-15", 0] } },
      { "patchline": { "source": ["obj-7", 1], "destination": ["obj-55", 0] } },
      { "patchline": { "source": ["obj-55", 0], "destination": ["obj-17", 0] } },
      { "patchline": { "source": ["obj-17", 2], "destination": ["obj-18", 1] } },
      { "patchline": { "source": ["obj-17", 1], "destination": ["obj-19", 0] } },
      { "patchline": { "source": ["obj-19", 0], "destination": ["obj-14", 0] } },
      { "patchline": { "source": ["obj-17", 0], "destination": ["obj-53", 0] } },
      { "patchline": { "source": ["obj-53", 0], "destination": ["obj-21", 0] } },
      { "patchline": { "source": ["obj-21", 0], "destination": ["obj-22", 0] } },
      { "patchline": { "source": ["obj-22", 0], "destination": ["obj-18", 0] } },
      { "patchline": { "source": ["obj-18", 0], "destination": ["obj-23", 0] } },
      { "patchline": { "source": ["obj-23", 0], "destination": ["obj-20", 0], "order": 1 } },
      { "patchline": { "source": ["obj-23", 0], "destination": ["obj-50", 0], "order": 0 } },
      { "patchline": { "source": ["obj-15", 0], "destination": ["obj-30", 0] } },
      { "patchline": { "source": ["obj-30", 2], "destination": ["obj-31", 0] } },
      { "patchline": { "source": ["obj-31", 0], "destination": ["obj-25", 1] } },
      { "patchline": { "source": ["obj-30", 1], "destination": ["obj-32", 0] } },
      { "patchline": { "source": ["obj-32", 0], "destination": ["obj-54", 0] } },
      { "patchline": { "source": ["obj-30", 0], "destination": ["obj-33", 0] } },
      { "patchline": { "source": ["obj-33", 0], "destination": ["obj-34", 0] } },
      { "patchline": { "source": ["obj-34", 0], "destination": ["obj-14", 0] } },
      { "patchline": { "source": ["obj-54", 0], "destination": ["obj-24", 0] } },
      { "patchline": { "source": ["obj-24", 1], "destination": ["obj-25", 0] } },
      { "patchline": { "source": ["obj-24", 0], "destination": ["obj-26", 0] } },
      { "patchline": { "source": ["obj-26", 0], "destination": ["obj-25", 1] } },
      { "patchline": { "source": ["obj-25", 0], "destination": ["obj-27", 0] } },
      { "patchline": { "source": ["obj-27", 0], "destination": ["obj-50", 0] } },
      { "patchline": { "source": ["obj-27", 1], "destination": ["obj-28", 0] } },
      { "patchline": { "source": ["obj-28", 0], "destination": ["obj-29", 0] } },
      { "patchline": { "source": ["obj-29", 0], "destination": ["obj-20", 0] } },
      { "patchline": { "source": ["obj-35", 0], "destination": ["obj-36", 0] } },
      { "patchline": { "source": ["obj-35", 1], "destination": ["obj-37", 0] } },
      { "patchline": { "source": ["obj-37", 0], "destination": ["obj-36", 0] } },
      { "patchline": { "source": ["obj-36", 0], "destination": ["obj-41", 0] } },
      { "patchline": { "source": ["obj-41", 3], "destination": ["obj-16", 0] } },
      { "patchline": { "source": ["obj-41", 2], "destination": ["obj-34", 0] } },
      { "patchline": { "source": ["obj-41", 1], "destination": ["obj-26", 0] } },
      { "patchline": { "source": ["obj-41", 0], "destination": ["obj-42", 0] } },
      { "patchline": { "source": ["obj-42", 1], "destination": ["obj-43", 0] } },
      { "patchline": { "source": ["obj-43", 0], "destination": ["obj-44", 0] } },
      { "patchline": { "source": ["obj-44", 1], "destination": ["obj-45", 1] } },
      { "patchline": { "source": ["obj-44", 0], "destination": ["obj-52", 0] } },
      { "patchline": { "source": ["obj-52", 0], "destination": ["obj-46", 0] } },
      { "patchline": { "source": ["obj-46", 0], "destination": ["obj-47", 0] } },
      { "patchline": { "source": ["obj-47", 0], "destination": ["obj-45", 0] } },
      { "patchline": { "source": ["obj-45", 0], "destination": ["obj-48", 0] } },
      { "patchline": { "source": ["obj-48", 0], "destination": ["obj-20", 0], "order": 1 } },
      { "patchline": { "source": ["obj-48", 0], "destination": ["obj-50", 0], "order": 0 } },
      { "patchline": { "source": ["obj-4", 1], "destination": ["obj-50", 1] } },
      { "patchline": { "source": ["obj-4", 2], "destination": ["obj-50", 2] } },
      { "patchline": { "source": ["obj-4", 3], "destination": ["obj-50", 3] } },
      { "patchline": { "source": ["obj-4", 4], "destination": ["obj-50", 4] } },
      { "patchline": { "source": ["obj-4", 5], "destination": ["obj-50", 5] } },
      { "patchline": { "source": ["obj-4", 6], "destination": ["obj-50", 6] } },
      { "patchline": { "source": ["obj-50", 0], "destination": ["obj-51", 0] } }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}

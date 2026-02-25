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
    "rect": [100.0, 100.0, 800.0, 650.0],
    "bglocked": 0,
    "openinpresentation": 0,
    "default_fontsize": 12.0,
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
    "description": "Help patch for midi.notecluster",
    "tags": "",
    "style": "",
    "subpatcher_template": "",
    "assistshowspatchername": 0,
    "autosave": 0,
    "boxes": [
      {
        "box": {
          "id": "obj-1",
          "maxclass": "comment",
          "text": "midi.notecluster",
          "fontsize": 18.0,
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [15.0, 15.0, 200.0, 27.0]
        }
      },
      {
        "box": {
          "id": "obj-2",
          "maxclass": "comment",
          "text": "Group note-ons within a time window and emit chord cluster metadata.\nInput: note pairs (pitch velocity). Note-ons accumulate during the window.\nWhen the window closes, the cluster list and metadata are emitted.",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [15.0, 45.0, 500.0, 48.0]
        }
      },
      {
        "box": {
          "id": "obj-10",
          "maxclass": "comment",
          "text": "--- Basic usage ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [15.0, 105.0, 150.0, 20.0]
        }
      },
      {
        "box": {
          "id": "obj-11",
          "maxclass": "comment",
          "text": "Send note pairs to inlet 1. Try rapid chords:",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [15.0, 130.0, 300.0, 20.0]
        }
      },
      {
        "box": {
          "id": "obj-12",
          "maxclass": "message",
          "text": "60 100",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [15.0, 160.0, 50.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-13",
          "maxclass": "message",
          "text": "64 100",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [75.0, 160.0, 50.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-14",
          "maxclass": "message",
          "text": "67 100",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [135.0, 160.0, 50.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-15",
          "maxclass": "comment",
          "text": "note-offs:",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [210.0, 160.0, 60.0, 20.0]
        }
      },
      {
        "box": {
          "id": "obj-16",
          "maxclass": "message",
          "text": "60 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [270.0, 160.0, 40.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-17",
          "maxclass": "message",
          "text": "64 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [320.0, 160.0, 40.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-20",
          "maxclass": "newobj",
          "text": "midi.notecluster",
          "numinlets": 2,
          "numoutlets": 3,
          "outlettype": ["", "", ""],
          "patching_rect": [15.0, 210.0, 420.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-21",
          "maxclass": "newobj",
          "text": "print cluster",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [15.0, 255.0, 78.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-22",
          "maxclass": "newobj",
          "text": "print metadata",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [210.0, 255.0, 88.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-23",
          "maxclass": "newobj",
          "text": "print noteoff",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [420.0, 255.0, 78.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-30",
          "maxclass": "comment",
          "text": "--- Control messages (inlet 2) ---",
          "fontface": 1,
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [15.0, 300.0, 250.0, 20.0]
        }
      },
      {
        "box": {
          "id": "obj-31",
          "maxclass": "message",
          "text": "window 10",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [15.0, 330.0, 68.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-32",
          "maxclass": "message",
          "text": "window 50",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [90.0, 330.0, 68.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-33",
          "maxclass": "message",
          "text": "sort 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [165.0, 330.0, 48.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-34",
          "maxclass": "message",
          "text": "sort 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [220.0, 330.0, 48.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-35",
          "maxclass": "message",
          "text": "unique 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [275.0, 330.0, 58.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-36",
          "maxclass": "message",
          "text": "unique 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [340.0, 330.0, 58.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-37",
          "maxclass": "message",
          "text": "flush",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [405.0, 330.0, 38.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-38",
          "maxclass": "message",
          "text": "reset",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [450.0, 330.0, 40.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-39",
          "maxclass": "message",
          "text": "bypass 1",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [500.0, 330.0, 58.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-40",
          "maxclass": "message",
          "text": "bypass 0",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [""],
          "patching_rect": [565.0, 330.0, 58.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-41",
          "maxclass": "newobj",
          "text": "midi.notecluster",
          "numinlets": 2,
          "numoutlets": 3,
          "outlettype": ["", "", ""],
          "patching_rect": [15.0, 375.0, 570.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-42",
          "maxclass": "newobj",
          "text": "print ctrl_cluster",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [15.0, 420.0, 102.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-43",
          "maxclass": "newobj",
          "text": "print ctrl_meta",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [270.0, 420.0, 90.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-44",
          "maxclass": "newobj",
          "text": "print ctrl_noteoff",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [570.0, 420.0, 102.0, 22.0]
        }
      },
      {
        "box": {
          "id": "obj-50",
          "maxclass": "comment",
          "text": "--- Outputs ---\nOutlet 1: cluster <p1> <p2> ...\nOutlet 2: count <n>, lowest <p>, highest <p>, single, done\nOutlet 3: note-off passthrough (pitch 0)",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [15.0, 465.0, 450.0, 62.0]
        }
      },
      {
        "box": {
          "id": "obj-60",
          "maxclass": "comment",
          "text": "--- Notes ---\n- Default window: 5ms (good for MIDI chord detection)\n- sort 1 (default): pitches sorted low to high\n- unique 1 (default): duplicate pitches collapsed\n- Single notes emit as cluster of size 1\n- Note-offs pass through outlet 3 unchanged\n- bypass 1: routes all input to outlet 3",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [15.0, 540.0, 450.0, 90.0]
        }
      }
    ],
    "lines": [
      { "patchline": { "source": ["obj-12", 0], "destination": ["obj-20", 0] } },
      { "patchline": { "source": ["obj-13", 0], "destination": ["obj-20", 0] } },
      { "patchline": { "source": ["obj-14", 0], "destination": ["obj-20", 0] } },
      { "patchline": { "source": ["obj-16", 0], "destination": ["obj-20", 0] } },
      { "patchline": { "source": ["obj-17", 0], "destination": ["obj-20", 0] } },
      { "patchline": { "source": ["obj-20", 0], "destination": ["obj-21", 0] } },
      { "patchline": { "source": ["obj-20", 1], "destination": ["obj-22", 0] } },
      { "patchline": { "source": ["obj-20", 2], "destination": ["obj-23", 0] } },
      { "patchline": { "source": ["obj-31", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-32", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-33", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-34", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-35", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-36", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-37", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-38", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-39", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-40", 0], "destination": ["obj-41", 1] } },
      { "patchline": { "source": ["obj-41", 0], "destination": ["obj-42", 0] } },
      { "patchline": { "source": ["obj-41", 1], "destination": ["obj-43", 0] } },
      { "patchline": { "source": ["obj-41", 2], "destination": ["obj-44", 0] } }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}

#!/usr/bin/env python3
"""
Metropolix Stage 2 Build Script
Transforms Phase 1 patch -> Stage 2 with:
- GateGen expanded to 9 inputs (gate scale, stretching, PCD, gate override, pulse count)
- NoteEdgeDetect expanded to 5 outputs (note_on, note_off, held_pitch, prev_pitch, legato)
- Track1Output rebuilt with legato, panic, proper note ordering
- SequencerCore expanded from 10->20 inlets (Stage 2 params + pulse count stepfun~)
- TransportStop expanded to 2 outlets (MIDI + panic bang)
- New UI controls (Velocity, Gate Scale, Gate Stretching, Pulse Count Div)
- Route expanded from 6->20 outputs
- Pulse count stepdiv~ pattern also routed to new stepfun~ for GateGen in9
"""

import json, sys

PATCH_PATH = "Metropolix.maxpat"

# ============================================================
# GateGen codebox code (9 inputs, 1 output)
# ============================================================
GATEGEN_CODE = """\
// Full gate generator - Stage 2
// in1=step phasor  in2=gate type(0-3)  in3=gate length(0.01-1.0)
// in4=stepcounter  in5=gate scale(0.01-2.0)  in6=gate stretching(0/1)
// in7=pulse count div(1-8)  in8=gate override(-1=OFF, 0=Rest, 0.01-1.0)
// in9=pulse count for current stage (1-8)
//
// Gate types: 0=Rest, 1=Single, 2=Multi, 3=Hold
// Gate override encoding: -1=OFF (use track gate), 0=Rest, 0.01-0.99=%, 1.0=Hold

History prev_counter(-1);
History pulse_in_stage(0);

phasor = in1;
gt = in2;
raw_gl = clamp(in3, 0.01, 1.0);
counter = in4;
gscale = clamp(in5, 0.01, 2.0);
stretching = in6 >= 0.5;
pcdiv = max(floor(in7), 1);
gate_ovr = in8;
total_pulses = max(floor(in9), 1);

// Detect stage boundary
new_stage = (counter != prev_counter);
if (new_stage) {
    pulse_in_stage = 0;
} else if (phasor < 0.01) {
    pulse_in_stage = pulse_in_stage + 1;
}
prev_counter = counter;

// Gate override: replaces track gate length when active
// -1=OFF, 0=Rest, 0.01-0.99=percentage, 1.0=Hold (forces gt=3)
eff_gl = raw_gl;
if (gate_ovr > -0.5) {
    if (gate_ovr < 0.005) {
        gt = 0;
    } else if (gate_ovr > 0.995) {
        gt = 3;
    } else {
        eff_gl = clamp(gate_ovr, 0.01, 1.0);
    }
}

// Apply gate scale (clamped to 1.0 so gates don't exceed pulse/stage)
gl = clamp(eff_gl * gscale, 0.01, 1.0);

// Gate Stretching: gate length as % of entire stage duration
// Truncate 1 tick (1/96 pulse) before next stage boundary
stage_pos = 0; stretched_gate = 0;
if (stretching) {
    stage_pos = (pulse_in_stage + phasor) / total_pulses;
    trunc = 1.0 - (1.0 / (96.0 * total_pulses));
    stretched_gl = min(gl, trunc);
    stretched_gate = stage_pos < stretched_gl;
}

gate = 0;
if (gt < 0.5) {
    // Rest: no gate
    gate = 0;
} else if (gt < 1.5) {
    // Single: gate on first pulse only
    if (stretching) {
        gate = stretched_gate;
    } else {
        if (pulse_in_stage < 0.5) { gate = phasor < gl; }
    }
} else if (gt < 2.5) {
    // Multi with pulse count division
    if (stretching) {
        if (pcdiv < 1.5) {
            gate = stretched_gate;
        } else {
            group_idx = floor(pulse_in_stage / pcdiv);
            group_start = group_idx * pcdiv;
            remaining = total_pulses - group_start;
            group_size = min(pcdiv, remaining);
            group_pos_in = pulse_in_stage - group_start;
            group_frac = (group_pos_in + phasor) / group_size;
            group_trunc = 1.0 - (1.0 / (96.0 * group_size));
            gate = group_frac < min(gl, group_trunc);
        }
    } else {
        if (pcdiv < 1.5) {
            gate = phasor < gl;
        } else {
            group_idx = floor(pulse_in_stage / pcdiv);
            group_start = group_idx * pcdiv;
            remaining = total_pulses - group_start;
            group_size = min(pcdiv, remaining);
            group_pos = pulse_in_stage - group_start;
            if (group_pos >= group_size - 1) {
                gate = phasor < gl;
            } else {
                gate = 1;
            }
        }
    }
} else {
    // Hold: always on (legato)
    gate = 1;
}

out1 = gate;
"""

# ============================================================
# NoteEdgeDetect codebox code (2 inputs, 5 outputs)
# ============================================================
NED_CODE = """\
// Edge detect with HOLD legato support
// in1=pitch  in2=gate(0/1)
// out1=note_on  out2=note_off  out3=held_pitch  out4=prev_pitch  out5=legato
//
// Legato (Hold): when pitch changes while gate is sustained,
// outputs note_on=1 with legato=1. note_off is NOT fired during legato.
// Downstream handles legato note-off via the legato detection path,
// guaranteeing note-on(new) fires before note-off(old).

History prev_gate(0);
History prev_pitch(0);
History held_pitch(60);
History prev_held(60);

pitch = in1;
gate = in2 >= 0.5;
note_on = 0; note_off = 0; legato = 0;

if (gate && !prev_gate) {
    note_on = 1;
    prev_held = held_pitch;
    held_pitch = pitch;
} else if (!gate && prev_gate) {
    note_off = 1;
} else if (gate && prev_gate && (pitch != prev_pitch)) {
    note_on = 1;
    legato = 1;
    prev_held = held_pitch;
    held_pitch = pitch;
}

prev_gate = gate;
prev_pitch = pitch;

out1 = note_on;
out2 = note_off;
out3 = held_pitch;
out4 = prev_held;
out5 = legato;
"""


def box(id, maxclass, **kw):
    b = {"id": id, "maxclass": maxclass}
    b.update(kw)
    return {"box": b}

def nobj(id, text, nin, nout, ot, rect, **kw):
    return box(id, "newobj", text=text, numinlets=nin, numoutlets=nout,
               outlettype=ot, patching_rect=rect, **kw)

def inlet_box(id, idx, rect, ot=None, comment=""):
    return box(id, "inlet", index=idx, numinlets=0, numoutlets=1,
               outlettype=[ot or ""], patching_rect=rect, comment=comment)

def outlet_box(id, idx, rect, comment=""):
    return box(id, "outlet", index=idx, numinlets=1, numoutlets=0,
               outlettype=[], patching_rect=rect, comment=comment)

def msg(id, text, rect):
    return box(id, "message", text=text, numinlets=2, numoutlets=1,
               outlettype=[""], patching_rect=rect)

def line(src_id, src_out, dst_id, dst_in, order=None):
    pl = {"source": [src_id, src_out], "destination": [dst_id, dst_in]}
    if order is not None:
        pl["order"] = order
    return {"patchline": pl}


def build_gategen(title):
    return {
        "fileversion": 1, "classnamespace": "dsp.gen",
        "rect": [0, 0, 600, 400],
        "boxes": [
            nobj("obj-1", "in 1", 0, 1, [""], [30, 30, 30, 22]),
            nobj("obj-2", "in 2", 0, 1, [""], [90, 30, 30, 22]),
            nobj("obj-3", "in 3", 0, 1, [""], [150, 30, 30, 22]),
            nobj("obj-4", "in 4", 0, 1, [""], [210, 30, 30, 22]),
            nobj("obj-5", "in 5", 0, 1, [""], [270, 30, 30, 22]),
            nobj("obj-6", "in 6", 0, 1, [""], [330, 30, 30, 22]),
            nobj("obj-7", "in 7", 0, 1, [""], [390, 30, 30, 22]),
            nobj("obj-8", "in 8", 0, 1, [""], [450, 30, 30, 22]),
            nobj("obj-9", "in 9", 0, 1, [""], [510, 30, 30, 22]),
            {"box": {"id": "obj-10", "maxclass": "newobj", "text": "codebox",
                     "numinlets": 9, "numoutlets": 1, "outlettype": [""],
                     "patching_rect": [30, 120, 500, 200], "code": GATEGEN_CODE}},
            nobj("obj-11", "out 1", 1, 0, [], [250, 350, 35, 22]),
        ],
        "lines": [
            line("obj-1", 0, "obj-10", 0), line("obj-2", 0, "obj-10", 1),
            line("obj-3", 0, "obj-10", 2), line("obj-4", 0, "obj-10", 3),
            line("obj-5", 0, "obj-10", 4), line("obj-6", 0, "obj-10", 5),
            line("obj-7", 0, "obj-10", 6), line("obj-8", 0, "obj-10", 7),
            line("obj-9", 0, "obj-10", 8), line("obj-10", 0, "obj-11", 0),
        ]
    }


def build_ned():
    return {
        "fileversion": 1, "classnamespace": "dsp.gen",
        "rect": [0, 0, 500, 400],
        "boxes": [
            nobj("obj-1", "in 1", 0, 1, [""], [30, 30, 30, 22]),
            nobj("obj-2", "in 2", 0, 1, [""], [150, 30, 30, 22]),
            {"box": {"id": "obj-3", "maxclass": "newobj", "text": "codebox",
                     "numinlets": 2, "numoutlets": 5,
                     "outlettype": ["", "", "", "", ""],
                     "patching_rect": [30, 100, 400, 180], "code": NED_CODE}},
            nobj("obj-4", "out 1", 1, 0, [], [30, 330, 35, 22]),
            nobj("obj-5", "out 2", 1, 0, [], [110, 330, 35, 22]),
            nobj("obj-6", "out 3", 1, 0, [], [190, 330, 35, 22]),
            nobj("obj-7", "out 4", 1, 0, [], [270, 330, 35, 22]),
            nobj("obj-8", "out 5", 1, 0, [], [350, 330, 35, 22]),
        ],
        "lines": [
            line("obj-1", 0, "obj-3", 0), line("obj-2", 0, "obj-3", 1),
            line("obj-3", 0, "obj-4", 0), line("obj-3", 1, "obj-5", 0),
            line("obj-3", 2, "obj-6", 0), line("obj-3", 3, "obj-7", 0),
            line("obj-3", 4, "obj-8", 0),
        ]
    }


def build_track1_output():
    """Build Track1Output with legato and panic.
    6 inlets: pitch(sig), gate(sig), velocity(int), channel(int), MIDI_thru(int), panic(bang)
    1 outlet: MIDI output
    """
    Y = lambda n: 40 + n * 50
    boxes = [
        inlet_box("obj-1", 1, [50, Y(0), 30, 30], "signal", "Pitch"),
        inlet_box("obj-2", 2, [150, Y(0), 30, 30], "signal", "Gate"),
        inlet_box("obj-3", 3, [350, Y(0), 30, 30], "", "Velocity"),
        inlet_box("obj-4", 4, [450, Y(0), 30, 30], "", "Channel"),
        inlet_box("obj-5", 5, [600, Y(0), 30, 30], "int", "MIDI thru"),
        inlet_box("obj-6", 6, [700, Y(0), 30, 30], "", "Panic"),
        {"box": {"id": "obj-10", "maxclass": "newobj",
                 "text": "gen~ @title NoteEdgeDetect",
                 "numinlets": 2, "numoutlets": 5,
                 "outlettype": ["signal", "signal", "signal", "signal", "signal"],
                 "patching_rect": [50, Y(1), 200, 22],
                 "patcher": build_ned(),
                 "saved_object_attributes": {"globalpatchername": ""}}},
        nobj("obj-11", "edge~", 1, 2, ["bang", "bang"], [50, Y(2), 40, 22]),
        nobj("obj-12", "edge~", 1, 2, ["bang", "bang"], [300, Y(2), 40, 22]),
        nobj("obj-13", "snapshot~ 0", 2, 1, ["float"], [50, Y(4), 70, 22]),
        nobj("obj-14", "snapshot~ 0", 2, 1, ["float"], [150, Y(4), 70, 22]),
        nobj("obj-15", "snapshot~ 0", 2, 1, ["float"], [250, Y(4), 70, 22]),
        nobj("obj-16", "i 100", 2, 1, ["int"], [350, Y(3), 35, 22]),
        nobj("obj-17", "i 1", 2, 1, ["int"], [450, Y(3), 35, 22]),
        nobj("obj-20", "t b b b", 1, 3, ["bang", "bang", "bang"], [50, Y(3), 55, 22]),
        nobj("obj-21", "int", 2, 1, ["int"], [50, Y(6), 30, 22]),
        nobj("obj-22", "int", 2, 1, ["int"], [150, Y(7), 30, 22]),
        nobj("obj-23", "int", 2, 1, ["int"], [250, Y(6), 30, 22]),
        nobj("obj-24", "t i i", 1, 2, ["int", "int"], [50, Y(7), 40, 22]),
        nobj("obj-25", "i 60", 2, 1, ["int"], [50, Y(8), 35, 22]),
        nobj("obj-30", "pack 0 0", 2, 1, [""], [50, Y(9), 55, 22]),
        nobj("obj-31", "schedule", 1, 1, [""], [50, Y(10), 55, 22]),
        nobj("obj-32", "midiformat", 7, 1, ["int"], [50, Y(11), 70, 22]),
        nobj("obj-33", "sel 0", 1, 2, ["bang", ""], [250, Y(7), 40, 22]),
        nobj("obj-34", "pack 0 0", 2, 1, [""], [180, Y(9), 55, 22]),
        msg("obj-35", "0", [230, Y(8), 20, 22]),
        nobj("obj-36", "schedule", 1, 1, [""], [180, Y(10), 55, 22]),
        nobj("obj-37", "midiformat", 7, 1, ["int"], [180, Y(11), 70, 22]),
        nobj("obj-40", "t b b", 1, 2, ["bang", "bang"], [300, Y(3), 45, 22]),
        nobj("obj-41", "pack 0 0", 2, 1, [""], [300, Y(9), 55, 22]),
        msg("obj-42", "0", [360, Y(8), 20, 22]),
        nobj("obj-43", "schedule", 1, 1, [""], [300, Y(10), 55, 22]),
        nobj("obj-44", "midiformat", 7, 1, ["int"], [300, Y(11), 70, 22]),
        nobj("obj-50", "t b b", 1, 2, ["bang", "bang"], [700, Y(3), 45, 22]),
        nobj("obj-51", "i 60", 2, 1, ["int"], [700, Y(5), 35, 22]),
        nobj("obj-52", "pack 0 0", 2, 1, [""], [700, Y(7), 55, 22]),
        msg("obj-53", "0", [750, Y(6), 20, 22]),
        msg("obj-54", "123 0", [800, Y(5), 45, 22]),
        nobj("obj-55", "schedule", 1, 1, [""], [700, Y(8), 55, 22]),
        nobj("obj-56", "schedule", 1, 1, [""], [800, Y(8), 55, 22]),
        nobj("obj-57", "midiformat", 7, 1, ["int"], [700, Y(9), 70, 22]),
        nobj("obj-58", "midiformat", 7, 1, ["int"], [800, Y(9), 70, 22]),
        outlet_box("obj-90", 1, [400, Y(12), 30, 30], "MIDI output"),
        # Channel change flush: change detects new value, t i b flushes then updates
        nobj("obj-60", "change", 1, 2, ["", "int"], [450, Y(1), 50, 22]),
        nobj("obj-61", "t i b", 1, 2, ["int", "bang"], [450, Y(2), 45, 22]),
    ]
    lines = [
        line("obj-1", 0, "obj-10", 0), line("obj-2", 0, "obj-10", 1),
        line("obj-10", 0, "obj-11", 0), line("obj-10", 1, "obj-12", 0),
        line("obj-10", 2, "obj-13", 0), line("obj-10", 3, "obj-14", 0),
        line("obj-10", 4, "obj-15", 0),
        line("obj-3", 0, "obj-16", 1),
        # Channel: inlet -> change -> t i b -> (bang: panic, int: update obj-17)
        line("obj-4", 0, "obj-60", 0),
        line("obj-60", 0, "obj-61", 0),
        line("obj-61", 1, "obj-50", 0),            # bang (first) -> panic flush
        line("obj-61", 0, "obj-17", 1, 1),          # int -> cold (store first)
        line("obj-61", 0, "obj-17", 0, 0),          # int -> hot (trigger last)
        line("obj-17", 0, "obj-32", 6, 0), line("obj-17", 0, "obj-37", 6, 1),
        line("obj-17", 0, "obj-44", 6, 2), line("obj-17", 0, "obj-57", 6, 3),
        line("obj-17", 0, "obj-58", 6, 4),
        line("obj-11", 0, "obj-20", 0),
        line("obj-20", 2, "obj-15", 1),
        line("obj-20", 1, "obj-14", 1, 0), line("obj-20", 1, "obj-13", 1, 1),
        # outlet 0: velocity(2) fires first, note-on(1) second, legato(0) last
        line("obj-20", 0, "obj-16", 0, 2),
        line("obj-20", 0, "obj-21", 0, 1),
        line("obj-20", 0, "obj-23", 0, 0),
        line("obj-13", 0, "obj-21", 1), line("obj-14", 0, "obj-22", 1),
        line("obj-15", 0, "obj-23", 1),
        line("obj-21", 0, "obj-24", 0),
        line("obj-24", 1, "obj-25", 1, 0), line("obj-24", 1, "obj-51", 1, 1),
        line("obj-24", 0, "obj-30", 0),
        line("obj-16", 0, "obj-30", 1),
        line("obj-30", 0, "obj-31", 0), line("obj-31", 0, "obj-32", 0),
        line("obj-32", 0, "obj-90", 0, 5),
        line("obj-23", 0, "obj-33", 0),
        line("obj-33", 1, "obj-35", 0, 1), line("obj-33", 1, "obj-22", 0, 0),
        line("obj-22", 0, "obj-34", 0), line("obj-35", 0, "obj-34", 1),
        line("obj-34", 0, "obj-36", 0), line("obj-36", 0, "obj-37", 0),
        line("obj-37", 0, "obj-90", 0, 3),
        line("obj-12", 0, "obj-40", 0),
        line("obj-40", 1, "obj-42", 0), line("obj-40", 0, "obj-25", 0),
        line("obj-25", 0, "obj-41", 0), line("obj-42", 0, "obj-41", 1),
        line("obj-41", 0, "obj-43", 0), line("obj-43", 0, "obj-44", 0),
        line("obj-44", 0, "obj-90", 0, 4),
        line("obj-6", 0, "obj-50", 0),
        line("obj-50", 1, "obj-53", 0),
        line("obj-50", 1, "obj-51", 0, 0),
        line("obj-51", 0, "obj-52", 0), line("obj-53", 0, "obj-52", 1),
        line("obj-52", 0, "obj-55", 0), line("obj-55", 0, "obj-57", 0),
        line("obj-57", 0, "obj-90", 0, 2),
        line("obj-50", 0, "obj-54", 0),
        line("obj-54", 0, "obj-56", 0), line("obj-56", 0, "obj-58", 2),
        line("obj-58", 0, "obj-90", 0, 1),
        line("obj-5", 0, "obj-90", 0, 0),
    ]
    return {"fileversion": 1, "classnamespace": "box",
            "rect": [0, 0, 900, 700], "boxes": boxes, "lines": lines}


def transform(patch):
    root = patch["patcher"]

    # 1. Expand route to 21 outlets
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] == "obj-9":
            bx["text"] = ("route pitches_trk1 pitches_trk2 pulses_trk1 pulses_trk2 "
                          "gatetypes_trk1 gatetypes_trk2 "
                          "gatelength_trk1 gatelength_trk2 "
                          "gatescale_trk1 gatescale_trk2 "
                          "gatestretching_trk1 gatestretching_trk2 "
                          "pulsecountdiv_trk1 pulsecountdiv_trk2 "
                          "velocity_trk1 velocity_trk2 "
                          "gateoverrides_trk1 gateoverrides_trk2 "
                          "restpitch_trk1 restpitch_trk2")
            bx["numoutlets"] = 21
            bx["outlettype"] = [""] * 21
            print("  Route: 21 outlets")

    # 2. Remove replaced objects
    remove_ids = {"obj-17", "obj-117"}
    root["boxes"] = [b for b in root["boxes"] if b["box"]["id"] not in remove_ids]
    root["lines"] = [l for l in root["lines"]
                     if l["patchline"]["source"][0] not in remove_ids
                     and l["patchline"]["destination"][0] not in remove_ids]
    print("  Removed obj-17, obj-117")

    # 3. Expand SequencerCore 10->20 inlets
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] != "obj-30":
            continue
        bx["numinlets"] = 20
        sc = bx["patcher"]
        for bb in sc["boxes"]:
            sb = bb["box"]
            if sb["id"] == "obj-28":
                sb.update({"numinlets": 9, "text": "gen~ @title GateGenT1",
                           "patcher": build_gategen("T1"),
                           "saved_object_attributes": {"globalpatchername": ""}})
            if sb["id"] == "obj-58":
                sb.update({"numinlets": 9, "text": "gen~ @title GateGenT2",
                           "patcher": build_gategen("T2"),
                           "saved_object_attributes": {"globalpatchername": ""}})
        sc["boxes"].extend([
            inlet_box("obj-80", 11, [700, 30, 30, 30], "signal"),
            inlet_box("obj-81", 12, [740, 30, 30, 30], "signal"),
            inlet_box("obj-82", 13, [780, 30, 30, 30], "signal"),
            inlet_box("obj-83", 14, [820, 30, 30, 30], "signal"),
            inlet_box("obj-84", 15, [860, 30, 30, 30], "signal"),
            inlet_box("obj-85", 16, [900, 30, 30, 30], "signal"),
            inlet_box("obj-86", 17, [940, 30, 30, 30]),
            inlet_box("obj-87", 18, [980, 30, 30, 30]),
            inlet_box("obj-88", 19, [1020, 30, 30, 30]),
            inlet_box("obj-89", 20, [1060, 30, 30, 30]),
            nobj("obj-26", "stepfun~ @pattern -1 -1 -1 -1 -1 -1 -1 -1",
                 2, 1, ["signal"], [940, 150, 230, 22]),
            nobj("obj-56", "stepfun~ @pattern -1 -1 -1 -1 -1 -1 -1 -1",
                 2, 1, ["signal"], [940, 350, 230, 22]),
            nobj("obj-90", "stepfun~ @pattern 1 1 1 1 1 1 1 1",
                 2, 1, ["signal"], [1100, 150, 220, 22]),
            nobj("obj-91", "stepfun~ @pattern 1 1 1 1 1 1 1 1",
                 2, 1, ["signal"], [1100, 350, 220, 22]),
        ])
        sc["lines"].extend([
            line("obj-22", 0, "obj-26", 0, 5), line("obj-52", 0, "obj-56", 0, 5),
            line("obj-86", 0, "obj-26", 0), line("obj-87", 0, "obj-56", 0),
            line("obj-22", 0, "obj-90", 0, 4), line("obj-52", 0, "obj-91", 0, 4),
            line("obj-88", 0, "obj-90", 0), line("obj-89", 0, "obj-91", 0),
            line("obj-80", 0, "obj-28", 4), line("obj-82", 0, "obj-28", 5),
            line("obj-84", 0, "obj-28", 6), line("obj-26", 0, "obj-28", 7),
            line("obj-90", 0, "obj-28", 8),
            line("obj-81", 0, "obj-58", 4), line("obj-83", 0, "obj-58", 5),
            line("obj-85", 0, "obj-58", 6), line("obj-56", 0, "obj-58", 7),
            line("obj-91", 0, "obj-58", 8),
        ])
        print("  SequencerCore: 20 inlets")

    # 4. Rebuild Track1Output 5->6 inlets
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] == "obj-40":
            bx["numinlets"] = 6
            bx["patcher"] = build_track1_output()
            bx["saved_object_attributes"] = {"globalpatchername": ""}
            print("  Track1Output: rebuilt")

    # 5. Expand TransportStop to 2 outlets
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] == "obj-60":
            bx["numoutlets"] = 2
            bx["outlettype"] = ["int", "bang"]
            ts = bx["patcher"]
            ts["boxes"].append(outlet_box("obj-8", 2, [200, 300, 30, 30], "Panic"))
            for ll in ts["lines"]:
                pl = ll["patchline"]
                if pl["source"] == ["obj-4", 0] and pl["destination"] == ["obj-5", 0]:
                    pl["order"] = 1
            ts["lines"].append(line("obj-4", 0, "obj-8", 0, 0))
            print("  TransportStop: 2 outlets")

    # 6. Remove ALL old lines to/from obj-40 (Track1Output)
    root["lines"] = [l for l in root["lines"]
                     if l["patchline"]["destination"][0] != "obj-40"
                     and l["patchline"]["source"][0] != "obj-40"]

    # 7. Add root-level objects
    root["boxes"].extend([
        nobj("obj-200", "sig~ 0.5", 1, 1, ["signal"], [500, 300, 55, 22]),
        nobj("obj-201", "sig~ 0.5", 1, 1, ["signal"], [570, 300, 55, 22]),
        nobj("obj-202", "sig~ 1.0", 1, 1, ["signal"], [640, 300, 55, 22]),
        nobj("obj-203", "sig~ 1.0", 1, 1, ["signal"], [710, 300, 55, 22]),
        nobj("obj-204", "sig~ 0", 1, 1, ["signal"], [780, 300, 55, 22]),
        nobj("obj-205", "sig~ 0", 1, 1, ["signal"], [850, 300, 55, 22]),
        nobj("obj-206", "sig~ 1", 1, 1, ["signal"], [920, 300, 55, 22]),
        nobj("obj-207", "sig~ 1", 1, 1, ["signal"], [990, 300, 55, 22]),
        nobj("obj-208", "i 127", 2, 1, ["int"], [500, 250, 40, 22]),
        nobj("obj-209", "i 127", 2, 1, ["int"], [550, 250, 40, 22]),
        nobj("obj-210", "prepend pattern", 2, 1, [""], [940, 250, 100, 22]),
        nobj("obj-211", "prepend pattern", 2, 1, [""], [1050, 250, 100, 22]),
        nobj("obj-212", "prepend pattern", 2, 1, [""], [1160, 250, 100, 22]),
        nobj("obj-213", "prepend pattern", 2, 1, [""], [1270, 250, 100, 22]),
        nobj("obj-220", "prepend update_gate_length", 2, 1, [""], [500, 500, 140, 22]),
        nobj("obj-221", "append 0", 2, 1, [""], [500, 530, 55, 22]),
        nobj("obj-230", "prepend update_velocity", 2, 1, [""], [700, 500, 120, 22]),
        nobj("obj-231", "append 0", 2, 1, [""], [700, 530, 55, 22]),
        nobj("obj-232", "prepend update_gate_scale", 2, 1, [""], [500, 570, 130, 22]),
        nobj("obj-233", "append 0", 2, 1, [""], [500, 600, 55, 22]),
        nobj("obj-234", "prepend update_gate_stretching", 2, 1, [""], [700, 570, 150, 22]),
        nobj("obj-235", "append 0", 2, 1, [""], [700, 600, 55, 22]),
        nobj("obj-236", "prepend update_pulse_count_div", 2, 1, [""], [500, 640, 150, 22]),
        nobj("obj-237", "append 0", 2, 1, [""], [500, 670, 55, 22]),
    ])

    # UI controls
    def live_menu_box(id, varname, enum, rect, initial=0, shortname=None):
        return {"box": {"id": id, "maxclass": "live.menu",
                "numinlets": 1, "numoutlets": 3, "outlettype": ["", "", "float"],
                "parameter_enable": 1, "patching_rect": rect,
                "presentation": 1, "presentation_rect": rect, "varname": varname,
                "saved_attribute_attributes": {"valueof": {
                    "parameter_longname": varname, "parameter_shortname": shortname or varname,
                    "parameter_type": 2, "parameter_enum": enum,
                    "parameter_initial_enable": 1, "parameter_initial": [float(initial)],
                    "parameter_linknames": 1}}}}

    def live_dial_box(id, varname, mmin, mmax, rect, initial=None, shortname=None):
        if initial is None: initial = mmin
        return {"box": {"id": id, "maxclass": "live.dial",
                "numinlets": 1, "numoutlets": 2, "outlettype": ["", "float"],
                "parameter_enable": 1, "patching_rect": rect,
                "presentation": 1, "presentation_rect": rect, "varname": varname,
                "saved_attribute_attributes": {"valueof": {
                    "parameter_longname": varname, "parameter_shortname": shortname or varname,
                    "parameter_type": 1, "parameter_mmin": float(mmin), "parameter_mmax": float(mmax),
                    "parameter_initial_enable": 1, "parameter_initial": [float(initial)],
                    "parameter_linknames": 1}}}}

    def live_toggle_box(id, varname, rect, initial=0, shortname=None):
        return {"box": {"id": id, "maxclass": "live.toggle",
                "numinlets": 1, "numoutlets": 1, "outlettype": [""],
                "parameter_enable": 1, "patching_rect": rect,
                "presentation": 1, "presentation_rect": rect, "varname": varname,
                "saved_attribute_attributes": {"valueof": {
                    "parameter_longname": varname, "parameter_shortname": shortname or varname,
                    "parameter_type": 2, "parameter_enum": ["Off", "On"],
                    "parameter_initial_enable": 1, "parameter_initial": [float(initial)],
                    "parameter_linknames": 1}}}}

    root["boxes"].extend([
        live_menu_box("obj-130", "Velocity", ["50%", "75%", "100%", "Track CV"],
                      [700, 450, 80, 22], initial=2, shortname="Vel"),
        live_dial_box("obj-131", "Gate Scale", 1, 200,
                      [500, 450, 44, 48], initial=100, shortname="G.Scale"),
        live_toggle_box("obj-132", "Gate Stretch",
                        [600, 450, 20, 20], initial=0, shortname="G.Str"),
        live_dial_box("obj-133", "Pulse Count Div", 1, 8,
                      [650, 450, 44, 48], initial=1, shortname="PC Div"),
    ])

    # 8. Add root connections
    # Add order to existing route->prepend seq lines (now fan out to 2 targets)
    for ll in root["lines"]:
        pl = ll["patchline"]
        if pl["source"] == ["obj-9", 2] and pl["destination"][0] == "obj-13":
            pl["order"] = 1
        if pl["source"] == ["obj-9", 3] and pl["destination"][0] == "obj-14":
            pl["order"] = 1

    root["lines"].extend([
        # Route Stage 2 -> sig~ converters
        line("obj-9", 6, "obj-200", 0), line("obj-9", 7, "obj-201", 0),
        line("obj-9", 8, "obj-202", 0), line("obj-9", 9, "obj-203", 0),
        line("obj-9", 10, "obj-204", 0), line("obj-9", 11, "obj-205", 0),
        line("obj-9", 12, "obj-206", 0), line("obj-9", 13, "obj-207", 0),
        line("obj-9", 14, "obj-208", 1), line("obj-9", 15, "obj-209", 1),
        line("obj-9", 16, "obj-210", 0), line("obj-9", 17, "obj-211", 0),
        # Pulse count patterns also to new prepend pattern objects
        line("obj-9", 2, "obj-212", 0, 0), line("obj-9", 3, "obj-213", 0, 0),

        # sig~ -> SequencerCore new inlets
        line("obj-200", 0, "obj-30", 8), line("obj-201", 0, "obj-30", 9),
        line("obj-202", 0, "obj-30", 10), line("obj-203", 0, "obj-30", 11),
        line("obj-204", 0, "obj-30", 12), line("obj-205", 0, "obj-30", 13),
        line("obj-206", 0, "obj-30", 14), line("obj-207", 0, "obj-30", 15),
        line("obj-210", 0, "obj-30", 16), line("obj-211", 0, "obj-30", 17),
        line("obj-212", 0, "obj-30", 18), line("obj-213", 0, "obj-30", 19),

        # Track1Output connections
        line("obj-30", 0, "obj-40", 0),   # pitch
        line("obj-30", 1, "obj-40", 1),   # gate
        line("obj-208", 0, "obj-40", 2),  # velocity
        line("obj-18", 0, "obj-40", 3),   # channel
        line("obj-3", 0, "obj-40", 4),    # MIDI thru
        line("obj-60", 1, "obj-40", 5),   # panic
        line("obj-40", 0, "obj-4", 0, 1), # Track1Output -> midiout

        # Gate Length UI -> config-manager
        line("obj-115", 0, "obj-220", 0),
        line("obj-220", 0, "obj-221", 0),
        line("obj-110", 0, "obj-221", 1, 6),
        line("obj-221", 0, "obj-8", 0),

        # Velocity menu -> config-manager
        line("obj-130", 0, "obj-230", 0),
        line("obj-230", 0, "obj-231", 0),
        line("obj-110", 0, "obj-231", 1, 5),
        line("obj-231", 0, "obj-8", 0),

        # Gate Scale -> config-manager
        line("obj-131", 0, "obj-232", 0),
        line("obj-232", 0, "obj-233", 0),
        line("obj-110", 0, "obj-233", 1, 4),
        line("obj-233", 0, "obj-8", 0),

        # Gate Stretching -> config-manager
        line("obj-132", 0, "obj-234", 0),
        line("obj-234", 0, "obj-235", 0),
        line("obj-110", 0, "obj-235", 1, 3),
        line("obj-235", 0, "obj-8", 0),

        # Pulse Count Div -> config-manager
        line("obj-133", 0, "obj-236", 0),
        line("obj-236", 0, "obj-237", 0),
        line("obj-110", 0, "obj-237", 1, 2),
        line("obj-237", 0, "obj-8", 0),
    ])

    # Fix obj-110 fan-out orders for existing connections (from Phase 1)
    # obj-110 already connects to obj-118[1], obj-122[1], obj-123[1]
    for ll in root["lines"]:
        pl = ll["patchline"]
        if pl["source"] == ["obj-110", 0]:
            dst = pl["destination"]
            if dst == ["obj-118", 1]:
                pl["order"] = 9
            elif dst == ["obj-122", 1]:
                pl["order"] = 8
            elif dst == ["obj-123", 1]:
                pl["order"] = 7

    print("  Root routing complete")
    return patch


def main():
    print("Building Metropolix Stage 2...")
    with open(PATCH_PATH) as f:
        patch = json.load(f)
    patch = transform(patch)
    with open(PATCH_PATH, "w") as f:
        json.dump(patch, f, indent=2)
    print(f"\nWrote {PATCH_PATH}")


if __name__ == "__main__":
    main()

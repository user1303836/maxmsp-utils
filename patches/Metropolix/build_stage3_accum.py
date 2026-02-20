#!/usr/bin/env python3
"""
Metropolix Stage 3 Accumulator Build Script
Adds accumulator system to the patch:
- Accumulator gen.codebox~ inside SequencerCore
- New stepfun~ for accum values and triggers
- Accum config routing from route -> sig~ -> SequencerCore
"""

import json

PATCH_PATH = "Metropolix.maxpat"

ACCUM_CODE = """\
// Accumulator State Machine
// in1=stepcounter  in2=gate signal  in3=accum value (from stepfun~)
// in4=accum trigger (0=Stage,1=Pulse,2=Ratchet)
// in5=accum mode (0=Stage,1=Track)  in6=accum order (0=Wrap,1=Pend,2=Rand,3=Hold)
// in7=accum polarity (0=Uni,1=Bi)  in8=limit+  in9=limit-
// in10=reset trigger  in11=gate type (0=Rest,1=Single,2=Multi,3=Hold)
// out1=accumulated degree offset

Data accum_degrees(8);
History track_accum(0);
Data accum_dir(8);
History track_dir(1);
History prev_counter(-1);
History prev_gate(0);
History rng_state(54321);

rng_state = (rng_state * 1103515245 + 12345) % 2147483648;
rng = abs(rng_state) / 2147483647.0;

counter = in1;
gate = in2 >= 0.5;
accum_val = floor(in3);
accum_trigger = floor(in4);
accum_mode = floor(in5);
accum_order = floor(in6);
accum_polarity = floor(in7);
limit_pos = max(floor(in8), 1);
limit_neg = max(floor(in9), 1);
reset_trig = in10 >= 0.5;
gate_type = floor(in11);

lo_limit = 0;
hi_limit = limit_pos;
if (accum_polarity > 0.5) {
    lo_limit = -limit_neg;
}

new_stage = (counter != prev_counter);
gate_rise = (gate && !prev_gate);

if (reset_trig) {
    for (i = 0; i < 8; i += 1) {
        poke(accum_degrees, 0, i);
        poke(accum_dir, 1, i);
    }
    track_accum = 0;
    track_dir = 1;
}

should_accum = 0;
if (gate_type > 0.5) {
    if (accum_trigger < 0.5) {
        should_accum = new_stage;
    } else if (accum_trigger < 1.5) {
        if (gate_type > 2.5) { should_accum = new_stage; }
        else if (gate_type < 1.5) { should_accum = new_stage; }
        else { should_accum = gate_rise; }
    } else {
        if (gate_type > 2.5) { should_accum = new_stage; }
        else { should_accum = gate_rise; }
    }
}

stage_idx = clamp(floor(counter) % 8, 0, 7);

if (should_accum && abs(accum_val) > 0) {
    current = 0; dir = 1;
    if (accum_mode < 0.5) {
        current = peek(accum_degrees, stage_idx);
        dir = peek(accum_dir, stage_idx);
    } else {
        current = track_accum; dir = track_dir;
    }

    new_val = current;
    if (accum_order < 0.5) {
        new_val = current + accum_val * dir;
        if (new_val > hi_limit) { new_val = lo_limit + (new_val - hi_limit - 1); }
        if (new_val < lo_limit) { new_val = hi_limit - (lo_limit - new_val - 1); }
        new_val = clamp(new_val, lo_limit, hi_limit);
    } else if (accum_order < 1.5) {
        new_val = current + accum_val * dir;
        if (new_val > hi_limit) { new_val = hi_limit - (new_val - hi_limit); dir = -1; }
        if (new_val < lo_limit) { new_val = lo_limit + (lo_limit - new_val); dir = 1; }
        new_val = clamp(new_val, lo_limit, hi_limit);
    } else if (accum_order < 2.5) {
        rand_step = 0;
        if (rng < 0.5) { rand_step = accum_val; }
        else if (rng < 0.8) { rand_step = -accum_val; }
        mag = max(1, abs(rand_step));
        if (mag > 1) { mag = ceil(rng * mag); }
        if (rand_step < 0) { mag = -mag; }
        new_val = clamp(current + mag, lo_limit, hi_limit);
    } else {
        new_val = clamp(current + accum_val * dir, lo_limit, hi_limit);
    }

    if (accum_mode < 0.5) {
        poke(accum_degrees, new_val, stage_idx);
        poke(accum_dir, dir, stage_idx);
    } else {
        track_accum = new_val; track_dir = dir;
    }
}

accum_out = 0;
if (accum_mode < 0.5) {
    accum_out = peek(accum_degrees, stage_idx);
} else {
    accum_out = track_accum;
}

prev_counter = counter;
prev_gate = gate;
out1 = accum_out;
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

def line(src_id, src_out, dst_id, dst_in, order=None):
    pl = {"source": [src_id, src_out], "destination": [dst_id, dst_in]}
    if order is not None:
        pl["order"] = order
    return {"patchline": pl}


def build_accum_gen():
    return {
        "fileversion": 1, "classnamespace": "dsp.gen",
        "rect": [0, 0, 800, 500],
        "boxes": [
            nobj("obj-1", "in 1", 0, 1, [""], [30, 30, 30, 22]),
            nobj("obj-2", "in 2", 0, 1, [""], [80, 30, 30, 22]),
            nobj("obj-3", "in 3", 0, 1, [""], [130, 30, 30, 22]),
            nobj("obj-4", "in 4", 0, 1, [""], [180, 30, 30, 22]),
            nobj("obj-5", "in 5", 0, 1, [""], [230, 30, 30, 22]),
            nobj("obj-6", "in 6", 0, 1, [""], [280, 30, 30, 22]),
            nobj("obj-7", "in 7", 0, 1, [""], [330, 30, 30, 22]),
            nobj("obj-8", "in 8", 0, 1, [""], [380, 30, 30, 22]),
            nobj("obj-9", "in 9", 0, 1, [""], [430, 30, 30, 22]),
            nobj("obj-10", "in 10", 0, 1, [""], [480, 30, 30, 22]),
            nobj("obj-11", "in 11", 0, 1, [""], [530, 30, 30, 22]),
            {"box": {"id": "obj-20", "maxclass": "newobj", "text": "codebox",
                     "numinlets": 11, "numoutlets": 1, "outlettype": [""],
                     "patching_rect": [30, 100, 550, 300], "code": ACCUM_CODE}},
            nobj("obj-30", "out 1", 1, 0, [], [250, 430, 35, 22]),
        ],
        "lines": [
            line("obj-1", 0, "obj-20", 0), line("obj-2", 0, "obj-20", 1),
            line("obj-3", 0, "obj-20", 2), line("obj-4", 0, "obj-20", 3),
            line("obj-5", 0, "obj-20", 4), line("obj-6", 0, "obj-20", 5),
            line("obj-7", 0, "obj-20", 6), line("obj-8", 0, "obj-20", 7),
            line("obj-9", 0, "obj-20", 8), line("obj-10", 0, "obj-20", 9),
            line("obj-11", 0, "obj-20", 10), line("obj-20", 0, "obj-30", 0),
        ]
    }


def transform(patch):
    root = patch["patcher"]

    # 1. Add root-level objects for accumulator routing
    root["boxes"].extend([
        # Unpack accumconfig_trk1 (6 values: limit+, limit-, mode, order, polarity, reset)
        nobj("obj-340", "unpack 7 7 0 0 0 0", 1, 6,
             ["int", "int", "int", "int", "int", "int"], [30, 880, 200, 22]),
        # sig~ for each accumconfig value
        nobj("obj-341", "sig~ 0", 1, 1, ["signal"], [30, 920, 45, 22]),   # mode
        nobj("obj-342", "sig~ 0", 1, 1, ["signal"], [80, 920, 45, 22]),   # order
        nobj("obj-343", "sig~ 0", 1, 1, ["signal"], [130, 920, 45, 22]),  # polarity
        nobj("obj-344", "sig~ 7", 1, 1, ["signal"], [180, 920, 45, 22]),  # limit+
        nobj("obj-345", "sig~ 7", 1, 1, ["signal"], [230, 920, 45, 22]),  # limit-
        nobj("obj-346", "sig~ 0", 1, 1, ["signal"], [280, 920, 45, 22]),  # reset

        # Prepend pattern for accum arrays
        nobj("obj-350", "prepend pattern", 2, 1, [""], [450, 880, 100, 22]),
        nobj("obj-351", "prepend pattern", 2, 1, [""], [560, 880, 100, 22]),
        nobj("obj-352", "prepend pattern", 2, 1, [""], [670, 880, 100, 22]),
        nobj("obj-353", "prepend pattern", 2, 1, [""], [780, 880, 100, 22]),
    ])

    # Route -> accum config
    root["lines"].extend([
        line("obj-9", 38, "obj-340", 0),   # accumconfig_trk1
        line("obj-340", 2, "obj-341", 0),   # mode
        line("obj-340", 3, "obj-342", 0),   # order
        line("obj-340", 4, "obj-343", 0),   # polarity
        line("obj-340", 0, "obj-344", 0),   # limit+
        line("obj-340", 1, "obj-345", 0),   # limit-
        line("obj-340", 5, "obj-346", 0),   # reset

        # Route -> prepend pattern for accum arrays
        line("obj-9", 34, "obj-350", 0),    # accumvalues_trk1
        line("obj-9", 35, "obj-351", 0),    # accumvalues_trk2
        line("obj-9", 36, "obj-352", 0),    # accumtriggers_trk1
        line("obj-9", 37, "obj-353", 0),    # accumtriggers_trk2
    ])

    # 2. Expand SequencerCore with accumulator internals
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] != "obj-30":
            continue
        sc = bx["patcher"]

        bx["numinlets"] = 40
        bx["numoutlets"] = 12
        bx["outlettype"] = ["signal", "signal", "", "signal", "signal", "",
                            "signal", "signal", "signal", "signal", "signal", "signal"]

        y = 800
        sc["boxes"].extend([
            # Inlets for accum patterns (31-34)
            inlet_box("obj-130", 31, [30, y, 30, 30], comment="AccumValues T1"),
            inlet_box("obj-131", 32, [70, y, 30, 30], comment="AccumValues T2"),
            inlet_box("obj-132", 33, [110, y, 30, 30], comment="AccumTriggers T1"),
            inlet_box("obj-133", 34, [150, y, 30, 30], comment="AccumTriggers T2"),
            # Inlets for accum config signals (35-40)
            inlet_box("obj-134", 35, [200, y, 30, 30], "signal", "AccumMode T1"),
            inlet_box("obj-135", 36, [240, y, 30, 30], "signal", "AccumOrder T1"),
            inlet_box("obj-136", 37, [280, y, 30, 30], "signal", "AccumPolarity T1"),
            inlet_box("obj-137", 38, [320, y, 30, 30], "signal", "AccumLimitPos T1"),
            inlet_box("obj-138", 39, [360, y, 30, 30], "signal", "AccumLimitNeg T1"),
            inlet_box("obj-139", 40, [400, y, 30, 30], "signal", "AccumReset T1"),

            # Stepfun~ for accum values
            nobj("obj-140", "stepfun~ @pattern 0 0 0 0 0 0 0 0",
                 2, 1, ["signal"], [30, y+80, 230, 22]),
            nobj("obj-141", "stepfun~ @pattern 0 0 0 0 0 0 0 0",
                 2, 1, ["signal"], [30, y+140, 230, 22]),
            # Stepfun~ for accum triggers
            nobj("obj-142", "stepfun~ @pattern 0 0 0 0 0 0 0 0",
                 2, 1, ["signal"], [280, y+80, 230, 22]),
            nobj("obj-143", "stepfun~ @pattern 0 0 0 0 0 0 0 0",
                 2, 1, ["signal"], [280, y+140, 230, 22]),

            # Accumulator gen~ T1
            {"box": {"id": "obj-150", "maxclass": "newobj",
                     "text": "gen~ @title AccumT1",
                     "numinlets": 11, "numoutlets": 1, "outlettype": ["signal"],
                     "patching_rect": [30, y+220, 250, 22],
                     "patcher": build_accum_gen(),
                     "saved_object_attributes": {"globalpatchername": ""}}},
            # Accumulator gen~ T2
            {"box": {"id": "obj-151", "maxclass": "newobj",
                     "text": "gen~ @title AccumT2",
                     "numinlets": 11, "numoutlets": 1, "outlettype": ["signal"],
                     "patching_rect": [350, y+220, 250, 22],
                     "patcher": build_accum_gen(),
                     "saved_object_attributes": {"globalpatchername": ""}}},

            # Outlets for accum degree offsets
            outlet_box("obj-144", 11, [530, y+300, 30, 30], "AccumDeg T1"),
            outlet_box("obj-145", 12, [570, y+300, 30, 30], "AccumDeg T2"),
        ])

        sc["lines"].extend([
            # Accum values stepfun~ wiring
            line("obj-22", 0, "obj-140", 0, 10),
            line("obj-52", 0, "obj-141", 0, 10),
            line("obj-130", 0, "obj-140", 0),
            line("obj-131", 0, "obj-141", 0),

            # Accum triggers stepfun~
            line("obj-22", 0, "obj-142", 0, 11),
            line("obj-52", 0, "obj-143", 0, 11),
            line("obj-132", 0, "obj-142", 0),
            line("obj-133", 0, "obj-143", 0),

            # AccumT1 inputs
            line("obj-20", 0, "obj-150", 0, 3),   # stepcounter T1
            line("obj-28", 0, "obj-150", 1),       # gate T1
            line("obj-140", 0, "obj-150", 2),      # accum value
            line("obj-142", 0, "obj-150", 3),      # accum trigger
            line("obj-134", 0, "obj-150", 4),      # mode
            line("obj-135", 0, "obj-150", 5),      # order
            line("obj-136", 0, "obj-150", 6),      # polarity
            line("obj-137", 0, "obj-150", 7),      # limit+
            line("obj-138", 0, "obj-150", 8),      # limit-
            line("obj-139", 0, "obj-150", 9),      # reset
            line("obj-25", 0, "obj-150", 10),      # gate type T1

            # AccumT2 inputs (reuse same config for now — TRK2 accum config
            # will be separate in full implementation, uses same signals for v1)
            line("obj-50", 0, "obj-151", 0, 3),   # stepcounter T2
            line("obj-58", 0, "obj-151", 1),       # gate T2
            line("obj-141", 0, "obj-151", 2),      # accum value T2
            line("obj-143", 0, "obj-151", 3),      # accum trigger T2
            line("obj-134", 0, "obj-151", 4),      # mode (shared for now)
            line("obj-135", 0, "obj-151", 5),      # order
            line("obj-136", 0, "obj-151", 6),      # polarity
            line("obj-137", 0, "obj-151", 7),      # limit+
            line("obj-138", 0, "obj-151", 8),      # limit-
            line("obj-139", 0, "obj-151", 9),      # reset
            line("obj-55", 0, "obj-151", 10),      # gate type T2

            # Outputs
            line("obj-150", 0, "obj-144", 0),
            line("obj-151", 0, "obj-145", 0),
        ])

        print(f"  SequencerCore: {bx['numinlets']} in, {bx['numoutlets']} out")

    # Wire root: prepend pattern -> SequencerCore inlets 30-33
    # sig~ config -> SequencerCore inlets 34-39
    root["lines"].extend([
        line("obj-350", 0, "obj-30", 30),
        line("obj-351", 0, "obj-30", 31),
        line("obj-352", 0, "obj-30", 32),
        line("obj-353", 0, "obj-30", 33),
        line("obj-341", 0, "obj-30", 34),
        line("obj-342", 0, "obj-30", 35),
        line("obj-343", 0, "obj-30", 36),
        line("obj-344", 0, "obj-30", 37),
        line("obj-345", 0, "obj-30", 38),
        line("obj-346", 0, "obj-30", 39),
    ])

    print("  Root routing for accumulator complete")
    return patch


def main():
    print("Building Metropolix Stage 3 Accumulator...")
    with open(PATCH_PATH) as f:
        patch = json.load(f)
    patch = transform(patch)
    with open(PATCH_PATH, "w") as f:
        json.dump(patch, f, indent=2)
    print(f"\nWrote {PATCH_PATH}")


if __name__ == "__main__":
    main()

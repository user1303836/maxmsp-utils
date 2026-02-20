#!/usr/bin/env python3
"""
Metropolix Stage 3 Build Script
Transforms Stage 2 patch -> Stage 3 with:
- GateGen expanded to 12 inputs (adds ratchet count, ratchet mode, probability, prob target)
- Route expanded to handle all Stage 3 messages
- SequencerCore expanded with new stepfun~ for ratchets, probability, slide toggles
- New SequencerCore outlets for slide toggle signal
- Slide amount/type routed through new signal path
"""

import json, sys

PATCH_PATH = "Metropolix.maxpat"

# ============================================================
# GateGen codebox code (12 inputs, 1 output)
# Adds ratcheting (3 modes) and probability
# ============================================================
GATEGEN_CODE = """\
// Full gate generator - Stage 3
// in1=step phasor  in2=gate type(0-3)  in3=gate length(0.01-1.0)
// in4=stepcounter  in5=gate scale(0.01-2.0)  in6=gate stretching(0/1)
// in7=pulse count div(1-8)  in8=gate override(-1=OFF, 0=Rest, 0.01-1.0)
// in9=pulse count for current stage (1-8)
// in10=ratchet count (1-8)  in11=ratchet mode (0=Multiply, 1=Pulse, 2=Gated)
// in12=probability (0.0-1.0)  in13=prob target (0=Stage, 1=Pulse)
//
// Gate types: 0=Rest, 1=Single, 2=Multi, 3=Hold
// Gate override encoding: -1=OFF (use track gate), 0=Rest, 0.01-0.99=%, 1.0=Hold

History prev_counter(-1);
History pulse_in_stage(0);
History stage_prob_pass(1);
History rng_state(12345);

// Simple LCG PRNG (deterministic per sample)
rng_state = (rng_state * 1103515245 + 12345) % 2147483648;
rng_val = abs(rng_state) / 2147483647.0;

phasor = in1;
gt = in2;
raw_gl = clamp(in3, 0.01, 1.0);
counter = in4;
gscale = clamp(in5, 0.01, 2.0);
stretching = in6 >= 0.5;
pcdiv = max(floor(in7), 1);
gate_ovr = in8;
total_pulses = max(floor(in9), 1);
ratchet_count = max(floor(in10), 1);
ratchet_mode = floor(in11);
prob = clamp(in12, 0.0, 1.0);
prob_target = floor(in13);

// Detect stage boundary and pulse boundary
new_stage = (counter != prev_counter);
new_pulse = phasor < 0.01;
if (new_stage) {
    pulse_in_stage = 0;
    // Stage probability: roll once on stage entry
    if (prob_target < 0.5) {
        stage_prob_pass = rng_val < prob;
    } else {
        stage_prob_pass = 1;
    }
} else if (new_pulse) {
    pulse_in_stage = pulse_in_stage + 1;
}
prev_counter = counter;

// Pulse probability: roll each pulse, latched across full pulse window
History h_pulse_prob_pass(1);
if (prob_target >= 0.5 && new_pulse) {
    h_pulse_prob_pass = rng_val <= prob;
} else if (new_stage) {
    h_pulse_prob_pass = 1;  // reset on new stage
}
pulse_prob_pass = h_pulse_prob_pass;

// Combined probability check
prob_pass = stage_prob_pass;
if (prob_target >= 0.5) {
    prob_pass = pulse_prob_pass;
}

// Gate override: replaces track gate length when active
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

// Apply gate scale
gl = clamp(eff_gl * gscale, 0.01, 1.0);

// Helper: compute ratchet sub-gate from a phase and count
// Returns 1 if within a ratchet sub-gate, 0 otherwise
// ratch_phase is 0..1 over the ratchet period, ratch_n is count
// Each sub-gate gets gl fraction of its sub-period

// === GATE GENERATION ===
gate = 0;

if (gt < 0.5) {
    // Rest: no gate
    gate = 0;

} else if (gt < 1.5) {
    // Single: gate on first pulse only
    if (stretching) {
        // Gate Stretching ON
        stage_pos = (pulse_in_stage + phasor) / total_pulses;
        trunc = 1.0 - (1.0 / (96.0 * total_pulses));
        stretched_gl = min(gl, trunc);

        if (ratchet_count > 1 && ratchet_mode < 0.5) {
            // Multiply: ratchets span entire stage
            sub_phase = fract(stage_pos * ratchet_count);
            gate = sub_phase < gl && stage_pos < trunc;
        } else if (ratchet_count > 1 && ratchet_mode < 1.5) {
            // Pulse: ratchets within first pulse only
            if (pulse_in_stage < 0.5) {
                sub_phase = fract(phasor * ratchet_count);
                gate = sub_phase < gl;
            }
        } else if (ratchet_count > 1 && ratchet_mode < 2.5) {
            // Gated: ratchets within first pulse, cut by gate length
            if (pulse_in_stage < 0.5) {
                sub_phase = fract(phasor * ratchet_count);
                gate = sub_phase < gl && phasor < stretched_gl * total_pulses;
            }
        } else {
            gate = stage_pos < stretched_gl;
        }
    } else {
        // Gate Stretching OFF
        if (pulse_in_stage < 0.5) {
            if (ratchet_count > 1) {
                sub_phase = fract(phasor * ratchet_count);
                gate = sub_phase < gl;
            } else {
                gate = phasor < gl;
            }
        }
    }

} else if (gt < 2.5) {
    // Multi with pulse count division
    if (stretching) {
        stage_pos = (pulse_in_stage + phasor) / total_pulses;
        trunc = 1.0 - (1.0 / (96.0 * total_pulses));

        if (pcdiv < 1.5) {
            if (ratchet_count > 1 && ratchet_mode < 0.5) {
                sub_phase = fract(stage_pos * ratchet_count);
                gate = sub_phase < gl && stage_pos < trunc;
            } else if (ratchet_count > 1 && ratchet_mode < 1.5) {
                sub_phase = fract(phasor * ratchet_count);
                gate = sub_phase < gl;
            } else if (ratchet_count > 1 && ratchet_mode < 2.5) {
                stretched_gl = min(gl, trunc);
                sub_phase = fract(phasor * ratchet_count);
                gate = sub_phase < gl && stage_pos < stretched_gl;
            } else {
                gate = stage_pos < min(gl, trunc);
            }
        } else {
            group_idx = floor(pulse_in_stage / pcdiv);
            group_start = group_idx * pcdiv;
            remaining = total_pulses - group_start;
            group_size = min(pcdiv, remaining);
            group_pos_in = pulse_in_stage - group_start;
            group_frac = (group_pos_in + phasor) / group_size;
            group_trunc = 1.0 - (1.0 / (96.0 * group_size));

            if (ratchet_count > 1) {
                // Ratchets within each group
                sub_phase = fract(group_frac * ratchet_count);
                gate = sub_phase < gl && group_frac < group_trunc;
            } else {
                gate = group_frac < min(gl, group_trunc);
            }
        }
    } else {
        // Gate Stretching OFF
        if (pcdiv < 1.5) {
            if (ratchet_count > 1) {
                sub_phase = fract(phasor * ratchet_count);
                gate = sub_phase < gl;
            } else {
                gate = phasor < gl;
            }
        } else {
            group_idx = floor(pulse_in_stage / pcdiv);
            group_start = group_idx * pcdiv;
            remaining = total_pulses - group_start;
            group_size = min(pcdiv, remaining);
            group_pos = pulse_in_stage - group_start;
            if (group_pos >= group_size - 1) {
                // Last pulse in group: apply gate length
                if (ratchet_count > 1) {
                    sub_phase = fract(phasor * ratchet_count);
                    gate = sub_phase < gl;
                } else {
                    gate = phasor < gl;
                }
            } else {
                // Interior pulse: gate is full on
                if (ratchet_count > 1) {
                    sub_phase = fract(phasor * ratchet_count);
                    gate = sub_phase < gl;
                } else {
                    gate = 1;
                }
            }
        }
    }

} else {
    // Hold: always on (legato)
    gate = 1;
}

// Apply probability
if (!prob_pass) {
    gate = 0;
}

out1 = gate;
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
    """Build GateGen gen~ patcher with 13 inputs (ratchets + probability)."""
    return {
        "fileversion": 1, "classnamespace": "dsp.gen",
        "rect": [0, 0, 800, 400],
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
            nobj("obj-10", "in 10", 0, 1, [""], [570, 30, 30, 22]),
            nobj("obj-11", "in 11", 0, 1, [""], [630, 30, 30, 22]),
            nobj("obj-12", "in 12", 0, 1, [""], [690, 30, 30, 22]),
            nobj("obj-13", "in 13", 0, 1, [""], [750, 30, 30, 22]),
            {"box": {"id": "obj-20", "maxclass": "newobj", "text": "codebox",
                     "numinlets": 13, "numoutlets": 1, "outlettype": [""],
                     "patching_rect": [30, 120, 740, 200], "code": GATEGEN_CODE}},
            nobj("obj-30", "out 1", 1, 0, [], [350, 350, 35, 22]),
        ],
        "lines": [
            line("obj-1", 0, "obj-20", 0), line("obj-2", 0, "obj-20", 1),
            line("obj-3", 0, "obj-20", 2), line("obj-4", 0, "obj-20", 3),
            line("obj-5", 0, "obj-20", 4), line("obj-6", 0, "obj-20", 5),
            line("obj-7", 0, "obj-20", 6), line("obj-8", 0, "obj-20", 7),
            line("obj-9", 0, "obj-20", 8), line("obj-10", 0, "obj-20", 9),
            line("obj-11", 0, "obj-20", 10), line("obj-12", 0, "obj-20", 11),
            line("obj-13", 0, "obj-20", 12), line("obj-20", 0, "obj-30", 0),
        ]
    }


def transform(patch):
    root = patch["patcher"]

    # ======================================================================
    # 1. Expand route to handle Stage 3 messages
    # ======================================================================
    # New messages from config-manager.js:
    # ratchets_trk1/trk2, probability_trk1/trk2, probtarget_trk1/trk2,
    # slidetoggles_trk1/trk2, slideamount_trk1/trk2, slidetype_trk1/trk2,
    # ratchetmode_trk1/trk2, accumvalues_trk1/trk2, accumtriggers_trk1/trk2,
    # accumconfig_trk1/trk2, degreelut_trk1/trk2

    stage2_routes = ("pitches_trk1 pitches_trk2 pulses_trk1 pulses_trk2 "
                     "gatetypes_trk1 gatetypes_trk2 "
                     "gatelength_trk1 gatelength_trk2 "
                     "gatescale_trk1 gatescale_trk2 "
                     "gatestretching_trk1 gatestretching_trk2 "
                     "pulsecountdiv_trk1 pulsecountdiv_trk2 "
                     "velocity_trk1 velocity_trk2 "
                     "gateoverrides_trk1 gateoverrides_trk2 "
                     "restpitch_trk1 restpitch_trk2")
    stage3_routes = ("ratchets_trk1 ratchets_trk2 "
                     "probability_trk1 probability_trk2 "
                     "probtarget_trk1 probtarget_trk2 "
                     "slidetoggles_trk1 slidetoggles_trk2 "
                     "slideamount_trk1 slideamount_trk2 "
                     "slidetype_trk1 slidetype_trk2 "
                     "ratchetmode_trk1 ratchetmode_trk2 "
                     "accumvalues_trk1 accumvalues_trk2 "
                     "accumtriggers_trk1 accumtriggers_trk2 "
                     "accumconfig_trk1 accumconfig_trk2 "
                     "degreelut_trk1 degreelut_trk2 "
                     "scalenames")

    all_routes = stage2_routes + " " + stage3_routes
    route_count = len(all_routes.split()) + 1  # +1 for pass-through outlet

    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] == "obj-9":
            bx["text"] = "route " + all_routes
            bx["numoutlets"] = route_count
            bx["outlettype"] = [""] * route_count
            print(f"  Route: {route_count} outlets ({len(all_routes.split())} routes + pass-through)")

    # ======================================================================
    # 2. Rebuild GateGen with 13 inputs (was 9)
    # ======================================================================
    # New inputs: in10=ratchet count, in11=ratchet mode,
    #             in12=probability, in13=prob target
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] != "obj-30":
            continue
        sc = bx["patcher"]
        for bb in sc["boxes"]:
            sb = bb["box"]
            if sb["id"] == "obj-28":
                sb.update({"numinlets": 13, "text": "gen~ @title GateGenT1",
                           "patcher": build_gategen("T1"),
                           "saved_object_attributes": {"globalpatchername": ""}})
                print("  GateGenT1: rebuilt with 13 inputs")
            if sb["id"] == "obj-58":
                sb.update({"numinlets": 13, "text": "gen~ @title GateGenT2",
                           "patcher": build_gategen("T2"),
                           "saved_object_attributes": {"globalpatchername": ""}})
                print("  GateGenT2: rebuilt with 13 inputs")

        # ======================================================================
        # 3. Add new stepfun~ objects and inlets to SequencerCore
        # ======================================================================
        # Currently 20 inlets. Adding:
        # 21-22: ratchets pattern (trk1/trk2)
        # 23-24: probability pattern (trk1/trk2)
        # 25-26: prob target pattern (trk1/trk2)
        # 27-28: slide toggle pattern (trk1/trk2)
        # 29-30: ratchet mode (trk1/trk2) - single value, not pattern
        # 31-32: slide amount (trk1/trk2) - single value signal
        # 33-34: slide type (trk1/trk2) - single value signal

        bx["numinlets"] = 34

        # Add new outlets for slide toggle signals
        # Current outlets: 1-8 (pitch1, gate1, stage1, pitch2, gate2, stage2, stepdiv1, stepdiv2)
        # Add: 9=slide_toggle_t1, 10=slide_toggle_t2
        bx["numoutlets"] = 10
        bx["outlettype"] = ["signal", "signal", "", "signal", "signal", "", "signal", "signal", "signal", "signal"]

        # New SequencerCore internal objects
        y_base = 500  # Place below existing objects
        sc["boxes"].extend([
            # New inlets (indices 21-34)
            inlet_box("obj-100", 21, [30, y_base, 30, 30], comment="Ratchets T1 pattern"),
            inlet_box("obj-101", 22, [70, y_base, 30, 30], comment="Ratchets T2 pattern"),
            inlet_box("obj-102", 23, [110, y_base, 30, 30], comment="Probability T1 pattern"),
            inlet_box("obj-103", 24, [150, y_base, 30, 30], comment="Probability T2 pattern"),
            inlet_box("obj-104", 25, [190, y_base, 30, 30], comment="ProbTarget T1 pattern"),
            inlet_box("obj-105", 26, [230, y_base, 30, 30], comment="ProbTarget T2 pattern"),
            inlet_box("obj-106", 27, [270, y_base, 30, 30], comment="SlideToggle T1 pattern"),
            inlet_box("obj-107", 28, [310, y_base, 30, 30], comment="SlideToggle T2 pattern"),
            inlet_box("obj-108", 29, [350, y_base, 30, 30], "signal", "RatchetMode T1"),
            inlet_box("obj-109", 30, [390, y_base, 30, 30], "signal", "RatchetMode T2"),
            inlet_box("obj-110", 31, [430, y_base, 30, 30], "signal", "SlideAmount T1"),
            inlet_box("obj-111", 32, [470, y_base, 30, 30], "signal", "SlideAmount T2"),
            inlet_box("obj-112", 33, [510, y_base, 30, 30], "signal", "SlideType T1"),
            inlet_box("obj-113", 34, [550, y_base, 30, 30], "signal", "SlideType T2"),

            # New stepfun~ objects for per-stage arrays
            # Ratchets (default 1)
            nobj("obj-120", "stepfun~ @pattern 1 1 1 1 1 1 1 1",
                 2, 1, ["signal"], [30, y_base + 80, 230, 22]),
            nobj("obj-121", "stepfun~ @pattern 1 1 1 1 1 1 1 1",
                 2, 1, ["signal"], [30, y_base + 180, 230, 22]),
            # Probability (default 1.0 = 100%)
            nobj("obj-122", "stepfun~ @pattern 1 1 1 1 1 1 1 1",
                 2, 1, ["signal"], [280, y_base + 80, 230, 22]),
            nobj("obj-123", "stepfun~ @pattern 1 1 1 1 1 1 1 1",
                 2, 1, ["signal"], [280, y_base + 180, 230, 22]),
            # Prob target (default 0 = Stage)
            nobj("obj-124", "stepfun~ @pattern 0 0 0 0 0 0 0 0",
                 2, 1, ["signal"], [530, y_base + 80, 230, 22]),
            nobj("obj-125", "stepfun~ @pattern 0 0 0 0 0 0 0 0",
                 2, 1, ["signal"], [530, y_base + 180, 230, 22]),
            # Slide toggle (default 0 = off)
            nobj("obj-126", "stepfun~ @pattern 0 0 0 0 0 0 0 0",
                 2, 1, ["signal"], [780, y_base + 80, 230, 22]),
            nobj("obj-127", "stepfun~ @pattern 0 0 0 0 0 0 0 0",
                 2, 1, ["signal"], [780, y_base + 180, 230, 22]),

            # New outlets for slide toggle
            outlet_box("obj-128", 9, [780, y_base + 260, 30, 30], "SlideToggle T1"),
            outlet_box("obj-129", 10, [820, y_base + 260, 30, 30], "SlideToggle T2"),
        ])

        # Wire stepfun~ to stepdiv~ phasors (for sample timing) and pattern inlets
        sc["lines"].extend([
            # Ratchets stepfun~ — phasor from stepdiv and pattern from inlet
            line("obj-22", 0, "obj-120", 0, 6),   # stepdiv T1 -> ratchets stepfun T1
            line("obj-52", 0, "obj-121", 0, 6),   # stepdiv T2 -> ratchets stepfun T2
            line("obj-100", 0, "obj-120", 0),      # pattern inlet -> stepfun
            line("obj-101", 0, "obj-121", 0),

            # Probability stepfun~
            line("obj-22", 0, "obj-122", 0, 7),
            line("obj-52", 0, "obj-123", 0, 7),
            line("obj-102", 0, "obj-122", 0),
            line("obj-103", 0, "obj-123", 0),

            # Prob target stepfun~
            line("obj-22", 0, "obj-124", 0, 8),
            line("obj-52", 0, "obj-125", 0, 8),
            line("obj-104", 0, "obj-124", 0),
            line("obj-105", 0, "obj-125", 0),

            # Slide toggle stepfun~
            line("obj-22", 0, "obj-126", 0, 9),
            line("obj-52", 0, "obj-127", 0, 9),
            line("obj-106", 0, "obj-126", 0),
            line("obj-107", 0, "obj-127", 0),

            # Connect new stepfun~ outputs to GateGen inputs
            # GateGen T1 (obj-28): in9=ratchet, in10=ratchet_mode, in11=prob, in12=probtarget
            line("obj-120", 0, "obj-28", 9),     # ratchet count -> GateGen T1 in10
            line("obj-108", 0, "obj-28", 10),     # ratchet mode -> GateGen T1 in11
            line("obj-122", 0, "obj-28", 11),     # probability -> GateGen T1 in12
            line("obj-124", 0, "obj-28", 12),     # prob target -> GateGen T1 in13

            # GateGen T2 (obj-58): same mapping
            line("obj-121", 0, "obj-58", 9),
            line("obj-109", 0, "obj-58", 10),
            line("obj-123", 0, "obj-58", 11),
            line("obj-125", 0, "obj-58", 12),

            # Slide toggle outputs
            line("obj-126", 0, "obj-128", 0),
            line("obj-127", 0, "obj-129", 0),
        ])

        print(f"  SequencerCore: {bx['numinlets']} inlets, {bx['numoutlets']} outlets")

    # ======================================================================
    # 4. Add root-level objects for Stage 3 routing
    # ======================================================================
    # Route outlet indices for Stage 3 messages (0-indexed):
    # 0-19: Stage 2 routes (existing)
    # 20: ratchets_trk1
    # 21: ratchets_trk2
    # 22: probability_trk1
    # 23: probability_trk2
    # 24: probtarget_trk1
    # 25: probtarget_trk2
    # 26: slidetoggles_trk1
    # 27: slidetoggles_trk2
    # 28: slideamount_trk1
    # 29: slideamount_trk2
    # 30: slidetype_trk1
    # 31: slidetype_trk2
    # 32: ratchetmode_trk1
    # 33: ratchetmode_trk2
    # 34: accumvalues_trk1
    # 35: accumvalues_trk2
    # 36: accumtriggers_trk1
    # 37: accumtriggers_trk2
    # 38: accumconfig_trk1
    # 39: accumconfig_trk2
    # 40: degreelut_trk1
    # 41: degreelut_trk2
    # 42: scalenames

    # Prepend pattern objects for array-type Stage 3 messages
    # These convert "ratchets_trk1 1 2 1 1..." to "pattern 1 2 1 1..." for stepfun~
    root["boxes"].extend([
        # Ratchets patterns -> prepend pattern -> SequencerCore
        nobj("obj-300", "prepend pattern", 2, 1, [""], [30, 750, 100, 22]),
        nobj("obj-301", "prepend pattern", 2, 1, [""], [140, 750, 100, 22]),
        # Probability patterns
        nobj("obj-302", "prepend pattern", 2, 1, [""], [250, 750, 100, 22]),
        nobj("obj-303", "prepend pattern", 2, 1, [""], [360, 750, 100, 22]),
        # Prob target patterns
        nobj("obj-304", "prepend pattern", 2, 1, [""], [470, 750, 100, 22]),
        nobj("obj-305", "prepend pattern", 2, 1, [""], [580, 750, 100, 22]),
        # Slide toggle patterns
        nobj("obj-306", "prepend pattern", 2, 1, [""], [690, 750, 100, 22]),
        nobj("obj-307", "prepend pattern", 2, 1, [""], [800, 750, 100, 22]),

        # sig~ converters for single-value Stage 3 messages
        # Slide amount T1/T2 (0.0-1.0)
        nobj("obj-310", "sig~ 0", 1, 1, ["signal"], [30, 820, 55, 22]),
        nobj("obj-311", "sig~ 0", 1, 1, ["signal"], [100, 820, 55, 22]),
        # Slide type T1/T2 (0/1/2)
        nobj("obj-312", "sig~ 0", 1, 1, ["signal"], [170, 820, 55, 22]),
        nobj("obj-313", "sig~ 0", 1, 1, ["signal"], [240, 820, 55, 22]),
        # Ratchet mode T1/T2 (0/1/2)
        nobj("obj-314", "sig~ 0", 1, 1, ["signal"], [310, 820, 55, 22]),
        nobj("obj-315", "sig~ 0", 1, 1, ["signal"], [380, 820, 55, 22]),
    ])

    # Connect route to new prepend pattern objects and sig~ converters
    root["lines"].extend([
        # Route -> prepend pattern for array messages
        line("obj-9", 20, "obj-300", 0),  # ratchets_trk1
        line("obj-9", 21, "obj-301", 0),  # ratchets_trk2
        line("obj-9", 22, "obj-302", 0),  # probability_trk1
        line("obj-9", 23, "obj-303", 0),  # probability_trk2
        line("obj-9", 24, "obj-304", 0),  # probtarget_trk1
        line("obj-9", 25, "obj-305", 0),  # probtarget_trk2
        line("obj-9", 26, "obj-306", 0),  # slidetoggles_trk1
        line("obj-9", 27, "obj-307", 0),  # slidetoggles_trk2

        # Route -> sig~ for single-value messages
        line("obj-9", 28, "obj-310", 0),  # slideamount_trk1
        line("obj-9", 29, "obj-311", 0),  # slideamount_trk2
        line("obj-9", 30, "obj-312", 0),  # slidetype_trk1
        line("obj-9", 31, "obj-313", 0),  # slidetype_trk2
        line("obj-9", 32, "obj-314", 0),  # ratchetmode_trk1
        line("obj-9", 33, "obj-315", 0),  # ratchetmode_trk2

        # Prepend pattern -> SequencerCore new inlets (20-27)
        line("obj-300", 0, "obj-30", 20),  # ratchets_trk1 pattern
        line("obj-301", 0, "obj-30", 21),  # ratchets_trk2 pattern
        line("obj-302", 0, "obj-30", 22),  # probability_trk1 pattern
        line("obj-303", 0, "obj-30", 23),  # probability_trk2 pattern
        line("obj-304", 0, "obj-30", 24),  # probtarget_trk1 pattern
        line("obj-305", 0, "obj-30", 25),  # probtarget_trk2 pattern
        line("obj-306", 0, "obj-30", 26),  # slidetoggles_trk1 pattern
        line("obj-307", 0, "obj-30", 27),  # slidetoggles_trk2 pattern

        # sig~ -> SequencerCore signal inlets (28-33)
        line("obj-314", 0, "obj-30", 28),  # ratchetmode_trk1
        line("obj-315", 0, "obj-30", 29),  # ratchetmode_trk2
        line("obj-310", 0, "obj-30", 30),  # slideamount_trk1
        line("obj-311", 0, "obj-30", 31),  # slideamount_trk2
        line("obj-312", 0, "obj-30", 32),  # slidetype_trk1
        line("obj-313", 0, "obj-30", 33),  # slidetype_trk2
    ])

    print("  Root routing for Stage 3 complete")
    return patch


def main():
    print("Building Metropolix Stage 3...")
    with open(PATCH_PATH) as f:
        patch = json.load(f)
    patch = transform(patch)
    with open(PATCH_PATH, "w") as f:
        json.dump(patch, f, indent=2)
    print(f"\nWrote {PATCH_PATH}")


if __name__ == "__main__":
    main()

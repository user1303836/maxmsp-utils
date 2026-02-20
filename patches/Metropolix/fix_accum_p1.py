#!/usr/bin/env python3
"""Fix accumulator P1 and P2 bugs:

P1-4: Accumulator fires when probability blocks gate
  - Add 2nd output to GateGen (prob_pass signal)
  - Add 12th input to AccumT1/T2 for prob_pass
  - Fix accumulator code to gate accumulation by prob_pass

P1-5: Accumulator outputs not wired
  - Add buffer~ degreelut_t1/t2 (57 samples) at root level
  - Add peek degreelut_t1/t2 message receivers for LUT population
  - Route degreelut_trk1/trk2 from route outlets 40/41
  - Add index~ for signal-rate degree→semitone lookup
  - Add +~ to sum semitone offset with pitch before SlideEngine/Track2Output

Missing wires:
  - accumconfig_trk2 (route outlet 39) needs unpack + sig~ + connections
  - AccumT2 needs its own 6 inlets for accumconfig (currently sharing T1's)
  - SequencerCore outlets 10/11 (AccumDeg T1/T2) need root connections

P2 fixes:
  - Accumulator Random order: separate RNG for magnitude, fix no-movement case
  - Wrap order: ignore stale dir, use sign of accum_val directly
  - AccumT2 PRNG seed: use different value (98765 vs 54321)
"""
import json, sys, copy

PATCH = "patches/Metropolix/Metropolix.maxpat"

with open(PATCH) as f:
    patch = json.load(f)

# ============================================================
# Helper functions for creating patch objects
# ============================================================
def box(id, maxclass, **kwargs):
    b = {"id": id, "maxclass": maxclass}
    b.update(kwargs)
    return {"box": b}

def nobj(id, text, numinlets, numoutlets, outlettype, rect, **kwargs):
    return box(id, "newobj", text=text, numinlets=numinlets,
               numoutlets=numoutlets, outlettype=outlettype,
               patching_rect=rect, **kwargs)

def inlet_box(id, index, rect, comment=""):
    return box(id, "inlet", index=index, numinlets=0, numoutlets=1,
               outlettype=[""], patching_rect=rect, comment=comment)

def outlet_box(id, index, rect, comment=""):
    return box(id, "outlet", index=index, numinlets=1, numoutlets=0,
               outlettype=[""], patching_rect=rect, comment=comment)

def line(src_id, src_outlet, dst_id, dst_inlet, **kwargs):
    pl = {"source": [src_id, src_outlet], "destination": [dst_id, dst_inlet]}
    pl.update(kwargs)
    return {"patchline": pl}

# ============================================================
# Navigate to key structures
# ============================================================
root = patch["patcher"]
sc = None
sc_box = None
for b in root["boxes"]:
    if b["box"].get("id") == "obj-30":
        sc = b["box"]["patcher"]
        sc_box = b["box"]
        break

if sc is None:
    print("ERROR: SequencerCore not found")
    sys.exit(1)

# ============================================================
# PART 1: Fix GateGen to output prob_pass as 2nd outlet
# ============================================================
print("=== Part 1: GateGen prob_pass output ===")

for obj_id, track_num in [("obj-28", 1), ("obj-58", 2)]:
    for b in sc["boxes"]:
        if b["box"].get("id") == obj_id:
            # Update parent box: 1 -> 2 outputs
            b["box"]["numoutlets"] = 2
            b["box"]["outlettype"] = ["signal", "signal"]

            gen = b["box"]["patcher"]

            # Add "out 2" object inside gen
            out2_id = "obj-31"
            gen["boxes"].append(
                nobj(out2_id, "out 2", 1, 0, [], [400.0, 500.0, 40.0, 22.0])
            )

            # Find the codebox and update code + add connection
            for gb in gen["boxes"]:
                gbox = gb["box"]
                if "codebox" in gbox.get("text", "") and "code" in gbox:
                    # Add "out2 = prob_pass;" at the end of the code
                    code = gbox["code"]
                    code = code.replace(
                        "out1 = gate;",
                        "out1 = gate;\nout2 = prob_pass;"
                    )
                    gbox["code"] = code

                    # Connect codebox to out 2
                    codebox_id = gbox["id"]
                    gen["lines"].append(line(codebox_id, 1, out2_id, 0))
                    break

            print(f"  Fixed GateGenT{track_num} ({obj_id}): added out2=prob_pass")
            break

# ============================================================
# PART 2: Fix AccumT1/T2 - add prob_pass input (in12)
# ============================================================
print("\n=== Part 2: Accumulator prob_pass input + code fixes ===")

ACCUM_CODE_FIXED = """// Accumulator State Machine
// in1=stepcounter  in2=gate signal  in3=accum value (from stepfun~)
// in4=accum trigger (0=Stage,1=Pulse,2=Ratchet)
// in5=accum mode (0=Stage,1=Track)  in6=accum order (0=Wrap,1=Pend,2=Rand,3=Hold)
// in7=accum polarity (0=Uni,1=Bi)  in8=limit+  in9=limit-
// in10=reset trigger  in11=gate type (0=Rest,1=Single,2=Multi,3=Hold)
// in12=probability pass (0=blocked, 1=passed)
// out1=accumulated degree offset

Data accum_degrees(8);
History track_accum(0);
Data accum_dir(8);
History track_dir(1);
History prev_counter(-1);
History prev_gate(0);
History rng_state({seed});
History rng2_state({seed2});

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
prob_pass = in12 >= 0.5;

lo_limit = 0;
hi_limit = limit_pos;
if (accum_polarity > 0.5) {{
    lo_limit = -limit_neg;
}}

new_stage = (counter != prev_counter);
gate_rise = (gate && !prev_gate);

if (reset_trig) {{
    for (i = 0; i < 8; i += 1) {{
        poke(accum_degrees, 0, i);
        poke(accum_dir, 1, i);
    }}
    track_accum = 0;
    track_dir = 1;
}}

// Determine if we should accumulate based on gate type + trigger mode
should_accum = 0;
if (gate_type > 0.5 && prob_pass) {{
    // Only accumulate when probability allows (REST from prob = no accum)
    if (accum_trigger < 0.5) {{
        // Stage trigger: accumulate once per stage entry
        should_accum = new_stage;
    }} else if (accum_trigger < 1.5) {{
        // Pulse trigger
        if (gate_type > 2.5) {{ should_accum = new_stage; }}
        else if (gate_type < 1.5) {{ should_accum = new_stage; }}
        else {{ should_accum = gate_rise; }}
    }} else {{
        // Ratchet trigger
        if (gate_type > 2.5) {{ should_accum = new_stage; }}
        else {{ should_accum = gate_rise; }}
    }}
}}

stage_idx = clamp(floor(counter) % 8, 0, 7);

if (should_accum && abs(accum_val) > 0) {{
    current = 0; dir = 1;
    if (accum_mode < 0.5) {{
        current = peek(accum_degrees, stage_idx);
        dir = peek(accum_dir, stage_idx);
    }} else {{
        current = track_accum; dir = track_dir;
    }}

    new_val = current;
    if (accum_order < 0.5) {{
        // Wrap: always use sign of accum_val, ignore stored dir
        new_val = current + accum_val;
        if (new_val > hi_limit) {{ new_val = lo_limit + (new_val - hi_limit - 1); }}
        if (new_val < lo_limit) {{ new_val = hi_limit - (lo_limit - new_val - 1); }}
        new_val = clamp(new_val, lo_limit, hi_limit);
    }} else if (accum_order < 1.5) {{
        // Pendulum
        new_val = current + abs(accum_val) * dir;
        if (new_val > hi_limit) {{ new_val = hi_limit - (new_val - hi_limit); dir = -1; }}
        if (new_val < lo_limit) {{ new_val = lo_limit + (lo_limit - new_val); dir = 1; }}
        new_val = clamp(new_val, lo_limit, hi_limit);
    }} else if (accum_order < 2.5) {{
        // Random: biased walk (50% forward, 30% opposite, 20% no movement)
        if (rng >= 0.8) {{
            // 20% no movement
            new_val = current;
        }} else {{
            // Generate separate RNG for magnitude
            rng2_state = (rng2_state * 1103515245 + 12345) % 2147483648;
            rng2 = abs(rng2_state) / 2147483647.0;
            mag = max(1, abs(accum_val));
            if (mag > 1) {{ mag = max(1, ceil(rng2 * mag)); }}
            if (rng < 0.5) {{
                // 50% in accum_val direction
                new_val = current + mag * sign(accum_val);
            }} else {{
                // 30% opposite direction
                new_val = current - mag * sign(accum_val);
            }}
            new_val = clamp(new_val, lo_limit, hi_limit);
        }}
    }} else {{
        // Hold: clamp without wrapping
        new_val = clamp(current + accum_val * dir, lo_limit, hi_limit);
    }}

    if (accum_mode < 0.5) {{
        poke(accum_degrees, new_val, stage_idx);
        poke(accum_dir, dir, stage_idx);
    }} else {{
        track_accum = new_val; track_dir = dir;
    }}
}}

accum_out = 0;
if (accum_mode < 0.5) {{
    accum_out = peek(accum_degrees, stage_idx);
}} else {{
    accum_out = track_accum;
}}

prev_counter = counter;
prev_gate = gate;
out1 = accum_out;"""

for obj_id, track_num, seed, seed2 in [("obj-150", 1, 54321, 13579), ("obj-151", 2, 98765, 24680)]:
    for b in sc["boxes"]:
        if b["box"].get("id") == obj_id:
            # Update parent: 11 -> 12 inputs
            b["box"]["numinlets"] = 12

            gen = b["box"]["patcher"]

            # Add "in 12" inside gen
            in12_id = "obj-12"
            gen["boxes"].append(
                nobj(in12_id, "in 12", 0, 1, [""], [550.0, 40.0, 40.0, 22.0])
            )

            # Find codebox and update code
            for gb in gen["boxes"]:
                gbox = gb["box"]
                if "codebox" in gbox.get("text", "") and "code" in gbox:
                    gbox["code"] = ACCUM_CODE_FIXED.format(seed=seed, seed2=seed2)

                    # Connect in12 to codebox inlet 11 (0-indexed)
                    codebox_id = gbox["id"]
                    gen["lines"].append(line(in12_id, 0, codebox_id, 11))
                    break

            print(f"  Fixed AccumT{track_num} ({obj_id}): added in12=prob_pass, seed={seed}")
            break

# ============================================================
# PART 3: Wire GateGen prob_pass (outlet 1) to Accum (inlet 11)
# ============================================================
print("\n=== Part 3: Wire GateGen -> Accum prob_pass inside SequencerCore ===")

# GateGenT1 (obj-28) outlet 1 -> AccumT1 (obj-150) inlet 11
sc["lines"].append(line("obj-28", 1, "obj-150", 11))
print("  Wired GateGenT1 outlet 1 -> AccumT1 inlet 11")

# GateGenT2 (obj-58) outlet 1 -> AccumT2 (obj-151) inlet 11
sc["lines"].append(line("obj-58", 1, "obj-151", 11))
print("  Wired GateGenT2 outlet 1 -> AccumT2 inlet 11")

# ============================================================
# PART 4: Add T2 accumconfig inlets to SequencerCore
# ============================================================
print("\n=== Part 4: Add T2 accumconfig inlets ===")

# Currently SequencerCore has 40 inlets.
# AccumT2 shares T1's inlets 35-40. We need 6 new inlets for T2 (41-46).
# Update SequencerCore to 46 inlets.
sc_box["numinlets"] = 46

# Add 6 new inlet objects inside SequencerCore
accum_t2_inlet_ids = []
accum_config_labels = ["AccumMode T2", "AccumOrder T2", "AccumPolarity T2",
                       "AccumLimitPos T2", "AccumLimitNeg T2", "AccumReset T2"]
for i in range(6):
    inlet_id = f"obj-{160 + i}"
    inlet_idx = 41 + i
    x = 1200 + i * 80
    sc["boxes"].append(
        inlet_box(inlet_id, inlet_idx, [x, 40.0, 30.0, 30.0], accum_config_labels[i])
    )
    accum_t2_inlet_ids.append(inlet_id)
    print(f"  Added inlet {inlet_idx}: {accum_config_labels[i]} ({inlet_id})")

# Remove old connections from T1 inlets (obj-134..139) to AccumT2 (obj-151)
# (Keep the T1 connections to AccumT1)
sc["lines"] = [l for l in sc["lines"] if not (
    l["patchline"]["destination"][0] == "obj-151" and
    l["patchline"]["source"][0] in ["obj-134", "obj-135", "obj-136", "obj-137", "obj-138", "obj-139"]
)]
print("  Removed stale T1->AccumT2 connections")

# Wire new T2 inlets to AccumT2 (obj-151) inlets 4-9
for i, inlet_id in enumerate(accum_t2_inlet_ids):
    sc["lines"].append(line(inlet_id, 0, "obj-151", 4 + i))
    print(f"  Wired {inlet_id} -> AccumT2 inlet {4 + i}")

# ============================================================
# PART 5: Add accumconfig_trk2 unpack + sig~ at root level
# ============================================================
print("\n=== Part 5: Add T2 accumconfig routing at root ===")

# Add unpack for accumconfig_trk2 (route outlet 39)
root["boxes"].append(
    nobj("obj-360", "unpack 7 7 0 0 0 0", 1, 6,
         ["int", "int", "int", "int", "int", "int"],
         [2200.0, 500.0, 120.0, 22.0])
)
# Connect route outlet 39 -> unpack
root["lines"].append(line("obj-9", 39, "obj-360", 0))
print("  Added unpack for accumconfig_trk2")

# Add 6 sig~ objects for T2 accumconfig
sig_ids_t2 = []
for i in range(6):
    sig_id = f"obj-{361 + i}"
    default_val = [7, 7, 0, 0, 0, 0][i]  # same defaults as T1
    root["boxes"].append(
        nobj(sig_id, f"sig~ {default_val}", 1, 1, ["signal"],
             [2200.0 + i * 80, 540.0, 50.0, 22.0])
    )
    # Connect unpack outlet i -> sig~
    root["lines"].append(line("obj-360", i, sig_id, 0))
    # Connect sig~ -> SequencerCore inlet (41+i = 0-indexed: 40+i)
    root["lines"].append(line(sig_id, 0, "obj-30", 40 + i))
    sig_ids_t2.append(sig_id)
    print(f"  Added {sig_id} (sig~ {default_val}) -> SC inlet {40 + i}")

# ============================================================
# PART 6: Wire accumulator outputs to pitch path at root level
# ============================================================
print("\n=== Part 6: Wire accumulator degree output to pitch path ===")

# Strategy: Use buffer~ + index~ for degree-to-semitone lookup
#
# For T1:
#   1. buffer~ degreelut_t1 57 1 (57 samples, 1 channel)
#   2. Route outlet 40 (degreelut_trk1) -> message "set" to buffer via peek
#   3. SequencerCore outlet 10 (AccumDeg T1, 0-indexed) contains degree offset
#   4. Offset degree by +28 to get buffer index (0-56)
#   5. index~ degreelut_t1 to look up semitone offset at signal rate
#   6. +~ to add semitone offset to pitch before SlideEngine

# T1 pitch path: SC outlet 0 (pitch) -> SlideEngine inlet 0
# We intercept: SC outlet 0 -> +~ left -> SlideEngine inlet 0
# AccumDeg -> +~ 28 -> index~ -> +~ right

# First, remove existing SC outlet 0 -> SlideEngine connection
root["lines"] = [l for l in root["lines"] if not (
    l["patchline"]["source"] == ["obj-30", 0] and
    l["patchline"]["destination"] == ["obj-320", 0]
)]
print("  Removed direct SC pitch -> SlideEngine connection")

# Add buffer~ for T1
root["boxes"].append(
    nobj("obj-370", "buffer~ degreelut_t1 57 1", 1, 2,
         ["float", "bang"], [1600.0, 300.0, 160.0, 22.0])
)
print("  Added buffer~ degreelut_t1")

# Add buffer~ for T2
root["boxes"].append(
    nobj("obj-371", "buffer~ degreelut_t2 57 1", 1, 2,
         ["float", "bang"], [1600.0, 340.0, 160.0, 22.0])
)
print("  Added buffer~ degreelut_t2")

# Route degreelut messages to populate buffers via "set" messages
# We need: route outlet 40 -> [prepend setnth] -> [buffer~ degreelut_t1]
# Actually, the degreelut is sent as a list of 57 values.
# We use a v8 approach or direct message. Best approach:
# route outlet 40 (degreelut_trk1) outputs 57 values as a list
# Use [zl iter 1] + counter to write each value via [poke degreelut_t1]
# Or simpler: use [array.fromlist] or just fill a buffer~ via message

# Simplest approach for buffer filling from a message list:
# route outlet -> [t l b] -> [zl len] for count, [zl iter 1] for values
# But for signal-rate, we actually want peek~ (sample lookup) not index~

# Actually the most direct approach in Max 9:
# route outlet 40 -> [prepend set] -> [buffer~ degreelut_t1]
# No wait - buffer~ doesn't accept "set" messages to fill samples.
#
# Correct approach: use [peek degreelut_t1] with index+value messages
# Or better: use a simple v8/v8.codebox that writes to a buffer.
#
# Simplest: Keep lookup in gen~ Data inside the accumulator itself.
# But the accumulator outputs degrees, not semitones. The conversion
# needs to happen AFTER the accumulator output.
#
# Most practical approach: Do the lookup INSIDE the accumulator gen~
# using a Data object that we populate from messages. gen~ Data can
# be set via the `param` mechanism or by sending messages to the gen~.
#
# Actually, the cleanest architecture is to do the degree-to-semitone
# lookup inside the accumulator gen~ codebox using a Data buffer,
# and output semitones directly instead of degrees.
#
# This avoids needing buffer~/peek~/index~ at root level entirely.
# We just need to get the LUT data into the gen~'s Data object.
#
# gen~ Data can be filled via "setvalue <data_name> <index> <value>"
# messages sent to the gen~ object. So:
# route outlet 40 -> [js to iterate] -> gen~ AccumT1
#
# Even simpler: Use a small subpatcher that iterates the list and
# sends setvalue messages. But let's use the most direct approach:
# We'll add a Data degreelut(57) inside the accumulator gen~ and
# modify the code to output semitone offset instead of degree offset.
#
# To populate the Data from outside, we send:
# [setvalue degreelut 0 <val0>], [setvalue degreelut 1 <val1>], etc.
#
# BUT: gen~ Data in gen.codebox~ is trickier. It needs `param` objects
# for external message access. Actually, gen~ `Data` objects ARE
# accessible from outside via messages: `<dataname> setall <values...>`
# or `<dataname> set <index> <value>`.
#
# Wait — for a gen~ inside a subpatcher (SequencerCore), messages to
# the gen~ Data would need to be routed through SequencerCore to the gen~.
# That adds complexity with more inlets.
#
# SIMPLEST APPROACH: Add the degree LUT as a Param/Data inside the
# accumulator codebox, and output the semitone-converted value.
# For LUT population, add a message inlet to the gen~ that accepts
# the full LUT as a list.
#
# Actually, let me reconsider. The simplest working approach that
# doesn't require modifying the gen~ codebox's Data architecture:
#
# 1. Add buffer~ at root level (already done above)
# 2. Use [peek degreelut_t1] (message-rate) to fill the buffer
# 3. Use [index~ degreelut_t1] (signal-rate) to look up values
# 4. AccumDeg output + 28 -> index~ -> +~ pitch
#
# For buffer filling: route outlet outputs 57 values as a flat list.
# We need to iterate through them with index. A simple approach:
# [t l b] -> [uzi 57] counts, [zl iter 1] gives values -> [pack i f] -> [poke degreelut_t1]
#
# Let me use this approach since it keeps gen~ codebox simple.

# --- T1 LUT fill path ---
# route outlet 40 -> [t l b] -> [uzi 57 0] (counter) + [zl iter 1] (values)
# -> [pack 0 0.] -> [poke degreelut_t1]
root["boxes"].append(
    nobj("obj-380", "t l b", 1, 2, ["", "bang"],
         [1800.0, 420.0, 40.0, 22.0])
)
root["boxes"].append(
    nobj("obj-381", "uzi 57 0", 2, 3, ["bang", "bang", "int"],
         [1860.0, 460.0, 70.0, 22.0])
)
root["boxes"].append(
    nobj("obj-382", "zl iter 1", 2, 2, ["", ""],
         [1780.0, 460.0, 60.0, 22.0])
)
root["boxes"].append(
    nobj("obj-383", "pack 0 0.", 2, 1, [""],
         [1800.0, 500.0, 60.0, 22.0])
)
root["boxes"].append(
    nobj("obj-384", "poke degreelut_t1", 3, 0, [],
         [1800.0, 540.0, 120.0, 22.0])
)

# Wire LUT fill: route40 -> t -> uzi+zl -> pack -> poke
root["lines"].append(line("obj-9", 40, "obj-380", 0))      # route -> t
root["lines"].append(line("obj-380", 0, "obj-382", 0))      # t list -> zl iter
root["lines"].append(line("obj-380", 1, "obj-381", 0))      # t bang -> uzi
root["lines"].append(line("obj-381", 2, "obj-383", 0))      # uzi count -> pack left
root["lines"].append(line("obj-382", 0, "obj-383", 1))      # zl iter value -> pack right
root["lines"].append(line("obj-383", 0, "obj-384", 0))      # pack -> poke
print("  Added T1 LUT fill path: route->t->uzi+zl->pack->poke")

# --- T2 LUT fill path ---
root["boxes"].append(
    nobj("obj-390", "t l b", 1, 2, ["", "bang"],
         [2000.0, 420.0, 40.0, 22.0])
)
root["boxes"].append(
    nobj("obj-391", "uzi 57 0", 2, 3, ["bang", "bang", "int"],
         [2060.0, 460.0, 70.0, 22.0])
)
root["boxes"].append(
    nobj("obj-392", "zl iter 1", 2, 2, ["", ""],
         [1980.0, 460.0, 60.0, 22.0])
)
root["boxes"].append(
    nobj("obj-393", "pack 0 0.", 2, 1, [""],
         [2000.0, 500.0, 60.0, 22.0])
)
root["boxes"].append(
    nobj("obj-394", "poke degreelut_t2", 3, 0, [],
         [2000.0, 540.0, 120.0, 22.0])
)

root["lines"].append(line("obj-9", 41, "obj-390", 0))
root["lines"].append(line("obj-390", 0, "obj-392", 0))
root["lines"].append(line("obj-390", 1, "obj-391", 0))
root["lines"].append(line("obj-391", 2, "obj-393", 0))
root["lines"].append(line("obj-392", 0, "obj-393", 1))
root["lines"].append(line("obj-393", 0, "obj-394", 0))
print("  Added T2 LUT fill path: route->t->uzi+zl->pack->poke")

# --- T1 pitch summing path ---
# SC outlet 10 (AccumDeg T1) -> [+~ 28] -> [index~ degreelut_t1] -> [+~] right inlet
# SC outlet 0 (pitch) -> [+~] left inlet -> SlideEngine inlet 0

root["boxes"].append(
    nobj("obj-400", "+~ 28", 2, 1, ["signal"],
         [1600.0, 600.0, 50.0, 22.0])
)
root["boxes"].append(
    nobj("obj-401", "index~ degreelut_t1", 3, 1, ["signal"],
         [1600.0, 640.0, 120.0, 22.0])
)
root["boxes"].append(
    nobj("obj-402", "+~", 2, 1, ["signal"],
         [1500.0, 680.0, 40.0, 22.0])
)

# Wire: SC outlet 10 -> +~ 28 -> index~ -> +~ right
root["lines"].append(line("obj-30", 10, "obj-400", 0))
root["lines"].append(line("obj-400", 0, "obj-401", 0))
root["lines"].append(line("obj-401", 0, "obj-402", 1))

# Wire: SC outlet 0 (pitch) -> +~ left
root["lines"].append(line("obj-30", 0, "obj-402", 0))

# Wire: +~ -> SlideEngine inlet 0
root["lines"].append(line("obj-402", 0, "obj-320", 0))
print("  Added T1 accum pitch path: SC->+~28->index~->+~->SlideEngine")

# --- T2 pitch summing path ---
# SC outlet 11 (AccumDeg T2) -> [+~ 28] -> [index~ degreelut_t2] -> [+~] right
# SC outlet 3 (T2 pitch) -> [+~] left -> Track2Output inlet 0

# Remove existing SC outlet 3 -> Track2Output connection
root["lines"] = [l for l in root["lines"] if not (
    l["patchline"]["source"] == ["obj-30", 3] and
    l["patchline"]["destination"] == ["obj-50", 0]
)]
print("  Removed direct SC T2 pitch -> Track2Output connection")

root["boxes"].append(
    nobj("obj-410", "+~ 28", 2, 1, ["signal"],
         [1600.0, 720.0, 50.0, 22.0])
)
root["boxes"].append(
    nobj("obj-411", "index~ degreelut_t2", 3, 1, ["signal"],
         [1600.0, 760.0, 120.0, 22.0])
)
root["boxes"].append(
    nobj("obj-412", "+~", 2, 1, ["signal"],
         [1500.0, 800.0, 40.0, 22.0])
)

root["lines"].append(line("obj-30", 11, "obj-410", 0))
root["lines"].append(line("obj-410", 0, "obj-411", 0))
root["lines"].append(line("obj-411", 0, "obj-412", 1))
root["lines"].append(line("obj-30", 3, "obj-412", 0))
root["lines"].append(line("obj-412", 0, "obj-50", 0))
print("  Added T2 accum pitch path: SC->+~28->index~->+~->Track2Output")

# ============================================================
# Save
# ============================================================
with open(PATCH, "w") as f:
    json.dump(patch, f, indent=1)

print("\n=== All fixes applied and saved ===")

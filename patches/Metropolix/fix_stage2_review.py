#!/usr/bin/env python3
"""
Fix three review issues in Stage 2:
[P1] MIDI channel change flush — add change detection + panic before channel update
[P2] Gate Override 100% = HOLD — force gt=3 when override >= 0.995
[P2] Rest pitch / gate override plumbing — add UI controls and route connections
"""

import json

PATCH_PATH = "Metropolix.maxpat"


def line(src_id, src_out, dst_id, dst_in, order=None):
    pl = {"source": [src_id, src_out], "destination": [dst_id, dst_in]}
    if order is not None:
        pl["order"] = order
    return {"patchline": pl}


def nobj(id, text, nin, nout, ot, rect, **kw):
    b = {"id": id, "maxclass": "newobj", "text": text,
         "numinlets": nin, "numoutlets": nout, "outlettype": ot,
         "patching_rect": rect}
    b.update(kw)
    return {"box": b}


def has_box(patcher, obj_id):
    """Check if a box with the given ID already exists in the patcher."""
    return any(b["box"]["id"] == obj_id for b in patcher["boxes"])


def fix_channel_flush(track_output_patcher):
    """[P1] Add change detection + panic flush before channel update in Track1Output."""
    boxes = track_output_patcher["boxes"]
    lines = track_output_patcher["lines"]

    # Idempotency: skip if already applied
    if has_box(track_output_patcher, "obj-60"):
        print("  [P1] Track1Output: channel change flush already present, skipping")
        return

    # Add change object (2 outlets: value, bang-on-change) and t i b trigger
    boxes.extend([
        nobj("obj-60", "change", 1, 2, ["", "int"],
             [450, 190 + 50, 50, 22]),
        nobj("obj-61", "t i b", 1, 2, ["int", "bang"],
             [450, 240 + 50, 45, 22]),
    ])

    # Remove existing direct connections from channel inlet (obj-4) to obj-17
    lines[:] = [l for l in lines if not (
        l["patchline"]["source"] == ["obj-4", 0] and
        l["patchline"]["destination"][0] == "obj-17"
    )]

    # New wiring:
    # obj-4 (channel inlet) -> change -> t i b
    #   t outlet 1 (b, fires FIRST) -> obj-50 (panic, flushes active note on OLD channel)
    #   t outlet 0 (i, fires SECOND) -> obj-17 inlet 1 (cold, stores new) then inlet 0 (hot, outputs)
    lines.extend([
        line("obj-4", 0, "obj-60", 0),            # channel -> change
        line("obj-60", 0, "obj-61", 0),            # change -> t i b
        line("obj-61", 1, "obj-50", 0),            # bang (first) -> panic path
        line("obj-61", 0, "obj-17", 1, 1),         # int (second) -> cold inlet (store first)
        line("obj-61", 0, "obj-17", 0, 0),         # int (second) -> hot inlet (trigger last)
    ])

    print("  [P1] Track1Output: channel change flush added")


def fix_gate_override_hold(sequencer_core_patcher):
    """[P2] Gate Override 100% = HOLD: force gt=3 when override >= 0.995."""
    old_override = """\
// Gate override: replaces track gate length when active
eff_gl = raw_gl;
if (gate_ovr > -0.5) {
    if (gate_ovr < 0.005) {
        gt = 0;
    } else {
        eff_gl = clamp(gate_ovr, 0.01, 1.0);
    }
}"""

    new_override = """\
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
}"""

    count = 0
    already = 0
    for b in sequencer_core_patcher["boxes"]:
        bx = b["box"]
        if bx.get("maxclass") == "newobj" and "GateGen" in bx.get("text", ""):
            gen_patcher = bx.get("patcher", {})
            for gb in gen_patcher.get("boxes", []):
                gbx = gb["box"]
                if "code" in gbx and "gate_ovr" in gbx.get("code", ""):
                    if old_override in gbx["code"]:
                        gbx["code"] = gbx["code"].replace(old_override, new_override)
                        count += 1
                    elif "gate_ovr > 0.995" in gbx["code"]:
                        already += 1

    if already > 0 and count == 0:
        print(f"  [P2] GateGen override hold: already patched ({already} codeboxes), skipping")
    else:
        print(f"  [P2] GateGen override hold: patched {count} codeboxes")


def fix_rest_pitch_plumbing(root):
    """[P2] Add rest pitch UI control and wire route restpitch outputs."""
    boxes = root["boxes"]
    lines = root["lines"]

    # Idempotency: skip if already applied
    if has_box(root, "obj-240"):
        print("  [P2] Rest pitch UI + gate overrides multislider already present, skipping")
        return

    # Add Rest Pitch UI: live.menu [Hold, Update]
    boxes.append({
        "box": {
            "id": "obj-240",
            "maxclass": "live.menu",
            "numinlets": 1,
            "numoutlets": 3,
            "outlettype": ["", "", "float"],
            "parameter_enable": 1,
            "patching_rect": [800, 450, 80, 22],
            "presentation": 1,
            "presentation_rect": [600, 80, 80, 15],
            "varname": "Rest Pitch",
            "saved_attribute_attributes": {
                "valueof": {
                    "parameter_longname": "Rest Pitch",
                    "parameter_shortname": "RestP",
                    "parameter_type": 2,
                    "parameter_enum": ["Hold", "Update"],
                    "parameter_initial_enable": 1,
                    "parameter_initial": [0],
                    "parameter_linknames": 1
                }
            }
        }
    })

    # Add prepend + append routing for rest pitch
    boxes.extend([
        nobj("obj-241", "prepend update_rest_pitch", 2, 1, [""],
             [800, 500, 140, 22]),
        nobj("obj-242", "append 0", 2, 1, [""],
             [800, 530, 55, 22]),
    ])

    # Wire: Rest Pitch menu -> prepend -> append track -> v8
    lines.extend([
        line("obj-240", 0, "obj-241", 0),
        line("obj-241", 0, "obj-242", 0),
        line("obj-110", 0, "obj-242", 1, 1),  # Track Select -> append
        line("obj-242", 0, "obj-8", 0),        # append -> v8
    ])

    # Add gate overrides multislider (8 stages, range -1 to 1)
    boxes.append({
        "box": {
            "id": "obj-243",
            "maxclass": "multislider",
            "numinlets": 1,
            "numoutlets": 2,
            "outlettype": ["", ""],
            "patching_rect": [900, 450, 120, 60],
            "presentation": 1,
            "presentation_rect": [600, 100, 120, 40],
            "size": 8,
            "setminmax": [-1.0, 1.0],
            "slidercolor": [0.5, 0.5, 0.5, 1.0],
            "candicane2": [0.145, 0.435, 0.718, 1.0]
        }
    })

    # Wire: multislider -> prepend update_gate_overrides -> v8
    boxes.extend([
        nobj("obj-244", "prepend update_gate_overrides", 2, 1, [""],
             [900, 530, 160, 22]),
    ])
    lines.extend([
        line("obj-243", 0, "obj-244", 0),
        line("obj-244", 0, "obj-8", 0),
    ])

    # Register new parameters
    if "parameters" not in root:
        root["parameters"] = {}
    root["parameters"]["obj-240"] = ["Rest Pitch", "RestP", 0]

    print("  [P2] Rest pitch UI + gate overrides multislider added")


def main():
    print("Fixing Stage 2 review issues...")
    with open(PATCH_PATH) as f:
        patch = json.load(f)

    root = patch["patcher"]

    # Fix 1: Channel flush in Track1Output
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] == "obj-40" and "Track1Output" in bx.get("text", ""):
            fix_channel_flush(bx["patcher"])
            break

    # Fix 2: Gate Override hold in GateGen codeboxes
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] == "obj-30" and "SequencerCore" in bx.get("text", ""):
            fix_gate_override_hold(bx["patcher"])
            break

    # Fix 3: Rest pitch / gate override plumbing
    fix_rest_pitch_plumbing(root)

    with open(PATCH_PATH, "w") as f:
        json.dump(patch, f, indent=2)
    print(f"\nWrote {PATCH_PATH}")


if __name__ == "__main__":
    main()

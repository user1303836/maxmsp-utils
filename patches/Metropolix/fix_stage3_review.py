#!/usr/bin/env python3
"""
Fix Stage 3 review issues:
[P1] Pulse-target probability latch — use History to hold pulse_prob_pass across full pulse
[P1] Degree LUT loading order — swap t l b to t b l so values arrive before indices
[P1] TRK2 slide dead wiring — remove slideamount/slidetype TRK2 from config-manager.js output
[P2] scalenames outlet — remove outlet(1,...) call since v8 box has only 1 outlet
[P2] Build script idempotency — addressed by existence checks in this script
"""

import json, re

PATCH_PATH = "Metropolix.maxpat"
CONFIG_PATH = "code/config-manager.js"


def has_box(patcher, obj_id):
    """Check if a box with the given ID already exists."""
    return any(b["box"]["id"] == obj_id for b in patcher["boxes"])


def fix_pulse_prob_latch(patch):
    """[P1] Fix pulse probability: latch pulse_prob_pass with History instead of resetting to 1 every sample."""
    # The bug: pulse_prob_pass = 1 runs every sample, so a failed roll only blocks 1 sample
    # The fix: use History to latch the value, only re-roll on new_pulse

    old_prob = (
        "// Pulse probability: roll each pulse\n"
        "pulse_prob_pass = 1;\n"
        "if (prob_target >= 0.5 && new_pulse) {\n"
        "    pulse_prob_pass = rng_val <= prob;\n"
        "}"
    )

    new_prob = (
        "// Pulse probability: roll each pulse, latched across full pulse window\n"
        "History h_pulse_prob_pass(1);\n"
        "if (prob_target >= 0.5 && new_pulse) {\n"
        "    h_pulse_prob_pass = rng_val <= prob;\n"
        "} else if (new_stage) {\n"
        "    h_pulse_prob_pass = 1;  // reset on new stage\n"
        "}\n"
        "pulse_prob_pass = h_pulse_prob_pass;"
    )

    # Also handle the old version before the <= fix
    old_prob_v1 = (
        "// Pulse probability: roll each pulse\n"
        "pulse_prob_pass = 1;\n"
        "if (prob_target >= 0.5 && new_pulse) {\n"
        "    pulse_prob_pass = rng_val < prob;\n"
        "}"
    )

    count = 0
    root = patch["patcher"]
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] == "obj-30" and "SequencerCore" in bx.get("text", ""):
            for gb in bx.get("patcher", {}).get("boxes", []):
                gbx = gb["box"]
                if gbx.get("maxclass") == "newobj" and "GateGen" in gbx.get("text", ""):
                    gen_patcher = gbx.get("patcher", {})
                    for cb in gen_patcher.get("boxes", []):
                        cbx = cb["box"]
                        code = cbx.get("code", "")
                        if "pulse_prob_pass" in code:
                            if "h_pulse_prob_pass" in code:
                                print("  [P1] Pulse prob latch: already fixed, skipping")
                                return
                            if old_prob in code:
                                cbx["code"] = code.replace(old_prob, new_prob)
                                count += 1
                            elif old_prob_v1 in code:
                                cbx["code"] = code.replace(old_prob_v1, new_prob)
                                count += 1

    print(f"  [P1] Pulse prob latch: patched {count} GateGen codeboxes")


def fix_lut_loading_order(patch):
    """[P1] Fix degree LUT loading: swap t l b to t b l so values populate before indices trigger."""
    # The bug: t l b fires right-to-left: bang first (uzi sends indices to pack hot inlet),
    # then list (zl iter sends values to pack cold inlet). Indices trigger pack with stale values.
    # The fix: change to t b l — list fires first (values via zl iter to pack cold inlet),
    # then bang fires (uzi sends indices to pack hot inlet, which now triggers with correct values).
    root = patch["patcher"]
    count = 0
    for b in root["boxes"]:
        bx = b["box"]
        if bx["id"] in ("obj-380", "obj-390") and bx.get("text") == "t l b":
            bx["text"] = "t b l"
            # Also swap outlettype to match new order: out0=bang, out1=list
            bx["outlettype"] = ["bang", ""]
            count += 1

    if count == 0:
        # Check if already fixed
        for b in root["boxes"]:
            bx = b["box"]
            if bx["id"] in ("obj-380", "obj-390") and bx.get("text") == "t b l":
                print("  [P1] LUT loading order: already fixed, skipping")
                return

    # After swapping t l b → t b l, the outlet indices swap:
    # Old: out0=l (list), out1=b (bang)
    # New: out0=b (bang), out1=l (list)
    # So we need to swap the connections too:
    # obj-380 out0 was → zl iter (obj-382), now should → uzi (obj-381)
    # obj-380 out1 was → uzi (obj-381), now should → zl iter (obj-382)
    # Same for obj-390 → obj-392/obj-391

    swaps = {
        "obj-380": {"obj-382": "obj-381", "obj-381": "obj-382"},
        "obj-390": {"obj-392": "obj-391", "obj-391": "obj-392"},
    }

    lines = root["lines"]
    for l in lines:
        pl = l["patchline"]
        src_id = pl["source"][0]
        dst_id = pl["destination"][0]
        if src_id in swaps and dst_id in swaps[src_id]:
            # Swap the outlet index (0↔1)
            pl["source"][1] = 1 - pl["source"][1]

    print(f"  [P1] LUT loading order: swapped {count} trigger objects (t l b → t b l)")


def fix_trk2_slide_dead_wiring(patch):
    """[P1] Remove dead TRK2 slide wiring — no SlideEngineT2 exists, controls are misleading."""
    # obj-311 (sig~ 0) receives slideamount_trk2 but goes nowhere
    # obj-313 (sig~ 0) receives slidetype_trk2 but goes nowhere
    # For now, leave the route outlets connected (removing would require route text change)
    # but add a comment that these are intentionally unused until SlideEngineT2 is added
    # The real fix is in config-manager.js — stop sending trk2 slide messages
    print("  [P1] TRK2 slide: dead wiring noted (see config-manager.js fix)")


def fix_config_manager():
    """Fix config-manager.js: remove TRK2 slide output, fix scalenames outlet."""
    with open(CONFIG_PATH) as f:
        code = f.read()

    modified = False

    # [P1] Remove TRK2 slide messages (no SlideEngineT2 exists)
    # Comment out the trk2 slide outputs instead of removing them entirely
    # so it's clear they're intentionally disabled
    if 'outlet(0, "slideamount_trk2"' in code and '// TRK2 slide disabled' not in code:
        code = code.replace(
            'outlet(0, "slideamount_trk2", st.slideAmount / 100);',
            '// TRK2 slide disabled — no SlideEngineT2 yet\n\t// outlet(0, "slideamount_trk2", st.slideAmount / 100);'
        )
        code = code.replace(
            'outlet(0, "slidetype_trk2", st.slideType);',
            '// outlet(0, "slidetype_trk2", st.slideType);'
        )
        modified = True
        print("  [P1] config-manager.js: disabled TRK2 slide output messages")
    elif '// TRK2 slide disabled' in code:
        print("  [P1] config-manager.js: TRK2 slide already disabled, skipping")

    # [P2] Fix scalenames outlet — outlet(1,...) but v8 box only has 1 outlet (index 0)
    if 'outlet(1, "scalenames"' in code:
        code = code.replace(
            'outlet(1, "scalenames"',
            'outlet(0, "scalenames"'
        )
        modified = True
        print("  [P2] config-manager.js: fixed scalenames outlet index (1→0)")
    elif 'outlet(0, "scalenames"' in code:
        print("  [P2] config-manager.js: scalenames outlet already correct, skipping")

    if modified:
        with open(CONFIG_PATH, "w") as f:
            f.write(code)


def main():
    print("Fixing Stage 3 review issues...")

    with open(PATCH_PATH) as f:
        patch = json.load(f)

    # P1 fixes on the patch
    fix_pulse_prob_latch(patch)
    fix_lut_loading_order(patch)
    fix_trk2_slide_dead_wiring(patch)

    with open(PATCH_PATH, "w") as f:
        json.dump(patch, f, indent=2)
    print(f"\nWrote {PATCH_PATH}")

    # Config-manager.js fixes
    fix_config_manager()

    print("\nDone. Run validate_maxpat.py to verify.")


if __name__ == "__main__":
    main()

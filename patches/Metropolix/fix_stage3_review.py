#!/usr/bin/env python3
"""
Fix Stage 3 review issues:
[P1] Pulse-target probability latch — use History to hold pulse_prob_pass across full pulse
[P1] Degree LUT dead chain — remove broken message-rate LUT chain (config-manager.js now writes buffers directly via v8 Buffer API)
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


def fix_lut_dead_chain(patch):
    """[P1] Remove dead message-rate LUT chain — config-manager.js now writes buffers directly via v8 Buffer API.

    The old chain was fundamentally broken: zl iter dumps all 57 values as a batch to pack's cold
    inlet (only the last one sticks), then uzi dumps all 57 indices to pack's hot inlet (all
    triggering with the same stale last value). No amount of outlet reordering fixes this.

    The real fix: config-manager.js uses new Buffer(name).poke(1, i, value) to write directly.
    This function removes the now-dead chain objects and their connections.

    Dead objects per track:
      T1: obj-380 (t b l), obj-381 (uzi 57 0), obj-382 (zl iter 1), obj-383 (pack 0 0.), obj-384 (poke degreelut_t1)
      T2: obj-390 (t b l), obj-391 (uzi 57 0), obj-392 (zl iter 1), obj-393 (pack 0 0.), obj-394 (poke degreelut_t2)
    """
    dead_ids = {"obj-380", "obj-381", "obj-382", "obj-383", "obj-384",
                "obj-390", "obj-391", "obj-392", "obj-393", "obj-394"}

    root = patch["patcher"]

    # Check if already removed
    present = {b["box"]["id"] for b in root["boxes"]} & dead_ids
    if not present:
        print("  [P1] LUT dead chain: already removed, skipping")
        return

    # Remove connections involving any dead object
    orig_line_count = len(root["lines"])
    root["lines"] = [
        l for l in root["lines"]
        if l["patchline"]["source"][0] not in dead_ids
        and l["patchline"]["destination"][0] not in dead_ids
    ]
    removed_lines = orig_line_count - len(root["lines"])

    # Remove the dead box objects
    orig_box_count = len(root["boxes"])
    root["boxes"] = [b for b in root["boxes"] if b["box"]["id"] not in dead_ids]
    removed_boxes = orig_box_count - len(root["boxes"])

    print(f"  [P1] LUT dead chain: removed {removed_boxes} objects and {removed_lines} connections")


def fix_trk2_slide_dead_wiring(patch):
    """[P1] Remove dead TRK2 slide wiring — no SlideEngineT2 exists, controls are misleading."""
    # obj-311 (sig~ 0) receives slideamount_trk2 but goes nowhere
    # obj-313 (sig~ 0) receives slidetype_trk2 but goes nowhere
    # For now, leave the route outlets connected (removing would require route text change)
    # but add a comment that these are intentionally unused until SlideEngineT2 is added
    # The real fix is in config-manager.js — stop sending trk2 slide messages
    print("  [P1] TRK2 slide: dead wiring noted (see config-manager.js fix)")


def fix_config_manager():
    """Fix config-manager.js: remove TRK2 slide output, fix scalenames outlet, verify Buffer API for LUT."""
    with open(CONFIG_PATH) as f:
        code = f.read()

    modified = False

    # [P1] Remove TRK2 slide messages (no SlideEngineT2 exists)
    # Two possible fix approaches: (a) comment-out approach, (b) if (track === 0) guard
    if 'if (track === 0)' in code and 'slideamount' in code:
        print("  [P1] config-manager.js: TRK2 slide already guarded with if (track === 0), skipping")
    elif 'outlet(0, "slideamount_trk2"' in code and '// TRK2 slide disabled' not in code:
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

    # [P1] Verify degreelut uses Buffer API (not message-rate outlet)
    if 'new Buffer(' in code and 'buf.poke(' in code:
        print("  [P1] config-manager.js: degreelut uses Buffer API, correct")
    elif 'outlet(0, "degreelut_"' in code:
        # Replace message-rate outlet with Buffer API writes
        code = re.sub(
            r'outlet\(0, "degreelut_" \+ prefix, \.\.\.degLUT\);',
            'var bufName = "degreelut_" + (track === 0 ? "t1" : "t2");\n'
            '\tvar buf = new Buffer(bufName);\n'
            '\tfor (var i = 0; i < degLUT.length; i++) {\n'
            '\t\tbuf.poke(1, i, degLUT[i]);\n'
            '\t}',
            code
        )
        modified = True
        print("  [P1] config-manager.js: replaced degreelut outlet with Buffer API writes")

    if modified:
        with open(CONFIG_PATH, "w") as f:
            f.write(code)


def main():
    print("Fixing Stage 3 review issues...")

    with open(PATCH_PATH) as f:
        patch = json.load(f)

    # P1 fixes on the patch
    fix_pulse_prob_latch(patch)
    fix_lut_dead_chain(patch)
    fix_trk2_slide_dead_wiring(patch)

    with open(PATCH_PATH, "w") as f:
        json.dump(patch, f, indent=2)
    print(f"\nWrote {PATCH_PATH}")

    # Config-manager.js fixes
    fix_config_manager()

    print("\nDone. Run validate_maxpat.py to verify.")


if __name__ == "__main__":
    main()

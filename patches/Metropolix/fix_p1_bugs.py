#!/usr/bin/env python3
"""Fix P1 bugs in GateGen codeboxes:
1. pulse_in_stage edge detection (use History prev_phasor)
2. Probability comparison: use <= instead of < (P2)
3. Different PRNG seed for GateGenT2 (P2)
"""
import json, sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from tools.migration_policy import guard_archived_migration

MIGRATION_ID = "metropolix-stage3-p1-gategen-fixes"
MIGRATION_STATUS = "archived"
MIGRATION_ARCHIVED_REASON = (
    "Historical P1 bug fix script kept for audit/reproduction. "
    "Current development must edit Metropolix.maxpat directly."
)
SOURCE_OF_TRUTH = "maxpat"

guard_archived_migration(
    script_file=__file__,
    migration_id=MIGRATION_ID,
    migration_status=MIGRATION_STATUS,
    archived_reason=MIGRATION_ARCHIVED_REASON,
    argv=sys.argv,
)

PATCH = "patches/Metropolix/Metropolix.maxpat"

with open(PATCH) as f:
    patch = json.load(f)

# Navigate to SequencerCore
sc = None
for b in patch["patcher"]["boxes"]:
    if b["box"].get("id") == "obj-30":
        sc = b["box"]["patcher"]
        break

if sc is None:
    print("ERROR: SequencerCore not found")
    sys.exit(1)

def fix_gategen_code(code, track_num):
    """Apply all fixes to a GateGen codebox code string."""

    # Fix 1: Add History prev_phasor and use edge detection
    # Replace the History block to add prev_phasor
    code = code.replace(
        "History prev_counter(-1);\nHistory pulse_in_stage(0);\nHistory stage_prob_pass(1);\nHistory rng_state(12345);",
        "History prev_counter(-1);\nHistory pulse_in_stage(0);\nHistory stage_prob_pass(1);\nHistory prev_phasor(1);\nHistory rng_state({});".format(
            12345 if track_num == 1 else 67890  # Fix 3: Different seed for T2
        )
    )

    # Fix 1 continued: Replace the pulse detection logic
    code = code.replace(
        "// Detect stage boundary and pulse boundary\n"
        "new_stage = (counter != prev_counter);\n"
        "new_pulse = phasor < 0.01;\n"
        "if (new_stage) {\n"
        "    pulse_in_stage = 0;\n"
        "    // Stage probability: roll once on stage entry\n"
        "    if (prob_target < 0.5) {\n"
        "        stage_prob_pass = rng_val < prob;\n"
        "    } else {\n"
        "        stage_prob_pass = 1;\n"
        "    }\n"
        "} else if (new_pulse) {\n"
        "    pulse_in_stage = pulse_in_stage + 1;\n"
        "}\n"
        "prev_counter = counter;\n"
        "\n"
        "// Pulse probability: roll each pulse\n"
        "pulse_prob_pass = 1;\n"
        "if (prob_target >= 0.5 && new_pulse) {\n"
        "    pulse_prob_pass = rng_val < prob;\n"
        "}",

        "// Detect stage boundary and pulse boundary via edge detection\n"
        "new_stage = (counter != prev_counter);\n"
        "new_pulse = (prev_phasor > 0.5 && phasor < 0.5);  // falling edge of phasor wrap\n"
        "if (new_stage) {\n"
        "    pulse_in_stage = 0;\n"
        "    // Stage probability: roll once on stage entry\n"
        "    if (prob_target < 0.5) {\n"
        "        stage_prob_pass = rng_val <= prob;\n"
        "    } else {\n"
        "        stage_prob_pass = 1;\n"
        "    }\n"
        "} else if (new_pulse) {\n"
        "    pulse_in_stage = pulse_in_stage + 1;\n"
        "}\n"
        "prev_counter = counter;\n"
        "prev_phasor = phasor;\n"
        "\n"
        "// Pulse probability: roll each pulse\n"
        "pulse_prob_pass = 1;\n"
        "if (prob_target >= 0.5 && new_pulse) {\n"
        "    pulse_prob_pass = rng_val <= prob;\n"
        "}"
    )

    return code


fixed_count = 0

# Fix both GateGenT1 (obj-28) and GateGenT2 (obj-58)
for obj_id, track_num in [("obj-28", 1), ("obj-58", 2)]:
    for b in sc["boxes"]:
        if b["box"].get("id") == obj_id:
            gen_patcher = b["box"]["patcher"]
            for gb in gen_patcher["boxes"]:
                box = gb["box"]
                if "codebox" in box.get("text", "") and "code" in box:
                    old_code = box["code"]
                    new_code = fix_gategen_code(old_code, track_num)
                    if old_code != new_code:
                        box["code"] = new_code
                        fixed_count += 1
                        print(f"Fixed GateGenT{track_num} ({obj_id})")
                    else:
                        print(f"WARNING: No changes made to GateGenT{track_num}")
                    break
            break

if fixed_count == 2:
    with open(PATCH, "w") as f:
        json.dump(patch, f, indent=1)
    print(f"\nAll {fixed_count} GateGen codeboxes fixed successfully.")
else:
    print(f"\nERROR: Expected 2 fixes, got {fixed_count}. Patch NOT saved.")
    sys.exit(1)

/**
 * Metropolix Config Manager (v8)
 *
 * Runs in the low-priority thread. NOT used for timing-critical operations.
 * Handles: scale database init, playback order precomputation,
 * pitch array generation, UI state management, preset logic.
 */

// Default pitch slider values (normalized 0.0-1.0, center = 0.5)
const DEFAULT_PITCHES = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
const DEFAULT_PULSE_COUNTS = [1, 1, 1, 1, 1, 1, 1, 1];
const DEFAULT_GATE_TYPES = [1, 1, 1, 1, 1, 1, 1, 1]; // 1 = Single

const SLIDER_OCTAVES_DEFAULT = 3;
const BOTTOM_PITCH_DEFAULT = 36; // C2

/**
 * Convert normalized slider values to MIDI note numbers.
 * note = bottom_pitch + round(slider * sliderOctaves * 12)
 */
function slidersToPitches(sliders, sliderOctaves, bottomPitch) {
	const range = sliderOctaves * 12;
	return sliders.map(s => Math.round(bottomPitch + s * range));
}

/**
 * Generate the pulse count array for stepcounter~ @seq.
 * Applies stages length and stage offset.
 */
function buildPulseSeq(pulseCounts, stagesLength, stageOffset) {
	const seq = [];
	for (let i = 0; i < stagesLength; i++) {
		const idx = (i + stageOffset) % 8;
		seq.push(pulseCounts[idx]);
	}
	return seq;
}

/**
 * Handle incoming messages from the patcher.
 */
function anything() {
	const msg = arrayfromargs(messagename, arguments);

	if (msg[0] === "init") {
		// Send default patterns to sequencer objects
		const pitches = slidersToPitches(DEFAULT_PITCHES, SLIDER_OCTAVES_DEFAULT, BOTTOM_PITCH_DEFAULT);
		outlet(0, "pitches_trk1", ...pitches);
		outlet(0, "pitches_trk2", ...pitches);
		outlet(0, "pulses_trk1", ...DEFAULT_PULSE_COUNTS);
		outlet(0, "pulses_trk2", ...DEFAULT_PULSE_COUNTS);
		outlet(0, "gatetypes_trk1", ...DEFAULT_GATE_TYPES);
		outlet(0, "gatetypes_trk2", ...DEFAULT_GATE_TYPES);
	}

	if (msg[0] === "update_pitches") {
		// msg[1..8] = slider values, msg[9] = track (0=TRK1, 1=TRK2)
		const sliders = msg.slice(1, 9).map(Number);
		const track = Number(msg[9]) || 0;
		const pitches = slidersToPitches(sliders, SLIDER_OCTAVES_DEFAULT, BOTTOM_PITCH_DEFAULT);
		const prefix = track === 0 ? "pitches_trk1" : "pitches_trk2";
		outlet(0, prefix, ...pitches);
	}
}

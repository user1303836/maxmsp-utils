/**
 * Metropolix Config Manager (v8)
 *
 * Runs in the low-priority thread. NOT used for timing-critical operations.
 * Handles: scale database init, playback order precomputation,
 * pitch array generation, UI state management, preset logic.
 *
 * Stage 2 additions: gate length, gate scale, gate stretching,
 * pulse count division, velocity, gate overrides, rest pitch.
 *
 * Stage 3 additions: scale database (49 factory + 20 user), quantizer,
 * scale-degree-to-semitone lookup, pitch override, probability,
 * direction, slide, ratchet, accumulator config.
 */

// Default pitch slider values (normalized 0.0-1.0, center = 0.5)
const DEFAULT_PITCHES = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
const DEFAULT_PULSE_COUNTS = [1, 1, 1, 1, 1, 1, 1, 1];
const DEFAULT_GATE_TYPES = [1, 1, 1, 1, 1, 1, 1, 1]; // 1 = Single
// Gate override encoding: -1=OFF (use track gate), 0=Rest, 0.01-0.99=%, 1.0=Hold
const DEFAULT_GATE_OVERRIDES = [-1, -1, -1, -1, -1, -1, -1, -1];

const SLIDER_OCTAVES_DEFAULT = 3;
const BOTTOM_PITCH_DEFAULT = 36; // C2

// Velocity mode mapping: mode index -> MIDI velocity
const VELOCITY_MAP = [64, 96, 127, 127]; // 0=50%, 1=75%, 2=100%, 3=TrackCV stub->100%

// ============================================================
// Scale Database (Section 3.1-3.2)
// ============================================================
// Each scale is defined as an array of semitone offsets from root.
// Bitmasks are computed at init time. Do NOT hardcode bitmask values.

const FACTORY_SCALES = [
	// Bank 1 — Major Modes (7)
	{ name: "Ionian (Major)", intervals: [0, 2, 4, 5, 7, 9, 11] },
	{ name: "Dorian", intervals: [0, 2, 3, 5, 7, 9, 10] },
	{ name: "Phrygian", intervals: [0, 1, 3, 5, 7, 8, 10] },
	{ name: "Lydian", intervals: [0, 2, 4, 6, 7, 9, 11] },
	{ name: "Mixolydian", intervals: [0, 2, 4, 5, 7, 9, 10] },
	{ name: "Aeolian (Minor)", intervals: [0, 2, 3, 5, 7, 8, 10] },
	{ name: "Locrian", intervals: [0, 1, 3, 5, 6, 8, 10] },
	// Bank 2 — Melodic Minor Modes (7)
	{ name: "Melodic Minor", intervals: [0, 2, 3, 5, 7, 9, 11] },
	{ name: "Dorian b2", intervals: [0, 1, 3, 5, 7, 9, 10] },
	{ name: "Lydian Augmented", intervals: [0, 2, 4, 6, 8, 9, 11] },
	{ name: "Lydian Dominant", intervals: [0, 2, 4, 6, 7, 9, 10] },
	{ name: "Mixolydian b6", intervals: [0, 2, 4, 5, 7, 8, 10] },
	{ name: "Locrian #2", intervals: [0, 2, 3, 5, 6, 8, 10] },
	{ name: "Altered", intervals: [0, 1, 3, 4, 6, 8, 10] },
	// Bank 3 — Harmonic Minor Modes (7)
	{ name: "Harmonic Minor", intervals: [0, 2, 3, 5, 7, 8, 11] },
	{ name: "Locrian #6", intervals: [0, 1, 3, 5, 6, 9, 10] },
	{ name: "Ionian #5", intervals: [0, 2, 4, 5, 8, 9, 11] },
	{ name: "Dorian #4", intervals: [0, 2, 3, 6, 7, 9, 10] },
	{ name: "Phrygian Dominant", intervals: [0, 1, 4, 5, 7, 8, 10] },
	{ name: "Lydian #2", intervals: [0, 3, 4, 6, 7, 9, 11] },
	{ name: "Ultralocrian", intervals: [0, 1, 3, 4, 6, 8, 9] },
	// Bank 4 — Miscellaneous (7)
	{ name: "Major Pentatonic", intervals: [0, 2, 4, 7, 9] },
	{ name: "Minor Pentatonic", intervals: [0, 3, 5, 7, 10] },
	{ name: "Whole Tone", intervals: [0, 2, 4, 6, 8, 10] },
	{ name: "WH Diminished", intervals: [0, 1, 3, 4, 6, 7, 9, 10] },
	{ name: "HW Diminished", intervals: [0, 2, 3, 5, 6, 8, 9, 11] },
	{ name: "Minor Blues", intervals: [0, 3, 5, 6, 7, 10] },
	{ name: "Chromatic", intervals: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] },
	// Bank 5 — World (7)
	{ name: "Bhairav / Arabic", intervals: [0, 1, 4, 5, 7, 8, 11] },
	{ name: "Hungarian Minor", intervals: [0, 2, 3, 6, 7, 8, 11] },
	{ name: "Chinese", intervals: [0, 4, 6, 7, 11] },
	{ name: "Hirajoshi", intervals: [0, 2, 3, 7, 8] },
	{ name: "In-Sen", intervals: [0, 1, 5, 7, 10] },
	{ name: "Kumoi", intervals: [0, 2, 3, 7, 9] },
	{ name: "Pelog", intervals: [0, 1, 3, 7, 8] },
	// Bank 6 — Major Chords (7)
	{ name: "Major", intervals: [0, 4, 7] },
	{ name: "Maj6", intervals: [0, 4, 7, 9] },
	{ name: "Maj7", intervals: [0, 4, 7, 11] },
	{ name: "Maj7b5", intervals: [0, 4, 6, 11] },
	{ name: "Maj7#5", intervals: [0, 4, 8, 11] },
	{ name: "Dom7", intervals: [0, 4, 7, 10] },
	{ name: "Maj9", intervals: [0, 2, 4, 7, 11] },
	// Bank 7 — Minor Chords (7)
	{ name: "Minor", intervals: [0, 3, 7] },
	{ name: "Min6", intervals: [0, 3, 7, 9] },
	{ name: "Min7", intervals: [0, 3, 7, 10] },
	{ name: "Min7b5", intervals: [0, 3, 6, 10] },
	{ name: "Dim7", intervals: [0, 3, 6, 9] },
	{ name: "Min9", intervals: [0, 2, 3, 7, 10] },
	{ name: "Min11", intervals: [0, 2, 3, 5, 7, 10] },
];

// User scales: 20 slots (2 banks of 10), initialized to chromatic
const USER_SCALE_COUNT = 20;
var userScales = [];
for (var _i = 0; _i < USER_SCALE_COUNT; _i++) {
	userScales.push({ name: "User " + (_i + 1), intervals: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] });
}

// Combined scale bank: factory (0-48) + user (49-68)
var allScales = FACTORY_SCALES.concat(userScales);

// Precomputed scale data (populated by initScaleData)
var scaleBitmasks = [];    // 12-bit bitmask per scale
var scaleDegreeLUT = [];   // per-scale: array of semitone offsets for degrees 0..N-1
var quantizerLUT = [];     // per-scale: 12-element array, pitchClass -> nearest scale pitchClass

let scaleSelect = 0;  // Current scale index (0-68)
let rootNote = 0;      // C

/**
 * Compute a 12-bit bitmask from an interval array.
 * Bit N set = semitone N is in scale.
 */
function intervalsToBitmask(intervals) {
	var mask = 0;
	for (var i = 0; i < intervals.length; i++) {
		mask |= (1 << (intervals[i] % 12));
	}
	return mask;
}

/**
 * Build quantizer lookup: for each pitch class 0-11,
 * find the nearest pitch class in the scale.
 * Prefer rounding down on ties (per spec section 3.3).
 */
function buildQuantizerLUT(bitmask) {
	var lut = new Array(12);
	for (var pc = 0; pc < 12; pc++) {
		if (bitmask & (1 << pc)) {
			lut[pc] = pc;
			continue;
		}
		// Search outward ±1, ±2, ... up to 6
		for (var d = 1; d <= 6; d++) {
			var lo = ((pc - d) % 12 + 12) % 12;
			var hi = (pc + d) % 12;
			var loIn = (bitmask & (1 << lo)) !== 0;
			var hiIn = (bitmask & (1 << hi)) !== 0;
			if (loIn && hiIn) {
				// Tie: prefer rounding down (lower pitch class)
				lut[pc] = lo;
				break;
			} else if (loIn) {
				lut[pc] = lo;
				break;
			} else if (hiIn) {
				lut[pc] = hi;
				break;
			}
		}
	}
	return lut;
}

/**
 * Build scale-degree-to-semitone lookup table.
 * degree 0 = root (always 0 semitones), degree 1 = next scale note, etc.
 * Extends to ±28 degrees for accumulator use.
 * Returns array indexed by (degree + 28), mapping to semitone offset from root.
 */
function buildDegreeLUT(intervals) {
	var numDegrees = intervals.length;
	var lut = new Array(57); // indices 0..56 represent degrees -28..+28
	for (var d = -28; d <= 28; d++) {
		var idx = d + 28;
		if (d >= 0) {
			var octave = Math.floor(d / numDegrees);
			var degreeInScale = d % numDegrees;
			lut[idx] = octave * 12 + intervals[degreeInScale];
		} else {
			// Negative degrees: go down from root
			var absD = -d;
			var octave = Math.ceil(absD / numDegrees);
			var remainder = absD % numDegrees;
			if (remainder === 0) {
				lut[idx] = -octave * 12;
			} else {
				lut[idx] = -(octave * 12) + intervals[numDegrees - remainder];
			}
		}
	}
	return lut;
}

/**
 * Initialize all scale data structures.
 * Called at device load and whenever scale definitions change.
 */
function initScaleData() {
	allScales = FACTORY_SCALES.concat(userScales);
	scaleBitmasks = [];
	quantizerLUT = [];
	scaleDegreeLUT = [];
	for (var i = 0; i < allScales.length; i++) {
		var bm = intervalsToBitmask(allScales[i].intervals);
		scaleBitmasks.push(bm);
		quantizerLUT.push(buildQuantizerLUT(bm));
		scaleDegreeLUT.push(buildDegreeLUT(allScales[i].intervals));
	}
}

/**
 * Quantize a MIDI note to the current scale + root.
 * Section 3.3: pitchClass = (note - root) mod 12
 * Find nearest set bit, prefer rounding down on ties.
 * Reconstruct: octave * 12 + root + quantized_pitchClass
 */
function quantizeNote(note) {
	var si = Math.max(0, Math.min(allScales.length - 1, scaleSelect));
	var lut = quantizerLUT[si];
	var relNote = note - rootNote;
	var octave = Math.floor(relNote / 12);
	var pc = ((relNote % 12) + 12) % 12;
	var qpc = lut[pc];
	var result = octave * 12 + rootNote + qpc;
	// When quantizer wraps up past the octave boundary (e.g., B→C on Major triad),
	// qpc is much lower than pc — the nearest note is actually in the NEXT octave
	if (qpc < pc && (pc - qpc) > 6) {
		result += 12;
	}
	return Math.max(0, Math.min(127, result));
}

/**
 * Get the semitone offset for a given accumulator degree count.
 * Uses the current scale's degree-to-semitone LUT.
 */
function accumDegreeToSemitones(degrees) {
	var si = Math.max(0, Math.min(allScales.length - 1, scaleSelect));
	var lut = scaleDegreeLUT[si];
	var idx = Math.max(0, Math.min(56, degrees + 28));
	return lut[idx];
}


// ============================================================
// Per-stage per-track parameters (Stage 3)
// ============================================================

// Pitch override: -1=OFF, or MIDI note 0-72 (C0-C5)
const DEFAULT_PITCH_OVERRIDES = [-1, -1, -1, -1, -1, -1, -1, -1];
// Ratchet count per stage (1-8)
const DEFAULT_RATCHETS = [1, 1, 1, 1, 1, 1, 1, 1];
// Probability per stage (0-100)
const DEFAULT_PROBABILITY = [100, 100, 100, 100, 100, 100, 100, 100];
// Probability target: 0=Stage, 1=Pulse
const DEFAULT_PROB_TARGET = [0, 0, 0, 0, 0, 0, 0, 0];
// Slide toggle per stage (0/1)
const DEFAULT_SLIDE_TOGGLES = [0, 0, 0, 0, 0, 0, 0, 0];
// Skip per stage (0/1)
const DEFAULT_SKIPS = [0, 0, 0, 0, 0, 0, 0, 0];
// Accumulator value per stage (-7 to +7)
const DEFAULT_ACCUM_VALUES = [0, 0, 0, 0, 0, 0, 0, 0];
// Accumulator trigger: 0=Stage, 1=Pulse, 2=Ratchet
const DEFAULT_ACCUM_TRIGGERS = [0, 0, 0, 0, 0, 0, 0, 0];


// Shared stage controls (both tracks use the same base values)
var pitches = DEFAULT_PITCHES.slice();
var pulseCounts = DEFAULT_PULSE_COUNTS.slice();
var gateTypes = DEFAULT_GATE_TYPES.slice();

// Per-track state (sequencer parameters that differ per track)
var trackState = [
	{
		stagesLength: 8,
		stageOffset: 0,
		playbackOrder: 0,
		direction: 0,          // 0=Forward, 1=Reverse
		sliderOctaves: SLIDER_OCTAVES_DEFAULT,
		sliderDirection: 0,    // 0=Normal, 1=Inverted
		bottomPitch: BOTTOM_PITCH_DEFAULT,
		gateLength: 50,
		gateScale: 100,
		gateStretching: 0,
		pulseCountDiv: 1,
		velocity: 2,
		restPitch: 0,
		transpose: 0,         // -60 to +60 semitones
		slideType: 0,         // 0=Analog, 1=Tempo, 2=Acid
		slideAmount: 0,       // 0-100
		ratchetMode: 0,       // 0=Multiply, 1=Pulse, 2=Gated
		// Per-stage per-track arrays
		gateOverrides: DEFAULT_GATE_OVERRIDES.slice(),
		pitchOverrides: DEFAULT_PITCH_OVERRIDES.slice(),
		ratchets: DEFAULT_RATCHETS.slice(),
		probability: DEFAULT_PROBABILITY.slice(),
		probTarget: DEFAULT_PROB_TARGET.slice(),
		slideToggles: DEFAULT_SLIDE_TOGGLES.slice(),
		skips: DEFAULT_SKIPS.slice(),
		accumValues: DEFAULT_ACCUM_VALUES.slice(),
		accumTriggers: DEFAULT_ACCUM_TRIGGERS.slice(),
		// Accumulator settings
		accumLimitPos: 7,
		accumLimitNeg: 7,
		accumMode: 0,      // 0=Stage, 1=Track
		accumOrder: 0,     // 0=Wrap, 1=Pendulum, 2=Random, 3=Hold
		accumPolarity: 0,  // 0=Unipolar, 1=Bipolar
		accumReset: 0,     // 0=Manual, 1=Auto, 2=Aux, 3=Mod
		// Pulse count override: -1=Switch (use shared), 1-8=force
		pulseCountOverride: -1,
		// Gate type override: -1=Switch (use shared), 0-6 = override types
		gateTypeOverride: -1,
	},
	{
		stagesLength: 8,
		stageOffset: 0,
		playbackOrder: 0,
		direction: 0,
		sliderOctaves: SLIDER_OCTAVES_DEFAULT,
		sliderDirection: 0,
		bottomPitch: BOTTOM_PITCH_DEFAULT,
		gateLength: 50,
		gateScale: 100,
		gateStretching: 0,
		pulseCountDiv: 1,
		velocity: 2,
		restPitch: 0,
		transpose: 0,
		slideType: 0,
		slideAmount: 0,
		ratchetMode: 0,
		gateOverrides: DEFAULT_GATE_OVERRIDES.slice(),
		pitchOverrides: DEFAULT_PITCH_OVERRIDES.slice(),
		ratchets: DEFAULT_RATCHETS.slice(),
		probability: DEFAULT_PROBABILITY.slice(),
		probTarget: DEFAULT_PROB_TARGET.slice(),
		slideToggles: DEFAULT_SLIDE_TOGGLES.slice(),
		skips: DEFAULT_SKIPS.slice(),
		accumValues: DEFAULT_ACCUM_VALUES.slice(),
		accumTriggers: DEFAULT_ACCUM_TRIGGERS.slice(),
		accumLimitPos: 7,
		accumLimitNeg: 7,
		accumMode: 0,
		accumOrder: 0,
		accumPolarity: 0,
		accumReset: 0,
		pulseCountOverride: -1,
		gateTypeOverride: -1,
	}
];

/**
 * Convert normalized slider values to MIDI note numbers.
 * note = bottom_pitch + round(slider * sliderOctaves * 12)
 * Respects slider direction (invert) per track.
 */
function slidersToPitches(sliders, sliderOctaves, bottomPitch, sliderDirection) {
	var range = sliderOctaves * 12;
	return sliders.map(function(s) {
		var val = sliderDirection ? (1.0 - s) : s;
		return Math.round(bottomPitch + val * range);
	});
}

/**
 * Apply per-stage pitch overrides, then quantize.
 * Implements steps 1-6 of the 10-step pitch pipeline:
 *   1. Slider → raw note
 *   2. Pitch override (replaces slider value if active)
 *   3. Pitch Pre modulation (TODO: added when mod bus exists)
 *   4. Accumulator offset (TODO: applied at runtime in gen~)
 *   5. Track transpose
 *   6. Quantize to scale
 */
function applyPitchPipeline(rawPitches, track) {
	var st = trackState[track];
	var result = [];
	for (var i = 0; i < rawPitches.length; i++) {
		var note = rawPitches[i];
		// Step 2: pitch override replaces slider value
		if (st.pitchOverrides[i % 8] >= 0) {
			note = st.pitchOverrides[i % 8];
		}
		// Step 5: transpose
		note += st.transpose;
		// Step 6: quantize
		note = quantizeNote(note);
		result.push(note);
	}
	return result;
}

/**
 * Apply skip filtering to base indices.
 * Returns filtered indices with skipped stages removed.
 * If all stages are skipped, keeps the first stage active (skip guard).
 */
function applySkips(baseIndices, skips) {
	var filtered = [];
	for (var i = 0; i < baseIndices.length; i++) {
		var stageIdx = baseIndices[i] % 8;
		if (!skips[stageIdx]) {
			filtered.push(baseIndices[i]);
		}
	}
	if (filtered.length === 0) {
		filtered.push(baseIndices[0]);
	}
	return filtered;
}

/**
 * Reorder an array according to the playback order and stages length.
 * Returns the reordered array that the signal-rate stepper traverses linearly.
 *
 * Orders: 0=Linear, 1=Ping Pong, 2=Pendulum, 3=Random, 4=Shuffle,
 * 5=Brownian, 6=Converge, 7=Diverge, 8=Pedal Point, 9=Hopscotch
 */
function buildStageSequence(stagesLength, stageOffset, order, skips) {
	var len = stagesLength;
	var baseIndices = [];
	for (var i = 0; i < len; i++) {
		baseIndices.push((i + stageOffset) % 8);
	}

	// Apply skip filtering before building order pattern
	baseIndices = applySkips(baseIndices, skips);
	len = baseIndices.length;

	var ordered;
	switch (order) {
		case 0: // Linear: 1,2,3,...,N
			ordered = baseIndices.slice();
			break;
		case 1: { // Ping Pong: 1,2,...,N,N,N-1,...,2,1 (repeats endpoints)
			ordered = baseIndices.slice();
			for (var i = len - 1; i >= 0; i--) {
				ordered.push(baseIndices[i]);
			}
			break;
		}
		case 2: { // Pendulum: 1,2,...,N,N-1,...,2 (omits endpoints on return)
			ordered = baseIndices.slice();
			if (len > 2) {
				for (var i = len - 2; i >= 1; i--) {
					ordered.push(baseIndices[i]);
				}
			}
			break;
		}
		case 3: { // Random: long pre-generated sequence
			ordered = [];
			var seqLen = Math.max(64, len * 8);
			for (var i = 0; i < seqLen; i++) {
				ordered.push(baseIndices[Math.floor(Math.random() * len)]);
			}
			break;
		}
		case 4: { // Shuffle: random permutation, repeat same permutation
			var perm = baseIndices.slice();
			for (var i = perm.length - 1; i > 0; i--) {
				var j = Math.floor(Math.random() * (i + 1));
				var tmp = perm[i];
				perm[i] = perm[j];
				perm[j] = tmp;
			}
			ordered = perm;
			break;
		}
		case 5: { // Brownian: 50% fwd, 25% stay, 25% bwd
			ordered = [];
			var seqLen = Math.max(64, len * 8);
			var pos = 0;
			for (var i = 0; i < seqLen; i++) {
				ordered.push(baseIndices[pos]);
				var r = Math.random();
				if (r < 0.5) {
					pos = (pos + 1) % len;
				} else if (r < 0.75) {
					// stay
				} else {
					pos = (pos - 1 + len) % len;
				}
			}
			break;
		}
		case 6: { // Converge: 1,N,2,N-1,3,...
			ordered = [];
			var lo = 0, hi = len - 1;
			while (lo <= hi) {
				ordered.push(baseIndices[lo]);
				if (lo !== hi) ordered.push(baseIndices[hi]);
				lo++;
				hi--;
			}
			break;
		}
		case 7: { // Diverge: mid,mid+1,mid-1,mid+2,mid-2,...
			ordered = [];
			var mid = Math.floor((len - 1) / 2);
			ordered.push(baseIndices[mid]);
			for (var d = 1; d < len; d++) {
				if (mid + d < len) ordered.push(baseIndices[mid + d]);
				if (mid - d >= 0) ordered.push(baseIndices[mid - d]);
			}
			break;
		}
		case 8: { // Pedal Point: 1,2,1,3,1,4,...,1,N
			ordered = [];
			for (var i = 1; i < len; i++) {
				ordered.push(baseIndices[0]);
				ordered.push(baseIndices[i]);
			}
			if (len === 1) ordered.push(baseIndices[0]);
			break;
		}
		case 9: { // Hopscotch: forward 2, back 1 (wrapping)
			ordered = [];
			var pos = 0;
			for (var i = 0; i < len; i++) {
				ordered.push(baseIndices[pos]);
				pos = (pos + 2) % len;
				ordered.push(baseIndices[pos]);
				pos = (pos - 1 + len) % len;
			}
			break;
		}
		default:
			ordered = baseIndices.slice();
	}

	return ordered;
}

/**
 * Map a stage index sequence to values from an array.
 */
function mapSequenceToValues(sequence, values) {
	return sequence.map(function(idx) { return values[idx]; });
}

/**
 * Resolve effective pulse counts per stage (shared + per-track override).
 */
function resolveEffectivePulseCounts(track) {
	var st = trackState[track];
	if (st.pulseCountOverride > 0) {
		var arr = [];
		for (var i = 0; i < 8; i++) arr.push(st.pulseCountOverride);
		return arr;
	}
	return pulseCounts.slice();
}

/**
 * Resolve effective gate types per stage (shared + per-track override).
 * Gate type override: -1=Switch, 0=Single, 1=Sngl+Rst, 2=Multi, 3=Multi+Rst, 4=Hold, 5=Hold+Rst
 * +Rst variants preserve REST stages from the shared switches.
 */
function resolveEffectiveGateTypes(track) {
	var st = trackState[track];
	if (st.gateTypeOverride < 0) {
		return gateTypes.slice();
	}
	// Map override enum to gate type: 0→1(S), 1→1/0(S+R), 2→2(M), 3→2/0(M+R), 4→3(H), 5→3/0(H+R)
	var overrideMap = [
		{ gt: 1, preserveRest: false },
		{ gt: 1, preserveRest: true },
		{ gt: 2, preserveRest: false },
		{ gt: 2, preserveRest: true },
		{ gt: 3, preserveRest: false },
		{ gt: 3, preserveRest: true },
	];
	var ov = overrideMap[Math.min(st.gateTypeOverride, overrideMap.length - 1)];
	var result = [];
	for (var i = 0; i < 8; i++) {
		if (ov.preserveRest && gateTypes[i] === 0) {
			result.push(0); // Keep REST
		} else {
			result.push(ov.gt);
		}
	}
	return result;
}

/**
 * Send all sequencer patterns for a given track.
 */
function sendTrackPatterns(track) {
	var st = trackState[track];
	var prefix = track === 0 ? "trk1" : "trk2";

	// Build stage index sequence
	var stageSeq = buildStageSequence(st.stagesLength, st.stageOffset, st.playbackOrder, st.skips);

	// Apply direction reversal
	if (st.direction) {
		stageSeq = stageSeq.slice().reverse();
	}

	// Build pitch pattern through the pipeline
	var rawPitches = slidersToPitches(pitches, st.sliderOctaves, st.bottomPitch, st.sliderDirection);
	var processedPitches = applyPitchPipeline(rawPitches, track);

	// Map stage sequence to values
	var orderedPitches = mapSequenceToValues(stageSeq, processedPitches);
	var effPulses = resolveEffectivePulseCounts(track);
	var orderedPulses = mapSequenceToValues(stageSeq, effPulses);
	var effGateTypes = resolveEffectiveGateTypes(track);
	var orderedGates = mapSequenceToValues(stageSeq, effGateTypes);
	var orderedGateOverrides = mapSequenceToValues(stageSeq, st.gateOverrides);

	// Stage 3 per-stage arrays ordered by sequence
	var orderedRatchets = mapSequenceToValues(stageSeq, st.ratchets);
	var orderedProbability = mapSequenceToValues(stageSeq, st.probability);
	var orderedProbTarget = mapSequenceToValues(stageSeq, st.probTarget);
	var orderedSlideToggles = mapSequenceToValues(stageSeq, st.slideToggles);
	var orderedAccumValues = mapSequenceToValues(stageSeq, st.accumValues);
	var orderedAccumTriggers = mapSequenceToValues(stageSeq, st.accumTriggers);

	outlet(0, "pitches_" + prefix, ...orderedPitches);
	outlet(0, "pulses_" + prefix, ...orderedPulses);
	outlet(0, "gatetypes_" + prefix, ...orderedGates);

	// Stage 2: per-track parameters
	outlet(0, "gatelength_" + prefix, st.gateLength / 100);
	outlet(0, "gatescale_" + prefix, st.gateScale / 100);
	outlet(0, "gatestretching_" + prefix, st.gateStretching);
	outlet(0, "pulsecountdiv_" + prefix, st.pulseCountDiv);
	outlet(0, "velocity_" + prefix, VELOCITY_MAP[st.velocity]);
	outlet(0, "gateoverrides_" + prefix, ...orderedGateOverrides);
	outlet(0, "restpitch_" + prefix, st.restPitch);

	// Stage 3: per-stage arrays
	outlet(0, "ratchets_" + prefix, ...orderedRatchets);
	outlet(0, "probability_" + prefix, ...orderedProbability.map(function(v) { return v / 100; }));
	outlet(0, "probtarget_" + prefix, ...orderedProbTarget);
	outlet(0, "slidetoggles_" + prefix, ...orderedSlideToggles);
	outlet(0, "accumvalues_" + prefix, ...orderedAccumValues);
	outlet(0, "accumtriggers_" + prefix, ...orderedAccumTriggers);

	// Stage 3: track-level params
	outlet(0, "slideamount_" + prefix, st.slideAmount / 100);
	outlet(0, "slidetype_" + prefix, st.slideType);
	outlet(0, "ratchetmode_" + prefix, st.ratchetMode);

	// Accumulator config
	outlet(0, "accumconfig_" + prefix, st.accumLimitPos, st.accumLimitNeg,
		st.accumMode, st.accumOrder, st.accumPolarity, st.accumReset);

	// Scale degree-to-semitone LUT for accumulator (send as message)
	var si = Math.max(0, Math.min(allScales.length - 1, scaleSelect));
	var degLUT = scaleDegreeLUT[si];
	outlet(0, "degreelut_" + prefix, ...degLUT);
}

/**
 * Send scale names to outlet 1 for UI menu population.
 */
function sendScaleNames() {
	var names = [];
	for (var i = 0; i < allScales.length; i++) {
		names.push(allScales[i].name);
	}
	outlet(1, "scalenames", ...names);
}

/**
 * Handle incoming messages from the patcher.
 */
function anything() {
	var msg = arrayfromargs(messagename, arguments);

	if (msg[0] === "init") {
		initScaleData();
		sendScaleNames();
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}

	if (msg[0] === "update_pitches") {
		pitches = msg.slice(1, 9).map(Number);
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}

	if (msg[0] === "update_stages_length") {
		var len = Math.max(1, Math.min(8, Number(msg[1]) || 8));
		var track = Number(msg[2]) || 0;
		trackState[track].stagesLength = len;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_playback_order") {
		var order = Math.max(0, Math.min(9, Number(msg[1]) || 0));
		var track = Number(msg[2]) || 0;
		trackState[track].playbackOrder = order;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_root_note") {
		rootNote = Math.max(0, Math.min(11, Number(msg[1]) || 0));
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}

	if (msg[0] === "update_scale_select") {
		scaleSelect = Math.max(0, Math.min(allScales.length - 1, Number(msg[1]) || 0));
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}

	if (msg[0] === "update_user_scale") {
		// msg[1] = user scale index (0-19), msg[2..13] = 12 on/off values for each pitch class
		var idx = Math.max(0, Math.min(USER_SCALE_COUNT - 1, Number(msg[1]) || 0));
		var intervals = [];
		for (var i = 0; i < 12; i++) {
			if (Number(msg[i + 2])) {
				intervals.push(i);
			}
		}
		if (intervals.length === 0) intervals.push(0); // At least root
		userScales[idx].intervals = intervals;
		initScaleData();
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}

	if (msg[0] === "update_direction") {
		var val = Number(msg[1]) ? 1 : 0;
		var track = Number(msg[2]) || 0;
		trackState[track].direction = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_transpose") {
		var val = Math.max(-60, Math.min(60, Number(msg[1]) || 0));
		var track = Number(msg[2]) || 0;
		trackState[track].transpose = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_slider_octaves") {
		var val = Math.max(1, Math.min(4, Number(msg[1]) || 3));
		var track = Number(msg[2]) || 0;
		trackState[track].sliderOctaves = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_slider_direction") {
		var val = Number(msg[1]) ? 1 : 0;
		var track = Number(msg[2]) || 0;
		trackState[track].sliderDirection = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_stage_offset") {
		var val = Math.max(0, Math.min(7, Number(msg[1]) || 0));
		var track = Number(msg[2]) || 0;
		trackState[track].stageOffset = val;
		sendTrackPatterns(track);
	}

	// Stage 2: per-track gate/velocity/division parameters

	if (msg[0] === "update_gate_length") {
		var val = Math.max(1, Math.min(100, Number(msg[1]) || 50));
		var track = Number(msg[2]) || 0;
		trackState[track].gateLength = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_gate_scale") {
		var val = Math.max(1, Math.min(200, Number(msg[1]) || 100));
		var track = Number(msg[2]) || 0;
		trackState[track].gateScale = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_gate_stretching") {
		var val = Number(msg[1]) ? 1 : 0;
		var track = Number(msg[2]) || 0;
		trackState[track].gateStretching = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_pulse_count_div") {
		var val = Math.max(1, Math.min(8, Number(msg[1]) || 1));
		var track = Number(msg[2]) || 0;
		trackState[track].pulseCountDiv = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_velocity") {
		var val = Math.max(0, Math.min(3, Number(msg[1]) || 0));
		var track = Number(msg[2]) || 0;
		trackState[track].velocity = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_gate_overrides") {
		// msg[1..8] = gate override values, msg[9] = track
		var track = Number(msg[9]) || 0;
		trackState[track].gateOverrides = msg.slice(1, 9).map(Number);
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_rest_pitch") {
		var val = Number(msg[1]) ? 1 : 0;
		var track = Number(msg[2]) || 0;
		trackState[track].restPitch = val;
		sendTrackPatterns(track);
	}

	// Stage 3: per-stage per-track parameters

	if (msg[0] === "update_pitch_overrides") {
		// msg[1..8] = pitch override values, msg[9] = track
		var track = Number(msg[9]) || 0;
		trackState[track].pitchOverrides = msg.slice(1, 9).map(Number);
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_ratchets") {
		// msg[1..8] = ratchet counts, msg[9] = track
		var track = Number(msg[9]) || 0;
		trackState[track].ratchets = msg.slice(1, 9).map(function(v) {
			return Math.max(1, Math.min(8, Number(v) || 1));
		});
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_probability") {
		// msg[1..8] = probability values (0-100), msg[9] = track
		var track = Number(msg[9]) || 0;
		trackState[track].probability = msg.slice(1, 9).map(function(v) {
			return Math.max(0, Math.min(100, Number(v) || 100));
		});
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_prob_target") {
		// msg[1..8] = target values (0=Stage, 1=Pulse), msg[9] = track
		var track = Number(msg[9]) || 0;
		trackState[track].probTarget = msg.slice(1, 9).map(function(v) {
			return Number(v) ? 1 : 0;
		});
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_slide_toggles") {
		// msg[1..8] = slide toggle values, msg[9] = track
		var track = Number(msg[9]) || 0;
		trackState[track].slideToggles = msg.slice(1, 9).map(function(v) {
			return Number(v) ? 1 : 0;
		});
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_skips") {
		// msg[1..8] = skip values, msg[9] = track
		var track = Number(msg[9]) || 0;
		trackState[track].skips = msg.slice(1, 9).map(function(v) {
			return Number(v) ? 1 : 0;
		});
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_accum_values") {
		// msg[1..8] = accumulator values (-7 to +7), msg[9] = track
		var track = Number(msg[9]) || 0;
		trackState[track].accumValues = msg.slice(1, 9).map(function(v) {
			return Math.max(-7, Math.min(7, Number(v) || 0));
		});
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_accum_triggers") {
		// msg[1..8] = trigger modes (0=Stage, 1=Pulse, 2=Ratchet), msg[9] = track
		var track = Number(msg[9]) || 0;
		trackState[track].accumTriggers = msg.slice(1, 9).map(function(v) {
			return Math.max(0, Math.min(2, Number(v) || 0));
		});
		sendTrackPatterns(track);
	}

	// Stage 3: track-level params

	if (msg[0] === "update_slide_type") {
		var val = Math.max(0, Math.min(2, Number(msg[1]) || 0));
		var track = Number(msg[2]) || 0;
		trackState[track].slideType = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_slide_amount") {
		var val = Math.max(0, Math.min(100, Number(msg[1]) || 0));
		var track = Number(msg[2]) || 0;
		trackState[track].slideAmount = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_ratchet_mode") {
		var val = Math.max(0, Math.min(2, Number(msg[1]) || 0));
		var track = Number(msg[2]) || 0;
		trackState[track].ratchetMode = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_accum_config") {
		// msg[1] = param name, msg[2] = value, msg[3] = track
		var param = msg[1];
		var val = Number(msg[2]) || 0;
		var track = Number(msg[3]) || 0;
		var st = trackState[track];
		if (param === "limit_pos") st.accumLimitPos = Math.max(1, Math.min(28, val));
		else if (param === "limit_neg") st.accumLimitNeg = Math.max(1, Math.min(28, val));
		else if (param === "mode") st.accumMode = val ? 1 : 0;
		else if (param === "order") st.accumOrder = Math.max(0, Math.min(3, val));
		else if (param === "polarity") st.accumPolarity = val ? 1 : 0;
		else if (param === "reset") st.accumReset = Math.max(0, Math.min(3, val));
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_pulse_count_override") {
		// msg[1] = override value (-1=Switch, 1-8), msg[2] = track
		var val = Number(msg[1]);
		var track = Number(msg[2]) || 0;
		if (val < 0) val = -1;
		else val = Math.max(1, Math.min(8, val));
		trackState[track].pulseCountOverride = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_gate_type_override") {
		// msg[1] = override value (-1=Switch, 0-5), msg[2] = track
		var val = Number(msg[1]);
		var track = Number(msg[2]) || 0;
		if (val < 0) val = -1;
		else val = Math.max(0, Math.min(5, val));
		trackState[track].gateTypeOverride = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_bottom_pitch") {
		// msg[1] = mode (0=C, 1=Root)
		var mode = Number(msg[1]) || 0;
		for (var t = 0; t < 2; t++) {
			trackState[t].bottomPitch = mode ? (rootNote + 24) : BOTTOM_PITCH_DEFAULT;
		}
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}
}

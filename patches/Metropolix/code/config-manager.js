/**
 * Metropolix Config Manager (v8)
 *
 * Runs in the low-priority thread. NOT used for timing-critical operations.
 * Handles: scale database init, playback order precomputation,
 * pitch array generation, UI state management, preset logic.
 *
 * Stage 2 additions: gate length, gate scale, gate stretching,
 * pulse count division, velocity, gate overrides, rest pitch.
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

// Shared stage controls (both tracks use the same base values)
let pitches = DEFAULT_PITCHES.slice();
let pulseCounts = DEFAULT_PULSE_COUNTS.slice();
let gateTypes = DEFAULT_GATE_TYPES.slice();
let gateOverrides = DEFAULT_GATE_OVERRIDES.slice();

// Per-track state (sequencer parameters that differ per track)
const trackState = [
	{
		stagesLength: 8,
		stageOffset: 0,
		playbackOrder: 0,
		sliderOctaves: SLIDER_OCTAVES_DEFAULT,
		gateLength: 50,
		gateScale: 100,
		gateStretching: 0,
		pulseCountDiv: 1,
		velocity: 2,
		restPitch: 0
	},
	{
		stagesLength: 8,
		stageOffset: 0,
		playbackOrder: 0,
		sliderOctaves: SLIDER_OCTAVES_DEFAULT,
		gateLength: 50,
		gateScale: 100,
		gateStretching: 0,
		pulseCountDiv: 1,
		velocity: 2,
		restPitch: 0
	}
];

// Stored for future quantizer use (Phase 2+), not applied in Phase 1
let rootNote = 0; // C

/**
 * Convert normalized slider values to MIDI note numbers.
 * note = bottom_pitch + round(slider * sliderOctaves * 12)
 */
function slidersToPitches(sliders, sliderOctaves, bottomPitch) {
	var range = sliderOctaves * 12;
	return sliders.map(function(s) { return Math.round(bottomPitch + s * range); });
}

/**
 * Reorder an array according to the playback order and stages length.
 * Returns the reordered array that the signal-rate stepper traverses linearly.
 *
 * Orders: 0=Linear, 1=Ping Pong, 2=Pendulum, 3=Random, 4=Shuffle,
 * 5=Brownian, 6=Converge, 7=Diverge, 8=Pedal Point, 9=Hopscotch
 */
function buildPlaybackPattern(values, stagesLength, stageOffset, order) {
	var len = stagesLength;
	var baseIndices = [];
	for (var i = 0; i < len; i++) {
		baseIndices.push((i + stageOffset) % 8);
	}

	var ordered;
	switch (order) {
		case 0: // Linear: 1,2,3,...,N
			ordered = baseIndices;
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
		default: // Random, Shuffle, Brownian fall back to Linear for Phase 1
			ordered = baseIndices;
	}

	return ordered.map(function(idx) { return values[idx]; });
}

/**
 * Send all sequencer patterns for a given track.
 */
function sendTrackPatterns(track) {
	var st = trackState[track];
	var prefix = track === 0 ? "trk1" : "trk2";
	var midiPitches = slidersToPitches(pitches, st.sliderOctaves, BOTTOM_PITCH_DEFAULT);
	var orderedPitches = buildPlaybackPattern(midiPitches, st.stagesLength, st.stageOffset, st.playbackOrder);
	var orderedPulses = buildPlaybackPattern(pulseCounts, st.stagesLength, st.stageOffset, st.playbackOrder);
	var orderedGates = buildPlaybackPattern(gateTypes, st.stagesLength, st.stageOffset, st.playbackOrder);
	var orderedGateOverrides = buildPlaybackPattern(gateOverrides, st.stagesLength, st.stageOffset, st.playbackOrder);

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
}

/**
 * Handle incoming messages from the patcher.
 */
function anything() {
	var msg = arrayfromargs(messagename, arguments);

	if (msg[0] === "init") {
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}

	if (msg[0] === "update_pitches") {
		// msg[1..8] = slider values (shared across both tracks)
		pitches = msg.slice(1, 9).map(Number);
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}

	if (msg[0] === "update_stages_length") {
		// msg[1] = stages length (1-8), msg[2] = track (0=TRK1, 1=TRK2)
		var len = Math.max(1, Math.min(8, Number(msg[1]) || 8));
		var track = Number(msg[2]) || 0;
		trackState[track].stagesLength = len;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_playback_order") {
		// msg[1] = order index (0-9), msg[2] = track (0=TRK1, 1=TRK2)
		var order = Math.max(0, Math.min(9, Number(msg[1]) || 0));
		var track = Number(msg[2]) || 0;
		trackState[track].playbackOrder = order;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_root_note") {
		// Stored for future quantizer use (Phase 2+), no-op in Phase 1
		rootNote = Math.max(0, Math.min(11, Number(msg[1]) || 0));
	}

	// Stage 2: per-track gate/velocity/division parameters

	if (msg[0] === "update_gate_length") {
		// msg[1] = gate length (1-100), msg[2] = track (0=TRK1, 1=TRK2)
		var val = Math.max(1, Math.min(100, Number(msg[1]) || 50));
		var track = Number(msg[2]) || 0;
		trackState[track].gateLength = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_gate_scale") {
		// msg[1] = gate scale (1-200), msg[2] = track (0=TRK1, 1=TRK2)
		var val = Math.max(1, Math.min(200, Number(msg[1]) || 100));
		var track = Number(msg[2]) || 0;
		trackState[track].gateScale = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_gate_stretching") {
		// msg[1] = gate stretching (0 or 1), msg[2] = track (0=TRK1, 1=TRK2)
		var val = Number(msg[1]) ? 1 : 0;
		var track = Number(msg[2]) || 0;
		trackState[track].gateStretching = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_pulse_count_div") {
		// msg[1] = pulse count division (1-8), msg[2] = track (0=TRK1, 1=TRK2)
		var val = Math.max(1, Math.min(8, Number(msg[1]) || 1));
		var track = Number(msg[2]) || 0;
		trackState[track].pulseCountDiv = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_velocity") {
		// msg[1] = velocity mode (0-3), msg[2] = track (0=TRK1, 1=TRK2)
		var val = Math.max(0, Math.min(3, Number(msg[1]) || 0));
		var track = Number(msg[2]) || 0;
		trackState[track].velocity = val;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_gate_overrides") {
		// msg[1..8] = gate override values (shared across both tracks)
		gateOverrides = msg.slice(1, 9).map(Number);
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}

	if (msg[0] === "update_rest_pitch") {
		// msg[1] = rest pitch mode (0=Hold, 1=Update), msg[2] = track (0=TRK1, 1=TRK2)
		var val = Number(msg[1]) ? 1 : 0;
		var track = Number(msg[2]) || 0;
		trackState[track].restPitch = val;
		sendTrackPatterns(track);
	}
}

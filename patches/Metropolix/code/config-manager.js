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

// Per-track state
const trackState = [
	{
		pitches: DEFAULT_PITCHES.slice(),
		pulseCounts: DEFAULT_PULSE_COUNTS.slice(),
		gateTypes: DEFAULT_GATE_TYPES.slice(),
		stagesLength: 8,
		stageOffset: 0,
		playbackOrder: 0,
		sliderOctaves: SLIDER_OCTAVES_DEFAULT
	},
	{
		pitches: DEFAULT_PITCHES.slice(),
		pulseCounts: DEFAULT_PULSE_COUNTS.slice(),
		gateTypes: DEFAULT_GATE_TYPES.slice(),
		stagesLength: 8,
		stageOffset: 0,
		playbackOrder: 0,
		sliderOctaves: SLIDER_OCTAVES_DEFAULT
	}
];

let rootNote = 0; // C

/**
 * Convert normalized slider values to MIDI note numbers.
 * note = bottom_pitch + round(slider * sliderOctaves * 12)
 */
function slidersToPitches(sliders, sliderOctaves, bottomPitch) {
	const range = sliderOctaves * 12;
	return sliders.map(s => Math.round(bottomPitch + s * range));
}

/**
 * Reorder an array according to the playback order and stages length.
 * Returns the reordered array that the signal-rate stepper traverses linearly.
 *
 * Orders: 0=Linear, 1=Ping Pong, 2=Pendulum, 3=Random, 4=Shuffle,
 * 5=Brownian, 6=Converge, 7=Diverge, 8=Pedal Point, 9=Hopscotch
 */
function buildPlaybackPattern(values, stagesLength, stageOffset, order) {
	const len = stagesLength;
	const baseIndices = [];
	for (let i = 0; i < len; i++) {
		baseIndices.push((i + stageOffset) % 8);
	}

	let ordered;
	switch (order) {
		case 0: // Linear
			ordered = baseIndices;
			break;
		case 1: { // Ping Pong: 0,1,...,N-1,N-2,...,1
			ordered = baseIndices.slice();
			if (len > 2) {
				for (let i = len - 2; i >= 1; i--) {
					ordered.push(baseIndices[i]);
				}
			}
			break;
		}
		case 2: { // Pendulum: 0,1,...,N-1,N-1,N-2,...,0,0
			ordered = baseIndices.slice();
			for (let i = len - 1; i >= 0; i--) {
				ordered.push(baseIndices[i]);
			}
			break;
		}
		case 6: { // Converge: 0,N-1,1,N-2,2,...
			ordered = [];
			let lo = 0, hi = len - 1;
			while (lo <= hi) {
				ordered.push(baseIndices[lo]);
				if (lo !== hi) ordered.push(baseIndices[hi]);
				lo++;
				hi--;
			}
			break;
		}
		case 7: { // Diverge: mid,mid+1,mid-1,mid+2,...
			ordered = [];
			const mid = Math.floor(len / 2);
			ordered.push(baseIndices[mid]);
			for (let d = 1; d < len; d++) {
				if (mid + d < len) ordered.push(baseIndices[mid + d]);
				if (mid - d >= 0) ordered.push(baseIndices[mid - d]);
			}
			break;
		}
		case 8: { // Pedal Point: 0,1,0,2,0,3,...
			ordered = [];
			for (let i = 1; i < len; i++) {
				ordered.push(baseIndices[0]);
				ordered.push(baseIndices[i]);
			}
			if (len === 1) ordered.push(baseIndices[0]);
			break;
		}
		case 9: { // Hopscotch: 0,2,4,...,1,3,5,...
			ordered = [];
			for (let i = 0; i < len; i += 2) ordered.push(baseIndices[i]);
			for (let i = 1; i < len; i += 2) ordered.push(baseIndices[i]);
			break;
		}
		default: // Random, Shuffle, Brownian fall back to Linear for Phase 1
			ordered = baseIndices;
	}

	return ordered.map(idx => values[idx]);
}

/**
 * Send all sequencer patterns for a given track.
 */
function sendTrackPatterns(track) {
	const st = trackState[track];
	const prefix = track === 0 ? "trk1" : "trk2";
	const pitches = slidersToPitches(st.pitches, st.sliderOctaves, BOTTOM_PITCH_DEFAULT + rootNote);
	const orderedPitches = buildPlaybackPattern(pitches, st.stagesLength, st.stageOffset, st.playbackOrder);
	const orderedPulses = buildPlaybackPattern(st.pulseCounts, st.stagesLength, st.stageOffset, st.playbackOrder);
	const orderedGates = buildPlaybackPattern(st.gateTypes, st.stagesLength, st.stageOffset, st.playbackOrder);

	outlet(0, "pitches_" + prefix, ...orderedPitches);
	outlet(0, "pulses_" + prefix, ...orderedPulses);
	outlet(0, "gatetypes_" + prefix, ...orderedGates);
}

/**
 * Handle incoming messages from the patcher.
 */
function anything() {
	const msg = arrayfromargs(messagename, arguments);

	if (msg[0] === "init") {
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}

	if (msg[0] === "update_pitches") {
		// msg[1..8] = slider values, msg[9] = track (0=TRK1, 1=TRK2)
		const sliders = msg.slice(1, 9).map(Number);
		const track = Number(msg[9]) || 0;
		trackState[track].pitches = sliders;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_stages_length") {
		// msg[1] = stages length (1-8), msg[2] = track (0=TRK1, 1=TRK2)
		const len = Math.max(1, Math.min(8, Number(msg[1]) || 8));
		const track = Number(msg[2]) || 0;
		trackState[track].stagesLength = len;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_playback_order") {
		// msg[1] = order index (0-9), msg[2] = track (0=TRK1, 1=TRK2)
		const order = Math.max(0, Math.min(9, Number(msg[1]) || 0));
		const track = Number(msg[2]) || 0;
		trackState[track].playbackOrder = order;
		sendTrackPatterns(track);
	}

	if (msg[0] === "update_root_note") {
		// msg[1] = root note (0-11, C=0)
		rootNote = Math.max(0, Math.min(11, Number(msg[1]) || 0));
		sendTrackPatterns(0);
		sendTrackPatterns(1);
	}
}

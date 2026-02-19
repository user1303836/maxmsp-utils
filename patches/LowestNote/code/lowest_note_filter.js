"use strict";

// Lowest Note Filter for Max4Live
// Buffers simultaneous note-ons (within a time window) and passes
// only the lowest pitch through. Note-offs for suppressed notes
// are also suppressed.
//
// Inlet 0: note data [pitch, velocity] from midiparse (also accepts "reset")
// Inlet 1: bang from delay (chord window expired)
// Outlet 0: filtered note data [pitch, velocity] to midiformat
// Outlet 1: timer control messages to delay object

inlets = 2;
outlets = 2;

// pitch -> velocity for notes buffered in the current chord window
let tempNotes = {};
// pitch -> true for notes we actually sent (so we know which note-offs to forward)
let sentNotes = {};

function list() {
	if (inlet === 0) {
		const pitch = arguments[0];
		const vel = arguments[1];

		if (vel > 0) {
			onNoteOn(pitch, vel);
		} else {
			onNoteOff(pitch);
		}
	}
}

function onNoteOn(pitch, vel) {
	tempNotes[pitch] = vel;

	// Restart the chord-detection window.
	// stop cancels any pending delay, then bang starts a fresh one.
	outlet(1, "stop");
	outlet(1, "bang");
}

function onNoteOff(pitch) {
	// If this pitch is still sitting in the temp buffer (window hasn't
	// fired yet), remove it so it doesn't participate in chord detection.
	if (pitch in tempNotes) {
		delete tempNotes[pitch];
	}

	// Only forward the note-off if we actually sent the corresponding note-on.
	if (pitch in sentNotes) {
		outlet(0, pitch, 0);
		delete sentNotes[pitch];
	}
}

function bang() {
	// Inlet 1: chord window timer fired — process buffered notes
	if (inlet === 1) {
		processWindow();
	}
}

function processWindow() {
	const pitches = Object.keys(tempNotes);
	if (pitches.length === 0) return;

	// Find the lowest pitch
	let lowestPitch = Number(pitches[0]);
	let lowestVel = tempNotes[lowestPitch];

	for (let i = 1; i < pitches.length; i++) {
		const p = Number(pitches[i]);
		if (p < lowestPitch) {
			lowestPitch = p;
			lowestVel = tempNotes[p];
		}
	}

	outlet(0, lowestPitch, lowestVel);
	sentNotes[lowestPitch] = true;

	tempNotes = {};
}

// Reset all state — called by live.thisdevice on init and deactivation.
// Sends note-offs for any currently held notes before clearing.
function reset() {
	outlet(1, "stop");
	for (const pitch of Object.keys(sentNotes)) {
		outlet(0, Number(pitch), 0);
	}
	tempNotes = {};
	sentNotes = {};
}

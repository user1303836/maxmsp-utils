"use strict";

// Lowest Note Filter for Max4Live
// Buffers simultaneous note-ons (within a time window) and passes
// only the lowest pitch through. Note-offs for suppressed notes
// are also suppressed.
//
// Inlet 0: note data [pitch, velocity] from midiparse
// Inlet 1: bang from delay (chord window expired)
// Outlet 0: filtered note data [pitch, velocity] to midiformat
// Outlet 1: timer control messages to delay object

inlets = 2;
outlets = 2;

var WINDOW_MS = 7;

// pitch -> velocity for notes buffered in the current chord window
var tempNotes = {};
// pitch -> true for notes we actually sent (so we know which note-offs to forward)
var sentNotes = {};

function list() {
	if (inlet === 0) {
		var pitch = arguments[0];
		var vel = arguments[1];

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
	var pitches = Object.keys(tempNotes);
	if (pitches.length === 0) return;

	// Find the lowest pitch
	var lowestPitch = Number(pitches[0]);
	var lowestVel = tempNotes[lowestPitch];

	for (var i = 1; i < pitches.length; i++) {
		var p = Number(pitches[i]);
		if (p < lowestPitch) {
			lowestPitch = p;
			lowestVel = tempNotes[p];
		}
	}

	outlet(0, lowestPitch, lowestVel);
	sentNotes[lowestPitch] = true;

	tempNotes = {};
}

// Reset all state (useful for live.thisdevice init or panic)
function reset() {
	// Send note-offs for any currently held notes before clearing
	for (var pitch in sentNotes) {
		outlet(0, Number(pitch), 0);
	}
	tempNotes = {};
	sentNotes = {};
}

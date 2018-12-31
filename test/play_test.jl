using Test

using Revise
using CureMIDI
import MIDI
import SampledSignals

import PortAudio

# pitch, velocity, position, duration,channel
C = MIDI.Note(60, 96, 0, 3000)
notes = MIDI.Notes()
push!(notes, C)

track = MIDI.MIDITrack()
MIDI.addnotes!(track, notes)


tpq = Int16(960)
bpm = 60
sample_rate = 44100
sampled_buf = synth(track, tpq, bpm, sample_rate, "violin_sample.sf2")

#stream = PortAudio.PortAudioStream(0, 2)
#PortAudio.write(stream, sampled_buf)

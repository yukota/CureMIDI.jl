using Test

import MIDI
import SampledSignals

using Revise
using CureMIDI

@testset "basic synth" begin

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

    # import PortAudio
    # stream = PortAudio.PortAudioStream(0, 2)
    # PortAudio.write(stream, sampled_buf)
end


@testset "pitch range" begin
    test_note = [MIDI.Note(0, 127, 0, 100), MIDI.Note(127, 127, 0, 100)]
    for note in test_note
        notes = MIDI.Notes()
        push!(notes, note)

        track = MIDI.MIDITrack()
        MIDI.addnotes!(track, notes)
        tpq = Int16(960)
        bpm = 60
        sample_rate = 44100
        sampled_buf = synth(track, tpq, bpm, sample_rate, "violin_sample.sf2")
        #import PortAudio
        #stream = PortAudio.PortAudioStream(0, 2)
        #PortAudio.write(stream, sampled_buf)
    end
end

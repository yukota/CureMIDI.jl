module CureMIDI

import FluidSynth
import SampledSignals
import MIDI

export synth
export tick_to_frame, tick_to_ms, ms_to_tick

"""
Synthesize a block of 16 bit audio samples to audio buffers.
# Arguments
- `track::MIDI.MIDITrack`
- `tpq::Int16`
- 'bpm::Real'
- 'sample_rate::Real'
- 'sound_font::AbstractString'
"""
function synth(track::MIDI.MIDITrack, tpq::Int16, bpm::Real, sample_rate::Real, sound_font::AbstractString)

    settings = FluidSynth.Settings()
    synth = FluidSynth.Synth(settings)
    # settings
    FluidSynth.set_sample_rate(synth, Float32(sample_rate))

    # load sound font
    sfont_id = FluidSynth.sfload(synth, sound_font)
    FluidSynth.program_select(synth, Int32(0), sfont_id, Int32(0), Int32(0))

    # allocate full buffer
    full_ticks = 0
    for note in  MIDI.getnotes(track)
        full_ticks = max(full_ticks, note.position + note.duration)
    end

    full_frames = tick_to_frame(full_ticks, tpq, bpm, sample_rate)
    left_full_buf = zeros(Float32, full_frames)
    right_full_buf = zeros(Float32, full_frames)

    left_note_buf = zeros(Float32, full_frames)
    right_note_buf = zeros(Float32, full_frames)
    for note in MIDI.getnotes(track)
        note_frames = tick_to_frame(note.position, tpq, bpm, sample_rate)
        fill!(left_note_buf, 0)
        fill!(right_note_buf, 0)

        channel = Int32(note.channel)
        pitch = Int32(note.pitch)
        velocity = Int32(note.velocity)
        FluidSynth.noteon(synth, channel, pitch, velocity)
        start_frames = tick_to_frame(note.position, tpq, bpm, sample_rate)
        duration_frames = tick_to_frame(note.duration, tpq, bpm, sample_rate)

        FluidSynth.write_float(synth, Int32(duration_frames), left_note_buf, Int32(start_frames) , Int32(1), right_note_buf, Int32(start_frames), Int32(1))
        try
            FluidSynth.noteoff(synth, channel, pitch)
        catch
            # sometimes, noteoff fail.
            # But not affect playing. so ignore error.
        end

        left_full_buf += left_note_buf
        right_full_buf += right_note_buf
    end

    buf = hcat(left_full_buf, right_full_buf)
    sampled_buf = SampledSignals.SampleBuf(buf, sample_rate)
    return sampled_buf
end

# support functions
"""
Convert from tick to synthsized result buffer index.
# Arguments
- 'tick::Uint' : ticks.
- `tpq::Int16` : Ticks per quarter note.
- `bpm::Real` : Beat per min. Beat means quater notes in this library.
- `sample_rate::Real` : Beat per min. Beat means quater notes in this library.
"""
function tick_to_frame(tick::UInt, tpq::Int16, bpm::Real, sample_rate::Real)
    ms_per_tick = MIDI.ms_per_tick(tpq, bpm)
    full_ms = ms_per_tick * tick
    frames = sample_rate * full_ms / 1000
    return UInt(ceil(frames))
end

"""
Convert from tick to millisecond.
# Arguments
- 'tick::Uint' : ticks.
- `tpq::Int16` : Ticks per quarter note.
- `bpm::Real` : Beat per min. Beat means quater notes in this library.
"""
function tick_to_ms(tick::UInt, tpq::Int16, bpm::Real)
    ms_per_tick = MIDI.ms_per_tick(tpq, bpm)
    return  tick * ms_per_tick
end

"""
Convert from millisecond to tick.
# Arguments
- 'ms::Real' : milliseconds.
- `tpq::Int16` : Ticks per quarter note.
- `bpm::Real` : Beat per min. Beat means quater notes in this library.
"""
function ms_to_tick(ms::Real, tpq::Int16, bpm::Real)
    ms_per_tick = MIDI.ms_per_tick(tpq, bpm)
    return  ms / ms_per_tick
end

end #module

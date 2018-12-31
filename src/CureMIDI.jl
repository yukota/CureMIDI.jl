module CureMIDI

import fluidsynth
import SampledSignals
import MIDI

export synth

"""
Synthesize a block of 16 bit audio samples to audio buffers.
# Arguments
- `len` : Count of audio frames to synthesize
- `bps` : Beat per seconds. Beat means quater notes in this library.
"""
function synth(track::MIDI.MIDITrack, tpq::Int16, bpm::Real, sample_rate::Real, sound_font::AbstractString)

    settings = fluidsynth.Settings()
    synth = fluidsynth.Synth(settings)
    # settings
    fluidsynth.set_sample_rate(synth, Float32(sample_rate))

    # load sound font
    sfont_id = fluidsynth.sfload(synth, sound_font)
    fluidsynth.program_select(synth, Int32(0), sfont_id, Int32(0), Int32(0))

    # allocate full buffer
    full_ticks = 0
    for note in  MIDI.getnotes(track)
        full_ticks = max(full_ticks, note.position + note.duration)
    end

    full_frames = ticks_to_frames(full_ticks, tpq, bpm, sample_rate)
    left_full_buf = zeros(Float32, full_frames)
    right_full_buf = zeros(Float32, full_frames)

    left_note_buf = zeros(Float32, full_frames)
    right_note_buf = zeros(Float32, full_frames)
    for note in MIDI.getnotes(track)
        note_frames = ticks_to_frames(note.position, tpq, bpm, sample_rate)
        fill!(left_note_buf, 0)
        fill!(right_note_buf, 0)

        channel = Int32(note.channel)
        pitch = Int32(note.pitch)
        velocity = Int32(note.velocity)
        fluidsynth.noteon(synth, channel, pitch, velocity)
        start_frames = ticks_to_frames(note.position, tpq, bpm, sample_rate)
        duration_frames = ticks_to_frames(note.duration, tpq, bpm, sample_rate)

        fluidsynth.write_float(synth, Int32(duration_frames), left_note_buf, Int32(start_frames) , Int32(1), right_note_buf, Int32(start_frames), Int32(1))
        fluidsynth.noteoff(synth, channel, pitch)

        left_full_buf += left_note_buf
        right_full_buf += right_note_buf
    end

  buf = hcat(left_full_buf, right_full_buf)
  sampled_buf = SampledSignals.SampleBuf(buf, sample_rate)
  return sampled_buf
end

# support functions
function ticks_to_frames(ticks::UInt, tpq::Int16, bpm::Real, sample_rate::Real)
    ms_per_tick = MIDI.ms_per_tick(tpq, bpm)
    full_ms = ms_per_tick * ticks
    frames = sample_rate * full_ms / 1000
    return UInt(ceil(frames))
end


end #module

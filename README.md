# CureMIDI.jl
[![Build Status](https://travis-ci.com/yukota/CureMIDI.jl.svg?branch=master)](https://travis-ci.com/yukota/CureMIDI.jl)

Utility functions for handling MIDI data.

## Install
### Install PortAudio.jl
CureMIDI.jl depends on PortAduio.jl.
PortAudio.jl need install by below steps in Pkg REPL-mode.
```
add PortAudio#julia1
add RingBuffers#master
build RingBuffers
build PortAudio
```

### Install FluidSynth.jl
CureMIDI.jl depends on FluidSynth.jl
FluidSynth.jl don't regisered in METADATA.
Please install it manually.
```
add https://github.com/yukota/FluidSynth.jl
```

### Install CureMIDI.jl
In Pkg REPL-mode.
```
add https://github.com/yukota/CureMIDI.jl.git
```

## Usage
### Convert MIDI(MIDI.jl) to SampleBuf(SampledSignals.jl)
PortAudio can sound SampleBuf type.
To sound MIDI, CureMIDI convert MIDI to SampleBuf.
```julia
track = MIDI.MIDITrack()

tpq = Int16(960)
bpm = 60
sample_rate = 44100
sampled_buf = synth(track, tpq, bpm, sample_rate, "violin_sample.sf2")
```

# Documentation
documentation page: https://yukota.github.io/CureMIDI.jl/dev/

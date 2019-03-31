var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Introduction",
    "title": "Introduction",
    "category": "page",
    "text": ""
},

{
    "location": "#Introduction-1",
    "page": "Introduction",
    "title": "Introduction",
    "category": "section",
    "text": "CureMIDI.jl is a utility package for playing MIDI."
},

{
    "location": "reference/#",
    "page": "Reference",
    "title": "Reference",
    "category": "page",
    "text": ""
},

{
    "location": "reference/#CureMIDI.synth",
    "page": "Reference",
    "title": "CureMIDI.synth",
    "category": "function",
    "text": "Synthesize a block of 16 bit audio samples to audio buffers.\n\nArguments\n\ntrack::MIDI.MIDITrack\ntpq::Int16\n\'bpm::Real\'\n\'sample_rate::Real\'\n\'sound_font::AbstractString\'\n\n\n\n\n\n"
},

{
    "location": "reference/#CureMIDI.tick_to_frame",
    "page": "Reference",
    "title": "CureMIDI.tick_to_frame",
    "category": "function",
    "text": "Convert from tick to synthsized result buffer index.\n\nArguments\n\n\'tick::Uint\' : ticks.\ntpq::Int16 : Ticks per quarter note.\nbpm::Real : Beat per min. Beat means quater notes in this library.\nsample_rate::Real : Beat per min. Beat means quater notes in this library.\n\n\n\n\n\n"
},

{
    "location": "reference/#CureMIDI.tick_to_ms",
    "page": "Reference",
    "title": "CureMIDI.tick_to_ms",
    "category": "function",
    "text": "Convert from tick to millisecond.\n\nArguments\n\n\'tick::Uint\' : ticks.\ntpq::Int16 : Ticks per quarter note.\nbpm::Real : Beat per min. Beat means quater notes in this library.\n\n\n\n\n\n"
},

{
    "location": "reference/#CureMIDI.ms_to_tick",
    "page": "Reference",
    "title": "CureMIDI.ms_to_tick",
    "category": "function",
    "text": "Convert from millisecond to tick.\n\nArguments\n\n\'ms::Real\' : milliseconds.\ntpq::Int16 : Ticks per quarter note.\nbpm::Real : Beat per min. Beat means quater notes in this library.\n\n\n\n\n\n"
},

{
    "location": "reference/#Reference-1",
    "page": "Reference",
    "title": "Reference",
    "category": "section",
    "text": "CurrentModule = CureMIDIsynth\ntick_to_frame\ntick_to_ms\nms_to_tick"
},

]}

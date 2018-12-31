using Test

using Revise

import CureMIDI


frames = CureMIDI.ticks_to_frames(UInt(192), Int16(960), 60, 44100)

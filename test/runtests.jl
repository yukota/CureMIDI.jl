using Test

@time @testset "private method test" begin include("util_test.jl") end
@time @testset "Sound play test" begin include("play_test.jl") end
#@time @testset "Midi file rendering Test" begin include("midifile_rendering_test.jl") end
# below test is need sound output.
# @time @testset "Audio driver Test" begin include("audiodriver_test.jl") end
# @time @testset "Midi file audio driver Test" begin include("midifile_play_test.jl") end

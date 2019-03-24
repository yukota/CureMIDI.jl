using Test

@time @testset "private method test" begin include("util_test.jl") end
@time @testset "Sound play test" begin include("play_test.jl") end
using Test

using Revise

import CureMIDI


 @testset "tick_to_ms test" begin
    @test CureMIDI.tick_to_ms(UInt(100), Int16(100), 100) == 600

end

@testset "ms_to_tick test" begin
    @test CureMIDI.ms_to_tick(600, Int16(100), 100) == 100

end

using AdventOfCode2021Julia
using Test

@testset "Day 1" begin
    @test AdventOfCode2021Julia.Day01.part1() == 1167
    @test AdventOfCode2021Julia.Day01.part2() == 1130
end

@testset "Day 2" begin
    @test AdventOfCode2021Julia.Day02.part1() == 1840243
    @test AdventOfCode2021Julia.Day02.part2() == 1727785422
end
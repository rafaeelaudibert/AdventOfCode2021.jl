
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

@testset "Day 3" begin
    @test AdventOfCode2021Julia.Day03.part1() == 2261546
    @test AdventOfCode2021Julia.Day03.part2() == 6775520
end

@testset "Day 4" begin
    @test AdventOfCode2021Julia.Day04.part1() == 87456
    @test AdventOfCode2021Julia.Day04.part2() == 15561
end

@testset "Day 5" begin
    @test AdventOfCode2021Julia.Day05.part1() == 5690
    @test AdventOfCode2021Julia.Day05.part2() == 17741
end
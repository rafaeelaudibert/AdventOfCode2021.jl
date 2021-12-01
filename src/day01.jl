module Day01

using AdventOfCode2021Julia

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day01.txt")))
    reports = parse_input(input)
    return count(diff(reports) .> 0)
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day01.txt")))
    reports = parse_input(input)
    sums = [a + b + c for (a, b, c) ∈ zip(reports[1:end], reports[2:end], reports[3:end])]
    return count(diff(sums) .> 0)
end

function parse_input(input::String)
    return parse.(Int, split(input))
end

end
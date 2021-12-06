module Day06

using AdventOfCode2021Julia

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day06.txt")))
    return solve_for(input, 80)
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day06.txt")))
    return solve_for(input, 256)
end

function solve_for(input::String, iters::Int64)
    parsed_input = parse.(Int8, split(input, ","))
    table = zeros(Int128, 9)

    # Fill base values
    for value in parsed_input
        @inbounds table[value+1] = table[value+1] + 1
    end

    # Optimized recurrent logic
    for iter = 1:iters-1
        @inbounds table[((iter+7)%9)+1] += table[(iter%9)+1]
    end

    return sum(table)
end
end

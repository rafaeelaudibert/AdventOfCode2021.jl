module Day06

using AdventOfCode2021Julia

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day06.txt")))
    return solve_for(input, 80)
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day06.txt")))
    return solve_for(input, 256)
end

function solve_for(input::String, iters::Int64)
    @time parsed_input = parse.(Int, split(rstrip(input), ","))
    table = zeros(Int128, iters + 1, 9) # Iters + 1 because it doesn't start on day 9

    # Fill first row of the table
    for value in parsed_input
        table[1, value+1] = table[1, value+1] + 1
    end

    # Unrolled because of efficiency
    for iter = 1:iters
        table[iter+1, 1] = table[iter, 2]
        table[iter+1, 2] = table[iter, 3]
        table[iter+1, 3] = table[iter, 4]
        table[iter+1, 4] = table[iter, 5]
        table[iter+1, 5] = table[iter, 6]
        table[iter+1, 6] = table[iter, 7]
        table[iter+1, 7] = table[iter, 8] + table[iter, 1] # Need to count the fishes which just reset
        table[iter+1, 8] = table[iter, 9]
        table[iter+1, 9] = table[iter, 1] # These are the new fishes
    end

    return sum(table[iters+1, :])
end
end

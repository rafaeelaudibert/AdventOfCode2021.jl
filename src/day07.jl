module Day07

using AdventOfCode2021Julia

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day07.txt")))
    parsed_input = parse_input(input)
    return compute_min_distance(parsed_input, (x, y) -> abs.(x .- y))
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day07.txt")))
    parsed_input = parse_input(input)
    return compute_min_distance(parsed_input, gauss_distance)
end

function parse_input(input::String)
    return parse.(Int, split(input, ","))
end

function compute_min_distance(values, distance_func)
    min_val, max_val = extrema(values)
    return Int64(min(map(pos -> sum(distance_func.(values, pos)), min_val:max_val)...))
end

function gauss_distance(pos, desired_pos)
    dist = abs(pos - desired_pos)
    return (dist * (dist + 1)) / 2
end
end

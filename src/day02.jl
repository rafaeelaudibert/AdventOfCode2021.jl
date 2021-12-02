module Day02

using AdventOfCode2021Julia

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day02.txt")))
    directions = parse_input(input)
    return prod(reduce(compute_position, directions, init = (0, 0)))
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day02.txt")))
    directions = parse_input(input)
    return prod(reduce(compute_position, directions, init = (0, 0, 0))[1:2]) # Notice this slicing, because we don't want to multiply the aim
end

function parse_input(input::String)
    return [split(pos, " ") for pos ∈ split(input, "\n")]
end

function compute_position(
    old_position::Tuple{Int64,Int64}, # X, Y
    direction::Vector{SubString{String}},
)
    rule = direction[1]
    offset = parse(Int, direction[2])

    if rule == "forward"
        return (old_position[1] + offset, old_position[2])
    elseif rule == "down"
        return (old_position[1], old_position[2] + offset)
    elseif rule == "up"
        return (old_position[1], old_position[2] - offset)
    end
end

function compute_position(
    old_position::Tuple{Int64,Int64,Int64}, # X, Y, aim
    direction::Vector{SubString{String}},
)
    rule = direction[1]
    offset = parse(Int, direction[2])

    if rule == "forward"
        return (
            old_position[1] + offset,
            old_position[2] + old_position[3] * offset,
            old_position[3],
        )
    elseif rule == "down"
        return (old_position[1], old_position[2], old_position[3] + offset)
    elseif rule == "up"
        return (old_position[1], old_position[2], old_position[3] - offset)
    end
end

end
module Day03

using AdventOfCode2021Julia

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day03.txt")))
    integers = parse_input(input)
    matrix = parse_zipped_matrix(integers)

    gamma, epsilon = compute_gamma_epsilon(matrix)
    return gamma * epsilon
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day03.txt")))
    integers = parse_input(input)
    oxygen, co2 = compute_oxygen_co2(integers)
    return oxygen * co2
end

function parse_input(input::String)
    return [parse01.(split(pos, "")) for pos ∈ split(input, "\n")]
end

function parse_zipped_matrix(integers)
    matrix = Array{Int8,2}(undef, length(first(integers)), length(integers))
    for (index, integer) ∈ enumerate(integers)
        matrix[:, index] = integer
    end

    return matrix
end

function compute_gamma_epsilon(matrix)
    most_common = compute_most_common.(eachrow(matrix))
    less_common = compute_inverse.(most_common)

    return vector_to_binary.((most_common, less_common))
end

function compute_oxygen_co2(integers)
    oxygen = compute_by_func(integers, compute_most_common)
    co2 = compute_by_func(integers, list -> compute_inverse(compute_most_common(list)))

    return vector_to_binary.((oxygen, co2))
end

function compute_by_func(list, func)
    idx = 0 # We are treating this as 0-indexed because of the modulo operation, so we need to +1 every time we use this
    while length(list) > 1
        chosen = func([row[idx+1] for row in list])

        list = filter(row -> row[idx+1] == chosen, list)

        idx += 1
        idx %= size(list[1], 1)
    end

    return list[1]
end

function compute_most_common(row)
    row_length = size(row, 1)
    count1 = count(==(1), row)
    return count1 >= row_length - count1 ? 1 : 0 # If same value, we keep 1 as described on the part 2 of the problem
end

function compute_inverse(value)
    return value == 0 ? 1 : 0
end

function vector_to_binary(vector)
    parse(Int, join(vector), base = 2)
end

function parse01(val)
    return val == "0" ? 0 : 1
end
end
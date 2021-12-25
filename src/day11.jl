module Day11

using AdventOfCode2021Julia

using DataStructures

SMALLEST_VALUE = typemin(Int)
RESET_VALUE = 0
FLASH_LIMIT = 9

# These are all of the possible 8 neighbours (even diagonal ones)
NEIGHBOURS = [
    CartesianIndex(-1, -1),
    CartesianIndex(0, -1),
    CartesianIndex(1, -1),
    CartesianIndex(-1, 0),
    CartesianIndex(1, 0),
    CartesianIndex(-1, 1),
    CartesianIndex(0, 1),
    CartesianIndex(1, 1),
]

toarray(s::Union{Set,Vector}) = [toarray.(s)...]
toarray(v) = v

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day11.txt")))
    matrix = parse_input(input)

    total_blinked = 0
    for _ = 1:100
        matrix, blinked = run_round(matrix)
        total_blinked += blinked
    end

    total_blinked
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day11.txt")))
    matrix = parse_input(input)

    # This is a fake size because we have an extra border all around it
    fake_matrix_size = size(matrix)
    matrix_length = (fake_matrix_size[1] - 2) * (fake_matrix_size[2] - 2)

    # We run this until the first time every position blinks
    for round = 1:typemax(Int)
        matrix, blinked = run_round(matrix)
        blinked == matrix_length && return round
    end
end

function run_round(matrix)
    # Sum 1 to every value on the matrix
    matrix .+= 1

    # We save here every value which has ever blinked
    blinked = Set{CartesianIndex{2}}()

    # We will keep iterating until no position has blinked
    while true
        # Get which position should blink now
        blinked_positions = Set(findall(val -> val > FLASH_LIMIT, matrix))

        # New blinked positions are the ones that blinked now and hadn't blinked before
        # Also, if no new positions blinked, stop the ieration
        new_blinked_positions = setdiff(blinked_positions, blinked)
        length(new_blinked_positions) == 0 && break

        # Get the positions of every position that should increase their power
        # And increase it on the matrix
        for new_blinked_position in new_blinked_positions
            for neighbour in NEIGHBOURS
                position = neighbour + new_blinked_position
                matrix[position] += 1
            end
        end

        # Add every position that blinked to the set
        push!(blinked, blinked_positions...)
    end

    # Reset the value to 0 for every one that blinked
    if length(blinked) > 0
        matrix[toarray(blinked)] .= RESET_VALUE
    end

    return matrix, length(blinked)
end

function parse_input(input::String)
    matrix = vecvec_to_matrix(map(row -> parse.(Int8, split(row, "")), split.(input, "\n")))
    matrix_size = size(matrix)

    # We are going to build a matrix with big values all around the matrix,
    # to help on part2
    return [
        fill(SMALLEST_VALUE, (1, matrix_size[2] + 2))
        fill(SMALLEST_VALUE, matrix_size[1]) matrix fill(SMALLEST_VALUE, matrix_size[1])
        fill(SMALLEST_VALUE, (1, matrix_size[2] + 2))
    ]
end

function vecvec_to_matrix(vecvec::AbstractVector{T}) where {T<:AbstractVector}
    transpose(hcat(vecvec...))
end
end

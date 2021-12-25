module Day09

using AdventOfCode2021Julia

using DataStructures

HIGHER_VALUE = 10

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day09.txt")))
    parsed_input = parse_input(input)

    low_points_index = get_low_points_index(parsed_input)
    return sum(parsed_input[low_points_index] .+ 1)
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day09.txt")))
    parsed_input = parse_input(input)

    low_points_index = get_low_points_index(parsed_input)
    basin_sizes = sort!(
        [
            compute_basin_size(parsed_input, low_point_index) for
            low_point_index in low_points_index
        ],
        rev = true,
    )

    # Multiply the 3 largest basins
    prod(basin_sizes[1:3])
end

function get_low_points_index(matrix)
    matrix_size = size(matrix)

    smaller_than_right = matrix .< [matrix[:, 2:end] fill(HIGHER_VALUE, matrix_size[1])]
    smaller_than_left = matrix .< [fill(HIGHER_VALUE, matrix_size[1]) matrix[:, 1:end-1]]
    smaller_than_top = matrix .< [matrix[2:end, :]; fill(HIGHER_VALUE, (1, matrix_size[2]))]
    smaller_than_bottom =
        matrix .< [fill(HIGHER_VALUE, (1, matrix_size[2])); matrix[1:end-1, :]]

    findall(
        smaller_than_right .& smaller_than_left .& smaller_than_top .& smaller_than_bottom,
    )
end

OFFSET_INDEXES = [
    CartesianIndex(-1, 0),
    CartesianIndex(1, 0),
    CartesianIndex(0, -1),
    CartesianIndex(0, 1),
]
function compute_basin_size(matrix, basin_index)
    searched = Set{CartesianIndex{2}}()
    queue = Queue{CartesianIndex{2}}()

    enqueue!(queue, basin_index)
    while !isempty(queue)
        top = dequeue!(queue)
        top in searched && continue

        searched = push!(searched, top)
        for offset_index in OFFSET_INDEXES
            index = offset_index + top

            # We don't need to check if we are inside the grid, because of the way we build the matrix
            # with some fake "walls" wight HIGHER_VALUEs all around it
            matrix[index] < 9 && enqueue!(queue, index)
        end
    end

    length(searched)
end

function parse_input(input::String)
    matrix = vecvec_to_matrix(map(row -> parse.(Int8, split(row, "")), split.(input, "\n")))
    matrix_size = size(matrix)

    # We are going to build a matrix with big values all around the matrix,
    # to help on part2
    return [
        fill(HIGHER_VALUE, (1, matrix_size[2] + 2))
        fill(HIGHER_VALUE, matrix_size[1]) matrix fill(HIGHER_VALUE, matrix_size[1])
        fill(HIGHER_VALUE, (1, matrix_size[2] + 2))
    ]
end

function vecvec_to_matrix(vecvec::AbstractVector{T}) where {T<:AbstractVector}
    transpose(hcat(vecvec...))
end

end

module Day04

using AdventOfCode2021Julia

ROWS_NUMBER = 5

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day04.txt")))
    numbers, matrices = parse_input(input)
    matrices = generate_bit_matrices(matrices)

    winning_matrix, winning_bit_matrix, winning_number, _, _, _ =
        run_bingo(numbers, matrices)
    return winning_number * sum(winning_matrix[findall((!).(winning_bit_matrix))])
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day04.txt")))
    numbers, matrices = parse_input(input)
    matrices = generate_bit_matrices(matrices)

    # Keep running bingo until we have our last matrix
    while size(matrices, 1) > 1
        _, _, winning_number, winning_matrix_idx, matrices, remaining_numbers =
            run_bingo(numbers, matrices)

        numbers = [winning_number; remaining_numbers] # We need to keep the last used number because might have bingoed more than once
        matrices = [matrices[1:winning_matrix_idx-1]; matrices[winning_matrix_idx+1:end]] # Remove the chosen matrix
    end

    winning_matrix, winning_bit_matrix, winning_number, _, _, _ =
        run_bingo(numbers, matrices)
    return winning_number * sum(winning_matrix[findall((!).(winning_bit_matrix))])
end

function parse_input(input::String)
    lines = split(input, "\n")

    integers = parse.(Int, split(lines[1], ","))
    matrix_lines = lines[2:end]

    matrix_count = Int64(size(matrix_lines, 1) / (ROWS_NUMBER + 1))
    matrices = [
        split.(
            matrix_lines[(matrix_idx*(ROWS_NUMBER+1))+2:((matrix_idx+1)*(ROWS_NUMBER+1))],
        ) for matrix_idx = 0:(matrix_count-1)
    ]

    int_matrices =
        vecvec_to_matrix.([[parse.(Int, vec) for vec in matrix] for matrix in matrices])

    return integers, int_matrices
end

function run_bingo(numbers, matrices)
    local winning_matrix, winning_bit_matrix, winning_number, winning_matrix_idx
    for number in numbers
        matrices = fill_number.(matrices, number)
        first = findfirst(is_bingo, matrices)

        if first !== nothing
            (winning_matrix, winning_bit_matrix) = matrices[first]
            winning_matrix_idx = first
            winning_number = number
            break
        end
    end

    remaining_numbers = numbers[findfirst(x -> x == winning_number, numbers)+1:end]

    return (
        winning_matrix,
        winning_bit_matrix,
        winning_number,
        winning_matrix_idx,
        matrices,
        remaining_numbers,
    )
end

function fill_number((bingo_matrix, bit_matrix), number)
    position = findall(x -> x == number, bingo_matrix)
    bit_matrix[position] .= true

    return (bingo_matrix, bit_matrix)
end

function is_bingo((bingo_matrix, bit_matrix))
    return any(all(bit_matrix[i, :]) for i = 1:size(bit_matrix, 1)) ||
           any(all(bit_matrix[:, j]) for j = 1:size(bit_matrix, 2))
end

function generate_bit_matrices(matrices)
    return map(matrix -> (matrix, BitMatrix(undef, size(matrix)...)), matrices)
end

function vecvec_to_matrix(vecvec::AbstractVector{T}) where {T<:AbstractVector}
    transpose(hcat(vecvec...))
end
end
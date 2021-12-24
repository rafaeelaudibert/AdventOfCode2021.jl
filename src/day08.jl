module Day08

using AdventOfCode2021Julia

UNIQUE_TO_NUMBER =
    Dict([(2, [1]), (3, [7]), (4, [4]), (5, [2, 3, 5]), (6, [6, 9, 0]), (7, [8])])


function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day08.txt")))
    parsed_input = parse_input(input)

    return count(
        size -> size == 2 || size == 3 || size == 4 || size == 7,
        map(length, reduce(vcat, map(x -> x[2], parsed_input))),
    )
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day08.txt")))
    # This solution is a translation from Lucas Alegre's Python solution [here](https://github.com/LucasAlegre/advent-of-code-2021/blob/main/day08.py)
    parsed_input = parse_input(input)

    return sum(solve_line.(parsed_input))
end

function solve_line((patterns, values))
    patterns = join.(sort!.(split.(patterns, "")))
    values = join.(sort!.(split.(values, "")))

    number_to_digits::Vector{Vector{String}} = [[], [], [], [], [], [], [], [], [], []]
    for digits in patterns
        for i in UNIQUE_TO_NUMBER[length(digits)]
            push!(number_to_digits[i+1], digits)
        end
    end

    # Solve for number 6
    for digits in number_to_digits[7]
        if length(intersect!(Set(digits), Set(number_to_digits[2][1]))) == 1
            number_to_digits[7] = [digits]
            filter!(e -> e != digits, number_to_digits[1])
            filter!(e -> e != digits, number_to_digits[10])
        end
    end

    # Solve for number 9
    for digits in number_to_digits[10]
        if length(intersect!(Set(digits), Set(number_to_digits[5][1]))) == 4
            number_to_digits[10] = [digits]
            filter!(e -> e != digits, number_to_digits[1])
        end
    end

    # Solve for number 3
    for digits in number_to_digits[4]
        if length(intersect!(Set(digits), Set(number_to_digits[2][1]))) == 2
            number_to_digits[4] = [digits]
            filter!(e -> e != digits, number_to_digits[3])
            filter!(e -> e != digits, number_to_digits[6])
        end
    end

    # Solve for number 5
    for digits in number_to_digits[6]
        if length(intersect!(Set(digits), Set(number_to_digits[7][1]))) == 5
            number_to_digits[6] = [digits]
            filter!(e -> e != digits, number_to_digits[3])
        end
    end

    digits_to_numbers =
        Dict(val[1] => (key - 1) for (key, val) in enumerate(number_to_digits))

    # Iterate over the digits displayed in the display, computing it's respective decimal value
    return sum(
        map((digit) -> 10^(4 - digit[1]) * digits_to_numbers[digit[2]], enumerate(values)),
    )
end

function parse_input(input::String)
    return [
        (split(patterns, " "), split(values, " ")) for
        (patterns, values) in split.(split(input, "\n"), " | ")
    ]
end
end
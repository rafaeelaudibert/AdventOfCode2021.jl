module Day10

using AdventOfCode2021Julia
using DataStructures

OPEN_CHARACTERS = ["(", "[", "{", "<"]
MATCH_CLOSE_CHARACTERS = Dict([(")", "("), ("]", "["), ("}", "{"), (">", "<")])
MATCH_OPEN_CHARACTERS = Dict([("(", ")"), ("[", "]"), ("{", "}"), ("<", ">")])
CHARACTERS_SYNTAX_ERROR_VALUE = Dict([(")", 3), ("]", 57), ("}", 1197), (">", 25137)])
CHARACTERS_INCOMPLETE_ERROR_VALUE = Dict([(")", 1), ("]", 2), ("}", 3), (">", 4)])

POSITION_MULTIPLIER = 5

@enum Error SyntaxError IncompleteLineError

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day10.txt")))
    parsed_input = parse_input(input)
    sum(
        character -> CHARACTERS_SYNTAX_ERROR_VALUE[character],
        map(
            extract_characters,
            filter(((error, _),) -> error == SyntaxError::Error, parse_line.(parsed_input)),
        ),
    )
end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day10.txt")))
    parsed_input = parse_input(input)

    incomplete_lines = map(
        extract_characters,
        filter(
            ((error, _),) -> error == IncompleteLineError::Error,
            parse_line.(parsed_input),
        ),
    )

    lines_values = map(
        characters -> reduce(
            (acc, curr) ->
                acc * POSITION_MULTIPLIER + CHARACTERS_INCOMPLETE_ERROR_VALUE[curr],
            characters,
            init = 0,
        ),
        incomplete_lines,
    )

    sorted_lines_values = sort!(lines_values)

    # Use the value in the middle
    sorted_lines_values[Int(ceil(length(sorted_lines_values) / 2))]
end

function extract_characters((_, characters))
    characters
end

function parse_line(line)
    stack = Stack{String}()
    for character in split(line, "")
        if character in OPEN_CHARACTERS
            push!(stack, character)
        else
            top = pop!(stack)
            if top != get(MATCH_CLOSE_CHARACTERS, character, "")
                return (SyntaxError, character)
            end
        end
    end

    (IncompleteLineError, [MATCH_OPEN_CHARACTERS[character] for character in stack])
end

function parse_input(input::String)
    split(input, "\n")
end

end

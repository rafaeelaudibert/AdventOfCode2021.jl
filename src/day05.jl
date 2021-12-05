module Day05

using AdventOfCode2021Julia

ROWS_NUMBER = 5

function part1(input::String = readInput(joinpath(@__DIR__, "..", "data", "day05.txt")))
    lines = parse_input(input)
    return compute_intersections([
        line for line in lines if line[1][1] == line[2][1] || line[1][2] == line[2][2] # Only horizontal and vertical lines
    ])

end

function part2(input::String = readInput(joinpath(@__DIR__, "..", "data", "day05.txt")))
    lines = parse_input(input)
    return compute_intersections(lines)
end

function compute_intersections(lines)
    dict = Dict{Tuple{Int64,Int64},Int64}()
    sizehint!(dict, size(lines, 1) * 1000)

    for line in lines
        x0, x1 = (line[1][1], line[2][1])
        y0, y1 = (line[1][2], line[2][2])
        x_slope = get_slope(x0, x1)
        y_slope = get_slope(y0, y1)

        while x0 != x1 || y0 != y1
            dict[(x0, y0)] = get!(dict, (x0, y0), 0) + 1

            # Increase according to the slope, which accounts for horizontal/vertical/diagonal lines
            x0 += x_slope
            y0 += y_slope
        end

        # Extra assignment at the end because we aren't using a do/while
        dict[(x0, y0)] = get(dict, (x0, y0), 0) + 1
    end

    return count(values(dict) .>= 2)
end

function get_slope(a::Int64, b::Int64)
    return a == b ? 0 : (a < b ? 1 : -1)
end

function parse_input(input::String)
    return parse_line.(split(input, "\n"))
end

LINE_REGEX = re = r"([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)"
function parse_line(input::SubString{String})
    values = match(LINE_REGEX, input)
    return (
        (parse(Int, values[1]), parse(Int, values[2])),
        (parse(Int, values[3]), parse(Int, values[4])),
    )
end

end
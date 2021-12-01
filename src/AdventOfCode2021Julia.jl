# This module is heavily inspired on goggle's [AdventOfCode2021.jl](https://github.com/goggle/AdventOfCode2021.jl) repository
module AdventOfCode2021Julia

using BenchmarkTools
using Printf

solvedDays = [1]

# Include the source files:
for day in solvedDays
    ds = @sprintf("%02d", day)
    include(joinpath(@__DIR__, "day$ds.jl"))
end

# Read the input from a file:
function readInput(path::String)
    s = open(path, "r") do file
        read(file, String)
    end
    return s
end
function readInput(day::Integer)
    path = joinpath(@__DIR__, "..", "data", @sprintf("day%02d.txt", day))
    return readInput(path)
end
export readInput


# Export a function `dayXY_partZ` for each day and part 1 and 2:
for d in solvedDays
    global ds = @sprintf("day%02d.txt", d)
    global modSymbol = Symbol(@sprintf("Day%02d", d))
    global dsSymbol_part1 = Symbol("part1")
    global dsSymbol_part2 = Symbol("part2")

    @eval begin
        input_path = joinpath(@__DIR__, "..", "data", ds)
        function $dsSymbol_part1(input::String = readInput($d))
            return AdventOfCode2021Julia.$modSymbol.$dsSymbol_part1(input)
        end
        export $dsSymbol_part1

        function $dsSymbol_part2(input::String = readInput($d))
            return AdventOfCode2021Julia.$modSymbol.$dsSymbol_part2(input)
        end
        export $dsSymbol_part2
    end
end

# Benchmark a list of different problems:
function benchmark(days = solvedDays)
    results = []
    for day in days
        modSymbol = Symbol(@sprintf("Day%02d", day))
        fSymbol_part1 = Symbol("part1")
        fSymbol_part2 = Symbol("part2")
        input = readInput(joinpath(@__DIR__, "..", "data", @sprintf("day%02d.txt", day)))
        @eval begin
            bresult_part1 =
                @benchmark(AdventOfCode2021Julia.$modSymbol.$fSymbol_part1($input))
            bresult_part2 =
                @benchmark(AdventOfCode2021Julia.$modSymbol.$fSymbol_part2($input))
        end
        push!(
            results,
            (
                day,
                (time(bresult_part1), memory(bresult_part1)),
                (time(bresult_part2), memory(bresult_part2)),
            ),
        )
    end
    return results
end

# Write the benchmark results into a markdown string:
function _to_markdown_table(bresults = benchmark())
    header =
        "| Day | Part 1 Time | Part 1 Allocated memory | Part 2 Time | Part 2 Allocated memory |\n" *
        "|----:|------------:|------------------------:|------------:|------------------------:|"
    lines = [header]
    for (d, (t1, m1), (t2, m2)) in bresults
        ds = string(d)
        t1s = BenchmarkTools.prettytime(t1)
        m1s = BenchmarkTools.prettymemory(m1)
        t2s = BenchmarkTools.prettytime(t2)
        m2s = BenchmarkTools.prettymemory(m2)
        push!(lines, "| $ds | $t1s | $m1s | $t2s | $m2s |")
    end
    return join(lines, "\n")
end

end # module

module Day01

using AdventOfCode2021Julia

function get_reports(input::String)
    return parse.(Int, split(input))
end

function part1(input::String)
    reports = get_reports(input)
    return count(diff(reports) .> 0)
end

function part2(input::String)
    reports = get_reports(input)
    sums = [a + b + c for (a, b, c) ∈ zip(reports[1:end-2], reports[2:end-1], reports[3:end])]
    return count(diff(sums) .> 0)
end

end # module
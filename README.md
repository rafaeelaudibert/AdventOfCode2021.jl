# AdventOfCode2021.jl 🎄

![Actions Status](https://github.com/rafaeelaudibert/adventofcode2021.jl/actions/workflows/ci.yml/badge.svg)

This is a working in progress repository for 2021's [Advent of Code](https://adventofcode.com/2021).

> **DISCLAIMER**: I have 0 to no-knowledge of Julia, and this is an attempt to learn a bit more about it. I'm doing my best, but please don't take this code as idiomatic Julia

## Benchmark ⚡

| Day | Part 1 Time | Part 1 Allocated memory | Part 2 Time | Part 2 Allocated memory |
| --: | ----------: | ----------------------: | ----------: | ----------------------: |
|   1 |  285.220 μs |              196.98 KiB |  300.675 μs |              259.98 KiB |
|   2 |  490.239 μs |              463.44 KiB |  488.359 μs |              463.44 KiB |
|   3 |    1.169 ms |                1.46 MiB |    1.607 ms |                1.51 MiB |
|   4 |    2.708 ms |                2.73 MiB |   10.893 ms |               11.51 MiB |
|   5 |   13.926 ms |               13.58 MiB |   29.035 ms |               26.48 MiB |
|   6 |   34.048 μs |               22.69 KiB |   34.563 μs |               22.69 KiB |
|   7 |    2.216 ms |               14.91 MiB |    3.693 ms |               14.91 MiB |
|   8 |    1.033 ms |              824.61 KiB |    5.841 ms |                4.15 MiB |
|   9 |    1.385 ms |                1.32 MiB |    4.923 ms |                7.52 MiB |
|  10 |    1.440 ms |                1.66 MiB |    1.509 ms |                1.68 MiB |

> This table is generated with `AdventOfCode2021Julia._to_markdown_table()` using the `BenchmarkTools` lib

## Credits 🧙

This repository models is based on [goggle](https://github.com/goggle)'s [AdventOfCode2021.jl](https://github.com/goggle/AdventOfCode2021.jl) repository

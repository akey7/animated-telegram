# animated-telegram-jl

Learning the basics of the Julia programming language and doing math-oriented programming with it.

## Dependencies

Since this repo is not yet a Julia package, it minimally needs the `Plots` package. Different folders of source code have their own dependencies. See the source code for details.

## Quarto

This repo uses [Quarto](https://quarto.org/docs/computations/julia.html) as a rendering environment for Julia execution. Installation can be tricky, and requires Python as well as Julia to be configured correctly. See the preceding reference on installing support for Quarto.

## Demonstrations

### `gpu`

These examples [follow this tutorial.](https://cuda.juliagpu.org/stable/tutorials/introduction/)

### `intro_to_hpc`

These examples [follow another tutorial.](https://forem.julialang.org/wikfeldt/a-brief-tour-of-julia-for-high-performance-computing-5deb#:~:text=This%20post%20gives%20an%20overview%20of%20Julia's%20features%20and%20capabilities)

For multiple CPU threads execute with something like `julia -t 64 .\step_03.jl` and adjust the `64` to be appropriate for the hardware you are running on.

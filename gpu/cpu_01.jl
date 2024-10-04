# From https://cuda.juliagpu.org/stable/tutorials/introduction/

using Test

N = 2^20
x = fill(1.0f0, N)  # a vector filled with 1.0 (Float32)
y = fill(2.0f0, N)  # a vector filled with 2.0

y .+= x             # increment each element of y with the corresponding element of x

@test all(y .== 3.0f0)

println("No news is good news!")

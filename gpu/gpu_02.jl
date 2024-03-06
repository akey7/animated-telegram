# From https://cuda.juliagpu.org/stable/tutorials/introduction/

using CUDA
using Test
using BenchmarkTools

N = 2^20
x_d = CUDA.fill(1.0f0, N)  # a vector stored on the GPU filled with 1.0 (Float32)
y_d = CUDA.fill(2.0f0, N)  # a vector stored on the GPU filled with 2.0

function add_broadcast!(y, x)
    CUDA.@sync y .+= x
    return
end

add_broadcast!(y_d, x_d)
@test all(Array(y_d) .== 3.0f0)
@btime add_broadcast!($y_d, $x_d)

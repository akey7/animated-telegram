# From https://cuda.juliagpu.org/stable/tutorials/introduction/

using CUDA
using Test
using BenchmarkTools

N = 2^20
x_d = CUDA.fill(1.0f0, N)  # a vector stored on the GPU filled with 1.0 (Float32)
y_d = CUDA.fill(2.0f0, N)  # a vector stored on the GPU filled with 2.0

function gpu_add1!(y, x)
    for i ∈ eachindex(y)
        @inbounds y[i] += x[i]
    end
    return nothing
end

println("No news is good news!")

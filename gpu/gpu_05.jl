# From https://cuda.juliagpu.org/stable/tutorials/introduction/

using CUDA
using Test
using BenchmarkTools

N = 2^20
x_d = CUDA.fill(1.0f0, N)  # a vector stored on the GPU filled with 1.0 (Float32)
y_d = CUDA.fill(2.0f0, N)  # a vector stored on the GPU filled with 2.0

function gpu_add2!(y, x)
    index = threadIdx().x 
    stride = blockDim().x 
    for i ∈ index:stride:length(y)
        @inbounds y[i] += x[i]
    end
    return nothing
end

fill!(y_d, 2)
@cuda threads=1024 gpu_add2!(y_d, x_d)  # Example uses 256, but I have 1024 on all my machines
@test all(Array(y_d) .== 3.0f0)
println("No news is good news!")

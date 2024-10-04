# From https://cuda.juliagpu.org/stable/tutorials/introduction/

using CUDA
using Test
using BenchmarkTools

N = 2^20
x_d = CUDA.fill(1.0f0, N)  # a vector stored on the GPU filled with 1.0 (Float32)
y_d = CUDA.fill(2.0f0, N)  # a vector stored on the GPU filled with 2.0

function gpu_add3!(y, x)
    index = (blockIdx().x - 1) * blockDim().x + threadIdx().x
    stride = gridDim().x * blockDim().x
    @cuprintln("thread $index, block: $stride, length: $length(y)")
    for i ∈ index:stride:length(y)
        @inbounds y[i] += x[i]
    end
    return nothing
end

function bench_gpu3!(y, x)
    kernel = @cuda launch=false gpu_add3!(y_d, x_d)
    config = launch_configuration(kernel.fun)
    threads = min(N, config.threads)
    blocks = cld(N, threads)

    CUDA.@sync begin
        kernel(y, x; threads, blocks)
    end
end

fill!(y_d, 2)
@btime bench_gpu3!($y_d, $x_d)

using BenchmarkTools
using CUDA

A_d = CuArray([1,2,3,4])
A_d .+= 1

A = Array(A_d)

# array on CPU
A = rand(2^13, 2^13)
# array on GPU
A_d = CuArray(A)

println("Using CPU...")
A * A

println("Using GPU...")
A_d * A_d

println("Done!")

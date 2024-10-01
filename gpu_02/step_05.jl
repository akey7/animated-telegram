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
@benchmark A * A evals = 1

println("Using GPU...")
@benchmark A_d * A_d evals = 1

println("Done!")

using CUDA
using BenchmarkTools
using Plots

@inbounds function lap2d_gpu!(u, unew)
    M, N = size(u)
    j = threadIdx().y + (blockIdx().y - 1) * blockDim().y
    i = threadIdx().x + (blockIdx().x - 1) * blockDim().x
    if i > 1 && i < N && j > 1 && j < M
        unew[i, j] = 0.25 * (u[i+1,j] + u[i-1,j] + u[i,j+1] + u[i,j-1])
    end
    return nothing
end

M = 4096
N = 4096
threads = (32, 32) # 32*32=1024
blocks = (N÷threads[1], M÷threads[2])

u = zeros(Float32, M, N)
u[1, :] = u[end, :] = u[:, 1] = u[:, end] .= 10.0
unew = copy(u)
u_d = CuArray(u)
unew_d = CuArray(unew)

println("Thinking...")

for i in 1:100_000
    @cuda blocks=blocks threads=threads lap2d_gpu!(u_d, unew_d)
    global u_d = copy(unew_d)
end

println("Displaying heatmap...")
display(heatmap(Array(u_d)))
println("Press enter to exit!")
readline()

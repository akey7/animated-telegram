using Plots
using BenchmarkTools
using .Threads

function lap2d!(u0, unew0)
    M, N = size(u0)
    for j ∈ 2:N-1
        for i ∈ 2:M-1
            @inbounds unew0[i, j] = 0.25 * (u0[i+1,j] + u0[i-1,j] + u0[i,j+1] + u0[i,j-1])
        end
    end
end

M = 4096
N = 4096
u = zeros(Float64, M, N)
u[1, :] = u[end, :] = u[:, 1] = u[:, end] .= 10.0
unew = copy(u)

# for i ∈ 1:50_000
#     lap2d!(u, unew)
#     global u = copy(unew)
# end

@btime lap2d!(u, unew)

display(heatmap(u))
readline()
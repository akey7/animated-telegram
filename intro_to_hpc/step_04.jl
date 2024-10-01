# julia -p 64 .\step_04.jl

using Plots
using SharedArrays
using Distributed
using BenchmarkTools

function lap2d!(u0::SharedArray, unew0::SharedArray)
    M, N = size(u0)
    @sync @distributed for j ∈ 2:N-1
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

su = SharedArray(u)
sunew = SharedArray(unew)

@btime lap2d!(su, sunew)

display(heatmap(su))
readline()

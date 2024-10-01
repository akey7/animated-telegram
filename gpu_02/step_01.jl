function lap2d!(u, unew)
    M, N = size(u)
    for j ∈ 2:N-1
        for i ∈ 2:M-1
            unew[i, j] = 0.25 * (u[i+1,j] + u[i-1,j] + u[i,j+1] + u[i,j-1])
        end
    end
end

using Printf

a6 = [sin, cos, tan]

for f in a6
    println(f(0))
end

a7 = [1 2 3; 4 5 6]
for n = 1:2, m = 1:3
    @printf("%d", a7[n, m])
end

a10 = [n^2 for n in 1:5]
println(a10)

a11 = [n *m for n in 1:5, m in 1:5]
println(a11)

using Statistics

s1 = "Just some random words"
println(length(s1))

println(s1[1])
println(s1[end])
println(s1[1:4])

s2 = string("Hello", "Goodbye")
println(s2)

i3 = 2
i4 = 5
interp = "$i3, $i4"
println(interp)

println(findfirst(isequal('o'), s2))
println(occursin("key", "monkey"))

age = 12

if age >= 5 && age <= 6
    println("Kinderarten")
else
    println("Grown up")
end

for i = 1:5, j = 2:2:10
    println("$i $j")
end

a1 = zeros(Int32, 2, 2)
a2 = Array{Int32}(undef, 5)
a3 = Float64[]
a4 = [1, 2, 3]

println(a4[1])
println(a4[end])
println(5 in a4)
println(findfirst(isequal(2), a4))
f(a) = (a >= 2)
println(findall(f, a4))
println(count(f, a4))
println(size(a4))
println(sum(a4))
splice!(a4, 2:1, [8, 9])
println(a4)
println(maximum(a4))


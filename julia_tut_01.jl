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

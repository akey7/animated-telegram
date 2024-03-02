d1 = Dict("pi" => 3.14, "e" => 2.718)
println(d1["pi"])
println(d1["e"])
delete!(d1, "pi")

for(key, value) in d1
    println("$key $value")
end

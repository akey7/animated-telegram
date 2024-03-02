struct Customer
    name::String
    balance::Float32
    id::Int
end

bob = Customer("Bob", 10.50, 123)
println(bob.name)

# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/03b-parsimonious-flux-balance/

using COBREXA
import JSONFBCModels, HiGHS
import AbstractFBCModels as A

println("############################################################")
println("# LOAD MODEL                                               #")
println("############################################################")

model = load_model("e_coli_core.json")

for reaction ∈ A.reactions(model)
    println(reaction)
end

println("############################################################")
println("# PRODUCTION ENVELOPE                                      #")
println("############################################################")

envelope = objective_production_envelope(
    model,
    ["EX_o2_e", "EX_co2_e"];
    breaks = 5,
    optimizer = HiGHS.Optimizer,
)

println("Available data in solution:")

for element ∈ envelope
    println(element)
end

println("############################################################")
println("# RANGES                                                   #")
println("############################################################")

println(envelope[1][1])
println(envelope[1][2])

# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/03b-parsimonious-flux-balance/

using COBREXA
import Clarabel
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
println("# pFBA FLUXES                                              #")
println("############################################################")

import HiGHS

solution = parsimonious_flux_balance_analysis(
    model;
    optimizer = HiGHS.Optimizer, # HiGHS is used only for LP here
    parsimonious_optimizer = Clarabel.Optimizer, # Clarabel is great for solving QPs
)

println("Available data in solution:")

for element ∈ solution
    println(element)
end

println("Fluxes:")

for flux ∈ solution.fluxes
    println(flux)
end

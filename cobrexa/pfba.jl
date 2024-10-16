# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/03a-flux-variability-analysis/

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
println("# FVA: WITHIN 1%                                           #")
println("############################################################")

solution = parsimonious_flux_balance_analysis(model; optimizer = Clarabel.Optimizer)

for element ∈ solution
    println(element)
end

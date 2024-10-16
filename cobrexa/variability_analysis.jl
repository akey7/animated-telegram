# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/03a-flux-variability-analysis/

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
println("# FVA                                                      #")
println("############################################################")

solution = flux_variability_analysis(model, optimizer = HiGHS.Optimizer)

for element ∈ solution
    println(element)
end

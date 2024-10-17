# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/05a-minimization-of-metabolic-adjustment/#

import JSONFBCModels
import HiGHS, Clarabel
import AbstractFBCModels.CanonicalModel as CM
import ConstraintTrees as C
using COBREXA
import AbstractFBCModels as A

println("############################################################")
println("# LOAD MODEL                                               #")
println("############################################################")

ecoli = load_model("e_coli_core.json", CM.Model)

for reaction ∈ A.reactions(ecoli)
    println(reaction)
end

println("############################################################")
println("# REACTION TO PERTURB                                      #")
println("############################################################")

println(ecoli.reactions["CYTBD"])

println("############################################################")
println("# PERTURB IT                                               #")
println("############################################################")

limited_ecoli = deepcopy(ecoli)
limited_ecoli.reactions["CYTBD"].upper_bound = 10.0
println(limited_ecoli.reactions["CYTBD"])

println("############################################################")
println("# SOLUTION: LIMITED E. COLI                                #")
println("############################################################")

solution = parsimonious_flux_balance_analysis(limited_ecoli, optimizer = Clarabel.Optimizer)

for element ∈ solution
    println(element)
end

println("############################################################")
println("# SOLUTION: MOMA                                           #")
println("############################################################")

moma_solution = metabolic_adjustment_minimization_analysis(
    limited_ecoli, # the model to be examined
    ecoli; # the model that gives the reference flux
    optimizer = Clarabel.Optimizer,
)

for element ∈ moma_solution
    println(element)
end

println("############################################################")
println("# COMPARE RESULTS                                          #")
println("############################################################")

difference = C.zip(-, solution, moma_solution, Float64)

for element ∈ first(sort(collect(difference.fluxes), by = last), 5)
    println(element[1], " ", element[2])
end

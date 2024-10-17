# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/04-community-models/

import JSONFBCModels
import HiGHS
import AbstractFBCModels.CanonicalModel as CM
import ConstraintTrees as C
using COBREXA
import AbstractFBCModels as A

println("############################################################")
println("# LOAD MODEL                                               #")
println("############################################################")

model = load_model("e_coli_core.json")

for reaction ∈ A.reactions(model)
    println(reaction)
end

println("############################################################")
println("# CREATE COMMUNITY                                         #")
println("############################################################")

ecoli = load_model("e_coli_core.json", CM.Model)
ecoli.reactions["EX_glc__D_e"].lower_bound = -1000.0
ecoli.reactions["EX_glc__D_e"].upper_bound = 1000.0

ecoli1 = deepcopy(ecoli)
ecoli1.reactions["CYTBD"].lower_bound = ecoli1.reactions["CYTBD"].upper_bound = 0.0
ecoli2 = deepcopy(ecoli)
ecoli2.reactions["FBA"].lower_bound = ecoli2.reactions["FBA"].upper_bound = 0.0
my_community = Dict("bug1" => (ecoli1, 0.2), "bug2" => (ecoli2, 0.8))

println(keys(my_community))

println("############################################################")
println("# FBA                                                      #")
println("############################################################")

solution = community_flux_balance_analysis(
    my_community,
    ["EX_glc__D_e" => (-10.0, 0.0)],
    optimizer = HiGHS.Optimizer,
)

zipper = C.zip(
    tuple,
    solution.bug1.interface.exchanges,
    solution.bug2.interface.exchanges,
    Tuple{Float64,Float64},
)

for element ∈ zipper
    println(element)
end

println("############################################################")
println("# SCREEN                                                   #")
println("############################################################")

screen(0.0:0.1:1.0) do ratio2
    ratio1 = 1 - ratio2
    res = community_flux_balance_analysis(
        [("bug1" => (ecoli1, ratio1)), ("bug2" => (ecoli2, ratio2))],
        ["EX_glc__D_e" => (-10.0, 0.0)],
        interface = :sbo, # usually more reproducible
        optimizer = HiGHS.Optimizer,
    )
    (ratio1, ratio2) => (isnothing(res) ? nothing : res.community_biomass)
    println(ratio1, " ", ratio2)
end


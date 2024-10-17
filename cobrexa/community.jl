# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/04-community-models/

import JSONFBCModels
import HiGHS
import AbstractFBCModels.CanonicalModel as CM
import ConstraintTrees as C

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

println(my_community)

# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/05c-mmdf/

import JSONFBCModels
import HiGHS, Clarabel
import AbstractFBCModels.CanonicalModel as CM
import ConstraintTrees as C
using COBREXA
import AbstractFBCModels as A

println("############################################################")
println("# LOAD MODEL                                               #")
println("############################################################")

model = load_model("e_coli_core.json", CM.Model)

for reaction ∈ A.reactions(model)
    println(reaction)
end

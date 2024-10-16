using COBREXA
import JSONFBCModels
import AbstractFBCModels.CanonicalModel as CM

model = convert(CM.Model, load_model("e_coli_core.json"))

println("############################################################")
println("# MODEL REACTIONS                                          #")
println("############################################################")

for (key, value) ∈ model.reactions
    println("Abbreviation: ", key, " Name: ", value.name, ", bounds: ", (value.lower_bound, value.upper_bound))
end

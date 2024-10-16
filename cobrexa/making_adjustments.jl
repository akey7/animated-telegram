using COBREXA
import JSONFBCModels
import AbstractFBCModels.CanonicalModel as CM
import HiGHS

model = convert(CM.Model, load_model("e_coli_core.json"))

println("############################################################")
println("# MODEL REACTIONS                                          #")
println("############################################################")

for (key, value) ∈ model.reactions
    println("Abbreviation: ", key, " Name: ", value.name, ", bounds: ", (value.lower_bound, value.upper_bound))
end

println("############################################################")
println("# PFK STOICHIOMETRY                                        #")
println("############################################################")

println(model.reactions["PFK"].stoichiometry)

println("############################################################")
println("# FBA: BASE SOLUTION                                       #")
println("############################################################")

base_solution = flux_balance_analysis(model, optimizer = HiGHS.Optimizer)
println(base_solution.objective)

println("############################################################")
println("# FBA: GLUCOSE INTAKE LIMITED                              #")
println("############################################################")

model.reactions["EX_glc__D_e"].lower_bound = -5.0
low_glucose_solution = flux_balance_analysis(model, optimizer = HiGHS.Optimizer)
println(low_glucose_solution.objective)

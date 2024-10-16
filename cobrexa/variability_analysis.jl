# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/03a-flux-variability-analysis/

using COBREXA
import JSONFBCModels, HiGHS

println("############################################################")
println("# LOAD MODEL                                               #")
println("############################################################")

model = load_model("e_coli_core.json")
println(model)

println("############################################################")
println("# FVA                                                      #")
println("############################################################")

solution = flux_variability_analysis(model, optimizer = HiGHS.Optimizer)
println(solution)

using COBREXA
import JSONFBCModels
import HiGHS

model = load_model("e_coli_core.json")
solution = flux_balance_analysis(model, optimizer = HiGHS.Optimizer)
println(solution.objective)
println(solution.fluxes.PFK)
println(collect(solution.fluxes))

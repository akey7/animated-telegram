# Follows https://cobrexa.github.io/COBREXA.jl/dev/examples/06a-sampling/#Flux-sampling

using COBREXA
import JSONFBCModels, HiGHS

model = load_model("e_coli_core.json")

s = flux_sample(
    model,
    optimizer = HiGHS.Optimizer,
    objective_bound = relative_tolerance_bound(0.99),
    n_chains = 2,
    collect_iterations = [10],
)

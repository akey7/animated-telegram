# Follows https://cobrexa.github.io/COBREXA.jl/dev/examples/06a-sampling/#Flux-sampling

using COBREXA
using CairoMakie
import JSONFBCModels, HiGHS

model = load_model("e_coli_core.json")

s = flux_sample(
    model,
    optimizer = HiGHS.Optimizer,
    objective_bound = relative_tolerance_bound(0.99),
    n_chains = 2,
    collect_iterations = [10],
)

fluxes = [s.O2t s.CO2t]

fig = Figure(resolution = (1080/2, 1080/2))
ax = Axis(fig[1, 1])
ax.title = "Scatter Plot"
ax.xlabel = "O2t"
ax.ylabel = "CO2t"
scatter!(ax, fluxes[:, 1], fluxes[:, 2], color = :blue, markersize = 10)
display(fig)

println("Press enter to exit...")

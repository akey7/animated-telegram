using COBREXA
import JSONFBCModels, HiGHS

model = load_model("e_coli_core.json")
cs = flux_balance_constraints(model, interface = :identifier_prefixes)
some_flux =
    optimized_values(cs, objective = cs.objective.value, optimizer = HiGHS.Optimizer)
import ConstraintTrees as C

cs = linear_parsimonious_flux_balance_constraints(model)

cs *=
    :fixed_exchanges^C.ConstraintTree(
        k => C.Constraint(cs.fluxes[k].value, relative_tolerance_bound(0.999)(v)) for
        (k, v) in some_flux.interface.exchanges
    )

cycle_free_flux = parsimonious_optimized_values(
    cs,
    objective = cs.objective.value,
    objective_value = some_flux.objective,
    parsimonious_objective = cs.parsimonious_objective.value,
    optimizer = HiGHS.Optimizer,
)

cs.objective.bound = C.Between(cycle_free_flux.objective * 0.999, Inf)
cs.parsimonious_objective.bound =
    C.Between(0, cycle_free_flux.parsimonious_objective * 1.001)

var = constraints_variability(cs, cs.fluxes, optimizer = HiGHS.Optimizer)

warmup = vcat(
    (
        transpose(v) for (_, vs) in constraints_variability(
            cs,
            cs.fluxes,
            optimizer = HiGHS.Optimizer,
            output = (_, om) -> variable_vector(om),
            output_type = Vector{Float64},
        ) for v in vs
    )...,
)

sample = sample_constraints(
    sample_chain_achr,
    cs,
    start_variables = warmup,
    seed = UInt(1234),
    output = cs.fluxes,
    n_chains = 10,
    collect_iterations = collect(10:15),
)

for (key, value) ∈ sample
    println(key, " ", value[1:5])
end

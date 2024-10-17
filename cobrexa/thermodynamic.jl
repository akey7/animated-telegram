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

println("############################################################")
println("# THERMODYNAMIC DATA                                       #")
println("############################################################")

reaction_standard_gibbs_free_energies = Dict{String,Float64}( # units of the energies are kJ/mol
    "ENO" => -3.8108376097261782,
    "FBA" => 23.376920310319235,
    "GAPD" => 0.5307809794271634,
    "GLCpts" => -45.42430981510088,
    "LDH_D" => 20.04059765689044,
    "PFK" => -18.546314942995934,
    "PGI" => 2.6307087407442395,
    "PGK" => 19.57192102020454,
    "PGM" => -4.470553692565886,
    "PYK" => -24.48733600711958,
    "TPI" => 5.621932460512994,
)

for (reaction_name, ΔG) ∈ reaction_standard_gibbs_free_energies
    println("Reaction: ", reaction_name, ", ΔG: ", ΔG)
end

println("############################################################")
println("# REFERENCE FLUX                                           #")
println("############################################################")

reference_flux = Dict(
    "ENO" => 1.0,
    "FBA" => 1.0,
    "GAPD" => 1.0,
    "GLCpts" => 1.0,
    "LDH_D" => -1.0,
    "PFK" => 1.0,
    "PGI" => 1.0,
    "PGK" => -1.0,
    "PGM" => 0.0,
    "PYK" => 1.0,
    "TPI" => 1.0,
)

for (reaction_name, flux) ∈ reference_flux
    println("Reaction: ", reaction_name, ", Flux: ", flux)
end

println("############################################################")
println("# MAX MIN DRIVING FORCE ANALYSIS                           #")
println("############################################################")

mmdf_solution = max_min_driving_force_analysis(
    model;
    reaction_standard_gibbs_free_energies,
    reference_flux,
    constant_concentrations = Dict("g3p_c" => exp(-8.5)),
    concentration_ratios = Dict(
        "atp" => ("atp_c", "adp_c", 10.0),
        "nadh" => ("nadh_c", "nad_c", 0.13),
    ),
    proton_metabolites = ["h_c"],
    water_metabolites = ["h2o_c"],
    concentration_lower_bound = 1e-6, # mol/L
    concentration_upper_bound = 1e-1, # mol/L
    T = 298.15, # Kelvin
    R = 8.31446261815324e-3, # kJ/K/mol
    optimizer = HiGHS.Optimizer,
)

for element ∈ mmdf_solution
    println(element)
end

println("############################################################")
println("# CONSTRAINTS VARIABILITY                                  #")
println("############################################################")

mmdf_system = max_min_driving_force_constraints(
    model;
    reaction_standard_gibbs_free_energies,
    reference_flux,
    constant_concentrations = Dict("g3p_c" => exp(-8.5)),
    concentration_ratios = Dict(
        "atp" => ("atp_c", "adp_c", 10.0),
        "nadh" => ("nadh_c", "nad_c", 0.13),
    ),
    proton_metabolites = ["h_c"],
    water_metabolites = ["h2o_c"],
    concentration_lower_bound = 1e-6, # mol/L
    concentration_upper_bound = 1e-1, # mol/L
    T = 298.15, # Kelvin
    R = 8.31446261815324e-3, # kJ/K/mol
)

cva_solution = constraints_variability(
    mmdf_system,
    mmdf_system.log_concentrations,
    objective = mmdf_system.min_driving_force.value,
    optimizer = HiGHS.Optimizer,
)

for element ∈ cva_solution
    println(element)
end

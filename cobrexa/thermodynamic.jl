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

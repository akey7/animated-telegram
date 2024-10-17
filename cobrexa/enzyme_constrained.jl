# Following https://cobrexa.github.io/COBREXA.jl/dev/examples/05b-enzyme-constrained-models/

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
println("# E. COLI KCATOME                                          #")
println("############################################################")

const ecoli_core_reaction_kcats = Dict(
    "ACALD" => 568.11,
    "PTAr" => 1171.97,
    "ALCD2x" => 75.95,
    "PDH" => 529.76,
    "MALt2_2" => 234.03,
    "CS" => 113.29,
    "PGM" => 681.4,
    "TKT1" => 311.16,
    "ACONTa" => 191.02,
    "GLNS" => 89.83,
    "ICL" => 17.45,
    "FBA" => 373.42,
    "FORt2" => 233.93,
    "G6PDH2r" => 589.37,
    "AKGDH" => 264.48,
    "TKT2" => 467.42,
    "FRD7" => 90.20,
    "SUCOAS" => 18.49,
    "ICDHyr" => 39.62,
    "AKGt2r" => 234.99,
    "GLUSy" => 33.26,
    "TPI" => 698.30,
    "FORt" => 234.38,
    "ACONTb" => 159.74,
    "GLNabc" => 233.80,
    "RPE" => 1772.485,
    "ACKr" => 554.61,
    "THD2" => 24.73,
    "PFL" => 96.56,
    "RPI" => 51.77,
    "D_LACt2" => 233.51,
    "TALA" => 109.05,
    "PPCK" => 218.42,
    "PGL" => 2120.42,
    "NADTRHD" => 186.99,
    "PGK" => 57.64,
    "LDH_D" => 31.11,
    "ME1" => 487.01,
    "PIt2r" => 233.86,
    "ATPS4r" => 71.42,
    "GLCpts" => 233.90,
    "GLUDy" => 105.32,
    "CYTBD" => 153.18,
    "FUMt2_2" => 234.37,
    "FRUpts2" => 234.19,
    "GAPD" => 128.76,
    "PPC" => 165.52,
    "NADH16" => 971.74,
    "PFK" => 1000.46,
    "MDH" => 25.93,
    "PGI" => 468.11,
    "ME2" => 443.09,
    "GND" => 240.12,
    "SUCCt2_2" => 234.18,
    "GLUN" => 44.76,
    "ADK1" => 111.64,
    "SUCDi" => 680.31,
    "ENO" => 209.35,
    "MALS" => 252.75,
    "GLUt2r" => 234.22,
    "PPS" => 706.14,
    "FUM" => 1576.83,
)

for (key, value) ∈ ecoli_core_reaction_kcats
    println(key, ", kcat = ", value)
end

println("############################################################")
println("# REACTION ISOZYMES                                        #")
println("############################################################")

reaction_isozymes = Dict{String,Dict{String,Isozyme}}() # a mapping from reaction IDs to isozyme IDs to isozyme structs.
for rid in A.reactions(model)
    grrs = A.reaction_gene_association_dnf(model, rid)
    isnothing(grrs) && continue # skip if no grr available
    haskey(ecoli_core_reaction_kcats, rid) || continue # skip if no kcat data available
    for (i, grr) in enumerate(grrs)
        d = get!(reaction_isozymes, rid, Dict{String,Isozyme}())
        d["isozyme_"*string(i)] = Isozyme( # each isozyme gets a unique name
            gene_product_stoichiometry = Dict(grr .=> fill(1.0, size(grr))), # assume subunit stoichiometry of 1 for all isozymes
            kcat_forward = ecoli_core_reaction_kcats[rid] * 3.6, # forward reaction turnover number units = 1/h
            kcat_reverse = ecoli_core_reaction_kcats[rid] * 3.6, # reverse reaction turnover number units = 1/h
        )
    end
end

for (reaction_name, isozymes_dict) ∈ reaction_isozymes
    for (isozyme_name, isozyme_struct) ∈ isozymes_dict
        println("Reaction id: ", reaction_name, ", Isozyme name: ", isozyme_name, ", Isozyme struct: ", isozyme_struct)
    end
end

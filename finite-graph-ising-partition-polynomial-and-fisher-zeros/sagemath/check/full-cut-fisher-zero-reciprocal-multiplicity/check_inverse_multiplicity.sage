# 対象ラベル: theorem_full_cut_fisher_zero_reciprocal_multiplicity
# 式ペア: mu_G(alpha^-1)=mu_G(alpha)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    for alpha in data["sample_points"]:
        multiplicity, _cofactor = exact_multiplicity_and_cofactor(polynomial, alpha)
        inverse_multiplicity, _inverse_cofactor = exact_multiplicity_and_cofactor(polynomial, alpha^(-1))
        assert inverse_multiplicity == multiplicity, (data["name"], alpha)

print("RESULT: PASS — exact QQbar multiplicities are invariant under alpha -> alpha^-1")

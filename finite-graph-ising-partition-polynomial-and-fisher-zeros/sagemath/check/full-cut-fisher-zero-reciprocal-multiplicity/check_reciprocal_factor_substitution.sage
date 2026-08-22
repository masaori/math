# 対象ラベル: theorem_full_cut_fisher_zero_reciprocal_multiplicity
# 式ペア: P_G(x)=x^|E| P_G(x^-1)=x^|E|(x^-1-alpha)^r Q_alpha(x^-1)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    reciprocal = x_fraction^edge_count * K(polynomial)(x_fraction^(-1))
    assert K(polynomial) == reciprocal, data["name"]
    for alpha in data["sample_points"]:
        multiplicity, cofactor = exact_multiplicity_and_cofactor(polynomial, alpha)
        substituted_factorization = (
            x_fraction^edge_count
            * (x_fraction^(-1) - alpha)^multiplicity
            * K(cofactor)(x_fraction^(-1))
        )
        assert reciprocal == substituted_factorization, (data["name"], alpha)

print("RESULT: PASS — reciprocal symmetry and the substituted exact linear-factor decomposition agree")

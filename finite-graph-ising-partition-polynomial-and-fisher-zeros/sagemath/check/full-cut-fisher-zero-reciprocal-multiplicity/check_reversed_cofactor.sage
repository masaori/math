# 対象ラベル: theorem_full_cut_fisher_zero_reciprocal_multiplicity
# 式ペア: R_alpha(x)=x^(|E|-r)Q_alpha(x^-1) in QQbar[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    for alpha in data["sample_points"]:
        multiplicity, cofactor = exact_multiplicity_and_cofactor(polynomial, alpha)
        assert cofactor.degree() == edge_count - multiplicity, (data["name"], alpha)
        reversed_fraction = x_fraction^(edge_count - multiplicity) * K(cofactor)(x_fraction^(-1))
        reversed_cofactor = R(reversed_fraction)
        assert K(reversed_cofactor) == reversed_fraction, (data["name"], alpha)

print("RESULT: PASS — each reversed exact cofactor lies in QQbar[x]")

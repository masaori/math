# 対象ラベル: theorem_full_cut_fisher_zero_reciprocal_multiplicity
# 式ペア: R_alpha(alpha^-1)=alpha^-(|E|-r) Q_alpha(alpha) != 0

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    for alpha in data["sample_points"]:
        multiplicity, cofactor = exact_multiplicity_and_cofactor(polynomial, alpha)
        reversed_cofactor = R(x_fraction^(edge_count - multiplicity) * K(cofactor)(x_fraction^(-1)))
        left = reversed_cofactor(alpha^(-1))
        right = alpha^(-(edge_count - multiplicity)) * cofactor(alpha)
        assert left == right, (data["name"], alpha)
        assert right != 0, (data["name"], alpha)

print("RESULT: PASS — every reversed cofactor is nonzero at the inverse point")

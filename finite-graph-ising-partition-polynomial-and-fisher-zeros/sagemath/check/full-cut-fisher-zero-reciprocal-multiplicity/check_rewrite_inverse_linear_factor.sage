# 対象ラベル: theorem_full_cut_fisher_zero_reciprocal_multiplicity
# 式ペア: (1-alpha*x)^r=(-alpha)^r(x-alpha^-1)^r

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    for alpha in data["sample_points"]:
        assert alpha != 0
        multiplicity, cofactor = exact_multiplicity_and_cofactor(polynomial, alpha)
        left = x_fraction^(edge_count - multiplicity) * (1 - alpha * x_fraction)^multiplicity * K(cofactor)(x_fraction^(-1))
        right = (-alpha)^multiplicity * (x_fraction - alpha^(-1))^multiplicity * x_fraction^(edge_count - multiplicity) * K(cofactor)(x_fraction^(-1))
        assert left == right, (data["name"], alpha)

print("RESULT: PASS — every nonzero alpha rewrites the linear factor into its inverse-root form")

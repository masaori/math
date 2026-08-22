# 対象ラベル: theorem_full_cut_fisher_zero_reciprocal_multiplicity
# 式ペア: x^|E|(x^-1-alpha)^r Q(x^-1)=x^(|E|-r)(1-alpha*x)^r Q(x^-1)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    for alpha in data["sample_points"]:
        multiplicity, cofactor = exact_multiplicity_and_cofactor(polynomial, alpha)
        left = x_fraction^edge_count * (x_fraction^(-1) - alpha)^multiplicity * K(cofactor)(x_fraction^(-1))
        right = x_fraction^(edge_count - multiplicity) * (1 - alpha * x_fraction)^multiplicity * K(cofactor)(x_fraction^(-1))
        assert left == right, (data["name"], alpha)

print("RESULT: PASS — extracting x^-r from the inverted linear factor preserves every tested expression")

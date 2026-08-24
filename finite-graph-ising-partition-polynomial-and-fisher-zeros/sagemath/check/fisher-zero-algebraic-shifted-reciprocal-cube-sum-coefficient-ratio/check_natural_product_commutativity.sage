# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: Omega(m)m(m-1)(m-2) = m(m-1)(m-2)Omega(m) in NN
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for exponent in range(3, data["edge_count"] + 1):
        multiplicity = data["multiplicities"][exponent]
        left = multiplicity * NN(exponent) * NN(exponent - 1) * NN(exponent - 2)
        right = NN(exponent) * NN(exponent - 1) * NN(exponent - 2) * multiplicity
        assert left == right, (data["name"], exponent)
print("RESULT: PASS — the NN factors may be reordered by commutativity")

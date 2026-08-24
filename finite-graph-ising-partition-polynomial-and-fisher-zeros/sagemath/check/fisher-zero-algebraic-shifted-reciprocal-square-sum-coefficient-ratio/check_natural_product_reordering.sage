# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: eta(Omega m(m-1)) = eta(m(m-1)Omega)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for exponent in range(2, data["edge_count"] + 1):
        multiplicity = data["multiplicities"][exponent]
        left = QQ(multiplicity * NN(exponent) * NN(exponent - 1))
        right = QQ(NN(exponent) * NN(exponent - 1) * multiplicity)
        assert left == right, (data["name"], exponent)
print("RESULT: PASS — associativity and commutativity reorder the natural-number factors")

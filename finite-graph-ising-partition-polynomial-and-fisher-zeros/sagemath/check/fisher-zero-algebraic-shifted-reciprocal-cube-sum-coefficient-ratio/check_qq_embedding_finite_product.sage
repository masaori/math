# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: QQ 内の四因子積を NN の積の標準単射像へまとめる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for exponent in range(3, data["edge_count"] + 1):
        multiplicity = data["multiplicities"][exponent]
        left = QQ(multiplicity) * prod((QQ(NN(exponent - offset)) for offset in range(3)), QQ(1))
        right = QQ(multiplicity * prod((NN(exponent - offset) for offset in range(3)), NN(1)))
        assert left == right, (data["name"], exponent)
print("RESULT: PASS — the NN-to-QQ embedding preserves the finite coefficient product")

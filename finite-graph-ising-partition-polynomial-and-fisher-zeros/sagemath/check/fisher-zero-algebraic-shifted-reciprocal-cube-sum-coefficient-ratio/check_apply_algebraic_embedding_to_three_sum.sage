# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: iota(eta(3)) = iota(eta(1)+eta(1)+eta(1))
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
assert QQbar(QQ(NN(3))) == QQbar(QQ(NN(1)) + QQ(NN(1)) + QQ(NN(1)))
print("RESULT: PASS — applying the QQ-to-QQbar embedding preserves the embedded three-term sum")

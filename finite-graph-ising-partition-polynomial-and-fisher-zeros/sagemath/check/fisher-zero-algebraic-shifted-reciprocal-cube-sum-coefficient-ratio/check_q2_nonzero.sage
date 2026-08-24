# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_2 is the nonzero image of 2 under NN-to-QQ-to-QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
assert NN(2) != 0
assert QQ(NN(2)) != 0
assert q2 == QQbar(QQ(NN(2)))
assert q2 != 0
print("RESULT: PASS — q_2 remains nonzero under both standard embeddings")

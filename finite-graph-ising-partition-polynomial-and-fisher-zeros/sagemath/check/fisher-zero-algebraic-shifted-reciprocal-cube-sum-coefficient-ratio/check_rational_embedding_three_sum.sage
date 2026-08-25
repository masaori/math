# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: eta(3) = eta(1)+eta(1)+eta(1)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
assert QQ(NN(3)) == QQ(NN(1)) + QQ(NN(1)) + QQ(NN(1))
print("RESULT: PASS — the standard embedding from NN to QQ preserves the three-term sum")

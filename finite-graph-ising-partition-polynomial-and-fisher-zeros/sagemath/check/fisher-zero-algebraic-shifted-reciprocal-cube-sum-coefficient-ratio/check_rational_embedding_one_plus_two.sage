# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: eta_{N,Q}(3) = eta_{N,Q}(1)+eta_{N,Q}(2)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
assert QQ(NN(3)) == QQ(NN(1)) + QQ(NN(2))
print("RESULT: PASS — the standard embedding from NN to QQ preserves 1+2")

# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: eta_{N,Q}(2) != 0
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
assert NN(2) != 0
assert QQ(NN(2)) != 0
print("RESULT: PASS — the standard embedding of 2 from NN to QQ is nonzero")

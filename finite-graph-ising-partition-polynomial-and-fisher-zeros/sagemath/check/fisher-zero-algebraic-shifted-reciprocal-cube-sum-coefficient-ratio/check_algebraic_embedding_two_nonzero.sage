# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: iota_{Q,Qbar}(eta_{N,Q}(2)) != 0
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
rational_two = QQ(NN(2))
assert rational_two != 0
assert QQbar(rational_two) != 0
print("RESULT: PASS — the standard embedding of eta(2) from QQ to QQbar is nonzero")

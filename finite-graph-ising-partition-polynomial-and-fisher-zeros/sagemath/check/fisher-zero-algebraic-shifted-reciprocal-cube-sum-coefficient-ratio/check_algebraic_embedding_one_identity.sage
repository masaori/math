# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: iota_{Q,Qbar}(eta_{N,Q}(1)) = 1_Qbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
rational_one = QQ(NN(1))
assert QQbar(rational_one) == QQbar.one()
print("RESULT: PASS — the standard embedding from QQ to QQbar preserves the multiplicative identity")

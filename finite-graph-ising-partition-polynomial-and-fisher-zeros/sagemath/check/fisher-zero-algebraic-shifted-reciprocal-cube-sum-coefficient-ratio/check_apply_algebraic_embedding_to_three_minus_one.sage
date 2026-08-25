# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: iota(eta(3)-eta(1))=iota(eta(2))
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
assert QQbar(QQ(NN(3)) - QQ(NN(1))) == QQbar(QQ(NN(2)))
print("RESULT: PASS — applying the QQ-to-QQbar embedding preserves the rational equality eta(3)-eta(1)=eta(2)")

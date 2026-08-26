# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_3-1_{Qbar} = q_3-q_1
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
assert q3 - QQbar(1) == q3 - q1
print("RESULT: PASS — substituting q_1=1 into q_3-1 gives q_3-q_1")

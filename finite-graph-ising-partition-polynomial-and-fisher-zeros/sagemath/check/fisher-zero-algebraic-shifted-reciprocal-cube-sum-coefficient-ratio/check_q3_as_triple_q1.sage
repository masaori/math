# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_3 = q_1+q_1+q_1
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
assert q3 == q1 + q1 + q1
print("RESULT: PASS — q_3 is the sum of three copies of q_1 in QQbar")

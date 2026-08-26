# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_3-1_{Qbar} = q_2
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
left = q3 - QQbar(1)
middle = q3 - q1
right = q2
assert left == middle
assert middle == right
assert left == right
print("RESULT: PASS — transitivity gives q_3-1_Qbar=q_2")

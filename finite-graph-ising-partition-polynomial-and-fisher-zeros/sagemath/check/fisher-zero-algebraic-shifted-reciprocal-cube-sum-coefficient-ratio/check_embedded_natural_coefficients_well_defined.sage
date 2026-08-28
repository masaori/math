# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 本文主張: r in {1, 2, 3} に対する q_r は NN から QQ を経て QQbar へ移した代数的数である
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")

embedded_natural_coefficients = (q1, q2, q3)
expected_coefficients = tuple(QQbar(QQ(NN(r))) for r in (1, 2, 3))

assert embedded_natural_coefficients == expected_coefficients
assert all(coefficient.parent() is QQbar for coefficient in embedded_natural_coefficients)

print("RESULT: PASS — q_r for r in {1, 2, 3} are the NN-to-QQ-to-QQbar images and belong to QQbar")

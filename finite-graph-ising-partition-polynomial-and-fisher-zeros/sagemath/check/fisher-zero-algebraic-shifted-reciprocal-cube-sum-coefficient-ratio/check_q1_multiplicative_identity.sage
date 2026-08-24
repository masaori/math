# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: P^2C-A^3+q_3A(A^2-PB) = P^2C-q_1A^3+q_3A(A^2-PB)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
assert q1 == QQbar(1)
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        A = coefficient_sum(data, a, 1)
        B = coefficient_sum(data, a, 2)
        C = coefficient_sum(data, a, 3)
        left = P**2 * C - A**3 + q3 * A * (A**2 - P * B)
        right = P**2 * C - q1 * A**3 + q3 * A * (A**2 - P * B)
        assert left == right, (data["name"], a)
print("RESULT: PASS — q_1 is exactly the multiplicative identity in QQbar")

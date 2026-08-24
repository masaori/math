# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: -q_1 A^3+q_3 A^3 = (q_3-q_1)A^3 in QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        A = coefficient_sum(data, a, 1)
        B = coefficient_sum(data, a, 2)
        C = coefficient_sum(data, a, 3)
        left = -q1 * A**3 + q3 * A**3 - q3 * P * A * B + P**2 * C
        right = (q3 - q1) * A**3 - q3 * P * A * B + P**2 * C
        assert left == right, (data["name"], a)
print("RESULT: PASS — distributivity factors the embedded cubic coefficient exactly")

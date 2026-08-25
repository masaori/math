# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_2^{-1}(N/P^3) = N/(q_2P^3)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            A = coefficient_sum(data, a, 1)
            B = coefficient_sum(data, a, 2)
            C = coefficient_sum(data, a, 3)
            numerator = q2 * A**3 - q3 * P * A * B + P**2 * C
            before = (QQbar(1) / q2) * (numerator / P**3)
            after = numerator / (q2 * P**3)
            assert before == after, (data["name"], a)
print("RESULT: PASS — q_2 is merged with the cubic denominator in a separate field-division step")

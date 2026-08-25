# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: S_{G,3} = q_2^{-1}(N/P^3)
# 帰属: q_2, S_{G,3}, N, P は QQbar に属する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            A = coefficient_sum(data, a, 1)
            B = coefficient_sum(data, a, 2)
            C = coefficient_sum(data, a, 3)
            numerator = q2 * A**3 - q3 * P * A * B + P**2 * C
            left = reciprocal_power_sum(data, a, 3)
            right = (QQbar(1) / q2) * (numerator / P**3)
            assert left == right, (data["name"], a)
print("RESULT: PASS — the nonzero q_2 factor is cancelled in a separate QQbar equality")

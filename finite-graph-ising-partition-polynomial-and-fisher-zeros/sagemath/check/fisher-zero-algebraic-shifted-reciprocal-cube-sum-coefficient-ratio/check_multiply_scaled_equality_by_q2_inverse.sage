# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_2S_{G,3}=N/P^3 の両辺へ q_2^{-1} を掛ける
# 帰属: q_2, S_{G,3}, N, P は QQbar に属する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            A = coefficient_sum(data, a, 1)
            B = coefficient_sum(data, a, 2)
            C = coefficient_sum(data, a, 3)
            reciprocal_cube_sum = reciprocal_power_sum(data, a, 3)
            numerator = q2 * A**3 - q3 * P * A * B + P**2 * C
            scaled_left = q2 * reciprocal_cube_sum
            scaled_right = numerator / P**3
            assert scaled_left == scaled_right, (data["name"], a)
            left = (QQbar(1) / q2) * scaled_left
            right = (QQbar(1) / q2) * scaled_right
            assert left == right, (data["name"], a)
print("RESULT: PASS — multiplying both sides of the scaled equality by q_2 inverse preserves equality")

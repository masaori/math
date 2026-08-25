# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_2 S_{G,3} = (q_2 A^3-q_3PAB+P^2C)/P^3
# 帰属: q_2, q_3, S_{G,3}, A, B, C, P は QQbar に属する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            A = coefficient_sum(data, a, 1)
            B = coefficient_sum(data, a, 2)
            C = coefficient_sum(data, a, 3)
            left = q2 * reciprocal_power_sum(data, a, 3)
            right = (q2 * A**3 - q3 * P * A * B + P**2 * C) / P**3
            assert left == right, (data["name"], a)
print("RESULT: PASS — the scaled shifted reciprocal cube sum equals the cubic coefficient quotient")

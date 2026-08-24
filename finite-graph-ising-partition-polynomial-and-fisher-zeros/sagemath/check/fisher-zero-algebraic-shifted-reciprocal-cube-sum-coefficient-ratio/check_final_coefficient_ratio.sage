# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: S_{G,3} = (q_2 A^3-q_3PAB+P^2C)/(q_2P^3)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            A = coefficient_sum(data, a, 1)
            B = coefficient_sum(data, a, 2)
            C = coefficient_sum(data, a, 3)
            right = (q2 * A**3 - q3 * P * A * B + P**2 * C) / (q2 * P**3)
            assert reciprocal_power_sum(data, a, 3) == right, (data["name"], a)
print("RESULT: PASS — the shifted reciprocal cube sum equals the finite third-derivative coefficient ratio")

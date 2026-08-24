# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_2 S_{G,3} = C/P - (A/P)^3 + q_3 (A/P)(A^2-PB)/P^2
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            A = coefficient_sum(data, a, 1)
            B = coefficient_sum(data, a, 2)
            C = coefficient_sum(data, a, 3)
            left = q2 * reciprocal_power_sum(data, a, 3)
            right = C / P - (A / P) ** 3 + q3 * (A / P) * ((A**2 - P * B) / P**2)
            assert left == right, (data["name"], a)
print("RESULT: PASS — the established first and second reciprocal-sum coefficient formulas substitute exactly")

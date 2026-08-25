# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_2 S_3 = C/P-R^3+q_3 R S_2
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            C = coefficient_sum(data, a, 3)
            R = reciprocal_power_sum(data, a, 1)
            S2 = reciprocal_power_sum(data, a, 2)
            S3 = reciprocal_power_sum(data, a, 3)
            assert q2 * S3 == C / P - R**3 + q3 * R * S2, (data["name"], a)
print("RESULT: PASS — equality symmetry gives the displayed scaled cube-sum identity")

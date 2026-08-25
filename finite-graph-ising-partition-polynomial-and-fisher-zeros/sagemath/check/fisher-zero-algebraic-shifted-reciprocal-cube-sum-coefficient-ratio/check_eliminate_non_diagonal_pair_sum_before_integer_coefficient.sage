# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: T_{G,3} = R_G^3 - q_3 R_G S_{G,2} + (q_3 - 1_{Qbar}) S_{G,3}
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            R = reciprocal_power_sum(data, a, 1)
            S2 = reciprocal_power_sum(data, a, 2)
            S3 = reciprocal_power_sum(data, a, 3)
            assert ordered_distinct_triple_sum(data, a) == R**3 - q3 * R * S2 + (q3 - QQbar(1)) * S3, (data["name"], a)
print("RESULT: PASS — eliminating the ordered non-diagonal pair sum precedes the embedded integer coefficient identity")

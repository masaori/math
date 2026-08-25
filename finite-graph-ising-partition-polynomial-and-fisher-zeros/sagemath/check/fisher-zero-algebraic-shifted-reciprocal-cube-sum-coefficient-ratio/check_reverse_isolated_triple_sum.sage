# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: T_{G,3} = R_G^3 - S_{G,3} - q_3 U_{G,2,1}
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            R = reciprocal_power_sum(data, a, 1)
            S3 = reciprocal_power_sum(data, a, 3)
            U = ordered_distinct_pair_sum(data, a)
            T3 = ordered_distinct_triple_sum(data, a)
            assert T3 == R**3 - S3 - q3 * U, (data["name"], a)
print("RESULT: PASS — the isolated triple-sum equality is reversed")

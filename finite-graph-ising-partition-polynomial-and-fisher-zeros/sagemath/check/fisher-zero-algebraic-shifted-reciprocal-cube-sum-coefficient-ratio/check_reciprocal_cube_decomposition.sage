# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: R_G(a)^3 = S_{G,3}(a) + q_3 U_G(a) + T_{G,3}(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            left = reciprocal_power_sum(data, a, 1) ** 3
            right = reciprocal_power_sum(data, a, 3) + q3 * ordered_distinct_pair_sum(data, a) + ordered_distinct_triple_sum(data, a)
            assert left == right, (data["name"], a)
print("RESULT: PASS — the reciprocal cube splits according to the three index-equality patterns")

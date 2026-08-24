# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: R_G(a) S_{G,2}(a) = S_{G,3}(a) + U_G(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            left = reciprocal_power_sum(data, a, 1) * reciprocal_power_sum(data, a, 2)
            right = reciprocal_power_sum(data, a, 3) + ordered_distinct_pair_sum(data, a)
            assert left == right, (data["name"], a)
print("RESULT: PASS — the reciprocal product splits into diagonal and ordered non-diagonal terms")

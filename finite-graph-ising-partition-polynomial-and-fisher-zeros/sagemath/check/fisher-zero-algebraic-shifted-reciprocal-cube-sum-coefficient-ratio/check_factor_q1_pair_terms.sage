# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_1 U+q_1 U+q_1 U = (q_1+q_1+q_1)U
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            pair_sum = ordered_distinct_pair_sum(data, a)
            assert q1 * pair_sum + q1 * pair_sum + q1 * pair_sum == (q1 + q1 + q1) * pair_sum, (data["name"], a)
print("RESULT: PASS — distributivity factors the three q_1-weighted pair sums")

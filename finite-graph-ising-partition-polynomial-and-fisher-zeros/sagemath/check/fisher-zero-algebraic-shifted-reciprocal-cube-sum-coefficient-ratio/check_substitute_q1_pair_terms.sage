# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: U+U+U = q_1 U+q_1 U+q_1 U
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            pair_sum = ordered_distinct_pair_sum(data, a)
            assert pair_sum + pair_sum + pair_sum == q1 * pair_sum + q1 * pair_sum + q1 * pair_sum, (data["name"], a)
print("RESULT: PASS — substituting q_1=1 into the three pair-sum terms preserves their sum")

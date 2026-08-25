# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: U_{G,2,1}(a) + U_{G,2,1}(a) + U_{G,2,1}(a) = q_3 U_{G,2,1}(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            pair_sum = ordered_distinct_pair_sum(data, a)
            assert pair_sum + pair_sum + pair_sum == q3 * pair_sum, (data["name"], a)
print("RESULT: PASS — three identical non-diagonal pair sums collect to q_3 times the pair sum")

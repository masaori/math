# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: S_{G,3}+U_{G,2,1}+U_{G,2,1}+V_{G,1,2}+T_{G,3}
#         = S_{G,3}+U_{G,2,1}+U_{G,2,1}+U_{G,2,1}+T_{G,3}
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            roots = data["roots"]
            reciprocal_cube_sum = reciprocal_power_sum(data, a, 3)
            ordered_pair_sum = ordered_distinct_pair_sum(data, a)
            swapped_ordered_pair_sum = sum(
                (
                    (a - roots[first]) ** (-1) * (a - roots[second]) ** (-2)
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                    if first != second
                ),
                QQbar(0),
            )
            ordered_triple_sum = ordered_distinct_triple_sum(data, a)
            before_substitution = (
                reciprocal_cube_sum
                + ordered_pair_sum
                + ordered_pair_sum
                + swapped_ordered_pair_sum
                + ordered_triple_sum
            )
            after_substitution = (
                reciprocal_cube_sum
                + ordered_pair_sum
                + ordered_pair_sum
                + ordered_pair_sum
                + ordered_triple_sum
            )
            assert before_substitution == after_substitution, (data["name"], a)
print("RESULT: PASS — substituting V_{1,2}=U_{2,1} into the five-term decomposition is exact")

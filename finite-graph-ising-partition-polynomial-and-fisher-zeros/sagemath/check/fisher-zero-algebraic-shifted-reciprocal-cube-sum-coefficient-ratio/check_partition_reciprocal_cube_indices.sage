# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: ordered triple sum = S_3 + U_{2,1} + U_{2,1} + V_{1,2} + T_3
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            roots = data["roots"]
            full_triple_sum = sum(
                (
                    ((a - roots[first]) * (a - roots[second]) * (a - roots[third])) ** (-1)
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                    for third in range(data["degree"])
                ),
                QQbar(0),
            )
            opposite_pair_sum = sum(
                (
                    (a - roots[first]) ** (-1) * (a - roots[second]) ** (-2)
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                    if first != second
                ),
                QQbar(0),
            )
            partitioned_sum = (
                reciprocal_power_sum(data, a, 3)
                + ordered_distinct_pair_sum(data, a)
                + ordered_distinct_pair_sum(data, a)
                + opposite_pair_sum
                + ordered_distinct_triple_sum(data, a)
            )
            assert full_triple_sum == partitioned_sum, (data["name"], a)
print("RESULT: PASS — the ordered triple sum partitions into the five index-equality terms")

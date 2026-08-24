# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: sum_{k!=l} 1/((a-alpha_k)(a-alpha_l)^2) = sum_{k!=l} 1/((a-alpha_k)^2(a-alpha_l))
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            roots = data["roots"]
            left = sum(
                (
                    (a - roots[first]) ** (-1) * (a - roots[second]) ** (-2)
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                    if first != second
                ),
                QQbar(0),
            )
            right = ordered_distinct_pair_sum(data, a)
            assert left == right, (data["name"], a)
print("RESULT: PASS — swapping the two non-diagonal indices preserves the ordered pair sum")

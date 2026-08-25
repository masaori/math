# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: V_{G,1,2}(a) = U_{G,2,1}(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            roots = data["roots"]
            opposite_pair_sum = sum(
                (
                    (a - roots[first]) ** (-1) * (a - roots[second]) ** (-2)
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                    if first != second
                ),
                QQbar(0),
            )
            assert opposite_pair_sum == ordered_distinct_pair_sum(data, a), (data["name"], a)
print("RESULT: PASS — swapping the ordered non-diagonal indices identifies V_{1,2} with U_{2,1}")

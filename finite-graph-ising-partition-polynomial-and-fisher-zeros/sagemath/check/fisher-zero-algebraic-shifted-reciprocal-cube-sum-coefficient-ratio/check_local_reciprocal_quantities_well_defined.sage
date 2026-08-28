# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 本文主張: 非零な零点差から定めた全ての局所逆数和は QQbar に属する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            assert all(a - alpha != 0 for alpha in roots), (data["name"], a)
            swapped_ordered_distinct_pair_sum = sum(
                (
                    (a - roots[first]) ** (-1)
                    * (a - roots[second]) ** (-2)
                    for first in range(len(roots))
                    for second in range(len(roots))
                    if first != second
                ),
                QQbar(0),
            )
            local_quantities = (
                reciprocal_power_sum(data, a, 1),
                reciprocal_power_sum(data, a, 2),
                reciprocal_power_sum(data, a, 3),
                ordered_distinct_pair_sum(data, a),
                swapped_ordered_distinct_pair_sum,
                ordered_distinct_triple_sum(data, a),
            )
            assert all(value.parent() is QQbar for value in local_quantities), (data["name"], a)
print("RESULT: PASS — every local reciprocal quantity is well-defined in QQbar at each nonzero evaluation")

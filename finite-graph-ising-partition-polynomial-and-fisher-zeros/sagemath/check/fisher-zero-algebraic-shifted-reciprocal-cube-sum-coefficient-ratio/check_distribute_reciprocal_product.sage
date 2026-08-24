# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: (sum_k 1/(a-alpha_k))(sum_l 1/(a-alpha_l)^2) = sum_{k,l} 1/((a-alpha_k)(a-alpha_l)^2)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            roots = data["roots"]
            left = (
                sum(((a - alpha) ** (-1) for alpha in roots), QQbar(0))
                * sum(((a - alpha) ** (-2) for alpha in roots), QQbar(0))
            )
            right = sum(
                (
                    (a - roots[first]) ** (-1) * (a - roots[second]) ** (-2)
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                ),
                QQbar(0),
            )
            assert left == right, (data["name"], a)
print("RESULT: PASS — finite distributivity expands the reciprocal product into the ordered double sum")

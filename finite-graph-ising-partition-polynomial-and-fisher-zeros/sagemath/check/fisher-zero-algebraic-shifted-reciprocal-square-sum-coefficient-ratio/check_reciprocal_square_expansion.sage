# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: R_G(a)^2 - sum_j (a-alpha_j)^-2 = sum_k sum_{l != k} ((a-alpha_k)(a-alpha_l))^-1
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            reciprocal_sum = sum(((a - alpha)**(-1) for alpha in data["roots"]), QQbar(0))
            reciprocal_square_sum = sum(((a - alpha)**(-2) for alpha in data["roots"]), QQbar(0))
            ordered_reciprocal_pair_sum = sum(
                (
                    ((a - data["roots"][first]) * (a - data["roots"][second])) ** (-1)
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                    if first != second
                ),
                QQbar(0),
            )
            assert reciprocal_sum**2 - reciprocal_square_sum == ordered_reciprocal_pair_sum, (data["name"], a)
print("RESULT: PASS — the reciprocal-sum square separates diagonal terms from ordered distinct-root pairs")

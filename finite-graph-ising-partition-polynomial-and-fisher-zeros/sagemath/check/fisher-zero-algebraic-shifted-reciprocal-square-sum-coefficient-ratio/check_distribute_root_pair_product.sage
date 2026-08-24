# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: prod_j(a-alpha_j) * sum_{k != l} 1/((a-alpha_k)(a-alpha_l))
#          = sum_{k != l} prod_j(a-alpha_j)/((a-alpha_k)(a-alpha_l))
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            total_product = prod((a - alpha for alpha in data["roots"]), QQbar(1))
            ordered_reciprocal_pair_sum = sum(
                (
                    ((a - data["roots"][first]) * (a - data["roots"][second])) ** (-1)
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                    if first != second
                ),
                QQbar(0),
            )
            distributed_sum = sum(
                (
                    total_product
                    / ((a - data["roots"][first]) * (a - data["roots"][second]))
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                    if first != second
                ),
                QQbar(0),
            )
            assert total_product * ordered_reciprocal_pair_sum == distributed_sum, (data["name"], a)
print("RESULT: PASS — the root product distributes over the ordered distinct-root-pair sum")

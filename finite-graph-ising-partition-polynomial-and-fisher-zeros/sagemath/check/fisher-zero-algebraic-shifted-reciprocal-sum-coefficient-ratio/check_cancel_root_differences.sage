# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio
# 式ペア: sum_k prod_j(a-alpha_j)/(a-alpha_k) = sum_k prod_{j != k}(a-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            root_product = prod((a - alpha for alpha in data["roots"]), QQbar(1))
            divided_product_sum = sum(
                (root_product / (a - alpha) for alpha in data["roots"]),
                QQbar(0),
            )
            excluded_factor_sum = sum(
                (
                    prod(
                        (a - alpha for index, alpha in enumerate(data["roots"]) if index != omitted),
                        QQbar(1),
                    )
                    for omitted in range(data["degree"])
                ),
                QQbar(0),
            )
            assert divided_product_sum == excluded_factor_sum, (data["name"], a)
print("RESULT: PASS — every nonzero root difference cancels one factor in its summand")

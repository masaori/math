# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio
# 式ペア: prod_j(a-alpha_j) sum_k 1/(a-alpha_k) = sum_k prod_j(a-alpha_j)/(a-alpha_k)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            root_product = prod((a - alpha for alpha in data["roots"]), QQbar(1))
            reciprocal_sum = sum(((a - alpha)**(-1) for alpha in data["roots"]), QQbar(0))
            divided_product_sum = sum(
                (root_product / (a - alpha) for alpha in data["roots"]),
                QQbar(0),
            )
            assert root_product * reciprocal_sum == divided_product_sum, (data["name"], a)
print("RESULT: PASS — distributivity moves the common shifted-root product into every summand")

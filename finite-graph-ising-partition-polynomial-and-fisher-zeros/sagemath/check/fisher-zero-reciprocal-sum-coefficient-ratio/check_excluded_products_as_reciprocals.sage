# 対象ラベル: theorem_fisher_zero_reciprocal_sum_coefficient_ratio
# 式ペア: sum_k product_(j != k) alpha_j = (product_j alpha_j) sum_k 1/alpha_k

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-reciprocal-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    degree = data["degree"]
    excluded_product_sum = sum(
        prod(roots[index] for index in range(degree) if index != omitted_index)
        for omitted_index in range(degree)
    )
    reciprocal_expression = prod(roots) * sum(QQbar(1) / alpha for alpha in roots)
    assert all(alpha != 0 for alpha in roots), data["name"]
    assert excluded_product_sum == reciprocal_expression, data["name"]

print("RESULT: PASS — every excluded-root product equals the total root product times the corresponding reciprocal")

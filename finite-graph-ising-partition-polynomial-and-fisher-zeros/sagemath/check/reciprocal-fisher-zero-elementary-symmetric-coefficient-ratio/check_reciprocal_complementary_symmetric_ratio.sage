# 対象ラベル: theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio
# 式ペア: e_k(alpha^(-1)) = e_{d-k}(alpha) / e_d(alpha)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-elementary-symmetric-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    assert all(alpha != 0 for alpha in roots), data["name"]
    reciprocal_roots = tuple(alpha ** (-1) for alpha in roots)
    total_product = selected_products(roots, data["degree"])
    assert total_product != 0, data["name"]
    for cardinality in range(data["degree"] + 1):
        reciprocal_symmetric_sum = selected_products(reciprocal_roots, cardinality)
        complementary_symmetric_ratio = (
            selected_products(roots, data["degree"] - cardinality) / total_product
        )
        assert reciprocal_symmetric_sum == complementary_symmetric_ratio, (
            data["name"],
            cardinality,
        )

print("RESULT: PASS — every reciprocal elementary symmetric sum is the complementary root sum divided by the total root product")

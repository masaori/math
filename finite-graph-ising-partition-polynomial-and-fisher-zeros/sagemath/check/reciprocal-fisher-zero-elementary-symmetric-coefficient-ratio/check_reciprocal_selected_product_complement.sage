# 対象ラベル: theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio
# 式ペア: prod_{j in I} alpha_j^(-1) = (prod_j alpha_j)^(-1) prod_{j notin I} alpha_j

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-elementary-symmetric-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    assert all(alpha != 0 for alpha in roots), data["name"]
    total_product = prod(roots, QQbar(1))
    for cardinality in range(data["degree"] + 1):
        for selected_indices in combinations(range(data["degree"]), cardinality):
            selected = frozenset(selected_indices)
            reciprocal_product = prod((roots[index] ** (-1) for index in selected), QQbar(1))
            complement_product = prod(
                (roots[index] for index in range(data["degree"]) if index not in selected),
                QQbar(1),
            )
            assert reciprocal_product == total_product ** (-1) * complement_product, (
                data["name"],
                cardinality,
                selected_indices,
            )

print("RESULT: PASS — every selected reciprocal product equals its complementary root product divided by the total product")

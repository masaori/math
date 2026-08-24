# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: distribute the common root-product denominator over the ordered triple sum
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        root_product = prod((a - alpha for alpha in roots), QQbar(1))
        if root_product != 0:
            omitted_products = tuple(
                prod(
                    (a - roots[index] for index in range(data["degree"]) if index not in omitted),
                    QQbar(1),
                )
                for omitted in Permutations(range(data["degree"]), 3)
            )
            left = sum(omitted_products, QQbar(0)) / root_product
            right = sum((term / root_product for term in omitted_products), QQbar(0))
            assert left == right, (data["name"], a)
print("RESULT: PASS — division distributes over the finite ordered triple sum")

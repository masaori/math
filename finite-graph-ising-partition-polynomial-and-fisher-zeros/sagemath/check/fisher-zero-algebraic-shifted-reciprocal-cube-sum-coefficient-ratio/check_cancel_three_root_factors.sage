# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: cancel the common nonzero factors outside each ordered triple term by term
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        root_product = prod((a - alpha for alpha in roots), QQbar(1))
        if root_product != 0:
            for omitted in Permutations(range(data["degree"]), 3):
                omitted_product = prod(
                    (a - roots[index] for index in range(data["degree"]) if index not in omitted),
                    QQbar(1),
                )
                omitted_factors = prod((a - roots[index] for index in omitted), QQbar(1))
                assert omitted_factors != 0, (data["name"], a, omitted)
                assert omitted_product / root_product == 1 / omitted_factors, (data["name"], a, omitted)
print("RESULT: PASS — each ordered triple term cancels exactly the common nonzero factors outside the triple")

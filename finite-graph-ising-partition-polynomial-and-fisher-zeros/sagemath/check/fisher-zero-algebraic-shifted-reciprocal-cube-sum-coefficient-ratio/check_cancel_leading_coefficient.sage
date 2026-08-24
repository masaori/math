# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: cancel the common nonzero leading coefficient in the third-derivative ratio
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        root_product = prod((a - alpha for alpha in roots), QQbar(1))
        if root_product != 0:
            omitted_sum = sum(
                (
                    prod(
                        (a - roots[index] for index in range(data["degree"]) if index not in omitted),
                        QQbar(1),
                    )
                    for omitted in Permutations(range(data["degree"]), 3)
                ),
                QQbar(0),
            )
            leading = data["leading_coefficient"]
            assert leading != 0, data["name"]
            assert (leading * omitted_sum) / (leading * root_product) == omitted_sum / root_product, (data["name"], a)
print("RESULT: PASS — the common nonzero leading coefficient cancels exactly")

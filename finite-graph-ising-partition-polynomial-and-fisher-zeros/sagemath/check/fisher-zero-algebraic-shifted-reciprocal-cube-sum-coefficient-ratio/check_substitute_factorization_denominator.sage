# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D^3 Pbar_G(a) / Pbar_G(a) の分母へ一次因子分解を代入する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
            root_product = prod((a - alpha for alpha in roots), QQbar(1))
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
            numerator = leading * omitted_sum
            assert polynomial_value == leading * root_product, (data["name"], a)
            assert numerator / polynomial_value == numerator / (leading * root_product), (data["name"], a)
print("RESULT: PASS — the evaluated linear factorization substitutes exactly into the ratio denominator")

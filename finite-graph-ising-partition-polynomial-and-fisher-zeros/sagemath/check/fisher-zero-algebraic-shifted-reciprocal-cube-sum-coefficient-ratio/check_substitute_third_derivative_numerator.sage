# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D^3 Pbar_G(a) / Pbar_G(a) の分子へ一次因子積の三回形式微分式を代入する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
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
            left = data["polynomial"].derivative(3)(a) / polynomial_value
            right = data["leading_coefficient"] * omitted_sum / polynomial_value
            assert left == right, (data["name"], a)
print("RESULT: PASS — the ordered omitted-index third derivative substitutes exactly into the ratio numerator")

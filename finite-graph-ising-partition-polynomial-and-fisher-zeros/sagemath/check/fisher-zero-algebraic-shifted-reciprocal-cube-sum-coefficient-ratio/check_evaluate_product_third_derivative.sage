# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: 一次因子積の三回形式微分式へ x=a を代入する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        evaluated_omitted_sum = sum(
            (
                prod(
                    (a - roots[index] for index in range(data["degree"]) if index not in omitted),
                    QQbar(1),
                )
                for omitted in Permutations(range(data["degree"]), 3)
            ),
            QQbar(0),
        )
        left = data["polynomial"].derivative(3)(a)
        right = data["leading_coefficient"] * evaluated_omitted_sum
        assert left == right, (data["name"], a)
print("RESULT: PASS — evaluating the product-side third derivative gives the ordered omitted-index sum at every algebraic point")

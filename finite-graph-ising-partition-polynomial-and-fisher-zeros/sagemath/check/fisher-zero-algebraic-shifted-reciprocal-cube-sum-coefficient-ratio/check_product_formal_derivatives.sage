# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: 重複度込み一次因子積を一回、二回、三回形式微分した各恒等式
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    x = data["x"]
    roots = data["roots"]
    for derivative_order in (1, 2, 3):
        omitted_products = sum(
            (
                prod(
                    (x - roots[index] for index in range(data["degree"]) if index not in omitted),
                    data["polynomial_ring"].one(),
                )
                for omitted in Permutations(range(data["degree"]), derivative_order)
            ),
            data["polynomial_ring"].zero(),
        )
        assert data["polynomial"].derivative(derivative_order) == data["leading_coefficient"] * omitted_products, (data["name"], derivative_order)
print("RESULT: PASS — each product-side formal derivative is the ordered omitted-index sum")

# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: 係数表示を一回、二回、三回形式微分した各多項式恒等式
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    polynomial = data["polynomial"]
    x = data["x"]
    for derivative_order in (1, 2, 3):
        coefficient_polynomial = sum(
            (
                QQbar(QQ(prod((exponent - offset for offset in range(derivative_order)), ZZ(1)) * data["multiplicities"][exponent]))
                * x ** (exponent - derivative_order)
                for exponent in range(derivative_order, data["edge_count"] + 1)
            ),
            data["polynomial_ring"].zero(),
        )
        assert polynomial.derivative(derivative_order) == coefficient_polynomial, (data["name"], derivative_order)
print("RESULT: PASS — each of the first three coefficient-side formal derivatives is exact")

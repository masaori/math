# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: 因数分解した有限係数和への形式微分の定義の適用
# 帰属: QQ, QQbar, QQbar[x] だけを用いる
polynomial_ring = PolynomialRing(QQbar, "x")
x = polynomial_ring.gen()


def polynomial_from_coefficients(coefficients):
    return sum(
        coefficients[degree] * x^degree
        for degree in range(len(coefficients))
    )


def derivative_from_coefficients(coefficients):
    return sum(
        coefficients[degree] * QQbar(QQ(degree)) * x^(degree - 1)
        for degree in range(1, len(coefficients))
    )


sqrt_two = QQbar(2).sqrt()
coefficient_pairs = [
    ([QQbar(0)], [QQbar(0)]),
    ([QQbar(3)], [sqrt_two, QQbar(-1)]),
    ([QQbar(1), sqrt_two, QQbar(-2)], [QQbar(5)]),
    ([sqrt_two, QQbar(3), QQbar(-1)], [QQbar(2), -sqrt_two, QQbar(4)]),
]

for first_coefficients, second_coefficients in coefficient_pairs:
    first_polynomial = polynomial_from_coefficients(first_coefficients)
    second_polynomial = polynomial_from_coefficients(second_coefficients)
    factored_coefficient_sums = (
        derivative_from_coefficients(first_coefficients) * second_polynomial
        + first_polynomial * derivative_from_coefficients(second_coefficients)
    )
    derivative_definition_step = (
        first_polynomial.derivative() * second_polynomial
        + first_polynomial * second_polynomial.derivative()
    )
    assert factored_coefficient_sums == derivative_definition_step

print("RESULT: PASS - the derivative definition is applied to the factored coefficient sums")

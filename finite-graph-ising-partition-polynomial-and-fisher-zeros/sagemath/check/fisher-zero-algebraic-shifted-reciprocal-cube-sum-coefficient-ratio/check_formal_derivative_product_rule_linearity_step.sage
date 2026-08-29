# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式列: 積の有限係数表示へ形式微分の線形性を適用する一行
# 帰属: QQbar, QQbar[x] だけを用いる
polynomial_ring = PolynomialRing(QQbar, "x")
x = polynomial_ring.gen()


def polynomial_from_coefficients(coefficients):
    return sum(
        (coefficients[degree] * x^degree for degree in range(len(coefficients))),
        polynomial_ring.zero(),
    )


sqrt_two = QQbar(2).sqrt()
coefficient_pairs = (
    ((QQbar(0),), (QQbar(0),)),
    ((QQbar(3),), (sqrt_two, QQbar(-1))),
    ((QQbar(1), sqrt_two, QQbar(-2)), (QQbar(5),)),
    ((sqrt_two, QQbar(3), QQbar(-1)), (QQbar(2), -sqrt_two, QQbar(4))),
)

for first_coefficients, second_coefficients in coefficient_pairs:
    first_polynomial = polynomial_from_coefficients(first_coefficients)
    second_polynomial = polynomial_from_coefficients(second_coefficients)
    product = first_polynomial * second_polynomial
    termwise_derivative = sum(
        (
            (
                first_coefficients[first_degree]
                * second_coefficients[second_degree]
                * x^(first_degree + second_degree)
            ).derivative()
            for first_degree in range(len(first_coefficients))
            for second_degree in range(len(second_coefficients))
        ),
        polynomial_ring.zero(),
    )
    assert product.derivative() == termwise_derivative

print("RESULT: PASS - linearity moves the formal derivative through the finite coefficient sum")

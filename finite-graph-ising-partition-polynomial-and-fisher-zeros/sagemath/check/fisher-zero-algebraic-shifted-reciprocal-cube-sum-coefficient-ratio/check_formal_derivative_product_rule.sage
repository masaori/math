# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D(fg) = D(f)g + fD(g)
# 帰属: QQ, QQbar, QQbar[x] だけを用いる
polynomial_ring = PolynomialRing(QQbar, "x")
x = polynomial_ring.gen()


def derivative_from_unique_coefficients(polynomial):
    polynomial = polynomial_ring(polynomial)
    return sum(
        polynomial[degree] * QQbar(QQ(degree)) * x^(degree - 1)
        for degree in range(1, polynomial.degree() + 1)
    ) if polynomial != 0 else polynomial_ring.zero()


sqrt_two = QQbar(2).sqrt()
polynomial_pairs = [
    (polynomial_ring.zero(), sqrt_two * x^2 + 1),
    (QQbar(3), sqrt_two * x^3 - x),
    (sqrt_two * x^2 + QQbar(5), x^3 - QQbar(2) * x + 1),
]

for first_polynomial, second_polynomial in polynomial_pairs:
    product_derivative = derivative_from_unique_coefficients(
        first_polynomial * second_polynomial
    )
    product_rule = (
        derivative_from_unique_coefficients(first_polynomial) * second_polynomial
        + first_polynomial * derivative_from_unique_coefficients(second_polynomial)
    )
    assert product_derivative == product_rule
    assert product_derivative == (first_polynomial * second_polynomial).derivative()

print("RESULT: PASS - the formal derivative satisfies the product rule")

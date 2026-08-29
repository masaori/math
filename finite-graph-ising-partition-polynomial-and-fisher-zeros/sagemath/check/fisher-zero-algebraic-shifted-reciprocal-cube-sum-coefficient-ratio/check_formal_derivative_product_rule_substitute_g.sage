# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: 第二多項式の係数表示 g=sum_j b_j x^j の代入
# 帰属: QQ, QQbar, QQbar[x] だけを用いる
polynomial_ring = PolynomialRing(QQbar, "x")
x = polynomial_ring.gen()


def polynomial_from_coefficients(coefficients):
    return sum(
        coefficients[degree] * x^degree
        for degree in range(len(coefficients))
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
    second_coefficient_sum = polynomial_from_coefficients(second_coefficients)
    before_substitution = (
        first_polynomial.derivative() * second_coefficient_sum
        + first_polynomial * second_coefficient_sum.derivative()
    )
    second_polynomial = polynomial_ring(second_coefficient_sum)
    after_substitution = (
        first_polynomial.derivative() * second_polynomial
        + first_polynomial * second_polynomial.derivative()
    )
    assert before_substitution == after_substitution

print("RESULT: PASS - the coefficient representation of g is substituted alone")

# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: 一意な係数表示から定めた Qbar 線形拡張は多項式の表示に依存しない
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
representations = [
    (
        sqrt_two * x^4 - QQbar(3) * x^2 + QQbar(5),
        (sqrt_two * x^4 + x^2) + (-QQbar(4) * x^2 + QQbar(5)),
    ),
    (polynomial_ring.zero(), x - x),
    (QQbar(7), QQbar(3) + QQbar(4)),
]

for first_representation, second_representation in representations:
    assert first_representation == second_representation
    first_derivative = derivative_from_unique_coefficients(first_representation)
    second_derivative = derivative_from_unique_coefficients(second_representation)
    assert first_derivative == second_derivative
    assert first_derivative == polynomial_ring(first_representation).derivative()

print("RESULT: PASS - the linear extension of the formal derivative is well-defined")

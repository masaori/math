# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式列: 分離した定数項へ形式微分の定数則を適用する一行
# 帰属: QQbar, QQbar[x] だけを用いる
polynomial_ring = PolynomialRing(QQbar, "x")
x = polynomial_ring.gen()


sqrt_two = QQbar(2).sqrt()
coefficient_pairs = (
    ((QQbar(0),), (QQbar(0),)),
    ((QQbar(3),), (sqrt_two, QQbar(-1))),
    ((QQbar(1), sqrt_two, QQbar(-2)), (QQbar(5),)),
    ((sqrt_two, QQbar(3), QQbar(-1)), (QQbar(2), -sqrt_two, QQbar(4))),
)

for first_coefficients, second_coefficients in coefficient_pairs:
    positive_degree_derivatives = sum(
        (
            (
                first_coefficients[first_degree]
                * second_coefficients[second_degree]
                * x^(first_degree + second_degree)
            ).derivative()
            for first_degree in range(len(first_coefficients))
            for second_degree in range(len(second_coefficients))
            if first_degree + second_degree > 0
        ),
        polynomial_ring.zero(),
    )
    before_constant_rule = (
        polynomial_ring(first_coefficients[0] * second_coefficients[0]).derivative()
        + positive_degree_derivatives
    )
    after_constant_rule = polynomial_ring.zero() + positive_degree_derivatives
    assert before_constant_rule == after_constant_rule

print("RESULT: PASS - the formal derivative constant rule replaces the separated constant term by zero")

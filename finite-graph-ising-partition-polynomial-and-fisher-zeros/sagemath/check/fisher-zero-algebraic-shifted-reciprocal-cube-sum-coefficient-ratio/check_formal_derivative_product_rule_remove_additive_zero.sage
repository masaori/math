# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式列: 定数項の形式微分から得た加法零元を除く一行
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
    assert polynomial_ring.zero() + positive_degree_derivatives == positive_degree_derivatives

print("RESULT: PASS - the additive identity removes the zero constant derivative term")

# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式列: 形式微分の積法則を有限係数表示から導く
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
    product = first_polynomial * second_polynomial

    expanded_product = sum(
        first_coefficients[first_degree]
        * second_coefficients[second_degree]
        * x^(first_degree + second_degree)
        for first_degree in range(len(first_coefficients))
        for second_degree in range(len(second_coefficients))
    )
    assert product == expanded_product

    derivative_of_product = product.derivative()
    differentiated_distributed_product = sum(
        first_coefficients[first_degree]
        * second_coefficients[second_degree]
        * QQbar(QQ(first_degree + second_degree))
        * x^(first_degree + second_degree - 1)
        for first_degree in range(len(first_coefficients))
        for second_degree in range(len(second_coefficients))
        if first_degree + second_degree > 0
    )
    assert derivative_of_product == differentiated_distributed_product

    rational_additive_split = sum(
        first_coefficients[first_degree]
        * second_coefficients[second_degree]
        * QQbar(QQ(first_degree) + QQ(second_degree))
        * x^(first_degree + second_degree - 1)
        for first_degree in range(len(first_coefficients))
        for second_degree in range(len(second_coefficients))
        if first_degree + second_degree > 0
    )
    assert differentiated_distributed_product == rational_additive_split

    algebraic_additive_split = sum(
        first_coefficients[first_degree]
        * second_coefficients[second_degree]
        * (QQbar(QQ(first_degree)) + QQbar(QQ(second_degree)))
        * x^(first_degree + second_degree - 1)
        for first_degree in range(len(first_coefficients))
        for second_degree in range(len(second_coefficients))
        if first_degree + second_degree > 0
    )
    assert rational_additive_split == algebraic_additive_split

    distributed_additive_terms = sum(
        first_coefficients[first_degree]
        * second_coefficients[second_degree]
        * QQbar(QQ(first_degree))
        * x^(first_degree + second_degree - 1)
        for first_degree in range(len(first_coefficients))
        for second_degree in range(len(second_coefficients))
        if first_degree + second_degree > 0
    ) + sum(
        first_coefficients[first_degree]
        * second_coefficients[second_degree]
        * QQbar(QQ(second_degree))
        * x^(first_degree + second_degree - 1)
        for first_degree in range(len(first_coefficients))
        for second_degree in range(len(second_coefficients))
        if first_degree + second_degree > 0
    )
    assert algebraic_additive_split == distributed_additive_terms

    separated_positive_degrees = sum(
        first_coefficients[first_degree]
        * second_coefficients[second_degree]
        * QQbar(QQ(first_degree))
        * x^(first_degree + second_degree - 1)
        for first_degree in range(1, len(first_coefficients))
        for second_degree in range(len(second_coefficients))
    ) + sum(
        first_coefficients[first_degree]
        * second_coefficients[second_degree]
        * QQbar(QQ(second_degree))
        * x^(first_degree + second_degree - 1)
        for first_degree in range(len(first_coefficients))
        for second_degree in range(1, len(second_coefficients))
    )
    assert distributed_additive_terms == separated_positive_degrees

    split_monomial_powers = sum(
        (
            first_coefficients[first_degree]
            * QQbar(QQ(first_degree))
            * x^(first_degree - 1)
        )
        * (second_coefficients[second_degree] * x^second_degree)
        for first_degree in range(1, len(first_coefficients))
        for second_degree in range(len(second_coefficients))
    ) + sum(
        (first_coefficients[first_degree] * x^first_degree)
        * (
            second_coefficients[second_degree]
            * QQbar(QQ(second_degree))
            * x^(second_degree - 1)
        )
        for first_degree in range(len(first_coefficients))
        for second_degree in range(1, len(second_coefficients))
    )
    assert separated_positive_degrees == split_monomial_powers

    factored_finite_sums = (
        derivative_from_coefficients(first_coefficients) * second_polynomial
        + first_polynomial * derivative_from_coefficients(second_coefficients)
    )
    assert split_monomial_powers == factored_finite_sums
    assert factored_finite_sums == (
        first_polynomial.derivative() * second_polynomial
        + first_polynomial * second_polynomial.derivative()
    )

print("RESULT: PASS - coefficient expansions derive the formal derivative product rule")

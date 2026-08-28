# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D^2 = D composed with D, D^3 = D composed with D composed with D
# 帰属: QQbar, QQbar[x] だけを用いる
polynomial_ring = PolynomialRing(QQbar, "x")
x = polynomial_ring.gen()

polynomials = [
    polynomial_ring.zero(),
    polynomial_ring.one(),
    QQbar(2).sqrt() * x^5 - QQbar(3) * x^2 + QQbar(7),
]

for polynomial in polynomials:
    first_derivative = polynomial.derivative()
    second_derivative_by_composition = first_derivative.derivative()
    third_derivative_by_composition = second_derivative_by_composition.derivative()
    assert polynomial.derivative(2) == second_derivative_by_composition
    assert polynomial.derivative(3) == third_derivative_by_composition

print("RESULT: PASS - the second and third formal derivatives are the stated iterates")

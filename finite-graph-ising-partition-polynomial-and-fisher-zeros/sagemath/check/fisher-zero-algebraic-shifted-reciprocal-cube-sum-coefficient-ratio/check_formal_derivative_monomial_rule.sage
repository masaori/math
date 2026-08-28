# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D(c x^m) = c iota(eta(m)) x^(m-1) for c in QQbar and m in NN_{>0}
# 帰属: QQ, QQbar, QQbar[x] だけを用いる
polynomial_ring = PolynomialRing(QQbar, "x")
x = polynomial_ring.gen()

coefficients = [QQbar(0), QQbar(1), QQbar(-3), QQbar(2).sqrt()]
positive_degrees = [1, 2, 5]

for coefficient in coefficients:
    for degree in positive_degrees:
        embedded_degree = QQbar(QQ(degree))
        monomial = coefficient * x^degree
        expected_derivative = coefficient * embedded_degree * x^(degree - 1)
        assert monomial.derivative() == expected_derivative

print("RESULT: PASS - the formal derivative monomial rule holds over QQbar[x]")

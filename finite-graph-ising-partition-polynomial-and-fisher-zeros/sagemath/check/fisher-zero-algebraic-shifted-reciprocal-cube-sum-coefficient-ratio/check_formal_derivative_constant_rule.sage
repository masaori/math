# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D(c) = 0 for every c in QQbar
# 帰属: QQbar、QQbar[x] だけを用いる
polynomial_ring = PolynomialRing(QQbar, "x")

constants = [QQbar(0), QQbar(1), QQbar(-3), QQbar(2).sqrt()]

for constant in constants:
    constant_polynomial = polynomial_ring(constant)
    assert constant_polynomial.derivative() == polynomial_ring.zero()

print("RESULT: PASS — the formal derivative of every tested algebraic constant is zero")

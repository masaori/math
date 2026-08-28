# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D(f+g)=D(f)+D(g), D(cf)=cD(f) in QQbar[x]
# 帰属: c in QQbar, f,g in QQbar[x]

polynomial_ring = PolynomialRing(QQbar, "x")
x = polynomial_ring.gen()

f = QQbar(2).sqrt() * x^4 - QQbar(3) * x^2 + QQbar(5)
g = -x^3 + QQbar(7).sqrt() * x + QQbar(11)
c = QQbar(13).sqrt()

assert (f + g).derivative() == f.derivative() + g.derivative()
assert (c * f).derivative() == c * f.derivative()

print("RESULT: PASS - formal differentiation is additive and QQbar-homogeneous")

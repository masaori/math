# 対象ラベル: claim_real_algebraic_archimedean, claim_real_algebraic_rational_pinching
R.<X> = PolynomialRing(QQ)
examples = [
    (X^2 - 2, QQ(1)),
    (3*X^3 - 7*X + 1, QQ(1)/7),
    (5*X - 3, QQ(1)/100),
]
for p, epsilon in examples:
    d = p.degree()
    S = sum(abs(p[j] / p[d]) for j in range(d))
    B = 1 + S
    u, v = B.numerator(), B.denominator()
    M = u + 1
    e, f = epsilon.numerator(), epsilon.denominator()
    n = 2*f + 1
    assert B <= u < M and 0 < 2 / QQ(n) < epsilon
    for a, multiplicity in p.roots(AA):
        assert -B < a < B
        assert -M < a < M
        J = [j for j in range(-M*n, M*n + 1) if QQ(j)/n <= a]
        assert J
        j0 = max(J)
        assert j0 < M*n
        assert a < QQ(j0 + 1)/n
        r, s = QQ(j0 - 1)/n, QQ(j0 + 1)/n
        assert r < a < s and 0 < s-r < epsilon
print('RESULT: PASS')

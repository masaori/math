# 対象ラベル: claim_real_algebraic_rational_bounds
# 有理係数多項式の最高次項が、B 以上で残余項の絶対値を超えることの厳密な有限検算。
R.<X> = PolynomialRing(QQ)
examples = [
    X^2 - 2,
    3*X^3 - 7*X + 1,
    -2*X^4 + X^2 - 5,
    X - QQ(3)/5,
]
for p in examples:
    d = p.degree()
    S = sum(abs(p[j] / p[d]) for j in range(d))
    B = 1 + S
    assert B > 0
    assert all(abs(z) < B for z, multiplicity in p.roots(QQbar) if z.imag() == 0)
    for x in [B, B + 1, 2*B + 1]:
        remainder = sum((p[j] / p[d])*x^j for j in range(d))
        assert abs(remainder) <= S*x^(d-1)
        assert S*x^(d-1) < x^d
        assert p(x) != 0 and p(-x) != 0
print('RESULT: PASS')

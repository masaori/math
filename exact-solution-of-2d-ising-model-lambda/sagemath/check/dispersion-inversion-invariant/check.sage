# 対象ラベル: claim_dispersion_inversion_invariant
# 逆元の冪と分散因子の二つの等式を厳密に検算する。
R.<w, z> = PolynomialRing(QQ)
F = R.fraction_field()
P.<x> = PolynomialRing(F)

def delta(u, v):
    return (1 + x^2)^2 - x*(1 - x^2)*(u + 1/u + v + 1/v)

assert delta(1/w, z) == delta(w, z)
assert delta(w, 1/z) == delta(w, z)
for L in range(1, 7):
    for twist in (0, 1):
        T.<t> = PolynomialRing(QQbar)
        roots = [r for r, mult in (t^L - (-1)^twist).roots(QQbar)]
        for r in roots:
            assert r != 0
            assert (1/r)^L == (-1)^twist
print('RESULT: PASS')

# 対象ラベル: claim_quadratic_multiplication_mem
# 二次体の乗法による閉性の行別検算。すべて QQ / QQbar の厳密計算。
from itertools import product

R = PolynomialRing(QQ, 't')
t = R.gen()
roots = (t ** 2 - 2).roots(QQbar, multiplicities=False)
assert len(roots) == 2
samples = sorted(set(QQ(p) / QQ(q) for p in range(-2, 3) for q in range(1, 3)))
assert len(samples) == 7
j = QQbar


def multiplication_cases():
    for s in roots:
        assert s * s == j(2)
        for a, b, ap, bp in product(samples, repeat=4):
            A, B, Ap, Bp = j(a), j(b), j(ap), j(bp)
            xi = A + B * s
            eta = Ap + Bp * s
            yield a, b, ap, bp, s, xi, eta, A, B, Ap, Bp

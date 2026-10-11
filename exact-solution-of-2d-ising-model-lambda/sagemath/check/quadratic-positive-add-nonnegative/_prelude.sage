# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 帰属: QQ / QQbar。実数体・複素数体の順序と浮動小数点は使わない。
from functools import lru_cache
from itertools import product

qpn_samples = sorted(set(QQ(n) / QQ(d) for n in range(-4, 5) for d in range(1, 5)))
qpn_nonnegative = tuple(q for q in qpn_samples if 0 <= q)
assert len(qpn_samples) == 23
assert len(qpn_nonnegative) == 12

def qpn_valid_cases():
    for a, b, ap, bp in product(qpn_nonnegative, repeat=4):
        if (a, b) != (0, 0) and (ap, bp) != (0, 0):
            yield a, b, ap, bp

@lru_cache(maxsize=None)
def qpn_rep(value, s):
    # 入力係数や和の公式を使わず、代数的数の最小多項式から表示を取り戻す。
    if value in QQ:
        a, b = QQ(value), QQ.zero()
    else:
        minimal = value.minpoly()
        assert minimal.degree() == 2, minimal
        a = QQ(-minimal[1] / (2 * minimal[2]))
        b = QQ((value - QQbar(a)) / s)
    assert value == QQbar(a) + QQbar(b) * s
    return a, b

def qpn_algebraic_cases():
    polynomial_ring = PolynomialRing(QQ, 'q')
    q = polynomial_ring.gen()
    roots = (q**2 - 2).roots(QQbar, multiplicities=False)
    assert len(roots) == 2
    for s in roots:
        assert s*s == 2
        for a, b, ap, bp in qpn_valid_cases():
            xi = QQbar(a) + QQbar(b)*s
            eta = QQbar(ap) + QQbar(bp)*s
            assert qpn_rep(xi, s) == (a, b)
            assert qpn_rep(eta, s) == (ap, bp)
            yield s, a, b, ap, bp, xi, eta

def qpn_coefficient_positive(ab):
    a, b = ab
    return ((0 <= a and 0 <= b and (a, b) != (0, 0))
            or (0 < a and b < 0 and 2*b*b < a*a)
            or (a < 0 and 0 < b and a*a < 2*b*b))

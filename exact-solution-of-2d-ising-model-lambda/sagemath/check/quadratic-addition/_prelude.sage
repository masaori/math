# 対象ラベル: claim_quadratic_addition_mem
# 帰属: QQ / QQbar。表示の係数は最小多項式から独立に取り戻す。
from functools import lru_cache
from itertools import product

@lru_cache(maxsize=None)
def qa_rep(value, s):
    if value in QQ:
        a, b = QQ(value), QQ.zero()
    else:
        minimal = value.minpoly()
        assert minimal.degree() == 2, minimal
        a = QQ(-minimal[1] / (2 * minimal[2]))
        b = QQ((value - QQbar(a)) / s)
    assert value == QQbar(a) + QQbar(b) * s
    return (a, b)

qa_ring = PolynomialRing(QQ, 'q')
qa_q = qa_ring.gen()
qa_roots = (qa_q**2 - 2).roots(QQbar, multiplicities=False)
qa_samples = sorted(set(QQ(n) / QQ(d) for n in range(-2, 3) for d in range(1, 3)))
assert len(qa_roots) == 2 and len(qa_samples) == 7
qa_cases = []
for s in qa_roots:
    assert s*s == 2
    for a0, b0, ap0, bp0 in product(qa_samples, repeat=4):
        xi = QQbar(a0) + QQbar(b0) * s
        eta = QQbar(ap0) + QQbar(bp0) * s
        a, b = qa_rep(xi, s)
        ap, bp = qa_rep(eta, s)
        assert (a, b, ap, bp) == (a0, b0, ap0, bp0)
        qa_cases.append((s, a, b, ap, bp, xi, eta))
assert len(qa_cases) == 4802
j = QQbar

_quadratic_addition_lines_ready = True

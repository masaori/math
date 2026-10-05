# 対象ラベル: claim_quadratic_zero_mem
# 帰属: QQ / QQbar。包含写像を通して有理数の零と代数的数の零を区別する。
if '_qz_roots' not in globals():
    _qz_polynomials = PolynomialRing(QQ, 'u')
    _qz_u = _qz_polynomials.gen()
    _qz_roots = (_qz_u ** 2 - 2).roots(QQbar, multiplicities=False)
    assert len(_qz_roots) == 2
    assert all(s.parent() is QQbar and s * s == QQbar(2) for s in _qz_roots)
    _qz_zero = QQbar(0)
    _qz_rational_zero = QQ(0)


def _qz_iota(a):
    assert a.parent() is QQ
    return QQbar(a)

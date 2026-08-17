# 対象ラベル: claim_critical_distance_squared_zero_iff_equal
# 帰属: AA / QQbar の厳密計算。浮動小数点を使わない。

I = QQbar.gen()
XI_SAMPLES = [
    QQbar(0), QQbar(1), QQbar(-1), QQbar(2).sqrt(), -QQbar(2).sqrt(),
    QQbar(I), QQbar(1) + QQbar(I), QQbar(2).sqrt() + QQbar(I),
]

checked = 0
for s in (QQbar(2).sqrt(), -QQbar(2).sqrt()):
    xc = -1 + s
    xcR = AA(xc)
    for xi in XI_SAMPLES + [xc]:
        a = AA(xi.real())
        b = AA(xi.imag())
        assert xi == QQbar(a) + QQbar(b) * I
        dsq = (a - xcR) * (a - xcR) + b * b
        assert dsq in AA
        assert (dsq == 0) == (xi == xc)
        if xi == xc:
            assert a == xcR and b == 0
        if b != 0:
            w = (a - xcR) * b ** (-1)
            assert w * w == ((a - xcR) * (a - xcR)) * (b * b) ** (-1)
        checked += 1

assert checked == 18
print("OK: claim_critical_distance_squared_zero_iff_equal (%d 組)" % checked)

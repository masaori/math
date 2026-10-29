# 対象ラベル: claim_complex_realization_injective
# 実代数的な係数の有限例で、複素像の等号と係数の等号を厳密に照合する。
omega = QQbar.zeta(4)
assert omega**2 == -1
pairs = [
    ((AA(2).sqrt(), AA(3).sqrt()), (AA(2).sqrt(), AA(3).sqrt())),
    ((AA(2).sqrt(), AA(3).sqrt()), (AA(2).sqrt(), -AA(3).sqrt())),
    ((AA(2).sqrt(), AA(3).sqrt()), (-AA(2).sqrt(), AA(3).sqrt())),
    ((AA(1) / 3, -AA(5).sqrt()), (AA(1) / 3, -AA(5).sqrt())),
]
for (a, b), (c, d) in pairs:
    xi = QQbar(a) + omega * QQbar(b)
    eta = QQbar(c) + omega * QQbar(d)
    assert (xi == eta) == (a == c and b == d)
    if xi == eta:
        assert a == c and b == d
print('RESULT: PASS')

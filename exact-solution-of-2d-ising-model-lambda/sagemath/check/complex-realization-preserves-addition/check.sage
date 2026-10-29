# 対象ラベル: claim_complex_realization_preserves_addition
# 有限例で係数表示と加法を厳密に検算する。
omega = QQbar.zeta(4)
assert omega**2 == -1
examples = [
    ((AA(2).sqrt(), AA(3).sqrt()), (AA(5).sqrt(), -AA(7).sqrt())),
    ((-AA(2).sqrt(), AA(1) / 3), (AA(2).sqrt(), AA(5).sqrt())),
]
for (a, b), (c, d) in examples:
    xi = QQbar(a) + QQbar(b) * omega
    eta = QQbar(c) + QQbar(d) * omega
    image_sum = QQbar(a+c) + QQbar(b+d) * omega
    image_xi = QQbar(a) + QQbar(b) * omega
    image_eta = QQbar(c) + QQbar(d) * omega
    assert xi + eta == QQbar(a+c) + QQbar(b+d) * omega
    assert image_sum == image_xi + image_eta
print('RESULT: PASS')

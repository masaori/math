# 対象ラベル: claim_complex_realization_preserves_multiplication
# 二係数表示の積と単位元を有限例で厳密に検算する。
omega = QQbar.zeta(4)
assert omega**2 == -1
examples = [
    ((AA(2).sqrt(), AA(3).sqrt()), (AA(5).sqrt(), -AA(7).sqrt())),
    ((-AA(2).sqrt(), AA(1) / 3), (AA(2).sqrt(), AA(5).sqrt())),
]
for (a, b), (c, d) in examples:
    xi = QQbar(a) + QQbar(b) * omega
    eta = QQbar(c) + QQbar(d) * omega
    real_coefficient = a*c - b*d
    imaginary_coefficient = a*d + b*c
    assert xi * eta == QQbar(real_coefficient) + QQbar(imaginary_coefficient) * omega
    assert QQbar(real_coefficient) + QQbar(imaginary_coefficient) * omega == xi * eta
assert QQbar(1) + QQbar(0) * omega == 1
print('RESULT: PASS')

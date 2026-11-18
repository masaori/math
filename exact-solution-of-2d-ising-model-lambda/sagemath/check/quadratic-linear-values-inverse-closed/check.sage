# 対象ラベル: claim_quadratic_linear_values_inverse_closed
# 二次係数表示の逆元。係数は QQ、平方根と値は QQbar に属する。
# 有限標本の式変形を厳密に検査する。全称の主張は Lean で検証する。
for a in [QQ(2), QQ(3), QQ(5)]:
    b = QQbar(a).sqrt()
    assert b * b == a
    for u in [QQ(-2), QQ(0), QQ(3)]:
        for v in [QQ(-2), QQ(0), QQ(3)]:
            y = QQbar(u) + QQbar(v) * b
            if y == 0:
                continue
            n = u * u - a * v * v
            assert n != 0
            z = QQbar(u / n) - QQbar(v / n) * b
            assert y * z == (QQbar(u) + QQbar(v) * b) * (QQbar(u) - QQbar(v) * b) / QQbar(n)
            assert (QQbar(u) + QQbar(v) * b) * (QQbar(u) - QQbar(v) * b) == QQbar(u * u) - QQbar(v * v) * b * b
            assert QQbar(u * u) - QQbar(v * v) * b * b == QQbar(n)
            assert y * z == 1
            assert z == y**(-1)
print('PASS')

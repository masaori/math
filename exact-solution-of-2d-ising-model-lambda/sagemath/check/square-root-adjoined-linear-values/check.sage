# 対象ラベル: claim_square_root_adjoined_subfield_equals_linear_values
# 一次式の値の部分体性と生成部分体との両包含を QQbar の厳密計算で検査する。
for a in [QQ(2), QQ(3), QQ(5)]:
    b = QQbar(a).sqrt()
    F = QQ
    coefficients = [QQ(-2), QQ(0), QQ(1), QQ(3)]
    assert b*b == a
    assert b not in F
    for u in coefficients:
        for v in coefficients:
            y = QQbar(u) + QQbar(v)*b
            assert y in QQbar
            assert y == QQbar(u) + QQbar(v)*b
            for w in coefficients:
                for t in coefficients:
                    z = QQbar(w) + QQbar(t)*b
                    assert y+z == QQbar(u+w) + QQbar(v+t)*b
                    assert y*z == QQbar(u*w+a*v*t) + QQbar(u*t+v*w)*b
            if y != 0:
                n = u*u-a*v*v
                assert n != 0
                assert y**(-1) == QQbar(u/n)-QQbar(v/n)*b
print('PASS')

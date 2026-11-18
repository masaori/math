# 対象ラベル: claim_square_root_adjoined_subfield_quadratic_representation
for a in [QQ(2), QQ(3), QQ(5)]:
    b = QQbar(a).sqrt()
    assert b not in QQ
    coeffs = [QQ(-2), QQ(0), QQ(1), QQ(3)]
    for u in coeffs:
        for v in coeffs:
            for w in coeffs:
                for t in coeffs:
                    lhs = QQbar(u) + QQbar(v)*b
                    rhs = QQbar(w) + QQbar(t)*b
                    assert (QQbar(v-t)*b == QQbar(v)*b-QQbar(t)*b)
                    assert (lhs == rhs) == (QQbar(v-t)*b == QQbar(w-u))
                    if v != t:
                        assert lhs != rhs
                    if lhs == rhs:
                        assert v == t
                        assert u == w
print('PASS')

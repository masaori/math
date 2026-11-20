# 対象ラベル: claim_imaginary_unit_extension_square_root
# 三分法の零の場合と、正負の平方和根から非零の場合の証人を検算する。
omega = QQbar(-1).sqrt()
assert omega*omega == -1
for a, b in [(QQbar(0), QQbar(0)), (QQbar(0), QQbar(4)),
             (QQbar(9), QQbar(0)),
             (QQbar(-9), QQbar(0)), (QQbar(3), QQbar(4)),
             (QQbar(-3), QQbar(4))]:
    if b == 0:
        if a == 0:
            u, v = QQbar(0), QQbar(0)
        elif a > 0:
            u, v = a.sqrt(), QQbar(0)
        else:
            u, v = QQbar(0), (-a).sqrt()
    else:
        s = a*a+b*b
        if a == 0:
            assert s == b*b
        assert s > 0
        c0 = -s.sqrt()
        assert c0*c0 == s
        c = -c0
        assert c*c == c0*c0
        assert c*c == s
        assert c+a > 0
        d, t = (c+a).sqrt(), QQbar(2).sqrt()
        assert d != 0 and t != 0
        u, v = d/t, b/(2*(d/t))
        assert 2*u*u == c+a
    assert (u+v*omega)*(u+v*omega) == a+b*omega
print("PASS imaginary-unit-extension-square-root")

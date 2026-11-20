# 対象ラベル: claim_imaginary_unit_nonzero_coefficient_square_root
# QQbar 上の厳密な例で、証人の選択と本文の各等号を検算する。
a, b, c = QQbar(3), QQbar(4), QQbar(5)
omega = QQbar(-1).sqrt()
d, t = QQbar(8).sqrt(), QQbar(2).sqrt()
assert b != 0
assert c*c == a*a + b*b
assert omega*omega == -1
assert d != 0 and t != 0
assert d*d == c+a
assert t*t == 2
u = d/t
assert u != 0
assert 2*u*u == 2*(d/t)*(d/t)
assert 2*(d/t)*(d/t) == d*d*(2/(t*t))
assert d*d*(2/(t*t)) == d*d
assert d*d == c+a
v = b/(2*u)
assert (u+v*omega)*(u+v*omega) == a+b*omega
print("PASS 122543")

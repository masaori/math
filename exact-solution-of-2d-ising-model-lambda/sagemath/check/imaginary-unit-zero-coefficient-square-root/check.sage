# 対象ラベル: claim_imaginary_unit_zero_coefficient_square_root
# 三分法の各場合で、本文の等号を QQbar の厳密演算で検算する。
omega = QQbar(-1).sqrt()
assert omega*omega == -1

a, u, v = QQbar(0), QQbar(0), QQbar(0)
assert (u+v*omega)**2 == (0+0*omega)**2
assert (0+0*omega)**2 == 0
assert QQbar(0) == a+0*omega

a, w = QQbar(9), QQbar(3)
u, v = w, QQbar(0)
assert w*w == a
assert (u+v*omega)**2 == (w+0*omega)**2
assert (w+0*omega)**2 == w*w
assert w*w == a
assert a == a+0*omega

a, w = QQbar(-9), QQbar(3)
u, v = QQbar(0), w
assert w*w == -a
assert (u+v*omega)**2 == (0+w*omega)**2
assert (0+w*omega)**2 == w*w*omega*omega
assert w*w*omega*omega == (-a)*omega*omega
assert (-a)*omega*omega == (-a)*(-1)
assert (-a)*(-1) == a
assert a == a+0*omega
print("PASS zero-coefficient-square-root")

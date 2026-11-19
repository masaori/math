# 対象ラベル: claim_imaginary_unit_square_root_formula
# 本文の五つの式鎖を QQbar の厳密な四則で一行ずつ検算する。

omega = QQbar(-1).sqrt()
assert omega * omega == -1
samples = [(QQbar(3), QQbar(4)), (QQbar(-3), QQbar(4)),
           (QQbar(0), QQbar(5)), (QQbar(2), QQbar(0))]
for a, b in samples:
    c = (a*a + b*b).sqrt()
    u = ((c+a)/2).sqrt()
    assert u != 0
    assert c*c == a*a + b*b
    assert 2*u*u == c+a
    v = b/(2*u)
    assert b*b == c*c-a*a
    assert c*c-a*a == (c-a)*(c+a)
    assert (c-a)*(c+a) == (c-a)*2*u*u
    assert v*v == b*b/(4*u*u)
    assert b*b/(4*u*u) == (c-a)*2*u*u/(4*u*u)
    assert (c-a)*2*u*u/(4*u*u) == (c-a)/2
    assert u*u-v*v == (c+a)/2-(c-a)/2
    assert (c+a)/2-(c-a)/2 == a
    assert 2*u*v == 2*u*b/(2*u)
    assert 2*u*b/(2*u) == b
    assert (u+v*omega)^2 == u*u+2*u*v*omega+v*v*omega*omega
    assert u*u+2*u*v*omega+v*v*omega*omega == (u*u-v*v)+2*u*v*omega
    assert (u*u-v*v)+2*u*v*omega == a+2*u*v*omega
    assert a+2*u*v*omega == a+b*omega
print("PASS: 4 exact algebraic pairs; each equality checked")

# 対象ラベル: claim_imaginary_unit_extension_quadratic_root
# 有理数体を標本に、判別式と根の式鎖を厳密に照合する。
omega = QQbar(-1).sqrt()
assert omega * omega == -1
for a, b, c, d in [(QQ(1), QQ(2), QQ(3), QQ(4)),
                    (QQ(0), QQ(0), QQ(1), QQ(0)),
                    (QQ(-2), QQ(1), QQ(0), QQ(-3))]:
    e = 2 + omega
    P = a + b * omega
    Q = c + d * omega
    p = e * P
    q = e * Q
    assert e != 0 and p / e == P and q / e == Q
    A = a * a - b * b - 4 * c
    B = 2 * a * b - 4 * d
    assert P * P - 4 * Q == (a + b * omega) ** 2 - 4 * (c + d * omega)
    assert (a + b * omega) ** 2 - 4 * (c + d * omega) == a*a + 2*a*b*omega + b*b*omega*omega - 4*c - 4*d*omega
    assert a*a + 2*a*b*omega + b*b*omega*omega - 4*c - 4*d*omega == a*a + 2*a*b*omega - b*b - 4*c - 4*d*omega
    assert a*a + 2*a*b*omega - b*b - 4*c - 4*d*omega == A + B*omega
    s = QQbar(A + B * omega).sqrt()
    assert s * s == P * P - 4 * Q
    # 実代数的数の体を標本に二係数へ分ける。
    u = (s + s.conjugate()) / 2
    v = (s - s.conjugate()) / (2 * omega)
    assert u.imag() == 0 and v.imag() == 0
    x = (-a + u) / 2
    y = (-b + v) / 2
    assert x + y * omega == ((-a + u) + (-b + v)*omega) / 2
    assert x + y * omega == (-P + s) / 2
    r = x + y * omega
    assert r*r + P*r + Q == ((-P+s)/2)**2 + P*((-P+s)/2) + Q
    assert ((-P+s)/2)**2 + P*((-P+s)/2) + Q == ((-P+s)**2 + 2*P*(-P+s) + 4*Q)/4
    assert ((-P+s)**2 + 2*P*(-P+s) + 4*Q)/4 == (s*s-P*P+4*Q)/4
    assert (s*s-P*P+4*Q)/4 == 0
    assert e*r*r + p*r + q == e*(r*r+P*r+Q)
    assert e*(r*r+P*r+Q) == 0
print("PASS imaginary-unit-extension-quadratic-root")

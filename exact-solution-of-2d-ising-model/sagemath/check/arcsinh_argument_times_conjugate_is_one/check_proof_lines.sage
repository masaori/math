# 対象ラベル: arcsinh_argument_times_conjugate_is_one
# 鎖 (y+s)(s-y) = ys - y² + s² - sy = s² - y² = (y²+1) - y² = 1 の四行と主張を確かめる。
# 帰属: 1・2 行目は s を独立な不定元に置いた QQ[y,s] で（s² = y²+1 を使わない行）、3 行目は関数体 QQ(y)[s]/(s²-y²-1) で、
#   主張は y の 7 点で s を AA の √(y²+1) として厳密に。
load("../../_shared/hyperbolic_by_definition.sage")
P.<y, s> = PolynomialRing(QQ)
l0 = (y + s) * (s - y)
l1 = y * s - y^2 + s^2 - s * y
l2 = s^2 - y^2
assert l0 == l1 == l2
assert l2 != 1                    # 対照: 3 行目は s² = y²+1 を使う
Q = P.quotient(s^2 - y^2 - 1)
assert Q(l2) == Q((y^2 + 1) - y^2) == Q(1)
print("1・2 行目が QQ[y,s] で、3・4 行目が QQ[y,s]/(s²-y²-1) で厳密に成り立ち、3 行目は s を独立に置くと成り立たない")
for y0 in [QQ(0), QQ(1), QQ(-1), QQ(-3)/7, QQ(10)^6, QQ(-1)/10^6, QQ(25)]:
    s0 = AA(y0^2 + 1).sqrt()
    assert (y0 + s0) * (s0 - y0) == 1
print("7 点で (y+√(y²+1))(√(y²+1)-y) = 1 が AA で厳密に成り立つ")
print("RESULT: PASS")

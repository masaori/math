# 対象ラベル: arcsinh_argument_is_positive
# 準備の pq = 1（arcsinh_argument_times_conjugate_is_one）、p+q の鎖 (y+s)+(s-y) = 2s > 0、背理法の三つの含意、
# 主張 y + √(y²+1) > 0 を確かめる。
# 帰属:
# - p+q の等号は QQ[y,s] で（s の性質を使わない）。
# - 符号と大小の行は、y の 9 点で s を AA（実代数的数）の √(y²+1) として厳密に。
# - 背理法の含意（p=0 なら pq=0、p<0 かつ q≥0 なら pq≤0、負の和は負）は順序体の性質で、QQ の符号の組で確かめる。
load("../../_shared/hyperbolic_by_definition.sage")
P.<y, s> = PolynomialRing(QQ)
assert (y + s) + (s - y) == 2 * s
print("p+q = 2s が QQ[y,s] で成り立つ")
points = [QQ(0), QQ(1), QQ(-1), QQ(-3)/7, QQ(10)^6, QQ(-10)^6, QQ(1)/10^6, QQ(-1)/10^6, QQ(-12345)/7]
for y0 in points:
    s0 = AA(y0^2 + 1).sqrt()
    p0, q0 = y0 + s0, s0 - y0
    assert p0 * q0 == 1 and s0 > 0 and 2 * s0 > 0 and p0 + q0 == 2 * s0
    assert p0 > 0                         # 主張
    assert y0 - s0 < 0                    # 対照: もう一つの根 y - √(y²+1) は負
print(f"{len(points)} 点で pq = 1、p+q = 2s > 0、主張が AA で厳密に成り立ち、y - √(y²+1) は負（対照）")
signs = [QQ(-2), QQ(-1)/3, QQ(0), QQ(1)/5, QQ(4)]
for a in signs:
    for b in signs:
        if a == 0: assert a * b == 0
        if a < 0 and b >= 0: assert a * b <= 0
        if a < 0 and b < 0: assert a + b < 0
print("背理法の三つの含意が QQ の符号の組 25 通りで成り立つ")
print("RESULT: PASS")

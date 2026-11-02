# 対象ラベル: cosh_is_even
# 主張 cosh(-x) = cosh x を、形式冪級数（全次数 14 以下）と具体の点のボールで確かめる。
# 帰属: 形式冪級数は QQ[x]。点は x ∈ QQ で、exp の値が QQ に収まらないので RealBallField(512) へ脱出する。
load("../../_shared/hyperbolic_by_definition.sage")

R = PolynomialRing(QQ, 'x'); x = R.gen()
assert cosh_series(R, -x) == cosh_series(R, x)
assert sinh_series(R, -x) != sinh_series(R, x)   # 対照
print(f"cosh(-x) と cosh(x) の形式冪級数が全次数 {D_SERIES} 以下で一致（sinh は一致しない）")

points = [QQ(0), QQ(1), QQ(-3)/7, QQ(10), QQ(1)/10^6, QQ(-25)]
for x0 in points:
    a, b = cosh_ball(-x0), cosh_ball(x0)
    assert a.overlaps(b) and max(a.rad(), b.rad()) < RR(2)^(-150) * max(1, abs(b.mid()))
    if x0 != 0:
        assert not sinh_ball(-x0).overlaps(sinh_ball(x0))
print(f"{len(points)} 点で cosh(-x) と cosh(x) のボールが重なり、x ≠ 0 では sinh(-x) と sinh(x) は重ならない")
print("RESULT: PASS")

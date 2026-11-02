# 対象ラベル: sinh_is_odd
# 主張 sinh(-x) = -sinh x を、形式冪級数（全次数 14 以下）と具体の点のボールで確かめる。
# 帰属: 形式冪級数は QQ[x]。点は x ∈ QQ で、RealBallField(512) へ脱出する。
load("../../_shared/hyperbolic_by_definition.sage")

R = PolynomialRing(QQ, 'x'); x = R.gen()
assert sinh_series(R, -x) == -sinh_series(R, x)
assert sinh_series(R, x) != 0
print(f"sinh(-x) と -sinh(x) の形式冪級数が全次数 {D_SERIES} 以下で一致")
points = [QQ(0), QQ(1), QQ(-3)/7, QQ(10), QQ(1)/10^6, QQ(-25)]
for x0 in points:
    a, b = sinh_ball(-x0), -sinh_ball(x0)
    assert a.overlaps(b) and max(a.rad(), b.rad()) < RR(2)^(-150) * max(1, abs(b.mid()))
    if x0 != 0:
        assert not a.overlaps(sinh_ball(x0))   # 対照: sinh(-x) ≠ sinh(x)
print(f"{len(points)} 点で sinh(-x) と -sinh(x) のボールが重なり、x ≠ 0 では sinh(x) とは重ならない")
print("RESULT: PASS")

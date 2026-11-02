# 対象ラベル: cosh_half_angle_formula
# 主張 cosh x = 1 + 2 sinh²(x/2) を、形式冪級数（全次数 14 以下）と具体の点のボールで確かめる。
# 帰属: 形式冪級数は QQ[x]。点は x ∈ QQ で RealBallField(512) へ脱出する。
load("../../_shared/hyperbolic_by_definition.sage")
P = PolynomialRing(QQ, 'x'); x = P.gen()
T = lambda p: truncate_total_degree(p, D_SERIES)
assert cosh_series(P, x) == T(1 + 2 * sinh_series(P, x / 2)^2)
assert cosh_series(P, x) != T(1 + 2 * sinh_series(P, x)^2)   # 対照: 半角を取らないと一致しない
points = [QQ(0), QQ(1), QQ(-3)/7, QQ(10), QQ(1)/10^6, QQ(-25)]
for x0 in points:
    lhs, rhs = cosh_ball(x0), 1 + 2 * sinh_ball(x0 / 2)^2
    assert lhs.overlaps(rhs) and max(lhs.rad(), rhs.rad()) < RR(2)^(-150) * max(1, abs(rhs.mid()))
print(f"形式冪級数が全次数 {D_SERIES} 以下で一致し、{len(points)} 点で両辺のボールが重なる")
print("RESULT: PASS")

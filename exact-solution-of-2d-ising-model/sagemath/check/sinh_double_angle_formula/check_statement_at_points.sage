# 対象ラベル: sinh_double_angle_formula
# 主張 sinh x = 2 sinh(x/2) cosh(x/2) を、形式冪級数（全次数 14 以下）と具体の点のボールで確かめる。
load("../../_shared/hyperbolic_by_definition.sage")
P = PolynomialRing(QQ, 'x'); x = P.gen()
T = lambda p: truncate_total_degree(p, D_SERIES)
assert sinh_series(P, x) == T(2 * sinh_series(P, x / 2) * cosh_series(P, x / 2))
assert sinh_series(P, x) != T(sinh_series(P, x / 2) * cosh_series(P, x / 2))   # 対照: 係数 2 を落とすと一致しない
points = [QQ(0), QQ(1), QQ(-3)/7, QQ(10), QQ(1)/10^6, QQ(-25)]
for x0 in points:
    lhs, rhs = sinh_ball(x0), 2 * sinh_ball(x0 / 2) * cosh_ball(x0 / 2)
    assert lhs.overlaps(rhs) and max(lhs.rad(), rhs.rad()) < RR(2)^(-150) * max(1, abs(rhs.mid()))
print(f"形式冪級数が全次数 {D_SERIES} 以下で一致し、{len(points)} 点で両辺のボールが重なる")
print("RESULT: PASS")

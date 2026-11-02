# 対象ラベル: sinh_double_angle_formula
# 証明の鎖 sinh x = sinh(x/2+x/2) = sinh(x/2)cosh(x/2)+cosh(x/2)sinh(x/2) = sinh(x/2)cosh(x/2)+sinh(x/2)cosh(x/2)
#   = 2 sinh(x/2)cosh(x/2) の四行を確かめる。
# 帰属: 1 行目は QQ[x] の等号、2 行目（sinh_addition_formula の複号 +）は QQ[x] の形式冪級数として全次数 14 以下で、
#   3・4 行目（乗法の交換律、同類項）は sinh(x/2), cosh(x/2) を QQ 上の独立な不定元 S, C に置いて。
load("../../_shared/hyperbolic_by_definition.sage")
P = PolynomialRing(QQ, 'x'); x = P.gen()
T = lambda p: truncate_total_degree(p, D_SERIES)
assert x / 2 + x / 2 == x
assert sinh_series(P, x) == sinh_series(P, x / 2 + x / 2)
line2 = T(sinh_series(P, x / 2) * cosh_series(P, x / 2) + cosh_series(P, x / 2) * sinh_series(P, x / 2))
assert sinh_series(P, x / 2 + x / 2) == line2
R = PolynomialRing(QQ, 'S,C'); S, C = R.gens()
assert S * C + C * S == S * C + S * C == 2 * S * C
print(f"1・2 行目が QQ[x] で（2 行目は形式冪級数の全次数 {D_SERIES} 以下で）、3・4 行目が QQ[S,C] で成り立つ")
print("RESULT: PASS")

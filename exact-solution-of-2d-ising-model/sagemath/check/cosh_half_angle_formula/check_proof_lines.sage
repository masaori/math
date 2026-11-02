# 対象ラベル: cosh_half_angle_formula
# 証明の鎖 cosh x = cosh(x/2+x/2) = cosh(x/2)cosh(x/2)+sinh(x/2)sinh(x/2) = cosh²(x/2)+sinh²(x/2)
#   = (1+sinh²(x/2))+sinh²(x/2) = 1+2sinh²(x/2) の五行を確かめる。
# 帰属:
# - 1 行目の引数の等号 x = x/2 + x/2 は QQ[x] の等号として。
# - 2 行目（cosh_addition_formula の複号 +）は QQ[x] の形式冪級数として全次数 14 以下で。
# - 3・5 行目（二乗の記法、同類項）は cosh(x/2), sinh(x/2) を QQ 上の独立な不定元 C, S に置いて。
# - 4 行目（cosh_sinh_basic_properties (2) を移項）は、不定元では成り立たず、剰余環 QQ[C,S]/(C²-S²-1) で
#   成り立つこと（この行が (2) だけを使うこと）と、形式冪級数で成り立つことを確かめる。
load("../../_shared/hyperbolic_by_definition.sage")

P = PolynomialRing(QQ, 'x'); x = P.gen()
T = lambda p: truncate_total_degree(p, D_SERIES)
assert x / 2 + x / 2 == x
assert cosh_series(P, x) == cosh_series(P, x / 2 + x / 2)
line2 = T(cosh_series(P, x / 2) * cosh_series(P, x / 2) + sinh_series(P, x / 2) * sinh_series(P, x / 2))
assert cosh_series(P, x / 2 + x / 2) == line2
print(f"1・2 行目が QQ[x] で（2 行目は形式冪級数の全次数 {D_SERIES} 以下で）成り立つ")

R = PolynomialRing(QQ, 'C,S'); C, S = R.gens()
l2 = C * C + S * S
l3 = C^2 + S^2
assert l2 == l3
l4 = (1 + S^2) + S^2
l5 = 1 + 2 * S^2
assert l4 == l5
assert l3 != l4                       # 対照: 独立な不定元では 4 行目は成り立たない
Q = R.quotient(C^2 - S^2 - 1)
assert Q(l3) == Q(l4)                 # (2) の関係式だけで成り立つ
assert T(cosh_series(P, x / 2)^2) == T(1 + sinh_series(P, x / 2)^2)   # (2) を x/2 で、形式冪級数として
print("3・5 行目が QQ[C,S] で、4 行目が QQ[C,S]/(C²-S²-1) で成り立ち、4 行目は独立な不定元では成り立たない")
print("RESULT: PASS")

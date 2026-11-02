# 対象ラベル: sinh_of_arcsinh
# 準備の (y+s)(s-y) = 1、exp(u) の鎖 exp(u) = exp(log(y+s)) = y+s、exp(-u) の鎖の七行、主の鎖の五行を確かめる。
# 帰属:
# - exp(-u) の鎖の 1〜4 行目と主の鎖の 3〜5 行目は、関数体 L = QQ(y)[s]/(s²-y²-1) に exp(-u) の値を独立な不定元 W として
#   足した L[W] で厳密に（exp(u) は 2 行目の結論 y+s に置く）。
# - exp(-u) の鎖の 5・6 行目（exp の積の法則、exp(0) = 1）と、exp(u) の鎖（exp(log w) = w）は、y の 7 点で
#   u = arcsinh(y) を囲むボールに本文の exp の部分和をボール演算で施して（RealBallField(512)）確かめる。
#   log は本文 def_real_logarithm_positive の exp の逆写像で、本文の exp は標準の exp に等しいので Arb の log で囲める。
load("../../_shared/hyperbolic_by_definition.sage")
Fy.<y> = FunctionField(QQ); Rs.<S> = Fy[]; L.<s> = Fy.extension(S^2 - y^2 - 1)
assert (y + s) * (s - y) == 1
LW.<W> = L[]
Eu = y + s                                  # exp(u) の鎖の結論
e1 = W * 1
e2 = W * ((y + s) * (s - y))
e3 = (W * (y + s)) * (s - y)
e4 = (W * Eu) * (s - y)
assert e1 == e2 == e3 == e4
# 5・6 行目: W·exp(u) = exp(-u+u) = exp(0) = 1 を使うと e4 = s - y。W·Eu = 1 の下でだけ成り立つ
assert e4 != s - y
Wsol = 1 / Eu
assert e4(W=Wsol) == s - y and Wsol == s - y
main1 = (Eu - (s - y)) / 2
assert main1 == (2 * y) / 2 == y
print("exp(-u) の鎖の 1〜4 行目、W·exp(u) = 1 の下での 7 行目、主の鎖の 3〜5 行目が L[W] で厳密に成り立つ")
points = [QQ(0), QQ(1), QQ(-1), QQ(-3)/7, QQ(25), QQ(-40), QQ(1)/10^6]
for y0 in points:
    u = arcsinh_ball(y0)
    s0 = sqrt_ball(y0^2 + 1)
    eu, emu = exp_ball_of_ball(u), exp_ball_of_ball(-u)
    assert eu.overlaps(y0 + s0)                     # exp(log(y+s)) = y+s
    assert (emu * eu).overlaps(exp_ball(0)) and exp_ball(0).contains_exact(1)   # exp(-u)exp(u) = exp(0) = 1
    assert emu.overlaps(s0 - y0)                    # exp(-u) の鎖の結論
    sh = sinh_by_definition(eu, emu)
    assert sh.overlaps(RBF512(y0)) and sh.rad() < RR(2)^(-100) * max(1, abs(y0))
print(f"{len(points)} 点で exp(u) = y+s、exp(-u)exp(u) = 1、exp(-u) = s-y、sinh(arcsinh(y)) = y がボールで成り立つ")
print("RESULT: PASS")

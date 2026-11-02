# 対象ラベル: sine_cubic_lower_bound
# 証明: t = 0 は sin 0 = 0 から。t > 0 では H(v) := sin v - v + v³/6、H' = cos v - 1 + v²/2 として
#   sin t - t + t³/6 = (sin t - t + t³/6) - (sin 0 - 0 + 0³/6) = ∫_0^t (cos v - 1 + v²/2) dv ≥ ∫_0^t 0 dv = 0 - 0 = 0。
# 帰属:
# - 導関数 H' と積分の値の行は SR の記号微分・記号積分で（sin' = cos は本文が外部から持ち込む微分の公式）。
# - 1 行目の sin 0 - 0 + 0³/6 = 0 は AA で厳密に。
# - 被積分関数の符号 cos v - 1 + v²/2 ≥ 0 と鎖の両端は、v, t = qπ（[0, π/2] の 12 等分点）で、sin・cos を AA で厳密に、
#   qπ を π のボールで囲んで比べる。
load("../../_shared/sine_cosine_by_definition.sage")
v, t = SR.var('v t')
assume(t > 0)                                                     # 証明の t > 0 の場合
H = lambda x: sin(x) - x + x^3/6
assert bool(diff(H(v), v) == cos(v) - 1 + v^2/2)
assert bool(integrate(cos(v) - 1 + v^2/2, v, 0, t) == H(t) - H(0))     # 2 行目
assert bool(integrate(0, v, 0, t) == 0 - 0)                             # 4 行目
print("導関数 H' = cos v - 1 + v²/2 と、積分の値の二つの行が SR で成り立つ")
assert sin_exact(0) - 0 + QQ(0)^3/6 == 0                                 # 1 行目と t = 0 の場合
for q in HALF_GRID[1:]:
    assert surely_gt(ball(cos_exact(q)) - 1 + angle_ball(q)^2/2, RBF256(0))   # 3 行目の被積分関数の符号
for q in HALF_GRID[1:]:
    lhs = ball(sin_exact(q)) - angle_ball(q) + angle_ball(q)^3/6
    assert surely_gt(lhs, RBF256(0))                                          # t > 0 での鎖の両端
print("t = 0 の場合と、[0, π/2] の 12 等分点で被積分関数の符号と鎖の両端 sin t - t + t³/6 > 0 が成り立つ")
assert surely_gt(RBF256(0), ball(sin_exact(-QQ(1)/4)) - angle_ball(-QQ(1)/4) + angle_ball(-QQ(1)/4)^3/6)
print("対照: t = -π/4 では sin t - t + t³/6 ≥ 0 が成り立たない")
print("RESULT: PASS")

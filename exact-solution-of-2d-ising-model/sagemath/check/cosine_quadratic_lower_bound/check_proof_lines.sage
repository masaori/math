# 対象ラベル: cosine_quadratic_lower_bound
# 証明: t = 0 は cos 0 = 1 から。t > 0 では G(u) := cos u - 1 + u²/2、G' = -sin u + u = u - sin u として
#   cos t - 1 + t²/2 = (cos t - 1 + t²/2) - (cos 0 - 1 + 0²/2) = ∫_0^t (u - sin u) du ≥ ∫_0^t 0 du = 0 - 0 = 0。
# 帰属:
# - 導関数 G' と積分の値の行は SR の記号微分・記号積分で（cos' = -sin は本文が外部から持ち込む微分の公式）。
# - 1 行目の cos 0 - 1 + 0²/2 = 0 は AA で厳密に。
# - 被積分関数の符号 u - sin u ≥ 0 と鎖の両端は、u, t = qπ（[0, π/2] の 12 等分点）で、sin・cos を AA で厳密に、
#   qπ を π のボールで囲んで比べる。
load("../../_shared/sine_cosine_by_definition.sage")
u, t = SR.var('u t')
assume(t > 0)                                                     # 証明の t > 0 の場合
G = lambda x: cos(x) - 1 + x^2/2
assert bool(diff(G(u), u) == -sin(u) + u) and bool(-sin(u) + u == u - sin(u))
assert bool(integrate(u - sin(u), u, 0, t) == G(t) - G(0))      # 2 行目
assert bool(integrate(0, u, 0, t) == 0 - 0)                      # 4 行目
print("導関数 G' = -sin u + u = u - sin u と、積分の値の二つの行が SR で成り立つ")
assert cos_exact(0) - 1 + QQ(0)^2/2 == 0                          # 1 行目と t = 0 の場合
for q in HALF_GRID:
    assert surely_ge(angle_ball(q) - ball(sin_exact(q)), RBF256(0)) or q == 0   # 3 行目の被積分関数の符号
for q in HALF_GRID[1:]:
    lhs = ball(cos_exact(q)) - 1 + angle_ball(q)^2 / 2
    assert surely_gt(lhs, RBF256(0))                                            # t > 0 での鎖の両端
print("t = 0 の場合と、[0, π/2] の 12 等分点で被積分関数の符号と鎖の両端 cos t - 1 + t²/2 > 0 が成り立つ")
assert surely_gt(RBF256(0), ball(cos_exact(QQ(1)/4)) - 1)
print("対照: t²/2 を落とした cos t - 1 ≥ 0 は t = π/4 で成り立たない")
print("RESULT: PASS")

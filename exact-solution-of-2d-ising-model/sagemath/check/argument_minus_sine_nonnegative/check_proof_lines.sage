# 対象ラベル: argument_minus_sine_nonnegative
# 証明: t = 0 は sin 0 = 0 から。t > 0 では F(u) := u - sin u、F' = 1 - cos u として
#   t - sin t = (t - sin t) - (0 - sin 0) = ∫_0^t (1 - cos u) du ≥ ∫_0^t 0 du = 0 - 0 = 0。
# 帰属:
# - 導関数 F' = 1 - cos と積分の値の行（(R4) の当てはめ）は SR の記号微分・記号積分で（微分の公式 sin' = cos は本文が外部から
#   持ち込む事実で、SR の sin・cos の微分はそれと同じ公式である）。
# - 1 行目の 0 - sin 0 = 0 と、被積分関数の各点の符号 1 - cos u ≥ 0 は、u = qπ（[0, π/2] の 12 等分点）で AA で厳密に。
# - 鎖の両端の大小 t - sin t ≥ 0 は、t = qπ（同じ 12 等分点）で、sin t を AA で厳密に、t = qπ を π のボールで囲んで比べる。
load("../../_shared/sine_cosine_by_definition.sage")
u, t = SR.var('u t')
assume(t > 0)                                                     # 証明の t > 0 の場合
F = lambda x: x - sin(x)
assert bool(diff(F(u), u) == 1 - cos(u))
assert bool(integrate(1 - cos(u), u, 0, t) == F(t) - F(0))      # 2 行目
assert bool(integrate(0, u, 0, t) == 0 - 0)                      # 4 行目
print("導関数 F' = 1 - cos と、積分の値の二つの行が SR で成り立つ")
assert 0 - sin_exact(0) == 0                                      # 1 行目と t = 0 の場合
for q in HALF_GRID:
    assert 1 - cos_exact(q) >= 0                                  # 3 行目の被積分関数の符号（cosine_at_most_one）
for q in HALF_GRID[1:]:
    lhs = angle_ball(q) - ball(sin_exact(q))
    assert surely_gt(lhs, RBF256(0))                              # t > 0 での鎖の両端
print(f"t = 0 の場合と、[0, π/2] の 12 等分点で被積分関数の符号（AA）と鎖の両端 t - sin t > 0（ボール）が成り立つ")
assert surely_gt(RBF256(0), angle_ball(-QQ(1)/4) - ball(sin_exact(-QQ(1)/4)))
print("対照: t = -π/4 では t - sin t ≥ 0 が成り立たない")
print("RESULT: PASS")

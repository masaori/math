# 対象ラベル: sine_of_half_pi_is_one
# 証明の鎖: sin(π/2) = sin(arcsin(1)) = 1。
#   1 行目: arcsin_of_one_is_half_pi（arcsin(1) = π/2 を右辺から左辺へ）。
#   2 行目: π/2 = arcsin(1) ∈ [−π/2, π/2]（arcsin_is_bijection の値域）で def_sin の y はただ一つ、arcsin(1) = π/2 なので y = 1。
# 帰属: sin(π/2) は 1 の 4 乗根 e^{iπ/2} の虚部として AA で厳密に作る（_shared/sine_cosine_by_definition.sage）。
#       arcsin(1) = π/2 は Sage の記号計算（SR）で厳密に、値域の判定は RealBallField(256) のボールの比較で確かめる
#       （π と弧の長さが実数なので ℝ へ脱出する。ボールの比較は真と判定できたときだけ真を返す）。
load("../../_shared/sine_cosine_by_definition.sage")
assert bool(arcsin(SR(1)) == pi / 2)                       # 1 行目: arcsin_of_one_is_half_pi
a1 = RBF256(1).arcsin()
assert (a1 - angle_ball(QQ(1) / 2)).contains_zero()         # 1 行目: ボールでも π/2 を含む
s = sin_exact(QQ(1) / 2)
assert s == 1                                                # 2 行目: def_sin の y は 1
assert RBF256(s).arcsin().overlaps(angle_ball(QQ(1) / 2))   # 2 行目: y = 1 は arcsin(y) = π/2 を満たす
# 否定の対照: y を 0 や −1 と取り違えると arcsin(y) は π/2 にならない
assert RBF256(0).arcsin() < angle_ball(QQ(1) / 2)
assert RBF256(-1).arcsin() < angle_ball(QQ(1) / 2)
print("鎖の二行と主張 sin(π/2) = 1 が成り立つ")
print("RESULT: PASS")

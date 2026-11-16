# 対象ラベル: cosine_of_half_pi_is_zero
# 証明の鎖: cos(π/2) = √(1−(sin(π/2))²) = √(1−1²) = √(1−1) = √0 = 0。すべて AA で厳密に確かめる。
#   1 行目: def_cos の θ → π/2（π/2 = arcsin(1) ∈ [−π/2, π/2] は arcsin_of_one_is_half_pi と arcsin_is_bijection の値域）。
#   2 行目: sine_of_half_pi_is_one。3 行目: power_of_real_one_is_one（m → 2）。4 行目: ℝ で a − a = 0（a → 1）。
#   5 行目: sqrt_of_real_zero_is_zero。
load("../../_shared/sine_cosine_by_definition.sage")
assert bool(arcsin(SR(1)) == pi / 2)                       # 1 行目の定義域の理由: arcsin(1) = π/2
assert (RBF256(1).arcsin() - angle_ball(QQ(1) / 2)).contains_zero()
s = sin_exact(QQ(1) / 2)
l1 = sqrt_nonneg(1 - s ^ 2)            # 1 行目: def_cos
l2 = sqrt_nonneg(1 - AA(1) ^ 2)        # 2 行目: sine_of_half_pi_is_one
l3 = sqrt_nonneg(AA(1) - AA(1))        # 3 行目: power_of_real_one_is_one (m → 2)
l4 = sqrt_nonneg(AA(0))                # 4 行目: a − a = 0 (a → 1)
assert s == 1                          # 2 行目の事実
assert AA(1) ^ 2 == 1                  # 3 行目の事実
assert AA(1) - AA(1) == 0              # 4 行目の事実
assert AA(0) >= 0 and AA(0) ^ 2 == 0   # 5 行目（sqrt_of_real_zero_is_zero）: 0 は 0 の非負平方根の条件を満たす
assert l1 == l2 == l3 == l4 == 0
assert cos_exact(QQ(1) / 2) == 0       # 主張（e^{iπ/2} の実部とも一致）
# 否定の対照: 2 行目で sin(π/2) を 0 と取り違えると √(1 − 0²) = 1 ≠ 0、3 行目で 1² を 2 と取り違えると 1 − 2 < 0 で非負平方根が取れない
assert sqrt_nonneg(1 - AA(0) ^ 2) != l4
assert AA(1) - AA(2) < 0
print("鎖の五行と主張 cos(π/2) = 0 が AA で成り立つ")
print("RESULT: PASS")

# 対象ラベル: cosine_zero
# 証明の鎖: cos 0 = √(1-(sin 0)²) = √(1-0²) = √(1-0·0) = √(1-0) = √1 = 1。すべて AA で厳密に確かめる。
load("../../_shared/sine_cosine_by_definition.sage")
s0 = sin_exact(0)
l1 = sqrt_nonneg(1 - s0 ^ 2)            # 1 行目: def_cos
l2 = sqrt_nonneg(1 - AA(0) ^ 2)         # 2 行目: sine_zero
l3 = sqrt_nonneg(1 - AA(0) * AA(0))     # 3 行目: square_of_real_number_is_product (r → 0)
l4 = sqrt_nonneg(1 - AA(0))             # 4 行目: ℝ で 0·x = 0 (x → 0)
l5 = sqrt_nonneg(AA(1))                 # 5 行目: ℝ で a − 0 = a (a → 1)
assert AA(0) ^ 2 == AA(0) * AA(0)       # 3 行目の事実
assert AA(0) * AA(0) == 0               # 4 行目の事実
assert AA(1) - AA(0) == 1               # 5 行目の事実
assert s0 == 0 and l1 == l2 == l3 == l4 == l5
# 否定の対照: 5 行目で差の向きを取り違えた 0 − 1 は 1 と一致せず（負なので非負平方根も取れない）、
# 4 行目で 0·0 を 1 と取り違えて √(1 − 1) とすると √0 = 0 ≠ 1 になる
assert AA(0) - AA(1) != 1 and AA(0) - AA(1) < 0
assert sqrt_nonneg(1 - AA(1)) != l5
assert AA(1) >= 0 and AA(1) ^ 2 == 1    # 6 行目（sqrt_of_real_one_is_one）: 1 は 1 の非負平方根の条件を満たす
assert l5 == 1
assert cos_exact(0) == 1                # 主張（e^{i·0} の実部とも一致）
print("鎖の六行と主張 cos 0 = 1 が AA で成り立つ")
print("RESULT: PASS")

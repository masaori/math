# 対象ラベル: complex_times_zero_is_zero
# 鎖の (0, 0 + 0) = (0, 0) の行の「0 は ℝ の加法の単位元」（set_and_algebra_notation）を、
# 行に書いた形 x + 0 = x と代入 x → 0 どおりに QQ の等号で比べる（浮動小数点を使わない）。
def add_right(x): return (x + 0, x)   # x + 0 = x
lhs, rhs = add_right(QQ(0))
assert lhs == rhs == 0
assert (QQ(0), QQ(0) + QQ(0)) == (QQ(0), QQ(0))
assert QQ(0) + QQ(1) != QQ(0)   # 対照: 単位元でない元を足すと一致しない
print("row (0, 0 + 0) = (0, 0)"); print("RESULT: PASS")

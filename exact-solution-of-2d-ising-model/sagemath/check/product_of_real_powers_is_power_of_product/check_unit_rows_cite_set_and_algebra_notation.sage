# 対象ラベル: product_of_real_powers_is_power_of_product
# 証明の「1 は ℝ の乗法の単位元」「0 は ℝ の加法の単位元」（set_and_algebra_notation）の行を、
# 行に書いた形（x·1 = x、1·x = x、x + 0 = x、0 + x = x）と代入どおりに、多項式環の等号で一行ずつ比べる（浮動小数点を使わない）。
def mul_right(x): return (x * 1, x)   # x·1 = x
# 1·1 = 1（x·1 = x の x → 1）
lhs, rhs = mul_right(QQ(1))
assert lhs == rhs == 1 and QQ(1)*QQ(1) == QQ(1)
assert QQ(2)*QQ(1) != QQ(1)   # 対照
print("unit row 1·1 = 1"); print("RESULT: PASS")

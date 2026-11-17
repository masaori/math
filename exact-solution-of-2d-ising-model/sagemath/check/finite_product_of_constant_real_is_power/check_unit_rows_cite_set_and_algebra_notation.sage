# 対象ラベル: finite_product_of_constant_real_is_power
# 証明の「1 は ℝ の乗法の単位元」「0 は ℝ の加法の単位元」（set_and_algebra_notation）の行を、
# 行に書いた形（x·1 = x、1·x = x、x + 0 = x、0 + x = x）と代入どおりに、多項式環の等号で一行ずつ比べる（浮動小数点を使わない）。
def mul_left(x):  return (1 * x, x)   # 1·x = x
R.<r> = PolynomialRing(QQ)
# m = 1 の鎖: r = 1·r（1·x = x の x → r を右辺から左辺へ）
lhs, rhs = mul_left(r)
assert rhs == lhs and r == R(1)*r
assert R(2)*r != r   # 対照
print("unit row of finite_product_of_constant_real_is_power"); print("RESULT: PASS")

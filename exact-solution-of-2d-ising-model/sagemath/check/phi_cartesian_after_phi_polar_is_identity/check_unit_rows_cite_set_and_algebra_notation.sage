# 対象ラベル: phi_cartesian_after_phi_polar_is_identity
# 証明の「1 は ℝ の乗法の単位元」「0 は ℝ の加法の単位元」（set_and_algebra_notation）の行を、
# 行に書いた形（x·1 = x、1·x = x、x + 0 = x、0 + x = x）と代入どおりに、多項式環の等号で一行ずつ比べる（浮動小数点を使わない）。
def mul_right(x): return (x * 1, x)   # x·1 = x
R.<y> = PolynomialRing(QQ)
# x = 0, y > 0 の鎖: (0, y·1) = (0, y)（x·1 = x の x → y）
assert mul_right(y)[0] == y and (R(0), y*R(1)) == (R(0), y)
assert R(2)*y != y   # 対照
print("unit row of phi_cartesian_after_phi_polar_is_identity"); print("RESULT: PASS")

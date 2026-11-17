# 対象ラベル: multiplicative_group_of_cc
# 証明の「1 は ℝ の乗法の単位元」「0 は ℝ の加法の単位元」（set_and_algebra_notation）の行を、
# 行に書いた形（x·1 = x、1·x = x、x + 0 = x、0 + x = x）と代入どおりに、多項式環の等号で一行ずつ比べる（浮動小数点を使わない）。
def mul_right(x): return (x * 1, x)   # x·1 = x
R.<a, b> = PolynomialRing(QQ)
# 積の単位元の鎖: (a·1 − b·0, a·0 + b·1) = (a − b·0, a·0 + b)（x·1 = x の x → a, x → b を 2 箇所へ）
assert mul_right(a)[0] == mul_right(a)[1] and mul_right(b)[0] == mul_right(b)[1]
assert (a*1 - b*0, a*0 + b*1) == (a - b*0, a*0 + b)
# 1_C の平方和の鎖: 1·1 + 0·0 = 1 + 0·0（x·1 = x の x → 1）
assert R(mul_right(R(1))[0]) == 1 and R(1)*R(1) + R(0)*R(0) == R(1) + R(0)*R(0)
assert R(2)*a != a   # 対照
print("unit rows of multiplicative_group_of_cc"); print("RESULT: PASS")

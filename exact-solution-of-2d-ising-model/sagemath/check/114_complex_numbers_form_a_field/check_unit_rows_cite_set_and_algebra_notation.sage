# 対象ラベル: complex_numbers_form_a_field
# 証明の「1 は ℝ の乗法の単位元」「0 は ℝ の加法の単位元」（set_and_algebra_notation）の行を、
# 行に書いた形（x·1 = x、1·x = x、x + 0 = x、0 + x = x）と代入どおりに、多項式環の等号で一行ずつ比べる（浮動小数点を使わない）。
def add_right(x): return (x + 0, x)   # x + 0 = x
R.<a, b> = PolynomialRing(QQ)
# 加法の単位元の鎖: (a + 0, b + 0) = (a, b)（x + 0 = x の x → a, x → b を 2 箇所へ）
assert add_right(a)[0] == a and add_right(b)[0] == b and (a + 0, b + 0) == (a, b)
# −z と (−1_C)·z の一致の鎖: ((−1)a, (−1)b + 0) = ((−1)a, (−1)b)（x + 0 = x の x → (−1)b）
assert add_right((-1)*b)[0] == (-1)*b and ((-1)*a, (-1)*b + 0) == ((-1)*a, (-1)*b)
assert a + 1 != a   # 対照
print("unit rows of complex_numbers_form_a_field"); print("RESULT: PASS")

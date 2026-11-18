# 対象ラベル: abs_basic_properties
# 名前だけの根拠「ℝ では 0 は和の単位元」を「0 は ℝ の加法の単位元 形 (代入)（set_and_algebra_notation）」に替えた 5 行を、
# 行に書いた形（0 + p = p、p + 0 = p）と代入どおりに、多項式環 QQ[a, b, c, d, x, y] の等号で一行ずつ比べる（浮動小数点を使わない）。
# 多項式環は式を正規化するので形の左右は区別できず、それはレビューの目視で確かめる。
R.<a, b, c, d, x, y> = QQ[]
def add_left(p): return (R(0) + p, p)    # 0 + p = p
def add_right(p): return (p + R(0), p)   # p + 0 = p
n = 0
# (1) x = 0, y > 0 と x = 0, y < 0 の鎖: 0 + y^2 = y^2（p → y^2）
l, r = add_left(y^2); assert l == r and R(0) + y^2 == y^2; n += 1
l, r = add_left(y^2); assert l == r; n += 1
# (1) x = 0, y = 0 の鎖: 0 + 0 = 0（p → 0）
l, r = add_left(R(0)); assert l == r and R(0) + R(0) == R(0); n += 1
# (4) Lagrange の恒等式の鎖: (a^2c^2+b^2d^2+a^2d^2+b^2c^2) + 0 = a^2c^2+b^2d^2+a^2d^2+b^2c^2
P = a^2*c^2 + b^2*d^2 + a^2*d^2 + b^2*c^2
l, r = add_right(P); assert l == r; n += 1
# 同じ鎖の両端（行の前後の値が鎖の端と一致すること）: (ac+bd)^2+(ad-bc)^2 = (a^2+b^2)(c^2+d^2)
assert (a*c + b*d)^2 + (a*d - b*c)^2 == P and P == (a^2 + b^2)*(c^2 + d^2); n += 1
# (6) の鎖: x^2 + 0 = x^2（p → x^2）
l, r = add_right(x^2); assert l == r; n += 1
# 否定コントロール: 単位元を 1 に取り違えると等号は成り立たない。
assert y^2 + 1 != y^2 and P + 1 != P
print("additive identity rows of abs_basic_properties: %d checks" % n)
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")

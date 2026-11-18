# 対象ラベル: sinh_of_arcsinh
# exp(-u) の鎖の 1 行目 exp(-u) = exp(-u)·1 の根拠を「1 は ℝ の乗法の単位元 x·1 = x (x → exp(-u))（set_and_algebra_notation）を右辺から左辺へ」に替えた。
# exp(-u) の値を不定元 W に置き、行に書いた形と代入どおりに QQ[W] の等号で確かめる（浮動小数点を使わない）。
# 多項式環は式を正規化するので形の左右は区別できず、それはレビューの目視で確かめる。
R.<W> = QQ[]
def mul_right_identity(x): return (x * R(1), x)   # x·1 = x
n = 0
l, r = mul_right_identity(W); assert l == r; n += 1   # x → exp(-u)（W）。右辺から左辺へ: W = W·1
# 否定コントロール: 単位元を 0 や 2 に取り違えると等号は成り立たない。
assert W * R(0) != W and W * R(2) != W
print("multiplicative identity row of sinh_of_arcsinh: %d checks" % n)
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")

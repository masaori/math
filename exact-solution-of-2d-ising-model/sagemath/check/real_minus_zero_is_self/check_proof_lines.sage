# 対象ラベル: real_minus_zero_is_self
# a - 0 = a + (-0) = a + 0 = a の 3 行の鎖を確かめる。
# -0 を QQ[a, n] の不定元 n に置き（-0 = 0 を前提にしないため）、
# 2 段目で引く real_negation_of_zero_is_zero（-0 = 0）は n を 0 に置き換える段として確かめる。
# 帰属: 多項式環 QQ[a, n]。浮動小数点は使わない。

R.<a, n> = QQ[]
ZERO = R(0)

lines = [
    a + n,          # 1 行目の右辺 a + (-0)（def_real_difference の y → a, z → 0。左辺 a - 0 は下で別に確かめる）
    a + ZERO,       # real_negation_of_zero_is_zero（n → 0）
    a,              # 加法の単位元
]

# def_real_difference の段: 差 y - z := y + (-z) を、z の加法の逆元を不定元 m に置いた形 y + m で表し、
# y → a、z → 0（-0 を n）を当てたものが 1 行目であることを記号で確かめる。
S.<y, m> = QQ[]
def difference(yv, neg_z):
    return S.hom([yv, neg_z], R)(y + m)
assert difference(a, n) == lines[0]
# 否定コントロール: z の逆元を -0（n）でなく 0 そのものに取り違えると 1 行目と一致しない。
assert difference(a, ZERO) != lines[0]
# real_negation_of_zero_is_zero の段: 1 行目の n を 0 に置き換えたものが 2 行目。
assert lines[0].subs(n=0) == lines[1]
# 加法の単位元の段は恒等的に等しい。
assert lines[1] == lines[2]
# 鎖の両端: -0 = 0 の下で a - 0 = a。
assert lines[0].subs(n=0) == lines[2]
# 否定コントロール: -0 を 0 に置き換えなければ 2 段目は成り立たない。
assert lines[0] != lines[1]
# 否定コントロール: 差の向きを取り違えた 0 - a は a と一致しない。
assert ZERO - a != a

print("QQ[a, n] で差の定義の段、n → 0 の置き換えの段、恒等的な段を 1 個ずつ確かめた（等号 3 個）")
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")

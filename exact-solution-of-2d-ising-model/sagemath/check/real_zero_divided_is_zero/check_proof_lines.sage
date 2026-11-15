# 対象ラベル: real_zero_divided_is_zero
# 0/x = 0·x^{-1} = 0 の 2 行の鎖を確かめる。
# 割られる側の 0 を QQ[o, x] の分数体の不定元 o に置き（0/x = 0 を前提にしないため）、
# 2 段目で引く real_zero_times_is_zero（0·y = 0）は o を 0 に置き換える段として確かめる。
# 帰属: 有理関数体 Frac(QQ[o, x])。x ≠ 0 は分数体で x が可逆であることに当たる。浮動小数点は使わない。

R.<o, x> = QQ[]
F = R.fraction_field()
o, x = F(o), F(x)

lines = [
    o / x,          # 1 行目の左辺 0/x
    o * x^(-1),     # def_real_quotient（y → 0, z → x）
    F(0),           # real_zero_times_is_zero（x → x^{-1}）
]

# def_real_quotient の段は恒等的に等しい。
assert lines[0] == lines[1]
# real_zero_times_is_zero の段: 2 行目の o を 0 に置き換えると 0。
assert lines[1].subs(o=0) == lines[2]
# 鎖の両端: o = 0 で 0/x = 0。
assert lines[0].subs(o=0) == lines[2]
# 0 でない有理数の x でも確かめる。
for v in [QQ(1), QQ(2), QQ(-3), QQ(5)/7]:
    assert QQ(0) / v == QQ(0) * v^(-1) == 0
# 否定コントロール: 割られる側を 1 に取り違えると 0 にならない。
assert F(1) / x != F(0)
# 否定コントロール: o を 0 に置き換えなければ 2 段目は成り立たない。
assert lines[1] != lines[2]

print("Frac(QQ[o, x]) で恒等的な段 1 個と、o → 0 の段 1 個を確かめた（等号 2 個）")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")

# 対象ラベル: real_times_half_is_quotient_by_two
# a·(1/2) = a/2 の 3 行の鎖を一行ずつ確かめる。
# 2 を不定元 t に置き（この鎖は 2 = 1 + 1 を使わないので、t のまま恒等的に等しい）、a も不定元に置く。
# 帰属: 有理関数体 Frac(QQ[a, t]) と QQ。浮動小数点は使わない。

R.<a, t> = QQ[]
F = R.fraction_field()
a = F(a)
t = F(t)
inv_t = t^(-1)

L1 = a*(1/t)          # a·(1/2)
L2 = a*(1*inv_t)      # def_real_quotient（y → 1、z → 2）
L3 = a*inv_t          # 乗法の単位元 1·x = x（x → 2^{-1}）
L4 = a/t              # def_real_quotient（y → a、z → 2）を右辺から左辺へ

assert L1 == L2
assert L2 == L3
assert L3 == L4
# 鎖の両端を t = 2 と a の有理数の値で QQ の値として確かめる。
for av in [QQ(0), QQ(1), QQ(-3), QQ(7)/5]:
    assert L1.subs(a=av, t=2) == L4.subs(a=av, t=2) == av/2
# 否定コントロール: 2 行目の 1 を 2 にすると等しくない。
assert a*(2*inv_t) != L1
# 否定コントロール: 3 行目の 2^{-1} を 2 にすると等しくない。
assert a*t != L4

print("Frac(QQ[a, t]) で恒等的な段 3 個と、t = 2 での両端 4 組を確かめた")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")

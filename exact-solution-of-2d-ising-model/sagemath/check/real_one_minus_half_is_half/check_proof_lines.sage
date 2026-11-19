# 対象ラベル: real_one_minus_half_is_half
# 1 − 1/2 = 1/2 の 8 行の鎖を一行ずつ確かめる。
# 2 を不定元 t に置き、行ごとに使う性質（t·t^{-1} = 1、t = 1 + 1）を、その行で初めて使う形で確かめる。
# 帰属: 有理関数体 Frac(QQ[t]) と QQ。浮動小数点は使わない。

R.<t> = QQ[]
F = R.fraction_field()
t = F(t)
inv_t = t^(-1)

# t·t^{-1} = 1 は Frac(QQ[t]) で恒等式として、t = 1 + 1 は t → 2 の代入で確かめる。
L1 = 1 - 1/t                      # 1 − 1/2
L2 = 1 + (-(1/t))                 # def_real_difference
L3 = t*inv_t + (-(1/t))           # 乗法の逆元 x·x^{-1} = 1 を右辺から左辺へ
L4 = (1 + 1)*inv_t + (-(1/t))     # def_real_two を左の因子の 2 だけへ
L5 = (1*inv_t + 1*inv_t) + (-(1/t))  # 分配律
L6 = (1/t + 1/t) + (-(1/t))       # def_real_quotient を右辺から左辺へ、2 箇所へ
L7 = 1/t + (1/t + (-(1/t)))       # 加法の結合律
L8 = 1/t + 0                      # 加法の逆元
L9 = 1/t                          # 加法の単位元

# 恒等的に等しい段（t を残したまま）: 差の定義・逆元・分配律・商の定義・結合律・加法の逆元・単位元。
assert L1 == L2
assert L2 == L3
assert L4 == L5
assert L5 == L6
assert L6 == L7
assert L7 == L8
assert L8 == L9
# def_real_two の段: t = 1 + 1 のときに限り等しい。
assert L3.subs(t=2) == L4.subs(t=2)
assert L3 != L4
# 鎖の両端を t = 2 で QQ の値として確かめる。
assert QQ(1) - QQ(1)/2 == QQ(1)/2
assert L1.subs(t=2) == L9.subs(t=2) == QQ(1)/2
# 否定コントロール: 1 − 1/3 は 1/3 にならない（2 = 1 + 1 が効いていること）。
assert L1.subs(t=3) != L9.subs(t=3)
# 否定コントロール: 分配律の行で一方の 1·t^{-1} を落とすと等しくない。
assert (1*inv_t) + (-(1/t)) != L4

print("Frac(QQ[t]) で恒等的な段 7 個と、t = 2 の段 1 個を確かめた（等号 8 個）")
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")

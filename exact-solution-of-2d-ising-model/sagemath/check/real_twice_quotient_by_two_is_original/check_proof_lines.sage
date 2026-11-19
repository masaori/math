# 対象ラベル: real_twice_quotient_by_two_is_original
# 2·(b/2) = b の 5 行の鎖を一行ずつ確かめる。
# 2 を不定元 t に置き（この鎖は 2 = 1 + 1 を使わず、t·t^{-1} = 1 だけを使うので、t のまま恒等的に等しい）、b も不定元に置く。
# 帰属: 有理関数体 Frac(QQ[b, t]) と QQ。浮動小数点は使わない。

R.<b, t> = QQ[]
F = R.fraction_field()
b = F(b)
t = F(t)
inv_t = t^(-1)

L1 = t*(b/t)          # 2·(b/2)
L2 = t*(b*inv_t)      # def_real_quotient（y → b、z → 2）
L3 = t*(inv_t*b)      # 乗法の交換則（x → b、y → 2^{-1}）
L4 = (t*inv_t)*b      # 乗法の結合則を右辺から左辺へ
L5 = 1*b              # 乗法の逆元 x·x^{-1} = 1（x → 2）
L6 = b                # 乗法の単位元 1·x = x（x → b）

assert L1 == L2
assert L2 == L3
assert L3 == L4
assert L4 == L5
assert L5 == L6
# 4 行目の逆元の段: t·t^{-1} が 1 であること。
assert t*inv_t == 1
# 鎖の両端を t = 2 と b の有理数の値で QQ の値として確かめる。
for bv in [QQ(0), QQ(1), QQ(-3), QQ(7)/5]:
    assert L1.subs(b=bv, t=2) == L6.subs(b=bv, t=2) == bv
# 否定コントロール: 4 行目の 1 を 2 にすると等しくない。
assert 2*b != L4
# 否定コントロール: 1 行目の 2^{-1} を 2 にすると等しくない。
assert t*(b*t) != L1

print("Frac(QQ[b, t]) で恒等的な段 5 個と、t = 2 での両端 4 組を確かめた")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")

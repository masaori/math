# 対象ラベル: real_product_of_inverses_is_inverse_of_product
# 準備 (a·b)·(a^{-1}·b^{-1}) = a·(b·(a^{-1}·b^{-1})) = a·((b·a^{-1})·b^{-1}) = a·((a^{-1}·b)·b^{-1})
#      = a·(a^{-1}·(b·b^{-1})) = a·(a^{-1}·1) = a·a^{-1} = 1 の 7 行と、
# 主鎖 a^{-1}·b^{-1} = 1·(a^{-1}·b^{-1}) = ((a·b)·(a·b)^{-1})·(a^{-1}·b^{-1}) = ((a·b)^{-1}·(a·b))·(a^{-1}·b^{-1})
#      = (a·b)^{-1}·((a·b)·(a^{-1}·b^{-1})) = (a·b)^{-1}·1 = (a·b)^{-1} の 6 行を確かめる。
# a^{-1}・b^{-1}・(a·b)^{-1} をそれぞれ不定元 ai・bi・ci に置き、逆元の前提 z z^{-1} = 1 は
# その前提が生成するイデアルに差が入ることとして確かめる（前提を使わない段は恒等的に等しい）。
# 帰属: 多項式環 QQ[a, b, ai, bi, ci] とそのイデアル。浮動小数点は使わない。

R.<a, b, ai, bi, ci> = QQ[]
I_a = R.ideal([a * ai - 1])          # def_real_quotient の z z^{-1} = 1（z → a）
I_b = R.ideal([b * bi - 1])          # 同（z → b）
I_ab = R.ideal([(a * b) * ci - 1])   # 同（z → a·b）

prep = [
    (a * b) * (ai * bi),
    a * (b * (ai * bi)),             # 結合律
    a * ((b * ai) * bi),             # 結合律を右辺から左辺へ
    a * ((ai * b) * bi),             # 可換律
    a * (ai * (b * bi)),             # 結合律
    a * (ai * 1),                    # 逆元（z → b）
    a * ai,                          # 単位元 x·1 = x
    R(1),                            # 逆元（z → a）
]
n = 0
for k in range(4):
    assert prep[k] == prep[k + 1]; n += 1                   # 結合律・可換律の段は恒等的
assert (prep[4] - prep[5]) in I_b; n += 1                    # b b^{-1} = 1 のもとで等しい
assert prep[5] == prep[6]; n += 1                            # 単位元
assert (prep[6] - prep[7]) in I_a; n += 1                    # a a^{-1} = 1 のもとで等しい

main = [
    ai * bi,
    1 * (ai * bi),                   # 単位元 1·x = x を右辺から左辺へ
    ((a * b) * ci) * (ai * bi),      # 逆元（z → a·b）を右辺から左辺へ
    (ci * (a * b)) * (ai * bi),      # 可換律
    ci * ((a * b) * (ai * bi)),      # 結合律
    ci * 1,                          # 準備
    ci,                              # 単位元 x·1 = x
]
assert main[0] == main[1]; n += 1
assert (main[1] - main[2]) in I_ab; n += 1
assert main[2] == main[3]; n += 1
assert main[3] == main[4]; n += 1
assert (main[4] - main[5]) in (I_a + I_b); n += 1            # 準備（a a^{-1} = 1、b b^{-1} = 1 のもとで）
assert main[5] == main[6]; n += 1
# 鎖の両端: 三つの逆元の前提のもとで a^{-1}·b^{-1} = (a·b)^{-1}。
assert (ai * bi - ci) in (I_a + I_b + I_ab); n += 1
# 0 でない有理数で a^{-1}·b^{-1} = (a·b)^{-1}（前提 a·b ≠ 0 は real_product_of_nonzero_is_nonzero）。
vals = [QQ(1), QQ(-2), QQ(3)/5, QQ(-7)/4]
for x in vals:
    for y in vals:
        assert x * y != 0
        assert x^(-1) * y^(-1) == (x * y)^(-1)
# 否定コントロール: a·b の逆元の前提を外すと結論は従わない。
assert (ai * bi - ci) not in (I_a + I_b)
# 否定コントロール: 逆元の段は恒等的な等号ではない。
assert main[1] != main[2]
# 否定コントロール: 準備の段は前提 b b^{-1} = 1 だけでは閉じない（a a^{-1} = 1 も要る）。
assert (main[4] - main[5]) not in I_b

print("QQ[a, b, ai, bi, ci] で準備の 7 段・主鎖の 6 段と両端を確かめた（%d 個）。0 でない有理数の組 %d 個で a^{-1}b^{-1} = (ab)^{-1}" % (n, len(vals)^2))
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")

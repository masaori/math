# 対象ラベル: real_negation_of_positive_is_negative
# 0 < a のとき −a < 0 を示す証明の鎖 −a = 0 + (−a) < a + (−a) = 0 の各行を確かめる。
# −a を不定元 na に置き（加法の逆元を前提にしないため）、前提を使う段は、その前提が生成するイデアルに差が入ることとして確かめる。
# 不等号の段（順序と加法の両立）は、両辺の差の形と、有理数の標本で公理の形が成り立つことで確かめる。
# 帰属: 多項式環 QQ[a, na] とそのイデアル、有理数 QQ、代数的実数 AA。浮動小数点は使わない。

R.<a, na> = QQ[]
I_neg = R.ideal([a + na])                          # def_real_difference の加法の逆元 a + (−a) = 0

k = 0
chain = [na, 0 + na, a + na, R(0)]
assert chain[0] == chain[1]; k += 1                          # 加法の単位元を右辺から左辺へ
assert (chain[2] - chain[1]) == a - R(0); k += 1             # 順序と加法の両立: 差は y − x = a − 0 で、同じ c = −a を足しただけ
assert (chain[2] - chain[3]) in I_neg; k += 1                # 加法の逆元（z → a）

# 順序と加法の両立の公理の形を有理数の標本で確かめる。
vals = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/7, QQ(5)]
m = 0
for x in vals:
    for y in vals:
        if x < y:
            for c in vals:
                assert x + c < y + c; m += 1

# 主張: 0 < a ⇒ −a < 0（QQ と AA の正の標本で）。鎖の各値も標本で確かめる。
samples = [QQ(1)/3, QQ(1), QQ(2), QQ(7)/5]
s = 0
for q in samples:
    assert -q == 0 + (-q) and 0 + (-q) < q + (-q) and q + (-q) == 0; s += 1
    assert -q < 0; s += 1
    assert -AA(q) < 0; s += 1
assert -AA(2).sqrt() < 0; s += 1

# 否定コントロール: 加法の逆元の前提を外すと a + (−a) = 0 は成り立たない。
assert (chain[2] - chain[3]) not in R.ideal([na])
# 否定コントロール: 0 < a を外すと主張は偽（a = −2 で −a = 2 > 0）。
assert not (-QQ(-2) < 0)

print("QQ[a, na] で証明の鎖の段 %d 個を確かめた。順序と加法の両立の公理の形を有理数の標本 %d 件で、主張を標本 %d 件で確かめた" % (k, m, s))
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")

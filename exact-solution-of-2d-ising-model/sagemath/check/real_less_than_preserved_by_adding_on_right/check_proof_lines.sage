# 対象ラベル: real_less_than_preserved_by_adding_on_right
# x < y ならば x + c < y + c を示す証明の各行を確かめる。
# 背理の鎖 x = x + 0 = x + (c + (−c)) = (x + c) + (−c) = (y + c) + (−c) = y + (c + (−c)) = y + 0 = y の各段を、
# −c を不定元 nc に置いた多項式環 QQ[x, y, c, nc] で、等号が恒等的か、前提が生成するイデアルに差が入ることとして確かめる。
# 不等号の段（≤ と加法の両立、< の定義）は、有理数の標本で公理と主張の形が成り立つことで確かめる。
# 帰属: 多項式環 QQ[x, y, c, nc] とそのイデアル、有理数 QQ、代数的実数 AA。浮動小数点は使わない。

R.<x, y, c, nc> = QQ[]
I_neg = R.ideal([c + nc])                 # def_real_difference の加法の逆元 c + (−c) = 0
I_hyp = R.ideal([(x + c) - (y + c)])      # 仮定 x + c = y + c
I_both = I_neg + I_hyp

chain = [x, x + 0, x + (c + nc), (x + c) + nc, (y + c) + nc, y + (c + nc), y + 0, y]
k = 0
assert chain[0] == chain[1]; k += 1                       # 加法の単位元を右辺から左辺へ
assert (chain[2] - chain[1]) in I_neg; k += 1             # 加法の逆元を右辺から左辺へ（z → c）
assert chain[2] == chain[3]; k += 1                       # 加法の結合律を右辺から左辺へ
assert (chain[4] - chain[3]) in I_hyp; k += 1             # 仮定 x + c = y + c
assert chain[4] == chain[5]; k += 1                       # 加法の結合律
assert (chain[5] - chain[6]) in I_neg; k += 1             # 加法の逆元（z → c）
assert chain[6] == chain[7]; k += 1                       # 加法の単位元
assert (chain[0] - chain[7]) in I_both                    # 鎖の両端 x = y

# 否定コントロール: 仮定 x + c = y + c を外すと x = y は出ない。加法の逆元を外しても出ない。
assert (chain[0] - chain[7]) not in I_neg
assert (chain[2] - chain[1]) not in I_hyp

# ≤ と加法の両立（公理の形）と主張 x < y ⇒ x + c < y + c を有理数と代数的実数の標本で確かめる。
vals = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/7, QQ(5)]
m = 0; s = 0
for a in vals:
    for b in vals:
        for t in vals:
            if a <= b:
                assert a + t <= b + t; m += 1
            if a < b:
                assert (a <= b and a != b) and (a + t <= b + t and a + t != b + t); s += 1   # < の定義の両向き
                assert a + t < b + t; s += 1
assert AA(2).sqrt() + AA(1) < AA(3).sqrt() + AA(1); s += 1
# 否定コントロール: x < y を外すと主張は偽（x = 1, y = 0）。
assert not (QQ(1) + 5 < QQ(0) + 5)

print("QQ[x, y, c, nc] で背理の鎖の段 %d 個と両端を確かめた。≤ と加法の両立を標本 %d 件で、主張と < の定義を標本 %d 件で確かめた" % (k, m, s))
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")

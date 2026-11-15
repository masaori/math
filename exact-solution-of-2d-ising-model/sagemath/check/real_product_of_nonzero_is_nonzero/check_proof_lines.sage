# 対象ラベル: real_product_of_nonzero_is_nonzero
# a·b = 0 を仮定して b = 1·b = (a^{-1}·a)·b = a^{-1}·(a·b) = a^{-1}·0 = 0 を導く 5 行の鎖を確かめる。
# a^{-1} を不定元 ai、仮定 a·b = 0 の右辺の 0 を不定元 o に置き（a^{-1}·a = 1 と a·b = 0 を前提にしないため）、
# 前提を使う段は、その前提が生成するイデアルに差が入ることとして確かめる。
# 5 行目 a^{-1}·0 = 0（real_times_zero_is_zero（x → a^{-1})）は、4 行目の o を 0 に置き換える段として確かめる。
# 帰属: 多項式環 QQ[ai, a, b, o] とそのイデアル。浮動小数点は使わない。

R.<ai, a, b, o> = QQ[]
I_inv = R.ideal([ai * a - 1])     # 乗法の逆元 a^{-1}·a = 1
I_hyp = R.ideal([a * b - o])      # 仮定 a·b = 0（右辺の 0 を o と書く）

lines = [
    b,                  # 鎖の左辺 b
    1 * b,              # 乗法の単位元を右辺から左辺へ
    (ai * a) * b,       # 乗法の逆元 a^{-1}·a = 1 を右辺から左辺へ
    ai * (a * b),       # 乗法の結合則
    ai * o,             # 仮定 a·b = 0（右辺の 0 を o と書く）
    R(0),               # real_times_zero_is_zero（x → a^{-1}）
]

n = 0
assert lines[0] == lines[1]; n += 1                        # 単位元の段は恒等的
assert (lines[1] - lines[2]) in I_inv; n += 1              # 逆元の段は a^{-1}·a = 1 のもとで等しい
assert lines[2] == lines[3]; n += 1                        # 結合則の段は恒等的
assert (lines[3] - lines[4]) in I_hyp; n += 1              # 仮定の段は a·b = o のもとで等しい
assert lines[4].subs(o=0) == lines[5]; n += 1              # real_times_zero_is_zero: o を 0 に置き換えると a^{-1}·0 = 0
# 鎖の両端: a^{-1}·a = 1 と a·b = 0 のもとで b = 0。
assert b in R.ideal([ai * a - 1, a * b]); n += 1
# 0 でない有理数どうしの積が 0 でないこと。
vals = [QQ(1), QQ(-2), QQ(3)/5, QQ(-7)/4]
for x in vals:
    for y in vals:
        assert x * y != 0
# 否定コントロール: 逆元の前提を外すと a·b = 0 から b = 0 は従わない（a = 0 のとき a·b = 0 でも b ≠ 0 でありうる）。
assert b not in R.ideal([a * b])
# 否定コントロール: 逆元の段は恒等的な等号ではない。
assert lines[1] != lines[2]
# 否定コントロール: o を 0 に置き換えなければ 5 行目は成り立たない。
assert lines[4] != lines[5]

print("QQ[ai, a, b, o] で鎖の 5 段と両端を確かめた（%d 個）。0 でない有理数の組 %d 個で積が 0 でない" % (n, len(vals)^2))
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")

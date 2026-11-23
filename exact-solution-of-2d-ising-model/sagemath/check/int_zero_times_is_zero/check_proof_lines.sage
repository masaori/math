# 対象ラベル: int_zero_times_is_zero
# 0x = 0x + 0 = 0x + (0x + (-(0x))) = (0x + 0x) + (-(0x)) = (0 + 0)x + (-(0x)) = 0x + (-(0x)) = 0
# の 6 行の鎖を確かめる（x ∈ ℤ）。
# 計算する環では 0x = 0 が既に成り立つので、掛ける側の 0 を ZZ[o, x] の不定元 o に置き、
# 0x = 0 を前提にしない形で、どの行にどの規則を当てたかを確かめる（足す側の 0 と逆元は環のもの）。
# 各行の根拠に書いた形（和の単位元 y + 0 = y、加法の逆元 y + (-y) = 0、加法の結合律、分配律 (y + z)t = yt + zt）を、
# 行に書いた代入で両辺を作り、前後の行の差がその形の両辺の差になっていることも確かめる。
# 帰属: 多項式環 ZZ[o, x] と整数 ZZ。浮動小数点は使わない。

R.<o, x> = ZZ[]
ZERO = R(0)

lines = [
    o * x,                                   # 1 行目の左辺 0x
    o * x + ZERO,                            # 和の単位元（y → 0x）を右辺から左辺へ
    o * x + (o * x + (-(o * x))),            # 加法の逆元（y → 0x）を右辺から左辺へ
    (o * x + o * x) + (-(o * x)),            # 加法の結合律を右辺から左辺へ
    (o + o) * x + (-(o * x)),                # 分配律 (y+z)t = yt+zt（y, z → 0、t → x）を右辺から左辺へ
    o * x + (-(o * x)),                      # 和の単位元（y → 0）
    ZERO,                                    # 加法の逆元（y → 0x）
]

# 和の単位元（y → o） 0 + 0 = 0 を当てる段（5 行目 → 6 行目）以外は、o を不定元にしたまま恒等的に等しい。
identity_steps = [0, 1, 2, 3, 5]
for k in identity_steps:
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1])

# 各行の形の両辺（代入済み）
y0 = o * x
assert y0 + ZERO == y0                                   # 1 段目: y + 0 = y（y → 0x）
assert y0 + (-y0) == ZERO                                # 2 段目・6 段目: y + (-y) = 0（y → 0x）
assert (y0 + y0) + (-y0) == y0 + (y0 + (-y0))            # 3 段目: (y + z) + t = y + (z + t)（y, z → 0x、t → -(0x)）
assert (o + o) * x == o * x + o * x                      # 4 段目: (y + z)t = yt + zt（y, z → 0、t → x）

# 0 + 0 = 0 の段: 4 行目・5 行目は (o + o) と o の違いだけで、o = 0 のとき o + o = o。
assert lines[4] - lines[5] == o * x
assert (o + o).subs(o=0) == o.subs(o=0) == 0
# 否定コントロール: o が一般の値なら 0 + 0 = 0 の段は成り立たない。
assert lines[4] != lines[5]
# 否定コントロール: 分配律の段で (o + o) を (o + 1) に取り違えると 3 行目と一致しない。
assert (o + 1) * x + (-(o * x)) != lines[3]

# o = 0 を代入すると、全ての行が 0 になり、鎖の両端 0x と 0 が一致する。
assert all(l.subs(o=0) == 0 for l in lines)

# 整数の標本で主張 0·x = 0 と、o = 0 での各行の値を確かめる。
m = 0
for a in range(-40, 41):
    a = ZZ(a)
    vals = [ZZ(l.subs(o=0, x=a)) for l in lines]
    assert all(v == 0 for v in vals)
    assert ZZ(0) * a == 0
    m += 1

print(f"ZZ[o, x] で恒等的な段 {len(identity_steps)} 個と、o = 0 でだけ成り立つ 0 + 0 = 0 の段 1 個を確かめた（等号 6 個）")
print(f"各段の根拠の形の両辺を 4 つ確かめた。整数の標本 {m} 件で全ての行と主張が 0 になった")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")

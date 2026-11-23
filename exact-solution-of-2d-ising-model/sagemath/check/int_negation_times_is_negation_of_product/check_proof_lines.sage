# 対象ラベル: int_negation_times_is_negation_of_product
# (-x)t = (-x)t + 0 = (-x)t + (xt + (-(xt))) = ((-x)t + xt) + (-(xt)) = ((-x) + x)t + (-(xt))
#       = 0t + (-(xt)) = 0 + (-(xt)) = -(xt)
# の 7 行の鎖を確かめる（x, t ∈ ℤ）。
# 計算する環では (-x) + x = 0 と 0t = 0 が既に成り立つので、5 行目の 0（(-x) + x を置き換えた 0）を ZZ[x, t, o] の不定元 o に置き、
# どの段で (-x) + x = 0 を当て、どの段で int_zero_times_is_zero（0t = 0）を当てたかを分けて確かめる。
# 帰属: 多項式環 ZZ[x, t, o] と整数 ZZ。浮動小数点は使わない。

R.<x, t, o> = ZZ[]
ZERO = R(0)
xt = x * t

lines = [
    (-x) * t,                                  # 左辺 (-x)t
    (-x) * t + ZERO,                           # 和の単位元（y → (-x)t）を右辺から左辺へ
    (-x) * t + (xt + (-xt)),                   # 加法の逆元（y → xt）を右辺から左辺へ
    ((-x) * t + xt) + (-xt),                   # 加法の結合律を右辺から左辺へ
    ((-x) + x) * t + (-xt),                    # 分配律 (y+z)s = ys+zs（y → -x, z → x, s → t）を右辺から左辺へ
    o * t + (-xt),                             # 加法の逆元 (-y)+y = 0（y → x）。0 を o と置く
    ZERO + (-xt),                              # int_zero_times_is_zero（x → t）
    -xt,                                       # 和の単位元 0 + y = y（y → -(xt)）
]

identity_steps = [0, 1, 2, 3, 6]
for k in identity_steps:
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1])

# 各段の根拠の形の両辺（代入済み）
assert (-x) * t + ZERO == (-x) * t                               # y + 0 = y
assert xt + (-xt) == ZERO                                        # y + (-y) = 0
assert ((-x) * t + xt) + (-xt) == (-x) * t + (xt + (-xt))        # 結合律
assert ((-x) + x) * t == (-x) * t + x * t                        # 右からの分配律
assert (-x) + x == ZERO                                          # (-y) + y = 0（y → x）
assert ZERO + (-xt) == -xt                                       # 0 + y = y

# (-x) + x = 0 を当てる段: 4 行目と 5 行目の差は ((-x) + x - o)t で、o = 0 で 0。
assert lines[4] - lines[5] == ((-x) + x - o) * t
assert (lines[4] - lines[5]).subs(o=0) == 0
# int_zero_times_is_zero を当てる段: 5 行目と 6 行目の差は o·t で、o = 0 で 0。
assert lines[5] - lines[6] == o * t
assert (lines[5] - lines[6]).subs(o=0) == 0

# 否定コントロール
assert lines[5] != lines[6]                                      # o が一般の値なら 0t = 0 の段は成り立たない
assert ((-x) + 1) * t + (-xt) != lines[3]                        # 分配律の段で x を 1 に取り違えると一致しない

# 整数の標本で主張 (-x)t = -(xt) と、o = 0 での各行の値を確かめる。
m = 0
for a in range(-15, 16):
    for b in range(-15, 16):
        a, b = ZZ(a), ZZ(b)
        vals = [ZZ(l.subs(x=a, t=b, o=0)) for l in lines]
        assert all(v == -(a * b) for v in vals)
        assert (-a) * b == -(a * b)
        m += 1

print(f"ZZ[x, t, o] で恒等的な段 {len(identity_steps)} 個と、o = 0 でだけ成り立つ段 2 個を確かめた（等号 7 個）")
print(f"各段の根拠の形の両辺を 6 つ確かめた。整数の標本 {m} 件で全ての行が -(xt) に等しかった")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")

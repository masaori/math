# 対象ラベル: real_minus_one_times_is_negation
# (-1)a = (-1)a + 0 = (-1)a + (a + (-a)) = ((-1)a + a) + (-a) = ((-1)a + 1·a) + (-a)
#       = ((-1) + 1)a + (-a) = (1 + (-1))a + (-a) = 0·a + (-a) = 0 + (-a) = (-a) + 0 = -a
# の 10 行の鎖を確かめる。
# 計算する環では (-1)a = -a が既に成り立つので、-1 を QQ[m, a] の不定元 m に置き、
# (-1)a = -a を前提にしない形で、どの行にどの規則を当てたかを確かめる（-a は環の加法の逆元）。
# 帰属: 多項式環 QQ[m, a]。浮動小数点は使わない。

R.<m, a> = QQ[]
ZERO = R(0)
ONE = R(1)

lines = [
    m * a,                                   # 左辺 (-1)a
    m * a + ZERO,                            # 加法の単位元を右辺から左辺へ
    m * a + (a + (-a)),                      # 加法の逆元（z → a）を右辺から左辺へ
    (m * a + a) + (-a),                      # 加法の結合律
    (m * a + ONE * a) + (-a),                # 1·a = a を右辺から左辺へ
    (m + ONE) * a + (-a),                    # 分配律 (x+y)c = xc+yc を右辺から左辺へ
    (ONE + m) * a + (-a),                    # 加法の可換律
    ZERO * a + (-a),                         # 加法の逆元（z → 1）: m = -1 でだけ成り立つ段
    ZERO + (-a),                             # real_zero_times_is_zero（x → a）
    (-a) + ZERO,                             # 加法の可換律
    -a,                                      # 加法の単位元
]

# 加法の逆元（z → 1）を当てる段（6 行目 → 7 行目）以外は、m を不定元にしたまま恒等的に等しい。
identity_steps = [0, 1, 2, 3, 4, 5, 7, 8, 9]
for k in identity_steps:
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1])

# 加法の逆元（z → 1）の段: 1 + m が m = -1 で 0 になる。
assert (ONE + m).subs(m=-1) == 0
assert lines[6].subs(m=-1) == lines[7]
# 否定コントロール: m が一般の値なら加法の逆元（z → 1）の段は成り立たない。
assert lines[6] != lines[7]
# 否定コントロール: 分配律の段で (m + 1) を (m - 1) に取り違えると 4 行目と一致しない。
assert (m - ONE) * a + (-a) != lines[4]
# 否定コントロール: 終点の符号を取り違えた a は、m = -1 の左辺と一致しない。
assert lines[0].subs(m=-1) != a

# m = -1 を代入すると、全ての行が -a になり、鎖の両端 (-1)a と -a が一致する。
eq_count = len(identity_steps) + 1
assert all(l.subs(m=-1) == -a for l in lines)

print(f"QQ[m, a] で恒等的な段 {len(identity_steps)} 個と、m = -1 でだけ成り立つ加法の逆元（z → 1）の段 1 個を確かめた（等号 {eq_count} 個）")
print("m = -1 を代入して全ての行が -a になった")
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")

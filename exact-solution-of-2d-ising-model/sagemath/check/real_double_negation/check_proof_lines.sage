# 対象ラベル: real_double_negation
# -(-a) = -(-a) + 0 = -(-a) + (a + (-a)) = -(-a) + ((-a) + a) = (-(-a) + (-a)) + a
#       = ((-a) + (-(-a))) + a = 0 + a = a + 0 = a
# の 8 行の鎖を確かめる。
# 計算する環では -(-a) = a が既に成り立つので、-(-a) を QQ[n, a] の不定元 n に置き、
# -(-a) = a を前提にしない形で、どの行にどの規則を当てたかを確かめる。
# 不定元 n に課すのは「n は -a の加法の逆元」すなわち (-a) + n = 0（n = a）だけである。
# 帰属: 多項式環 QQ[n, a]。浮動小数点は使わない。

R.<n, a> = QQ[]
ZERO = R(0)

lines = [
    n,                                       # 左辺 -(-a)
    n + ZERO,                                # 加法の単位元を右辺から左辺へ
    n + (a + (-a)),                          # 加法の逆元（z → a）を右辺から左辺へ
    n + ((-a) + a),                          # 加法の可換律
    (n + (-a)) + a,                          # 加法の結合律
    ((-a) + n) + a,                          # 加法の可換律
    ZERO + a,                                # 加法の逆元（z → -a）: n = a でだけ成り立つ段
    a + ZERO,                                # 加法の可換律
    a,                                       # 加法の単位元
]

# 加法の逆元（z → -a）を当てる段（5 行目 → 6 行目）以外は、n を不定元にしたまま恒等的に等しい。
identity_steps = [0, 1, 2, 3, 4, 6, 7]
for k in identity_steps:
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1])

# 加法の逆元（z → -a）の段: (-a) + n が n = a（-a の加法の逆元）で 0 になる。
assert ((-a) + n).subs(n=a) == 0
assert lines[5].subs(n=a) == lines[6]
# 否定コントロール: n が一般の値なら加法の逆元（z → -a）の段は成り立たない。
assert lines[5] != lines[6]
# 否定コントロール: 結合律の段で最後の項の符号を取り違えた (n + (-a)) + (-a) は 3 行目と一致しない。
assert (n + (-a)) + (-a) != lines[3]
# 否定コントロール: 終点の符号を取り違えた -a は、n = a の左辺と一致しない。
assert lines[0].subs(n=a) != -a

# n = a を代入すると、全ての行が a になり、鎖の両端 -(-a) と a が一致する。
eq_count = len(identity_steps) + 1
assert all(l.subs(n=a) == a for l in lines)

print(f"QQ[n, a] で恒等的な段 {len(identity_steps)} 個と、n = a でだけ成り立つ加法の逆元（z → -a）の段 1 個を確かめた（等号 {eq_count} 個）")
print("n = a を代入して全ての行が a になった")
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")

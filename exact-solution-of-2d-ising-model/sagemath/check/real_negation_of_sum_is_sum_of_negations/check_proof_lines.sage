# 対象ラベル: real_negation_of_sum_is_sum_of_negations
# -(x+y) = (-1)(x+y) = (-1)x+(-1)y = (-x)+(-y) の 3 行の鎖を確かめる。
# 計算する環では -(x+y) = (-x)+(-y) が既に成り立つので、主張を引く段を区別するため、
# 符号を反転した元 -(x+y), -x, -y を QQ[x, y, nxy, nx, ny] の不定元に置く。
# 1 行目（real_minus_one_times_is_negation、a → x+y を右辺から左辺へ）は -(x+y) を (-1)(x+y) に置いたときにだけ等しい。
# 2 行目（ℝ の分配則 p(q+r) = pq+pr、p → -1, q → x, r → y）は不定元のまま恒等的に等しい。
# 3 行目（real_minus_one_times_is_negation、a → x と a → y を 2 箇所へ）は -x・-y を (-1)x・(-1)y に置いたときにだけ等しい。
# 帰属: 多項式環 QQ[x, y, nxy, nx, ny]。浮動小数点は使わない。

R.<x, y, nxy, nx, ny> = QQ[]
m1 = R(-1)

lines = [
    nxy,               # 左辺 -(x+y)
    m1 * (x + y),      # real_minus_one_times_is_negation (a → x+y) を右辺から左辺へ
    m1 * x + m1 * y,   # 分配則 (p → -1, q → x, r → y)
    nx + ny,           # real_minus_one_times_is_negation (a → x と a → y)
]

identity_steps = [1]
rules = {
    0: {nxy: m1 * (x + y)},
    2: {nx: m1 * x, ny: m1 * y},
}
eq = 0
for k in identity_steps:
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1]); eq += 1
for k, sub in rules.items():
    assert lines[k].subs(sub) == lines[k + 1].subs(sub), (k,)
    assert lines[k] != lines[k + 1], ("段", k, "は根拠を当てずに恒等的に成り立ってしまう")
    eq += 1

# 否定コントロール
neg = 0
full = {nxy: -(x + y), nx: -x, ny: -y}
# 1. 主張を当てる段を置き換えなしで比べると一致しない
assert lines[0] != lines[1]; neg += 1
# 2. 一方の符号だけを反転した (-x)+y は、全ての置き換えの後の左辺と一致しない
assert lines[0].subs(full) != -x + y; neg += 1
# 3. 符号を反転しない x+y は、左辺と一致しない
assert lines[0].subs(full) != x + y; neg += 1
# 4. 3 行目の置き換えで -y を (-1)x と取り違えると 3 行目と一致しない
assert lines[2] != lines[3].subs({nx: m1 * x, ny: m1 * x}); neg += 1

# 全ての符号反転を本来の値に置くと、全ての行が -x-y になり、鎖の両端が一致する
assert all(l.subs(full) == -x - y for l in lines)

# 本文で引く側の代入の実例 (x, y) → (y, v), (xv, yu), (s, x_{m+1}), (a, b), ((ad)f, (bc)f), (b(cf), b(de)),
# (x, y)（cosh・sinh の加法定理）, (1/2, 1/2), (θ̃_μ, 2πk)
S.<a, b, c, d, e, f, u, v, w, z, s, xm, th, k, pi_> = QQ[]
inst = [(z, v), (w*v, z*u), (s, xm), (a, b), ((a*d)*f, (b*c)*f), (b*(c*f), b*(d*e)),
        (w, z), (QQ(1)/2, QQ(1)/2), (th, 2*pi_*k)]
for (p, q) in inst:
    assert -(p + q) == (-p) + (-q)

print(f"QQ[x, y, nxy, nx, ny] で恒等的な段 {len(identity_steps)} 個と、根拠を当てる段 {len(rules)} 個を確かめた（等号 {eq} 個）")
print("符号反転を本来の値に置いて全ての行が -x-y になった")
print(f"使う側の代入の実例 {len(inst)} 件で両辺が等しい")
print(f"negative controls (broken lines detected): {neg}")
print("RESULT: PASS")

# 対象ラベル: real_times_negation_is_negation_of_product
# x(-t) = (-t)x = -(tx) = -(xt) の 3 行の鎖を確かめる。
# 計算する環では x(-t) = -(xt) が既に成り立つので、主張を引く段を区別するため、
# 符号を反転した元 -t, -(tx), -(xt) を QQ[x, t, nt, ntx, nxt] の不定元に置く。
# 乗法の可換則の 1 行目は不定元のまま恒等的に等しい。
# 2 行目（real_negation_times_is_negation_of_product の (-p)q = -(pq)、p → t, q → x）は、
# その主張が成り立つ形 -t = (-1)t、-(tx) = (-1)(tx) に置いたときにだけ等しい。
# 3 行目（乗法の可換則 p → t, q → x を符号反転の中へ）は、-(tx)・-(xt) を (-1)(tx)・(-1)(xt) に置いたときにだけ等しい。
# 帰属: 多項式環 QQ[x, t, nt, ntx, nxt]。浮動小数点は使わない。

R.<x, t, nt, ntx, nxt> = QQ[]
m1 = R(-1)

lines = [
    x * nt,    # 左辺 x(-t)
    nt * x,    # 乗法の可換則 (p → x, q → -t)
    ntx,       # real_negation_times_is_negation_of_product (p → t, q → x): (-t)x を -(tx) に
    nxt,       # 乗法の可換則 (p → t, q → x): -(tx) を -(xt) に
]

identity_steps = [0]
rules = {
    1: {nt: m1 * t, ntx: m1 * (t * x)},
    2: {ntx: m1 * (t * x), nxt: m1 * (x * t)},
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
full = {nt: -t, ntx: -(t * x), nxt: -(x * t)}
# 1. 主張を当てる段を置き換えなしで比べると一致しない
assert lines[1] != lines[2]; neg += 1
# 2. 符号を落とした x·t は、全ての置き換えの後の左辺と一致しない
assert lines[0].subs(full) != x * t; neg += 1
# 3. 符号を外へ出さずに -t を -x と取り違えた (-x)x は、左辺と一致しない
assert (-x) * x != lines[0].subs(full); neg += 1
# 4. 2 行目の置き換えで -(tx) を (-1)(tt) と取り違えると 3 行目と一致しない
assert lines[1].subs({nt: m1 * t}) != m1 * (t * t); neg += 1

# 全ての符号反転を本来の値に置くと、全ての行が -(xt) になり、鎖の両端が一致する
assert all(l.subs(full) == -(x * t) for l in lines)

# 本文で引く側の代入の実例 (x, t) → (a, df), (b, df), (ac, bd), (a, b), (x, v), (2π, μ-1/2), (2π, κ), (j, 2πκ), (2π, k), (γ, 1/2), (-γ, 1/2)
S.<a, b, c, d, f, v, w, mu, ka, j, k, g, pi_> = QQ[]
inst = [(a, d*f), (b, d*f), (a*c, b*d), (a, b), (w, v), (2*pi_, mu - QQ(1)/2), (2*pi_, ka),
        (j, 2*pi_*ka), (2*pi_, k), (g, QQ(1)/2), (-g, QQ(1)/2)]
for (p, q) in inst:
    assert p * (-q) == -(p * q)

print(f"QQ[x, t, nt, ntx, nxt] で恒等的な段 {len(identity_steps)} 個と、根拠を当てる段 {len(rules)} 個を確かめた（等号 {eq} 個）")
print("符号反転を本来の値に置いて全ての行が -(xt) になった")
print(f"使う側の代入の実例 {len(inst)} 件で両辺が等しい")
print(f"negative controls (broken lines detected): {neg}")
print("RESULT: PASS")

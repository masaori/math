# 対象ラベル: real_negation_times_is_negation_of_product
# (-x)t = ((-1)x)t = (-1)(xt) = -(xt) の 3 行の鎖を確かめる。
# 計算する環では (-1)·y = -y が既に成り立つので、主張を引く段を区別するため、
# 符号を反転した元 -x, -(xt) を QQ[x, t, nx, nxt] の不定元に置き、
# real_minus_one_times_is_negation を当てる段だけを、その主張が与える置き換えで確かめる。
# 乗法の結合律の段は不定元のまま恒等的に等しい。
# 帰属: 多項式環 QQ[x, t, nx, nxt]。浮動小数点は使わない。

R.<x, t, nx, nxt> = QQ[]
m1 = R(-1)

lines = [
    nx * t,             # 左辺 (-x)t
    (m1 * x) * t,       # real_minus_one_times_is_negation (a → x) を右辺から左辺へ: nx を (-1)x に
    m1 * (x * t),       # 乗法の結合律 (p → -1, q → x, r → t)
    nxt,                # real_minus_one_times_is_negation (a → xt): (-1)(xt) を nxt に
]

rules = {
    0: {nx: m1 * x},          # (-1)·x = -x を右辺から左辺へ
    2: {nxt: m1 * (x * t)},   # (-1)·(xt) = -(xt)
}
identity_steps = [1]
eq = 0
for k in identity_steps:
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1]); eq += 1
for k, sub in rules.items():
    assert lines[k].subs(sub) == lines[k + 1].subs(sub), (k,)
    assert lines[k] != lines[k + 1], ("段", k, "は主張を当てずに恒等的に成り立ってしまう")
    eq += 1

# 否定コントロール
neg = 0
full = {nx: -x, nxt: -(x * t)}
# 1. 主張を当てる段を置き換えなしで比べると一致しない
assert lines[0] != lines[1]; neg += 1
# 2. 結合律の段で (-1) を落とした x·t は 3 行目と一致しない
assert x * t != lines[2]; neg += 1
# 3. 終点の符号を取り違えた xt は、全ての置き換えの後の左辺と一致しない
assert lines[0].subs(full) != x * t; neg += 1
# 4. 右から掛ける因子を取り違えた (-1)(x·x) は 3 行目と一致しない
assert m1 * (x * x) != lines[2]; neg += 1

# 全ての符号反転を本来の値に置くと、全ての行が -(xt) になり、鎖の両端が一致する
assert all(l.subs(full) == -(x * t) for l in lines)

# 鎖を使う側の代入の実例（(x, t) → (bd, e), (bd, f), (bd, ac), (1/2, S)）で主張の両辺が等しい
S.<a, b, c, d, e, f, s> = QQ[]
inst = [(b*d, e), (b*d, f), (b*d, a*c), (QQ(1)/2, s)]
for (p, q) in inst:
    assert (-p) * q == -(p * q)

print(f"QQ[x, t, nx, nxt] で恒等的な段 {len(identity_steps)} 個と、主張を当てる段 {len(rules)} 個を確かめた（等号 {eq} 個）")
print("符号反転を本来の値に置いて全ての行が -(xt) になった")
print(f"使う側の代入の実例 {len(inst)} 件で両辺が等しい")
print(f"negative controls (broken lines detected): {neg}")
print("RESULT: PASS")

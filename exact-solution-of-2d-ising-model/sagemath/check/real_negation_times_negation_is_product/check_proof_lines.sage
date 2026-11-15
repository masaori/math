# 対象ラベル: real_negation_times_negation_is_product
# (-a)(-b) = ((-1)a)(-b) = ((-1)a)((-1)b) = (-1)(a((-1)b)) = (-1)((a(-1))b) = (-1)(((-1)a)b)
#          = (-1)((-1)(ab)) = (-1)(-(ab)) = -(-(ab)) = ab
# の 9 行の鎖を確かめる。
# 計算する環では (-1)·x = -x も -(-x) = x も既に成り立つので、主張を引く段を区別するため、
# 符号を反転した元 -a, -b, -(ab), -(-(ab)) を QQ[a, b, na, nb, nab, nnab] の不定元に置き、
# 「(-1)·x は x の符号反転」（real_minus_one_times_is_negation）と「-(-x) = x」（real_double_negation）を
# 当てる段だけを、その主張が与える置き換えで確かめる。乗法の結合則・可換則の段は不定元のまま恒等的に等しい。
# 帰属: 多項式環 QQ[a, b, na, nb, nab, nnab]。浮動小数点は使わない。

R.<a, b, na, nb, nab, nnab> = QQ[]
m1 = R(-1)

lines = [
    na * nb,                          # 左辺 (-a)(-b)
    (m1 * a) * nb,                    # real_minus_one_times_is_negation (a → a) を右辺から左辺へ: na を (-1)a に
    (m1 * a) * (m1 * b),              # real_minus_one_times_is_negation (a → b) を右辺から左辺へ: nb を (-1)b に
    m1 * (a * (m1 * b)),              # 乗法の結合則
    m1 * ((a * m1) * b),              # 乗法の結合則
    m1 * ((m1 * a) * b),              # 乗法の可換則
    m1 * (m1 * (a * b)),              # 乗法の結合則
    m1 * nab,                         # real_minus_one_times_is_negation (a → ab): (-1)(ab) を nab に
    nnab,                             # real_minus_one_times_is_negation (a → -(ab)): (-1)nab を nnab に
    a * b,                            # real_double_negation (a → ab): nnab を ab に
]

# 主張が与える置き換え（各段で当てる 1 つだけ）
rules = {
    0: {na: m1 * a},                  # (-1)·a = -a を右辺から左辺へ
    1: {nb: m1 * b},                  # (-1)·b = -b を右辺から左辺へ
    6: {nab: m1 * (a * b)},           # (-1)·(ab) = -(ab)
    7: {nnab: m1 * nab},              # (-1)·(-(ab)) = -(-(ab))
    8: {nnab: a * b},                 # -(-(ab)) = ab
}
identity_steps = [2, 3, 4, 5]
eq = 0
for k in identity_steps:
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1]); eq += 1
for k, sub in rules.items():
    assert lines[k].subs(sub) == lines[k + 1].subs(sub), (k,)
    assert lines[k] != lines[k + 1], ("段", k, "は主張を当てずに恒等的に成り立ってしまう")
    eq += 1

# 否定コントロール
neg = 0
# 1. 主張を当てる段を置き換えなしで比べると一致しない（上の != で確かめた 5 件の代表として 1 件数える）
assert lines[0] != lines[1]; neg += 1
# 2. 可換則の段で符号を落とした m1 * ((a) * b) は 5 行目と一致しない
assert m1 * (a * b) != lines[5]; neg += 1
# 3. 終点の符号を取り違えた -(ab) は、全ての置き換えの後の左辺と一致しない
full = {na: -a, nb: -b, nab: -(a * b), nnab: a * b}
assert lines[0].subs(full) != -(a * b); neg += 1

# 全ての符号反転を本来の値に置くと、全ての行が ab になり、鎖の両端が一致する
assert all(l.subs(full) == a * b for l in lines)

print(f"QQ[a, b, na, nb, nab, nnab] で恒等的な段 {len(identity_steps)} 個と、主張を当てる段 {len(rules)} 個を確かめた（等号 {eq} 個）")
print("符号反転を本来の値に置いて全ての行が ab になった")
print(f"negative controls (broken lines detected): {neg}")
print("RESULT: PASS")

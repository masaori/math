# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 末端偶数仮定の反証: mod_add
# 式・所属: (r + 1) % 2 == ((r % 2) + 1) % 2
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    t = coordinate(sigma, sigma[i])
    if r + 1 == p and r % 2 == 0:
        assert (r + 1) % 2 == ((r % 2) + 1) % 2, (sigma, i, m, p, r)
        checked += 1
assert checked == 0, checked
print('RESULT: PASS (末端偶数仮定の反証: mod_add: %s 件)' % checked)
print('対象事例なし: 矛盾する仮定の枝の論証は Lean で検証する。')

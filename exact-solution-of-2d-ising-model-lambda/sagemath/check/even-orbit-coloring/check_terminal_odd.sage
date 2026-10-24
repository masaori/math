# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 末端の座標は奇数
# 式・所属: r % 2 == 1
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if r + 1 == p:
        assert r % 2 == 1, (sigma, i, m, p, r)
        checked += 1
assert checked == 358, checked
print('RESULT: PASS (末端の座標は奇数: %s 件)' % checked)

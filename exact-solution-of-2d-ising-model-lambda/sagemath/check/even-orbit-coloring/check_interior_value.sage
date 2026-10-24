# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 非末端の後続元の表示
# 式・所属: iterate(sigma, r + 1, m) == sigma[i]
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if r + 1 < p:
        assert iterate(sigma, r + 1, m) == sigma[i], (sigma, i, m, p, r)
        checked += 1
assert checked == 1030, checked
print('RESULT: PASS (非末端の後続元の表示: %s 件)' % checked)

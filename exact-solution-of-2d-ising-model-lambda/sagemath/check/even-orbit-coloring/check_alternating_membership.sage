# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 後続写像による所属の反転
# 式・所属: (sigma[i] in coloring) == (i not in coloring)
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if True:
        assert (sigma[i] in coloring) == (i not in coloring), (sigma, i, m, p, r)
        checked += 1
assert checked == 1388, checked
print('RESULT: PASS (後続写像による所属の反転: %s 件)' % checked)

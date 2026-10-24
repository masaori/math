# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 元座標非零と補集合所属の同値
# 式・所属: (r % 2 != 0) == (i not in coloring)
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    t = coordinate(sigma, sigma[i])
    if True:
        assert (r % 2 != 0) == (i not in coloring), (sigma, i, m, p, r)
        checked += 1
assert checked == 1388, checked
print('RESULT: PASS (元座標非零と補集合所属の同値: %s 件)' % checked)

# 対象ラベル: def_even_orbit_coordinate
# 本文の行: 座標の範囲
# 式・所属: 0 <= r < p
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if True:
        assert 0 <= r < p, (sigma, i, m, p, r)
        checked += 1
assert checked == 1388, checked
print('RESULT: PASS (座標の範囲: %s 件)' % checked)

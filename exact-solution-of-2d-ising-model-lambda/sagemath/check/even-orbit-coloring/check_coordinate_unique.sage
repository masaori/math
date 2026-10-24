# 対象ラベル: def_even_orbit_coordinate
# 本文の行: 周期未満の座標の一意性
# 式・所属: [k for k in range(p) if iterate(sigma, k, m) == i] == [r]
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if True:
        assert [k for k in range(p) if iterate(sigma, k, m) == i] == [r], (sigma, i, m, p, r)
        checked += 1
assert checked == 1388, checked
print('RESULT: PASS (周期未満の座標の一意性: %s 件)' % checked)

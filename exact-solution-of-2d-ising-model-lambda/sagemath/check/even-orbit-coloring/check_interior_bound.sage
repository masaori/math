# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 非末端の後続座標の範囲
# 式・所属: 0 <= r + 1 < p
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if r + 1 < p:
        assert 0 <= r + 1 < p, (sigma, i, m, p, r)
        checked += 1
assert checked == 1030, checked
print('RESULT: PASS (非末端の後続座標の範囲: %s 件)' % checked)

# 対象ラベル: claim_even_orbit_minimum_color
# 本文の行: 最小元の零回反復
# 式・所属: iterate(sigma, 0, min(orbit(sigma, m))) == min(orbit(sigma, m))
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    t = coordinate(sigma, sigma[i])
    if True:
        assert iterate(sigma, 0, min(orbit(sigma, m))) == min(orbit(sigma, m)), (sigma, i, m, p, r)
        checked += 1
assert checked == 1388, checked
print('RESULT: PASS (最小元の零回反復: %s 件)' % checked)

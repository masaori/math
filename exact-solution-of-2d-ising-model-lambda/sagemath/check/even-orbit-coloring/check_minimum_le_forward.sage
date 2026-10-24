# 対象ラベル: claim_even_orbit_minimum_color
# 本文の行: 軌道内の最小元の第一不等式
# 式・所属: min(orbit(sigma, j)) <= m
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    t = coordinate(sigma, sigma[i])
    for j in orbit(sigma, i):
        assert min(orbit(sigma, j)) <= m, (sigma, i, m, p, r)
        checked += 1
assert checked == 6424, checked
print('RESULT: PASS (軌道内の最小元の第一不等式: %s 件)' % checked)

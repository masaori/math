# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 軌道内の任意の始点への変更
# 式・所属: orbit(sigma, j) == orbit(sigma, i)
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    t = coordinate(sigma, sigma[i])
    for j in orbit(sigma, i):
        assert orbit(sigma, j) == orbit(sigma, i), (sigma, i, m, p, r)
        checked += 1
assert checked == 6424, checked
print('RESULT: PASS (軌道内の任意の始点への変更: %s 件)' % checked)

# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 最小元からの周期の不変性
# 式・所属: period(sigma, min(orbit(sigma, sigma[i]))) == p
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if True:
        assert period(sigma, min(orbit(sigma, sigma[i]))) == p, (sigma, i, m, p, r)
        checked += 1
assert checked == 1388, checked
print('RESULT: PASS (最小元からの周期の不変性: %s 件)' % checked)

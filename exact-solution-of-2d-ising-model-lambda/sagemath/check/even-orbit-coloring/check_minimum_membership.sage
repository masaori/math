# 対象ラベル: claim_even_orbit_minimum_color
# 本文の行: 最小元は二色付け集合に属する
# 式・所属: m in coloring
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if True:
        assert m in coloring, (sigma, i, m, p, r)
        checked += 1
assert checked == 1388, checked
print('RESULT: PASS (最小元は二色付け集合に属する: %s 件)' % checked)

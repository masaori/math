# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 一周期後の帰還
# 式・所属: iterate(sigma, p, m) == m
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if r + 1 == p:
        assert iterate(sigma, p, m) == m, (sigma, i, m, p, r)
        checked += 1
assert checked == 358, checked
print('RESULT: PASS (一周期後の帰還: %s 件)' % checked)

# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 零回反復の表示
# 式・所属: m == iterate(sigma, 0, m)
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    if r + 1 == p:
        assert m == iterate(sigma, 0, m), (sigma, i, m, p, r)
        checked += 1
assert checked == 358, checked
print('RESULT: PASS (零回反復の表示: %s 件)' % checked)

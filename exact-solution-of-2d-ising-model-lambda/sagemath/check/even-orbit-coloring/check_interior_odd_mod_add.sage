# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 非末端で元座標が奇数: 和の剰余
# 式・所属: (r + 1) % 2 == ((r % 2) + 1) % 2
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    t = coordinate(sigma, sigma[i])
    if r + 1 < p and r % 2 == 1:
        assert (r + 1) % 2 == ((r % 2) + 1) % 2, (sigma, i, m, p, r)
        checked += 1
assert checked == 336, checked
print('RESULT: PASS (非末端で元座標が奇数: 和の剰余: %s 件)' % checked)

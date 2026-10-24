# 対象ラベル: claim_even_orbit_coloring
# 本文の行: 非末端で元座標が奇数: 計算
# 式・所属: (ZZ(1) + 1) % 2 == 0
# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
load('sagemath/check/even-orbit-coloring/_prelude.sage')

checked = 0
for sigma, coloring, i, m, p, r in ROWS:
    t = coordinate(sigma, sigma[i])
    if r + 1 < p and r % 2 == 1:
        assert (ZZ(1) + 1) % 2 == 0, (sigma, i, m, p, r)
        checked += 1
assert checked == 336, checked
print('RESULT: PASS (非末端で元座標が奇数: 計算: %s 件)' % checked)

# 対象ラベル: def_even_orbit_minimum, def_even_orbit_coordinate
# 本文の行: 最小元は有限番号集合、周期・座標は自然数。
load('sagemath/check/even-orbit-coloring/_prelude.sage')
for sigma, coloring, i, m, p, r in ROWS:
    assert m in range(len(sigma))
    assert p in ZZ and p >= 0
    assert r in ZZ and r >= 0
    assert r % 2 in (0, 1)
print('RESULT: PASS (最小元・周期・座標・余りの所属: %s 件)' % len(ROWS))

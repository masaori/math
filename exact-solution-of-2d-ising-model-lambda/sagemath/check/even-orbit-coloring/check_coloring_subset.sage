# 対象ラベル: def_even_orbit_coloring
# 本文の行: 第一色は有限番号集合の部分集合。
load('sagemath/check/even-orbit-coloring/_prelude.sage')
for sigma, coloring in CASES:
    assert coloring <= frozenset(range(len(sigma)))
print('RESULT: PASS (第一色の部分集合性: %s 件)' % len(CASES))

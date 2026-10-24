# 対象ラベル: def_even_orbit_coloring
# 本文の行: 空集合では第一色は空集合。
load('sagemath/check/even-orbit-coloring/_prelude.sage')
empty_cases = [(sigma, coloring) for sigma, coloring in CASES if not sigma]
assert empty_cases == [((), frozenset())]
print('RESULT: PASS (空集合の第一色: 1 件)')

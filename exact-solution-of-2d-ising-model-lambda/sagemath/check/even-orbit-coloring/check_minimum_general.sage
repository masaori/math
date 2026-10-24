# 対象ラベル: claim_even_orbit_minimum_color
# 最小元の第一色への所属は、偶数長条件なしで全置換を検査する。
load('sagemath/check/even-orbit-coloring/_prelude.sage')
permutation_count = 0
point_count = 0
for size in range(7):
    for sigma in permutations(range(size)):
        permutation_count += 1
        coloring = frozenset(i for i in range(size) if coordinate(sigma, i) % 2 == 0)
        for i in range(size):
            m = min(orbit(sigma, i))
            assert m in coloring, (sigma, i, m)
            point_count += 1
assert permutation_count == 874
assert point_count == 5039
print('RESULT: PASS (偶数長条件なしの最小元所属: 874 置換・5039 元)')

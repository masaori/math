# 対象ラベル: claim_repeated_adjacent_sum_difference
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 末項の添字を前周期と最後の位置へ分ける
for u, c in repeated_cases():
    n = len(u)
    k = c - 1
    ub = lambda j: extend(u, j)
    r = lambda j: ub(j % n)
    joined = lambda j: r(j) if j < c*n else r(j-c*n)
    A = internal(c*n, r)
    assert r(c*n-1) == r((c-1)*n+(n-1)), (u, c)
    count += 1
print('last_index: PASS (' + str(count) + ' configurations)')

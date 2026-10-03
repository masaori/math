# 対象ラベル: claim_repeated_adjacent_sum_difference
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 後半の添字へ周期分を加える
for u, c in repeated_cases():
    n = len(u)
    k = c - 1
    ub = lambda j: extend(u, j)
    r = lambda j: ub(j % n)
    joined = lambda j: r(j) if j < c*n else r(j-c*n)
    A = internal(c*n, r)
    assert all(r(j-c*n) == r(c*n+(j-c*n)) for j in range(c*n,(c+2)*n+1)), (u, c)
    count += 1
print('join_period: PASS (' + str(count) + ' configurations)')

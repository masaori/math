# 対象ラベル: claim_repeated_adjacent_sum_difference
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 余りの式を反復列へ戻す
for u, c in repeated_cases():
    n = len(u)
    k = c - 1
    ub = lambda j: extend(u, j)
    r = lambda j: ub(j % n)
    joined = lambda j: r(j) if j < c*n else r(j-c*n)
    A = internal(c*n, r)
    assert all(ub(j % n) == r(j) for j in range(2*n+2)), (u, c)
    count += 1
print('period_fold: PASS (' + str(count) + ' configurations)')

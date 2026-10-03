# 対象ラベル: claim_repeated_adjacent_sum_difference
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 一周期の隣接項を元の列へ置換
for u, c in repeated_cases():
    n = len(u)
    k = c - 1
    ub = lambda j: extend(u, j)
    r = lambda j: ub(j % n)
    joined = lambda j: r(j) if j < c*n else r(j-c*n)
    A = internal(c*n, r)
    assert sum((theta(r(j),r(j+1)) for j in range(n-1)),ZZ(0)) == sum((theta(ub(j),ub(j+1)) for j in range(n-1)),ZZ(0)), (u, c)
    count += 1
print('base_substitute: PASS (' + str(count) + ' configurations)')

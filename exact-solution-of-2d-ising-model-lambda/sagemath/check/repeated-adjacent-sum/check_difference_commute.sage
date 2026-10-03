# 対象ラベル: claim_repeated_adjacent_sum_difference
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 加法の交換律で一周期の内部和を前へ移す
for u, c in repeated_cases():
    n = len(u)
    k = c - 1
    ub = lambda j: extend(u, j)
    r = lambda j: ub(j % n)
    joined = lambda j: r(j) if j < c*n else r(j-c*n)
    A = internal(c*n, r)
    assert theta(ub(n-1),ub(0))+internal(n,ub) == internal(n,ub)+theta(ub(n-1),ub(0)), (u, c)
    count += 1
print('difference_commute: PASS (' + str(count) + ' configurations)')

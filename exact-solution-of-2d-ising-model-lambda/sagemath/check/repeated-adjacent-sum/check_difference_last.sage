# 対象ラベル: claim_repeated_adjacent_sum_difference
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 接合の末項を置換
for u, c in repeated_cases():
    n = len(u)
    k = c - 1
    ub = lambda j: extend(u, j)
    r = lambda j: ub(j % n)
    joined = lambda j: r(j) if j < c*n else r(j-c*n)
    A = internal(c*n, r)
    assert (A+theta(r(c*n-1),r(0))+internal(n,r))-A == (A+theta(ub(n-1),r(0))+internal(n,r))-A, (u, c)
    count += 1
print('difference_last: PASS (' + str(count) + ' configurations)')

# 対象ラベル: claim_repeated_adjacent_sum_difference
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 追加した一周期を長さの和へ書き換える
for u, c in repeated_cases():
    n = len(u)
    k = c - 1
    ub = lambda j: extend(u, j)
    r = lambda j: ub(j % n)
    joined = lambda j: r(j) if j < c*n else r(j-c*n)
    A = internal(c*n, r)
    assert internal((c+1)*n,r)-A == internal(c*n+n,r)-A, (u, c)
    count += 1
print('difference_length: PASS (' + str(count) + ' configurations)')

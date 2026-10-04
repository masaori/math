# 対象ラベル: claim_one_sided_parallel_return_repetition
# n=b+1 の代入
import os
import sys
if 'return_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for n, c, i, a, b, A, B, G, P, v in return_rows('seam'):
    lhs = -(G[n]-G[b])
    rhs = -(G[b+1]-G[b])
    assert lhs == rhs, (n, c, i, a, b, A, B, lhs, rhs)
    count += 1
print('check_seam_last_index: PASS (' + str(count) + ' cases)')

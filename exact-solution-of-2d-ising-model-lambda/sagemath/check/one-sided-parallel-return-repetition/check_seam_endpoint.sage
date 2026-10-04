# 対象ラベル: claim_one_sided_parallel_return_repetition
# 階段の終点は周期ベクトル
import os
import sys
if 'return_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for n, c, i, a, b, A, B, G, P, v in return_rows('seam'):
    lhs = -(B-G[b])
    rhs = -(G[n]-G[b])
    assert lhs == rhs, (n, c, i, a, b, A, B, lhs, rhs)
    count += 1
print('check_seam_endpoint: PASS (' + str(count) + ' cases)')

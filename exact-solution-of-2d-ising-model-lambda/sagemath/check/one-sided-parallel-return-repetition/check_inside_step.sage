# 対象ラベル: claim_one_sided_parallel_return_repetition
# 符号反転歩の定義
import os
import sys
if 'return_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for n, c, i, a, b, A, B, G, P, v in return_rows('inside'):
    lhs = -(G[b+1]-G[b])
    rhs = v[b]
    assert lhs == rhs, (n, c, i, a, b, A, B, lhs, rhs)
    count += 1
print('check_inside_step: PASS (' + str(count) + ' cases)')

# 対象ラベル: claim_one_sided_parallel_return_repetition
# 共通の加数を消す
import os
import sys
if 'return_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for n, c, i, a, b, A, B, G, P, v in return_rows('inside'):
    lhs = (A+(c-a)*B-G[b+1])-(A+(c-a)*B-G[b])
    rhs = -G[b+1]+G[b]
    assert lhs == rhs, (n, c, i, a, b, A, B, lhs, rhs)
    count += 1
print('check_inside_cancel: PASS (' + str(count) + ' cases)')

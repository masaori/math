# 対象ラベル: claim_one_sided_parallel_return_repetition
# 有限の歩ベクトル列は c 回の連結
import os
import sys
if 'return_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for n, c, i, a, b, A, B, G, P, v in return_rows('word'):
    lhs = [P[j+1]-P[j] for j in range(c*n)]
    rhs = v * c
    assert lhs == rhs, (n, c, i, a, b, A, B, lhs, rhs)
    count += 1
print('check_repetition: PASS (' + str(count) + ' cases)')

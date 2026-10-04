# 対象ラベル: claim_one_sided_parallel_return_repetition
# 第三部分の点を展開
import os
import sys
if 'return_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for n, c, i, a, b, A, B, G, P, v in return_rows('seam'):
    lhs = P[i+1]-P[i]
    rhs = (A+(c-(a+1))*B-G[0])-(A+(c-a)*B-G[b])
    assert lhs == rhs, (n, c, i, a, b, A, B, lhs, rhs)
    count += 1
print('check_seam_expand: PASS (' + str(count) + ' cases)')

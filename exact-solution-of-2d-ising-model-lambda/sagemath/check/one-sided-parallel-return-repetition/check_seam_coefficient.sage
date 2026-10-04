# 対象ラベル: claim_one_sided_parallel_return_repetition
# 係数は負の一
import os
import sys
if 'return_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for n, c, i, a, b, A, B, G, P, v in return_rows('seam'):
    lhs = ((c-(a+1))-(c-a))*B+G[b]
    rhs = -B+G[b]
    assert lhs == rhs, (n, c, i, a, b, A, B, lhs, rhs)
    count += 1
print('check_seam_coefficient: PASS (' + str(count) + ' cases)')

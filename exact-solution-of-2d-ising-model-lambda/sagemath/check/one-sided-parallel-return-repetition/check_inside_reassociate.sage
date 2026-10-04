# 対象ラベル: claim_one_sided_parallel_return_repetition
# (an+b)+1=an+(b+1)
import os
import sys
if 'return_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for n, c, i, a, b, A, B, G, P, v in return_rows('inside'):
    lhs = (a*n+b)+1
    rhs = a*n+(b+1)
    assert lhs == rhs, (n, c, i, a, b, A, B, lhs, rhs)
    count += 1
print('check_inside_reassociate: PASS (' + str(count) + ' cases)')

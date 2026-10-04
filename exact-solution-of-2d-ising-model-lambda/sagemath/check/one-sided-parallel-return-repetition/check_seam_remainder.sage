# 対象ラベル: claim_one_sided_parallel_return_repetition
# 余りは零
import os
import sys
if 'return_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for n, c, i, a, b, A, B, G, P, v in return_rows('seam'):
    lhs = (i+1)%n
    rhs = ZZ(0)
    assert lhs == rhs, (n, c, i, a, b, A, B, lhs, rhs)
    count += 1
print('check_seam_remainder: PASS (' + str(count) + ' cases)')

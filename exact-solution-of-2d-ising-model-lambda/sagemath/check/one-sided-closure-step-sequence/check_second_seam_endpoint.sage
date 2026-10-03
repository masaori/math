# 対象ラベル: claim_one_sided_closure_step_sequence
# 二番目の接合点の一致
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('second_seam'):
    lhs = R[0]-Q[b-1]
    rhs = Q[b]-Q[b-1]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('second_seam_endpoint: PASS (' + str(count) + ' cases)')

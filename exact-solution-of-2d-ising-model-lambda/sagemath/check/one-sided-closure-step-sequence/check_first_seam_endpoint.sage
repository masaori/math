# 対象ラベル: claim_one_sided_closure_step_sequence
# 最初の接合点の一致
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('first_seam'):
    lhs = Q[0]-P[a-1]
    rhs = P[a]-P[a-1]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('first_seam_endpoint: PASS (' + str(count) + ' cases)')

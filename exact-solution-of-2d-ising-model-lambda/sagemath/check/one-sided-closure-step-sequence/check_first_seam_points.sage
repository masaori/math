# 対象ラベル: claim_one_sided_closure_step_sequence
# 第一の接合点で点列を展開
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('first_seam'):
    lhs = F(a)-F(a-1)
    rhs = Q[0]-P[a-1]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('first_seam_points: PASS (' + str(count) + ' cases)')

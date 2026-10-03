# 対象ラベル: claim_one_sided_closure_step_sequence
# 第二の接合点で点列を展開
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('second_seam'):
    lhs = F(a+b)-F(a+b-1)
    rhs = R[0]-Q[b-1]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('second_seam_points: PASS (' + str(count) + ' cases)')

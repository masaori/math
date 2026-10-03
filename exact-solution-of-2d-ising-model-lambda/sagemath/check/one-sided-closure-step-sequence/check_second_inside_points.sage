# 対象ラベル: claim_one_sided_closure_step_sequence
# 第二の区間内部で点列を展開
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('second_inside'):
    lhs = F(a+k+1)-F(a+k)
    rhs = Q[k+1]-Q[k]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('second_inside_points: PASS (' + str(count) + ' cases)')

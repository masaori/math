# 対象ラベル: claim_one_sided_closure_step_sequence
# 第一の連結成分
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('first_inside'):
    lhs = u[j]
    rhs = z[j]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('first_inside_join: PASS (' + str(count) + ' cases)')

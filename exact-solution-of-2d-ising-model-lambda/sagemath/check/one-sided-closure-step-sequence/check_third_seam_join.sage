# 対象ラベル: claim_one_sided_closure_step_sequence
# 第三の末歩の連結
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('third_seam'):
    lhs = w[c-1]
    rhs = z[a+b+c-1]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('third_seam_join: PASS (' + str(count) + ' cases)')

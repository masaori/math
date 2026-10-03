# 対象ラベル: claim_one_sided_closure_step_sequence
# 第二の歩ベクトルの定義
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('second_inside'):
    lhs = Q[k+1]-Q[k]
    rhs = v[k]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('second_inside_step: PASS (' + str(count) + ' cases)')

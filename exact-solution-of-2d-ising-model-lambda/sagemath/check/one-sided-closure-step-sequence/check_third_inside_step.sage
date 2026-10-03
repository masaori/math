# 対象ラベル: claim_one_sided_closure_step_sequence
# 第三の歩ベクトルの定義
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('third_inside'):
    lhs = R[k+1]-R[k]
    rhs = w[k]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('third_inside_step: PASS (' + str(count) + ' cases)')

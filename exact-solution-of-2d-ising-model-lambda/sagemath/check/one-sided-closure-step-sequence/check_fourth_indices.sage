# 対象ラベル: claim_one_sided_closure_step_sequence
# 逆向きの添字を計算
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for a, b, c, N, P, Q, R, S, F, u, v, w, x, z, j, k in rows('fourth'):
    lhs = S[N-(j+1)]-S[N-j]
    rhs = S[b-(k+1)]-S[b-k]
    assert lhs == rhs, (a, b, c, j, lhs, rhs)
    count += 1
print('fourth_indices: PASS (' + str(count) + ' cases)')

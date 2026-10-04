# 対象ラベル: claim_one_sided_periodic_lift_repetition
# 一周期の歩の定義
import os
import sys
if 'lift_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for m, B, P, k0, c, u, i, a, b in step_rows():
    lhs = P(k0+b+1)-P(k0+b)
    rhs = u[b]
    assert lhs == rhs, (m, lhs, rhs)
    count += 1
print('check_step_word: PASS (' + str(count) + ' cases)')

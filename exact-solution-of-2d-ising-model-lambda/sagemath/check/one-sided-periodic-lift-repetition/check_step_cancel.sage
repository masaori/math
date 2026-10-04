# 対象ラベル: claim_one_sided_periodic_lift_repetition
# 共通の並進の消去
import os
import sys
if 'lift_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for m, B, P, k0, c, u, i, a, b in step_rows():
    lhs = (P(k0+b+1)+a*B)-(P(k0+b)+a*B)
    rhs = P(k0+b+1)-P(k0+b)
    assert lhs == rhs, (m, lhs, rhs)
    count += 1
print('check_step_cancel: PASS (' + str(count) + ' cases)')

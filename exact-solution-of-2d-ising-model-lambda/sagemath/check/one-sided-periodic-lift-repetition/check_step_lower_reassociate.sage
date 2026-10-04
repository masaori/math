# 対象ラベル: claim_one_sided_periodic_lift_repetition
# 始点添字の加法の整理
import os
import sys
if 'lift_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for m, B, P, k0, c, u, i, a, b in step_rows():
    lhs = k0+(a*m+b)
    rhs = (k0+b)+a*m
    assert lhs == rhs, (m, lhs, rhs)
    count += 1
print('check_step_lower_reassociate: PASS (' + str(count) + ' cases)')

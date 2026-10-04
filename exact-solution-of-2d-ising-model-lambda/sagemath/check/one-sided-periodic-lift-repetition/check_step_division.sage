# 対象ラベル: claim_one_sided_periodic_lift_repetition
# 歩の添字の整数除法
import os
import sys
if 'lift_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for m, B, P, k0, c, u, i, a, b in step_rows():
    lhs = i
    rhs = a*m+b
    assert lhs == rhs, (m, lhs, rhs)
    count += 1
print('check_step_division: PASS (' + str(count) + ' cases)')

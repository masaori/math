# 対象ラベル: claim_one_sided_periodic_lift_repetition
# 終点添字への代入
import os
import sys
if 'lift_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for m, B, P, k0, c, u, i, a, b in step_rows():
    lhs = k0+i+1
    rhs = k0+(a*m+b)+1
    assert lhs == rhs, (m, lhs, rhs)
    count += 1
print('check_step_upper_substitute: PASS (' + str(count) + ' cases)')

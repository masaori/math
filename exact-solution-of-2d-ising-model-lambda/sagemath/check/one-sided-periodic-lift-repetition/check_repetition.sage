# 対象ラベル: claim_one_sided_periodic_lift_repetition
# 有限列全体の反復
import os
import sys
if 'lift_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for m, B, P, k0, c, u in repetition_rows():
    lhs = [P(k0+i+1)-P(k0+i) for i in range(c*m)]
    rhs = u*c
    assert lhs == rhs, (m, lhs, rhs)
    count += 1
print('check_repetition: PASS (' + str(count) + ' cases)')

# 対象ラベル: claim_one_sided_periodic_lift_repetition
# 整数の環の法則
import os
import sys
if 'lift_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for m, points, B, P, j, q, r, a in translation_rows():
    lhs = (q*m+r)+a*m
    rhs = (q+a)*m+r
    assert lhs == rhs, (m, lhs, rhs)
    count += 1
print('check_translation_regroup: PASS (' + str(count) + ' cases)')

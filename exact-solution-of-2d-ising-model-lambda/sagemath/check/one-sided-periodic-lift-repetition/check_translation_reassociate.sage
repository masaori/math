# 対象ラベル: claim_one_sided_periodic_lift_repetition
# 加法の結合則
import os
import sys
if 'lift_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for m, points, B, P, j, q, r, a in translation_rows():
    lhs = points[r]+(q*B+a*B)
    rhs = (points[r]+q*B)+a*B
    assert lhs == rhs, (m, lhs, rhs)
    count += 1
print('check_translation_reassociate: PASS (' + str(count) + ' cases)')

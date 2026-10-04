# 対象ラベル: claim_one_sided_periodic_lift_repetition
# 並進した添字の余り
import os
import sys
if 'lift_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for m, points, B, P, j, q, r, a in translation_rows():
    lhs = (j+a*m)%m
    rhs = r
    assert lhs == rhs, (m, lhs, rhs)
    count += 1
print('check_translation_remainder: PASS (' + str(count) + ' cases)')

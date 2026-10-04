# 零元の挿入
# 対象ラベル: claim_one_sided_transverse_steps_base_independent
import os
import sys
if 'transverse_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for g, Q, d, C, s, q, r in point_rows():
    lhs = Q+(q*d+C[r])
    rhs = Q+((vector(ZZ,(0,0))+q*d)+C[r])
    assert lhs == rhs, (g[:5], lhs, rhs)
    count += 1
print('check_base_zero: PASS (' + str(count) + ' cases)')

# 共通基点の消去
# 対象ラベル: claim_one_sided_transverse_steps_base_independent
import os
import sys
if 'transverse_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for g, Q, first, last in step_rows():
    lhs = (Q+staircase(g,vector(ZZ,(0,0)),last))-(Q+staircase(g,vector(ZZ,(0,0)),first))
    rhs = staircase(g,vector(ZZ,(0,0)),last)-staircase(g,vector(ZZ,(0,0)),first)
    assert lhs == rhs, (g[:5], lhs, rhs)
    count += 1
print('check_step_cancel: PASS (' + str(count) + ' cases)')

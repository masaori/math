# 第二部分を原点基準の順向き列へ同定
# 対象ラベル: claim_one_sided_transverse_steps_base_independent
import os
import sys
if 'transverse_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for g, S, B, c, b, i, upper, lower in closure_rows():
    lhs = staircase(g,S+c*B,i+1)-staircase(g,S+c*B,i)
    rhs = staircase(g,vector(ZZ,(0,0)),i+1)-staircase(g,vector(ZZ,(0,0)),i)
    assert lhs == rhs, (g[:5], lhs, rhs)
    count += 1
print('check_upper_origin: PASS (' + str(count) + ' cases)')

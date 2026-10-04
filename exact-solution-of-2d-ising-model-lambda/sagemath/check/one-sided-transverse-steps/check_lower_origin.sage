# 第四部分を原点基準の逆向き列へ同定
# 対象ラベル: claim_one_sided_transverse_steps_base_independent
import os
import sys
if 'transverse_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for g, S, B, c, b, i, upper, lower in closure_rows():
    lhs = staircase(g,S,b-(i+1))-staircase(g,S,b-i)
    rhs = staircase(g,vector(ZZ,(0,0)),b-(i+1))-staircase(g,vector(ZZ,(0,0)),b-i)
    assert lhs == rhs, (g[:5], lhs, rhs)
    count += 1
print('check_lower_origin: PASS (' + str(count) + ' cases)')

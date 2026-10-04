# 一側閉包の第二部分の歩
# 対象ラベル: claim_one_sided_transverse_steps_base_independent
import os
import sys
if 'transverse_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for g, S, B, c, b, i, upper, lower in closure_rows():
    lhs = upper[i+1]-upper[i]
    rhs = staircase(g,S+c*B,i+1)-staircase(g,S+c*B,i)
    assert lhs == rhs, (g[:5], lhs, rhs)
    count += 1
print('check_upper_definition: PASS (' + str(count) + ' cases)')

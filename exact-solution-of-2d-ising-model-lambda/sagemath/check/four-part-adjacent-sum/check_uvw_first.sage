# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 三部分の先頭を二部分の先頭へ置換
for u, v, w, x in four_cases():
    a, b, c, d = map(len, (u, v, w, x))
    uv = u + v
    uvw = uv + w
    z = uvw + x
    lhs = uvw[0]
    rhs = uv[0]
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('uvw_first: PASS (' + str(count) + ' cases)')

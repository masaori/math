# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 二部分の先頭を最初の列の先頭へ置換
for u, v, w, x in four_cases():
    a, b, c, d = map(len, (u, v, w, x))
    uv = u + v
    uvw = uv + w
    z = uvw + x
    lhs = uv[0]
    rhs = u[0]
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('uv_first: PASS (' + str(count) + ' cases)')

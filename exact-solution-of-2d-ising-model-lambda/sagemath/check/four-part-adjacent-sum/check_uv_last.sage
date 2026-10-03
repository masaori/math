# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 二部分の末項
for u, v, w, x in four_cases():
    a, b, c, d = map(len, (u, v, w, x))
    uv = u + v
    uvw = uv + w
    z = uvw + x
    lhs = uv[a + b - 1]
    rhs = v[b - 1]
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('uv_last: PASS (' + str(count) + ' cases)')

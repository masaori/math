# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 三部分の末項
for u, v, w, x in four_cases():
    a, b, c, d = map(len, (u, v, w, x))
    uv = u + v
    uvw = uv + w
    z = uvw + x
    lhs = uvw[a + b + c - 1]
    rhs = w[c - 1]
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('uvw_last: PASS (' + str(count) + ' cases)')

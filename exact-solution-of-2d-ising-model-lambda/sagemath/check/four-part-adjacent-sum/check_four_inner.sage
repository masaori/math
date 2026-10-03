# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 内側の二列分割
for u, v, w, x in four_cases():
    a, b, c, d = map(len, (u, v, w, x))
    uv = u + v
    uvw = uv + w
    z = uvw + x
    lhs = (internal(uv) + theta(uv[a + b - 1], w[0]) + internal(w)) + theta(uvw[a + b + c - 1], x[0]) + internal(x)
    rhs = ((internal(u) + theta(u[a - 1], v[0]) + internal(v)) + theta(uv[a + b - 1], w[0]) + internal(w)) + theta(uvw[a + b + c - 1], x[0]) + internal(x)
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('four_inner: PASS (' + str(count) + ' cases)')

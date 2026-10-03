# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 内部和の分割結果を代入
for u, v, w, x in four_cases():
    a, b, c, d = map(len, (u, v, w, x))
    uv = u + v
    uvw = uv + w
    z = uvw + x
    S = internal(u) + theta(u[a - 1], v[0]) + internal(v) + theta(v[b - 1], w[0]) + internal(w) + theta(w[c - 1], x[0]) + internal(x)
    lhs = internal(z) + theta(z[a + b + c + d - 1], z[0])
    rhs = S + theta(z[a + b + c + d - 1], z[0])
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('cyclic_internal: PASS (' + str(count) + ' cases)')

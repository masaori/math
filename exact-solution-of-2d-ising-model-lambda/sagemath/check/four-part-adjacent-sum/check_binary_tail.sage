# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 分割後の後半だけを置換
for u, v in binary_cases():
    a, b = len(u), len(v)
    y = u + v
    lhs = (internal(u) + theta(u[a - 1], v[0])) + sum((theta(y[a + j], y[a + j + 1]) for j in range(b - 1)), ZZ(0))
    rhs = internal(u) + theta(u[a - 1], v[0]) + internal(v)
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('binary_tail: PASS (' + str(count) + ' cases)')

# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 連結の内部和を前半・境界・後半へ分割
for u, v in binary_cases():
    a, b = len(u), len(v)
    y = u + v
    lhs = sum((theta(y[j], y[j + 1]) for j in range(a + b - 1)), ZZ(0))
    rhs = (sum((theta(y[j], y[j + 1]) for j in range(a - 1)), ZZ(0)) + theta(y[a - 1], y[a])) + sum((theta(y[a + j], y[a + j + 1]) for j in range(b - 1)), ZZ(0))
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('binary_partition: PASS (' + str(count) + ' cases)')

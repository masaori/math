# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 前半の有限和を内部和の記号へ戻す
for u, v in binary_cases():
    a, b = len(u), len(v)
    y = u + v
    lhs = sum((theta(u[j], u[j + 1]) for j in range(a - 1)), ZZ(0))
    rhs = internal(u)
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('prefix_internal: PASS (' + str(count) + ' cases)')

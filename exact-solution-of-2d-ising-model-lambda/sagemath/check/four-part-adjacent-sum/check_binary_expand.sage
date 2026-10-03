# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 連結の内部和を有限和へ展開
for u, v in binary_cases():
    a, b = len(u), len(v)
    y = u + v
    lhs = internal(y)
    rhs = sum((theta(y[j], y[j + 1]) for j in range(a + b - 1)), ZZ(0))
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('binary_expand: PASS (' + str(count) + ' cases)')

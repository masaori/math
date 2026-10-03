# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 有限和を前半と添字を移した後半へ分割
for a, b, k in product(range(1, 9), range(1, 9), range(5)):
    f = lambda j: ZZ(j) ** (k + 1) - ZZ(3) * j + ZZ(k - 2)
    lhs = sum((f(j) for j in range(a + b - 1)), ZZ(0))
    rhs = sum((f(j) for j in range(a)), ZZ(0)) + sum((f(a + j) for j in range(b - 1)), ZZ(0))
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('interval_split: PASS (' + str(count) + ' cases)')

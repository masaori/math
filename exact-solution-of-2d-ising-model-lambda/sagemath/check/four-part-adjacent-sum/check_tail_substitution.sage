# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 後半の隣接対を元の列へ置換
for u, v in binary_cases():
    a, b = len(u), len(v)
    y = u + v
    lhs = sum((theta(y[a + j], y[a + j + 1]) for j in range(b - 1)), ZZ(0))
    rhs = sum((theta(v[j], v[j + 1]) for j in range(b - 1)), ZZ(0))
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('tail_substitution: PASS (' + str(count) + ' cases)')

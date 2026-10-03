# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
# 境界の一項を末項と先頭へ置換
for u, v in binary_cases():
    a, b = len(u), len(v)
    y = u + v
    lhs = theta(y[a - 1], y[a])
    rhs = theta(u[a - 1], v[0])
    assert lhs == rhs, (lhs, rhs)
    count += 1
print('boundary_substitution: PASS (' + str(count) + ' cases)')

# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 両端点を剰余類へ射影すると一致する。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    assert tuple((-coordinate) % length for coordinate in points[n]) == tuple((-coordinate) % length for coordinate in points[0])
    checked += 1
print(f'RESULT: PASS ({checked} cases, projection_closed)')

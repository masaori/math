# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 一方向の全歩を同じ歩で置換。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    if p == 0 or q == 0:
        d = steps[0]
        assert cyclic_turning(steps) == sum((quarter_turn(d, d) for s in range(n - 1)), ZZ(0)) + quarter_turn(d, d)
        checked += 1
print(f'RESULT: PASS ({checked} cases, one_direction_constant)')

# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 内部の同方向の零項を除く。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    if p > 0 and q > 0:
        assert cyclic_turning(steps) == quarter_turn(vector_scale(-1, a), vector_scale(-1, b)) + quarter_turn(steps[-1], steps[0])
        checked += 1
print(f'RESULT: PASS ({checked} cases, two_direction_internal)')

# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 符号反転後も四つの単位歩の一つである。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    for v in steps:
        assert v in unit_directions()
        checked += 1
print(f'RESULT: PASS ({checked} cases, unit_steps)')

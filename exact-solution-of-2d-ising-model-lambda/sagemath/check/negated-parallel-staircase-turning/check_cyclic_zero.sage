# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 方向番号から循環総回転数零を直接確認。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    assert cyclic_turning(steps) == 0
    checked += 1
print(f'RESULT: PASS ({checked} cases, cyclic_zero)')

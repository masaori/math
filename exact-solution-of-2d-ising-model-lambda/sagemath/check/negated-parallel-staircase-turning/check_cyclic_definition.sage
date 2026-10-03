# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 循環総回転数を内部の回転数と閉じる回転数へ分割。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    assert cyclic_turning(steps) == sum((step_turning(steps[s], steps[s + 1]) for s in range(n - 1)), ZZ(0)) + step_turning(steps[-1], steps[0])
    checked += 1
print(f'RESULT: PASS ({checked} cases, cyclic_definition)')

# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 二方向の場合は逆順の歩列と異なることを確認。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    if p > 0 and q > 0:
        assert steps != reversed_steps(length, horizontal, vertical)
        checked += 1
print(f'RESULT: PASS ({checked} cases, order_distinction)')

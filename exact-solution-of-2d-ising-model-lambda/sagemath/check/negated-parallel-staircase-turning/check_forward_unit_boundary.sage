# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 整数係数の差を計算（boundary）。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    for s in range(n):
        if s == p:
            assert forward_reduction(p, a, b, s) == (a if s < p else b)
            checked += 1
print(f'RESULT: PASS ({checked} cases, forward_unit_boundary)')

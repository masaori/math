# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 同じ添字順の符号反転歩を二区間へ同定（last）。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    for s in range(n):
        if s >= p:
            assert vector_scale(-1, vector_subtract(points[s + 1], points[s])) == vector_scale(-1, b)
            checked += 1
print(f'RESULT: PASS ({checked} cases, negated_block_last)')

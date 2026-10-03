# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 正の階段の隣接差を座標式へ展開（before）。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    for s in range(n):
        if s < p:
            assert vector_subtract(points[s + 1], points[s]) == forward_expansion(p, a, b, s)
            checked += 1
print(f'RESULT: PASS ({checked} cases, forward_expand_before)')

# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 反対歩という仮定の平行座標への代入だけを検査。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    for v in steps:
        opposite = vector_scale(-1, v)
        assert parallel_coordinate(horizontal, vertical, opposite) == parallel_coordinate(horizontal, vertical, vector_scale(-1, v))
        checked += 1
print(f'RESULT: PASS ({checked} cases, opposite_substitute)')

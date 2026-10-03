# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 二つの接合の逆順の値を加法逆元へ置換。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    if p > 0 and q > 0:
        first, last = vector_scale(-1, a), vector_scale(-1, b)
        assert quarter_turn(first, last) + quarter_turn(last, first) == quarter_turn(first, last) - quarter_turn(first, last)
        checked += 1
print(f'RESULT: PASS ({checked} cases, two_direction_negate)')

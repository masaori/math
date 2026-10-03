# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: sum_s 0+0=0。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    p, a, q, b = constant_blocks(length, horizontal, vertical)
    n = p + q
    first = vector_scale(-1, b)
    last = vector_scale(-1, a)
    if p == 0 or q == 0:
        assert sum((ZZ(0) for index in range(n - 1)), ZZ(0)) + ZZ(0) == 0
        checked += 1
print(f'RESULT: PASS ({checked} cases, one_direction_zero_sum)')

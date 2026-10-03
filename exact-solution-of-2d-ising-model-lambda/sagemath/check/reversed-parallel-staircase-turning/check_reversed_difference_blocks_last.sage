# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: 反転した場合分け=b (index >= p)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    p, a, q, b = constant_blocks(length, horizontal, vertical)
    n = p + q
    first = vector_scale(-1, b)
    last = vector_scale(-1, a)
    for index in range(n):
        if index >= p:
            left = vector_scale(-1, first) if n - 1 - index < q else vector_scale(-1, last)
            assert left == b
            checked += 1
print(f'RESULT: PASS ({checked} cases, reversed_difference_blocks_last)')

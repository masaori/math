# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: 共通項を消した式=B (index < q)。帰属: ZZ。
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
        if index < q:
            assert vector_scale((index + 1) - index, first) == first
            checked += 1
print(f'RESULT: PASS ({checked} cases, forward_unit_before)')

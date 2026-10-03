# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: u_s=-(G(n-s)-G(n-1-s))。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    p, a, q, b = constant_blocks(length, horizontal, vertical)
    n = p + q
    first = vector_scale(-1, b)
    last = vector_scale(-1, a)
    steps = reversed_steps(length, horizontal, vertical)
    for index in range(n):
        before = parallel_point(length, horizontal, vertical, n - 1 - index)
        after = parallel_point(length, horizontal, vertical, n - index)
        assert steps[index] == vector_scale(-1, vector_subtract(after, before))
        checked += 1
print(f'RESULT: PASS ({checked} cases, reversed_difference_negate)')

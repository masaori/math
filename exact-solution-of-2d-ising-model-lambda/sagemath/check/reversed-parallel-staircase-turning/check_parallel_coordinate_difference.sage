# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: pi(u_s)=pi(G(n-1-s))-pi(G(n-s))。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    steps = reversed_steps(length, horizontal, vertical)
    count = len(steps)
    for index, step in enumerate(steps):
        before = parallel_point(length, horizontal, vertical, count - 1 - index)
        after = parallel_point(length, horizontal, vertical, count - index)
        assert parallel_coordinate(horizontal, vertical, step) == (
            parallel_coordinate(horizontal, vertical, before)
            - parallel_coordinate(horizontal, vertical, after))
        checked += 1
print(f'RESULT: PASS ({checked} cases, parallel_coordinate_difference)')

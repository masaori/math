# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: pi(G(n-1-s))-pi(G(n-s))<0。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    count = length * (abs(horizontal) + abs(vertical))
    for index in range(count):
        before = parallel_point(length, horizontal, vertical, count - 1 - index)
        after = parallel_point(length, horizontal, vertical, count - index)
        assert (parallel_coordinate(horizontal, vertical, before)
                - parallel_coordinate(horizontal, vertical, after)) < 0
        checked += 1
print(f'RESULT: PASS ({checked} cases, parallel_coordinate_negative)')

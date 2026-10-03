# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: -pi(u_s)>0。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    for step in reversed_steps(length, horizontal, vertical):
        assert -parallel_coordinate(horizontal, vertical, step) > 0
        checked += 1
print(f'RESULT: PASS ({checked} cases, opposite_coordinate_positive)')

# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: a_col*a_row-a_row*a_col=0。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for direction in unit_directions():
    assert direction[1] * direction[0] - direction[0] * direction[1] == 0
    checked += 1
print(f'RESULT: PASS ({checked} cases, same_direction_reduction)')

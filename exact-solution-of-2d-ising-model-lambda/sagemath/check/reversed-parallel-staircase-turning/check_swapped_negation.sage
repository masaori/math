# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: a_row*b_col-a_col*b_row=-(a_col*b_row-a_row*b_col)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for left in unit_directions():
    for right in unit_directions():
        if right != (-left[0], -left[1]):
            assert left[0] * right[1] - left[1] * right[0] == -(left[1] * right[0] - left[0] * right[1])
            checked += 1
print(f'RESULT: PASS ({checked} cases, swapped_negation)')

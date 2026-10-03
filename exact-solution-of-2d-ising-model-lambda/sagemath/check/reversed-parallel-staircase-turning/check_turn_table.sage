# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: tau(u,v)=u_col*v_row-u_row*v_col (非後退単位歩対)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for left in unit_directions():
    for right in unit_directions():
        if right != (-left[0], -left[1]):
            assert step_turning(left, right) == quarter_turn(left, right)
            checked += 1
print(f'RESULT: PASS ({checked} admissible direction pairs)')

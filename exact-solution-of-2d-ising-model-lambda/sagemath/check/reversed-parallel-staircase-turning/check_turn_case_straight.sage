# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: vartheta(u,v)=0 (straight)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for left in unit_directions():
    right = left
    assert quarter_turn(left, right) == 0
    checked += 1
print(f'RESULT: PASS ({checked} cases, turn_case_straight)')

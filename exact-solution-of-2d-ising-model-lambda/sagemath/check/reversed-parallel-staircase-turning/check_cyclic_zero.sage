# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: t_circ(R)=0。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    steps = reversed_steps(length, horizontal, vertical)
    assert cyclic_turning(steps) == 0
    checked += 1
print(f'RESULT: PASS ({checked} reversed parallel staircases with zero cyclic turning)')

# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: vartheta(u_{n-1},u_0)=vartheta(b,a) (p>0, q>0)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    if horizontal != 0 and vertical != 0:
        first_count, first, last_count, last = constant_blocks(length, horizontal, vertical)
        steps = reversed_steps(length, horizontal, vertical)
        assert quarter_turn(steps[-1], steps[0]) == quarter_turn(last, first)
        checked += 1
print(f'RESULT: PASS ({checked} two-direction closing terms)')

# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: t_circ(R)=sum_{s=0}^{n-2}vartheta(u_s,u_{s+1})+vartheta(u_{n-1},u_0)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    steps = reversed_steps(length, horizontal, vertical)
    assert len(steps) == length * (abs(horizontal) + abs(vertical)) > 0
    for index, step in enumerate(steps):
        following = steps[(index + 1) % len(steps)]
        assert step in unit_directions()
        assert following != (-step[0], -step[1])
    assert cyclic_turning(steps) == internal_turning(steps) + quarter_turn(steps[-1], steps[0])
    checked += 1
print(f'RESULT: PASS ({checked} cyclic decompositions, including one-step words)')

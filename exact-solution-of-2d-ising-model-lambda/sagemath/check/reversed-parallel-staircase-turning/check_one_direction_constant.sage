# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: t_circ(R)=sum_s vartheta(d,d)+vartheta(d,d)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    p, a, q, b = constant_blocks(length, horizontal, vertical)
    n = p + q
    first = vector_scale(-1, b)
    last = vector_scale(-1, a)
    if p == 0 or q == 0:
        steps = reversed_steps(length, horizontal, vertical)
        direction = b if p == 0 else a
        assert all(step == direction for step in steps)
        assert cyclic_turning(steps) == sum((quarter_turn(direction, direction) for index in range(n - 1)), ZZ(0)) + quarter_turn(direction, direction)
        checked += 1
print(f'RESULT: PASS ({checked} cases, one_direction_constant)')

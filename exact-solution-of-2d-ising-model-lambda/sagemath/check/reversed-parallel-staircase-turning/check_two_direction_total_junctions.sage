# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: t_circ(R)=vartheta(a,b)+vartheta(b,a)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    p, a, q, b = constant_blocks(length, horizontal, vertical)
    n = p + q
    first = vector_scale(-1, b)
    last = vector_scale(-1, a)
    if p > 0 and q > 0:
        assert cyclic_turning(reversed_steps(length, horizontal, vertical)) == quarter_turn(a, b) + quarter_turn(b, a)
        checked += 1
print(f'RESULT: PASS ({checked} cases, two_direction_total_junctions)')

# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: sum_{s=0}^{n-2}vartheta(u_s,u_{s+1})=vartheta(a,b) (p>0, q>0)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    if horizontal != 0 and vertical != 0:
        first_count, first, last_count, last = constant_blocks(length, horizontal, vertical)
        steps = reversed_steps(length, horizontal, vertical)
        assert first_count > 0 and last_count > 0
        for index in range(len(steps) - 1):
            expected = quarter_turn(first, last) if index == first_count - 1 else ZZ(0)
            assert quarter_turn(steps[index], steps[index + 1]) == expected
        assert internal_turning(steps) == quarter_turn(first, last)
        checked += 1
print(f'RESULT: PASS ({checked} two-direction internal sums and unique internal junctions)')

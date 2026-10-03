# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: G(n-1-s)-G(n-s)=(-sign(w_v),0) (A<=0, LH<=s<n)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    if horizontal * vertical <= 0:
        steps = reversed_steps(length, horizontal, vertical)
        for index in range(length * abs(horizontal), len(steps)):
            assert steps[index] == (-integer_sign(vertical), ZZ(0))
            checked += 1
print(f'RESULT: PASS ({checked} reversed steps, nonpositive product second block)')

# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: F(j+1)-F(j)=展開した座標式 (index < q)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    p, a, q, b = constant_blocks(length, horizontal, vertical)
    n = p + q
    first = vector_scale(-1, b)
    last = vector_scale(-1, a)
    for index in range(n):
        if index < q:
            left = vector_subtract(two_block_point(q, first, last, index + 1), two_block_point(q, first, last, index))
            right = vector_subtract(vector_scale(index + 1, first), vector_scale(index, first))
            assert left == right
            checked += 1
print(f'RESULT: PASS ({checked} cases, forward_expand_before)')

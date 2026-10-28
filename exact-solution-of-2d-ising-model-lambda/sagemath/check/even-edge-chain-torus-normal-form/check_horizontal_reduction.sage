import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
# 対象ラベル: claim_even_edge_chain_torus_normal_form
# 横辺係数 H^h_{i,j}=a_i+q_i+q_{i-1} と横切断線偶奇。
for length, horizontal, vertical in cases():
    _, first_horizontal, first_vertical = reduce_vertical(length, horizontal, vertical)
    coefficients, reduced_horizontal, reduced_vertical = reduce_horizontal(length, first_horizontal, first_vertical)
    horizontal_parity = sum(horizontal[i, length - 1] for i in range(length)) % 2
    for i in range(length):
        for j in range(length):
            assert first_horizontal[i, j] == first_horizontal[i, 0]
            assert reduced_horizontal[i, j] == (first_horizontal[i, 0] + coefficients[i] + coefficients[(i - 1) % length]) % 2
            assert reduced_horizontal[i, j] == (horizontal_parity if i == 0 else 0)
            assert reduced_vertical[i, j] == first_vertical[i, j]
print('RESULT: PASS horizontal reduction')

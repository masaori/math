import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
# 対象ラベル: claim_even_edge_chain_torus_normal_form
# C=h R_h+v R_v+Σ(p^v_{i,j}+q_j)P_{i,j} を各辺で照合する。
for length, horizontal, vertical in cases():
    vertical_coefficients, first_horizontal, first_vertical = reduce_vertical(length, horizontal, vertical)
    horizontal_coefficients, _, _ = reduce_horizontal(length, first_horizontal, first_vertical)
    recovered_horizontal = {(i, j): 0 for i in range(length) for j in range(length)}
    recovered_vertical = recovered_horizontal.copy()
    horizontal_parity = sum(horizontal[i, length - 1] for i in range(length)) % 2
    vertical_parity = sum(vertical[length - 1, j] for j in range(length)) % 2
    for j in range(length):
        recovered_horizontal[0, j] = horizontal_parity
    for i in range(length):
        recovered_vertical[i, 0] = vertical_parity
    for i in range(length):
        for j in range(length):
            if (vertical_coefficients[i, j] + horizontal_coefficients[i]) % 2:
                add_square(recovered_horizontal, recovered_vertical, length, i, j)
    assert recovered_horizontal == horizontal
    assert recovered_vertical == vertical
print('RESULT: PASS chain reconstruction')

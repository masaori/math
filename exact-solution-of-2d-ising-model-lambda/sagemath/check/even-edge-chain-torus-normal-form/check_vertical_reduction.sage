import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
# 対象ラベル: claim_even_edge_chain_torus_normal_form
# 縦辺係数 V^v_{i,j}=V_{i,j}+p^v_{i,j-1}+p^v_{i,j} と縦切断線偶奇。
for length, horizontal, vertical in cases():
    coefficients, reduced_horizontal, reduced_vertical = reduce_vertical(length, horizontal, vertical)
    vertical_parity = sum(vertical[length - 1, j] for j in range(length)) % 2
    for i in range(length):
        assert sum(vertical[i, j] for j in range(length)) % 2 == vertical_parity
        for j in range(length):
            assert reduced_vertical[i, j] == (vertical[i, j] + coefficients[i, (j - 1) % length] + coefficients[i, j]) % 2
            assert reduced_vertical[i, j] == (vertical_parity if j == 0 else 0)
print('RESULT: PASS vertical reduction')

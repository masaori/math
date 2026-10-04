# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: T(f,d)=\tau_f(f,d)
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    for k, edge in enumerate(directed):
        f, d = edge
        assert directed[composite[k]] == swap_image(f, edge)
        checked += 1
print("RESULT: PASS (composition_action, %d cases)" % checked)

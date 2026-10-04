# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \tau_e\circ\tau_f=\tau_f\circ\tau_e
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    for e in range(len(swaps)):
        for f in range(e + 1, len(swaps)):
            assert compose(swaps[e], swaps[f]) == compose(swaps[f], swaps[e])
            checked += len(directed)
print("RESULT: PASS (swap_commutation, %d cases)" % checked)

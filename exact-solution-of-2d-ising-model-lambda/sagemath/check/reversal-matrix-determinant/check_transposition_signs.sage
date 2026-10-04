# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \prod_{e\in E_L}\operatorname{sgn}\tau_e=\prod_{e\in E_L}(-1)
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    assert prod(sign(swap) for swap in swaps) == prod(ZZ(-1) for swap in swaps)
    checked += 1
print("RESULT: PASS (transposition_signs, %d cases)" % checked)

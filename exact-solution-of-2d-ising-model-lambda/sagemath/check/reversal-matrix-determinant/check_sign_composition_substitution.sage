# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \operatorname{sgn}\iota=\operatorname{sgn}(\mathop{\circ}_{e\in E_L}\tau_e)
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    assert sign(reverse) == sign(composite)
    checked += 1
print("RESULT: PASS (sign_composition_substitution, %d cases)" % checked)

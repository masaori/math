# 対象ラベル: claim_reversal_matrix_determinant_one / def_integer_matrix_determinant
# 式ペア: \det J_L=\sum_\sigma\operatorname{sgn}\sigma\prod_w(J_L)_{w,\sigma(w)}
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    assert J.det() == leibniz_sum(L)
    checked += 1
print("RESULT: PASS (determinant_definition, %d cases)" % checked)

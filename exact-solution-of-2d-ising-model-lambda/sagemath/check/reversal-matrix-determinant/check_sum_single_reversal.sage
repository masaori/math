# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \sum_\sigma\operatorname{sgn}\sigma\prod_w(J_L)_{w,\sigma(w)}=\operatorname{sgn}\iota\prod_w(J_L)_{w,\iota(w)}
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    assert leibniz_sum(L) == weighted_term(J, reverse)
    checked += 1
print("RESULT: PASS (sum_single_reversal, %d cases)" % checked)

# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \operatorname{sgn}\iota\prod_w(J_L)_{w,\iota(w)}=\operatorname{sgn}\iota\prod_w1
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    assert weighted_term(J, reverse) == sign(reverse) * prod(ZZ(1) for edge in directed)
    checked += 1
print("RESULT: PASS (selected_entries, %d cases)" % checked)

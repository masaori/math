# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \operatorname{sgn}\sigma\prod_w(J_L)_{w,\sigma(w)}=\operatorname{sgn}\sigma\cdot0
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L, J, permutation, witness in mismatch_cases():
    assert weighted_term(J, permutation) == sign(permutation) * ZZ(0)
    checked += 1
print("RESULT: PASS (zero_product_substitution, %d cases)" % checked)

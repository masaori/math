# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \prod_w(J_L)_{w,\sigma(w)}=0
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L, J, permutation, witness in mismatch_cases():
    assert row_product(J, permutation) == ZZ(0)
    checked += 1
print("RESULT: PASS (zero_row_product, %d cases)" % checked)

# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: (J_L)_{w,\sigma(w)}=0\quad(\sigma(w)\ne\iota(w))
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L, J, permutation, witness in mismatch_cases():
    assert J[witness, permutation[witness]] == ZZ(0)
    checked += 1
print("RESULT: PASS (mismatch_entry, %d cases)" % checked)

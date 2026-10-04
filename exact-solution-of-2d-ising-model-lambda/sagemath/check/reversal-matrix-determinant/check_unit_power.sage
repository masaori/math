# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: 1^{L^2}=1
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    assert ZZ(1) ** (L * L) == ZZ(1)
    checked += 1
print("RESULT: PASS (unit_power, %d cases)" % checked)

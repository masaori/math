# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \operatorname{sgn}\iota\cdot1=\operatorname{sgn}\iota
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    assert sign(reverse) * ZZ(1) == sign(reverse)
    checked += 1
print("RESULT: PASS (unit_multiplication, %d cases)" % checked)

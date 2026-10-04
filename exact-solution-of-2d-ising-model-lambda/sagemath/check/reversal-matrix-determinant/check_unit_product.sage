# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \operatorname{sgn}\iota\prod_w1=\operatorname{sgn}\iota\cdot1
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    assert sign(reverse) * prod(ZZ(1) for edge in directed) == sign(reverse) * ZZ(1)
    checked += 1
print("RESULT: PASS (unit_product, %d cases)" % checked)

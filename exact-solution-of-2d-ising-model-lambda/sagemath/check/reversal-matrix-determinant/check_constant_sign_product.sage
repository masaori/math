# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \prod_{e\in E_L}(-1)=(-1)^{|E_L|}
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    directed, reverse, swaps, composite, J = data(L)
    assert prod(ZZ(-1) for swap in swaps) == ZZ(-1) ** len(swaps)
    checked += 1
print("RESULT: PASS (constant_sign_product, %d cases)" % checked)

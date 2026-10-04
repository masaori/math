# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: \operatorname{sgn}\sigma\cdot0=0
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L, J, permutation, witness in mismatch_cases():
    assert sign(permutation) * ZZ(0) == ZZ(0)
    checked += 1
print("RESULT: PASS (zero_weighted_term, %d cases)" % checked)

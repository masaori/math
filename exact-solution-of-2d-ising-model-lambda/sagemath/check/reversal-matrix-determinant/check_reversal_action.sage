# 対象ラベル: claim_reversal_matrix_determinant_one
# 式ペア: (f,1-d)=\iota(f,d)
# 帰属: 有限集合と ZZ。浮動小数点を使わない。
load('sagemath/check/reversal-matrix-determinant/_prelude.sage')

checked = 0
for L in range(1, 6):
    for f, d in directed_edges(L):
        assert (f, 1 - d) == reversal((f, d))
        checked += 1
print("RESULT: PASS (reversal_action, %d cases)" % checked)

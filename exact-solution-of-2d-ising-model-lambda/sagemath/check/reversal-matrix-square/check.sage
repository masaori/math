# 対象ラベル: claim_reversal_matrix_square / def_reversal_matrix
load('sagemath/check/reversal-matrix-square/_prelude.sage')

for L, oriented, J, I, square in matrix_cases:
    assert J.base_ring() is ZZ
    assert square == I
    assert all(sum(J.row(i)) == 1 for i in range(J.nrows()))
    assert all(sum(J.column(i)) == 1 for i in range(J.ncols()))
print('RESULT: PASS; L=1,...,5 の整数行列の積、全15,664成分、各行・各列の和を確認')

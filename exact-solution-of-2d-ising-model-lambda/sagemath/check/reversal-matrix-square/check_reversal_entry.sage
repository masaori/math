# 対象ラベル: claim_reversal_matrix_square
# 式ペア: J[iota(e),f]=[f=iota(iota(e))]
load('sagemath/check/reversal-matrix-square/_prelude.sage')

count = ZZ(0)
for L, oriented, J, I, square in matrix_cases:
    for i, e in enumerate(oriented):
        for j, f in enumerate(oriented):
            expr1 = reversal_entry(reverse_edge(e),f)
            expr2 = ZZ(f == reverse_edge(reverse_edge(e)))
            assert expr1 == expr2, (L, e, f, expr1, expr2)
            count += 1
assert count == 15664
print("RESULT: PASS reversal_entry;", count, "equalities")

# 対象ラベル: claim_reversal_matrix_square
# 式ペア: sum_g J[e,g]J[g,f]=J[e,iota(e)]J[iota(e),f]
load('sagemath/check/reversal-matrix-square/_prelude.sage')

count = ZZ(0)
for L, oriented, J, I, square in matrix_cases:
    for i, e in enumerate(oriented):
        for j, f in enumerate(oriented):
            expr1 = sum((reversal_entry(e,g) * reversal_entry(g,f) for g in oriented), ZZ(0))
            expr2 = reversal_entry(e,reverse_edge(e)) * reversal_entry(reverse_edge(e),f)
            assert expr1 == expr2, (L, e, f, expr1, expr2)
            count += 1
assert count == 15664
print("RESULT: PASS sum_single;", count, "equalities")

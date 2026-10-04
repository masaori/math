# 対象ラベル: claim_reversal_matrix_square
# 式ペア: J[e,g]J[g,f]=0 J[g,f]
load('sagemath/check/reversal-matrix-square/_prelude.sage')

count = ZZ(0)
for L, oriented, J, I, square in matrix_cases:
    for i, e in enumerate(oriented):
        for j, f in enumerate(oriented):
            for g in oriented:
                if g == reverse_edge(e):
                    continue
                expr1 = reversal_entry(e, g) * reversal_entry(g, f)
                expr2 = ZZ(0) * reversal_entry(g, f)
                assert expr1 == expr2, (L, e, f, expr1, expr2)
                count += 1
assert count == 1297296
print("RESULT: PASS off_support_entry;", count, "equalities")

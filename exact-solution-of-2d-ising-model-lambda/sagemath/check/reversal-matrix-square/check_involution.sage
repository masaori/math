# 対象ラベル: claim_reversal_matrix_square
# 式ペア: [f=iota(iota(e))]=[f=e]
load('sagemath/check/reversal-matrix-square/_prelude.sage')

count = ZZ(0)
for L, oriented, J, I, square in matrix_cases:
    for i, e in enumerate(oriented):
        for j, f in enumerate(oriented):
            expr1 = ZZ(f == reverse_edge(reverse_edge(e)))
            expr2 = ZZ(f == e)
            assert expr1 == expr2, (L, e, f, expr1, expr2)
            count += 1
assert count == 15664
print("RESULT: PASS involution;", count, "equalities")

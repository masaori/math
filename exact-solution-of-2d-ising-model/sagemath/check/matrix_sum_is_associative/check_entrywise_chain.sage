# 対象ラベル: matrix_sum_is_associative（(A + B) + C = A + (B + C)）
# 証明の成分ごとの 5 行の鎖を式どおりに組み、隣り合う項が等しいこと、全成分が一致することを確かめる。
# 成分は K = QQ(i) 上の多項式環の不定元。
load("../../_shared/linear_algebra_families.sage")
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        R = PolynomialRing(K, ["%s%d_%d" % (X, a, b) for X in "abc" for a in range(m) for b in range(n)])
        g = iter(R.gens())
        A = matrix(R, m, n, [next(g) for _ in range(m * n)])
        B = matrix(R, m, n, [next(g) for _ in range(m * n)])
        Cm = matrix(R, m, n, [next(g) for _ in range(m * n)])
        L = (A + B) + Cm
        Rr = A + (B + Cm)
        for i in range(m):
            for k in range(n):
                chain = [L[i, k], (A + B)[i, k] + Cm[i, k], (A[i, k] + B[i, k]) + Cm[i, k],
                         A[i, k] + (B[i, k] + Cm[i, k]), A[i, k] + (B + Cm)[i, k], Rr[i, k]]
                for t in range(len(chain) - 1):
                    ok(chain[t] == chain[t + 1], (m, n, i, k, t))
        ok(L == Rr, (m, n))
# 対照: 差は結合的でない
A = matrix(K, [[1]]); B = matrix(K, [[2]]); Cm = matrix(K, [[3]])
ok((A - B) - Cm != A - (B - Cm), "対照")
print("checked", count(), "items")
print("RESULT: PASS")

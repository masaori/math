# 対象ラベル: identity_matrix_is_right_unit_of_mat_mult
# 証明の (i,k) 成分の八行の鎖の九つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# j = k の項を分けた和は、分けた項と残りの添字の和を別々に組む。帰属: QQ 上の多項式環（A の成分は不定元）。
load("_prelude.sage")

count = 0
for m in DIMS:
    for n in DIMS:
        P, _, (A,) = generic_ring([("a", m, n)])
        In = body_identity(P, n)
        d = lambda r, s: body_delta(P, r, s)
        AI = body_product(A, In)
        for i in range(m):
            for k in range(n):
                others = [j for j in range(n) if j != k]
                chain = [
                    AI[i, k],
                    sum(A[i, j] * In[j, k] for j in range(n)),
                    sum(A[i, j] * d(j, k) for j in range(n)),
                    A[i, k] * d(k, k) + sum(A[i, j] * d(j, k) for j in others),
                    A[i, k] * P(1) + sum(A[i, j] * P(0) for j in others),
                    A[i, k] + sum(A[i, j] * P(0) for j in others),
                    A[i, k] + sum(P(0) * A[i, j] for j in others),
                    A[i, k] + sum(P(0) for j in others),
                    A[i, k],
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, k, t)
                count += 1
print(f"checked {count} entries over 9 shapes")
print("RESULT: PASS")

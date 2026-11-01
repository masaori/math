# 対象ラベル: identity_matrix_is_left_unit_of_mat_mult
# 証明の (i,k) 成分の七行の鎖の八つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# j = i の項を分けた和は、分けた項と残りの添字の和を別々に組む。帰属: QQ 上の多項式環（A の成分は不定元）。
load("_prelude.sage")

count = 0
for m in DIMS:
    for n in DIMS:
        P, _, (A,) = generic_ring([("a", m, n)])
        Im = body_identity(P, m)
        d = lambda r, s: body_delta(P, r, s)
        IA = body_product(Im, A)
        for i in range(m):
            for k in range(n):
                others = [j for j in range(m) if j != i]
                chain = [
                    IA[i, k],
                    sum(Im[i, j] * A[j, k] for j in range(m)),
                    sum(d(i, j) * A[j, k] for j in range(m)),
                    d(i, i) * A[i, k] + sum(d(i, j) * A[j, k] for j in others),
                    P(1) * A[i, k] + sum(P(0) * A[j, k] for j in others),
                    A[i, k] + sum(P(0) * A[j, k] for j in others),
                    A[i, k] + sum(P(0) for j in others),
                    A[i, k],
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, k, t)
                count += 1
print(f"checked {count} entries over 9 shapes")
print("RESULT: PASS")

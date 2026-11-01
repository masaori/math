# 対象ラベル: scalar_multiple_factors_out_of_right_factor
# 証明の (i,k) 成分の八行の鎖の九つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 A(aB) = a(AB) を、Sage のスカラー倍と行列積（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（a と A, B の成分は不定元）。
load("_prelude.sage")

count = 0
for m in DIMS:
  for n in DIMS:
    for p in DIMS:
        P, (a,), (A, B) = generic_ring([("A", m, n), ("B", n, p)], scalars=["s_a"])
        aB = body_scalar(a, B)
        AB = body_product(A, B)
        aAB = body_scalar(a, AB)
        L = body_product(A, aB)
        for i in range(m):
            for k in range(p):
                chain = [
                    L[i, k],
                    sum(A[i, j] * aB[j, k] for j in range(n)),
                    sum(A[i, j] * (a * B[j, k]) for j in range(n)),
                    sum((A[i, j] * a) * B[j, k] for j in range(n)),
                    sum((a * A[i, j]) * B[j, k] for j in range(n)),
                    sum(a * (A[i, j] * B[j, k]) for j in range(n)),
                    a * sum(A[i, j] * B[j, k] for j in range(n)),
                    a * AB[i, k],
                    aAB[i, k],
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, p, i, k, t)
                count += 1
        assert L == a * (A * B)
print(f"checked {count} entries and the statement over 27 shapes")
print("RESULT: PASS")

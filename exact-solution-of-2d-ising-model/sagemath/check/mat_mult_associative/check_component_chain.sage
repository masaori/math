# 対象ラベル: mat_mult_associative
# 証明の (i,k) 成分の八行の鎖の九つの項を、各項を書かれた式どおりに成分から組んで、隣り合う項が等しいことを確かめる。
# 第一項は成分の式で組んだ積 (AB)C、最終項は A(BC)。帰属: QQ 上の多項式環（成分は不定元）。
# 不定元で成り立つ等号は成分へ任意の複素数を代入しても成り立つ。浮動小数点はない。
load("_prelude.sage")

count = 0
for m in DIMS:
  for n in DIMS:
    for p in DIMS:
      for q in DIMS:
        P, _, (A, B, C) = generic_ring([("a", m, n), ("b", n, p), ("c", p, q)])
        AB = body_product(A, B)
        BC = body_product(B, C)
        L = body_product(AB, C)
        Rt = body_product(A, BC)
        for i in range(m):
            for k in range(q):
                chain = [
                    L[i, k],
                    sum(AB[i, l] * C[l, k] for l in range(p)),
                    sum(sum(A[i, j] * B[j, l] for j in range(n)) * C[l, k] for l in range(p)),
                    sum(sum((A[i, j] * B[j, l]) * C[l, k] for j in range(n)) for l in range(p)),
                    sum(sum(A[i, j] * (B[j, l] * C[l, k]) for j in range(n)) for l in range(p)),
                    sum(sum(A[i, j] * (B[j, l] * C[l, k]) for l in range(p)) for j in range(n)),
                    sum(A[i, j] * sum(B[j, l] * C[l, k] for l in range(p)) for j in range(n)),
                    sum(A[i, j] * BC[j, k] for j in range(n)),
                    Rt[i, k],
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, p, q, i, k, t)
                count += 1
print(f"checked {count} entries over 81 shapes")
print("RESULT: PASS")

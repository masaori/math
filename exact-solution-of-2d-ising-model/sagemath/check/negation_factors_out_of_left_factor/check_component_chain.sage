# 対象ラベル: negation_factors_out_of_left_factor
# 証明の (i,k) 成分の八行の鎖の九つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 (-A)B = -(AB) を、Sage の符号反転と行列積（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（A, B の成分は不定元）。不定元で成り立つ等号は、成分へ任意の複素数を代入しても成り立つ。
load("_prelude.sage")

count = 0
for m in DIMS:
  for n in DIMS:
    for p in DIMS:
        P, _, (A, B) = generic_ring([("A", m, n), ("B", n, p)])
        mo = P(-1)                      # -1_C
        nA = body_negation(A)
        AB = body_product(A, B)
        nAB = body_negation(AB)
        L = body_product(nA, B)
        for i in range(m):
            for k in range(p):
                chain = [
                    L[i, k],                                              # ((-A)B)_ik
                    sum(nA[i, j] * B[j, k] for j in range(n)),            # mat_mult
                    sum(body_neg_scalar(A[i, j]) * B[j, k] for j in range(n)),  # def_matrix_negation
                    sum((mo * A[i, j]) * B[j, k] for j in range(n)),      # multiply_by_minus_one
                    sum(mo * (A[i, j] * B[j, k]) for j in range(n)),      # 積の結合律
                    mo * sum(A[i, j] * B[j, k] for j in range(n)),        # 分配律
                    mo * AB[i, k],                                        # mat_mult
                    body_neg_scalar(AB[i, k]),                            # multiply_by_minus_one
                    nAB[i, k],                                            # def_matrix_negation
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, p, i, k, t)
                count += 1
        assert L == -(A * B)
        # 対照: 符号反転を落とした AB とは一致しない（零でない不定元の多項式の差 2AB がある）
        assert L != A * B
print(f"checked {count} entries and the statement over 27 shapes")
print("RESULT: PASS")

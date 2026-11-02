# 対象ラベル: scalar_multiple_distributes_over_matrix_difference
# 証明の (i,k) 成分の十二行の鎖の十三の項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 c(A-B) = cA - cB を、Sage のスカラー倍と差（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（c と A, B の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("_prelude.sage")

count = 0
for m in DIMS:
    for p in DIMS:
        P, (c,), (A, B) = generic_ring([("A", m, p), ("B", m, p)], scalars=["s_c"])
        mo = P(-1)                      # -1_C
        AmB = body_difference(A, B)
        cA = body_scalar(c, A)
        cB = body_scalar(c, B)
        L = body_scalar(c, AmB)
        Rhs = body_difference(cA, cB)
        for i in range(m):
            for k in range(p):
                chain = [
                    L[i, k],                                   # (c(A-B))_ik
                    c * AmB[i, k],                             # def_matrix_scalar_multiple
                    c * (A[i, k] - B[i, k]),                   # def_matrix_difference（複素数の差は Sage の差で組む）
                    c * (A[i, k] + body_neg_scalar(B[i, k])),  # def_complex_difference
                    c * A[i, k] + c * body_neg_scalar(B[i, k]),  # 分配律
                    c * A[i, k] + c * (mo * B[i, k]),          # multiply_by_minus_one
                    c * A[i, k] + (c * mo) * B[i, k],          # 積の結合律
                    c * A[i, k] + (mo * c) * B[i, k],          # 積の交換律
                    c * A[i, k] + mo * (c * B[i, k]),          # 積の結合律
                    c * A[i, k] + body_neg_scalar(c * B[i, k]),  # multiply_by_minus_one
                    c * A[i, k] - c * B[i, k],                 # def_complex_difference（複素数の差は Sage の差で組む）
                    cA[i, k] - cB[i, k],                       # def_matrix_scalar_multiple を 2 箇所
                    Rhs[i, k],                                 # def_matrix_difference
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, p, i, k, t)
                count += 1
        assert L == c * A - c * B
        # 対照: 第 2 項の c を落とした cA - B とは一致しない
        assert L != c * A - B
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")

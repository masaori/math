# 対象ラベル: scalar_multiple_of_negated_matrix
# 証明の (i,j) 成分の九行の鎖の十の項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 a(-A) = -(aA) を、Sage のスカラー倍と符号反転（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（a と A の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("_prelude.sage")

count = 0
for m in DIMS:
    for n in DIMS:
        P, (a,), (A,) = generic_ring([("A", m, n)], scalars=("a",))
        mo = P(-1)                      # -1_C
        nA = body_negation(A)
        aA = body_scalar(a, A)
        L = body_scalar(a, nA)
        naA = body_negation(aA)
        for i in range(m):
            for j in range(n):
                chain = [
                    L[i, j],                                # (a(-A))_ij
                    a * nA[i, j],                           # def_matrix_scalar_multiple
                    a * body_neg_scalar(A[i, j]),           # def_matrix_negation
                    a * (mo * A[i, j]),                     # multiply_by_minus_one
                    (a * mo) * A[i, j],                     # 積の結合律
                    (mo * a) * A[i, j],                     # 積の交換律
                    mo * (a * A[i, j]),                     # 積の結合律
                    body_neg_scalar(a * A[i, j]),           # multiply_by_minus_one
                    body_neg_scalar(aA[i, j]),              # def_matrix_scalar_multiple
                    naA[i, j],                              # def_matrix_negation
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, j, t)
                count += 1
        assert L == -(a * A)
        # 対照: 符号反転を落とした aA とは一致しない（差 2aA は零でない多項式）
        assert L != a * A
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")

# 対象ラベル: scalar_multiple_distributes_over_matrix_sum
# 証明の (i,j) 成分の五行の鎖の六つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 c(A + B) = cA + cB を、Sage のスカラー倍と和（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（c と A, B の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, (c,), (A, B) = generic_ring([("A", m, n), ("B", m, n)], scalars=["s_c"])
        ApB = body_sum(A, B)
        cA = body_scalar(c, A)
        cB = body_scalar(c, B)
        L = body_scalar(c, ApB)
        Rhs = body_sum(cA, cB)
        for i in range(m):
            for j in range(n):
                chain = [
                    L[i, j],                     # (c(A+B))_ij
                    c * ApB[i, j],               # def_matrix_scalar_multiple
                    c * (A[i, j] + B[i, j]),     # def_matrix_sum
                    c * A[i, j] + c * B[i, j],   # C の分配律
                    cA[i, j] + cB[i, j],         # def_matrix_scalar_multiple を 2 箇所
                    Rhs[i, j],                   # def_matrix_sum
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, j, t)
                count += 1
        assert L == c * A + c * B
        # 対照: 第 2 項の c を落とした cA + B とは一致しない
        assert L != c * A + B
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")

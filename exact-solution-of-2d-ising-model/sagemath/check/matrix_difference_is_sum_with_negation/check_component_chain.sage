# 対象ラベル: matrix_difference_is_sum_with_negation
# 証明の (i,j) 成分の四行の鎖の五つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 A - B = A + (-B) を、Sage の差・符号反転・和（独立な経路）で組んだ両辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（A, B の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, _, (A, B) = generic_ring([("A", m, n), ("B", m, n)])
        lhs = body_difference(A, B)
        rhs = body_sum(A, body_negation(B))
        for i in range(m):
            for j in range(n):
                chain = [
                    lhs[i, j],                                  # (A - B)_ij
                    A[i, j] - B[i, j],                          # def_matrix_difference（右辺は Sage の ℂ 側の差）
                    A[i, j] + body_neg_scalar(B[i, j]),         # def_complex_difference
                    A[i, j] + body_negation(B)[i, j],           # def_matrix_negation
                    rhs[i, j],                                  # def_matrix_sum
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, j, t)
                count += 1
        assert lhs == rhs
        assert A - B == A + (-B) == lhs
        # 対照: 符号反転を付け忘れた A + B とは一致しない（差 2B は零でない多項式）
        assert lhs != body_sum(A, B)
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")

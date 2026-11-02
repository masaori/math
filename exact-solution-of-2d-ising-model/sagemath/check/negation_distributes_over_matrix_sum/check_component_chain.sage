# 対象ラベル: negation_distributes_over_matrix_sum
# 証明の (i,j) 成分の七行の鎖の八つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 -(A + B) = (-A) + (-B) を、Sage の符号反転と和（独立な経路）で組んだ両辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（A, B の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, _, (A, B) = generic_ring([("A", m, n), ("B", m, n)])
        mo = P(-1)                      # -1_C
        lhs = body_negation(body_sum(A, B))
        rhs = body_sum(body_negation(A), body_negation(B))
        for i in range(m):
            for j in range(n):
                chain = [
                    lhs[i, j],                                              # (-(A+B))_ij
                    body_neg_scalar(body_sum(A, B)[i, j]),                  # def_matrix_negation
                    body_neg_scalar(A[i, j] + B[i, j]),                     # def_matrix_sum
                    mo * (A[i, j] + B[i, j]),                               # multiply_by_minus_one
                    mo * A[i, j] + mo * B[i, j],                            # C の分配律
                    body_neg_scalar(A[i, j]) + body_neg_scalar(B[i, j]),    # multiply_by_minus_one（2 か所）
                    body_negation(A)[i, j] + body_negation(B)[i, j],        # def_matrix_negation（2 か所）
                    rhs[i, j],                                              # def_matrix_sum
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, j, t)
                count += 1
        assert lhs == rhs
        assert -(A + B) == (-A) + (-B) == lhs
        # 対照: 片方の項だけ符号反転した (-A) + B とは一致しない（差 -2B は零でない多項式）
        assert lhs != body_sum(body_negation(A), B)
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")

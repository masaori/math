# 対象ラベル: zero_matrix_is_left_zero_of_mat_mult（O_{m,n} B = O_{m,p}）
# 証明の (i,k) 成分の五行の鎖の項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
#   (O B)_ik = Σ_j O_ij B_jk = Σ_j 0·B_jk = Σ_j 0 = 0 = (O_{m,p})_ik
# あわせて主張を Sage 組み込みの積（独立な経路）とも比べる。
# 帰属: QQ 上の多項式環（B の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        for p in [1, 2, 3]:
            P, _, (B,) = generic_ring([("B", n, p)])
            Omn = matrix(P, m, n, lambda i, j: P(0))   # def_zero_matrix
            Omp = matrix(P, m, p, lambda i, k: P(0))   # def_zero_matrix
            lhs = body_product(Omn, B)
            for i in range(m):
                for k in range(p):
                    chain = [
                        lhs[i, k],                                       # (O B)_ik
                        sum(Omn[i, j] * B[j, k] for j in range(n)),      # mat_mult
                        sum(P(0) * B[j, k] for j in range(n)),           # def_zero_matrix を各項へ
                        sum(P(0) for j in range(n)),                     # complex_zero_times_is_zero を各項へ
                        P(0),                                            # finite_sum_of_complex_zeros
                        Omp[i, k],                                       # def_zero_matrix
                    ]
                    for t in range(len(chain) - 1):
                        assert chain[t] == chain[t + 1], (m, n, p, i, k, t)
                    count += 1
            assert lhs == Omp
            assert zero_matrix(P, m, n) * B == zero_matrix(P, m, p) == lhs
            # 対照: 零行列でない左因子（単位行列の列を切り出したもの）では零にならない
            E = matrix(P, m, n, lambda i, j: P(1) if i == j else P(0))
            assert body_product(E, B) != Omp
print(f"checked {count} entries over 27 shapes")
print("RESULT: PASS")

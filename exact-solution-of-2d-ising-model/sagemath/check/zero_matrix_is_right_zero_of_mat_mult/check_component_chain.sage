# 対象ラベル: zero_matrix_is_right_zero_of_mat_mult（A O_{n,p} = O_{m,p}）
# 証明の (i,k) 成分の五行の鎖の項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
#   (A O)_ik = Σ_j A_ij O_jk = Σ_j A_ij·0 = Σ_j 0 = 0 = (O_{m,p})_ik
# あわせて主張を Sage 組み込みの積（独立な経路）とも比べる。
# 帰属: QQ 上の多項式環（A の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        for p in [1, 2, 3]:
            P, _, (A,) = generic_ring([("A", m, n)])
            Onp = matrix(P, n, p, lambda j, k: P(0))   # def_zero_matrix
            Omp = matrix(P, m, p, lambda i, k: P(0))   # def_zero_matrix
            lhs = body_product(A, Onp)
            for i in range(m):
                for k in range(p):
                    chain = [
                        lhs[i, k],                                       # (A O)_ik
                        sum(A[i, j] * Onp[j, k] for j in range(n)),      # mat_mult
                        sum(A[i, j] * P(0) for j in range(n)),           # def_zero_matrix を各項へ
                        sum(P(0) for j in range(n)),                     # complex_times_zero_is_zero を各項へ
                        P(0),                                            # finite_sum_of_complex_zeros
                        Omp[i, k],                                       # def_zero_matrix
                    ]
                    for t in range(len(chain) - 1):
                        assert chain[t] == chain[t + 1], (m, n, p, i, k, t)
                    count += 1
            assert lhs == Omp
            assert A * zero_matrix(P, n, p) == zero_matrix(P, m, p) == lhs
            # 対照: 零行列でない右因子（単位行列の行を切り出したもの）では零にならない
            E = matrix(P, n, p, lambda j, k: P(1) if j == k else P(0))
            assert body_product(A, E) != Omp
print(f"checked {count} entries over 27 shapes")
print("RESULT: PASS")

# 対象ラベル: trace_of_positive_definite_is_positive
# b^{(k)*}Ab^{(k)} = A_kk の 11 行を不定元で、δ の二つの性質と b^{(k)} ≠ 0 を厳密に確かめ、
# トレースの 3 行と主張を具体の正定値な A（C^*C + I）で確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

for n in [1, 2, 3, 4]:
    P, _, _, (A,), _ = generic_ring(n, mats=["A"])
    R = range(n)
    I = body_identity(n, P)
    d = lambda i, j: body_delta(i, j, P)
    for i in R:
        for j in R:
            assert cc_conj(d(i, j)) == d(i, j) and d(i, j) == d(j, i)
    AI, IA = body_prod(A, I), body_prod(I, A)
    for k in R:
        b = [d(i, k) for i in R]
        assert b[k] == (1, 0) and b[k] != (0, 0)
        lines = [
            body_cbv(b, A, b),                                                                    # b^*Ab
            fsum([fsum([cc_mul(cc_mul(cc_conj(d(i, k)), A[i][l]), d(l, k)) for l in R]) for i in R]),   # (def_conjugate_bilinear_value)
            fsum([fsum([cc_mul(cc_mul(d(i, k), A[i][l]), d(l, k)) for l in R]) for i in R]),      # conj δ = δ
            fsum([fsum([cc_mul(d(i, k), cc_mul(A[i][l], d(l, k))) for l in R]) for i in R]),      # 結合律
            fsum([cc_mul(d(i, k), fsum([cc_mul(A[i][l], d(l, k)) for l in R])) for i in R]),      # 分配律
            fsum([cc_mul(d(i, k), fsum([cc_mul(A[i][l], I[l][k]) for l in R])) for i in R]),      # (def_identity_matrix)
            fsum([cc_mul(d(i, k), AI[i][k]) for i in R]),                                         # (mat_mult)
            fsum([cc_mul(d(i, k), A[i][k]) for i in R]),                                          # (identity_matrix_is_right_unit_of_mat_mult)
            fsum([cc_mul(d(k, i), A[i][k]) for i in R]),                                          # δ_ik = δ_ki
            fsum([cc_mul(I[k][i], A[i][k]) for i in R]),                                          # (def_identity_matrix)
            IA[k][k],                                                                             # (mat_mult)
            A[k][k],                                                                              # (identity_matrix_is_left_unit_of_mat_mult)
        ]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], (n, k, t)
        PK = gauss_ring(P)
        gb = vector(PK, [PK(1) if i == k else PK(0) for i in R])
        assert to_g(lines[0], PK) == gb * to_g_mat(A, PK) * gb                        # 比べる側
    print(f"n = {n}: 各 k で 11 個の等号と δ の性質を不定元で確かめた")

set_random_seed(13)
for n in [1, 2, 3, 4]:
    for _ in range(6):
        gA = rand_posdef(n)
        assert sage_is_positive_definite(gA)
        A = from_g_mat(gA)
        rs = []
        for k in range(n):
            b = [body_delta(i, k, QQ) for i in range(n)]
            v = body_cbv(b, A, b)
            assert v == A[k][k] and is_positive_real_inclusion(v)
            rs.append(v[0])
        tr = fsum([A[k][k] for k in range(n)])                 # def_trace
        assert tr == fsum([iota(q, QQ) for q in rs]) == iota(sum(rs), QQ)
        assert sum(rs) >= rs[0] > 0
        assert to_g(tr, KG) == gA.trace()                       # 比べる側: Sage の trace
    print(f"n = {n}: 具体の 6 個の正定値な A で、トレースの 3 行と主張を確かめた")
# 正定値が要ることの確認: エルミートだが正定値でない行列ではトレースが正とは限らない
gM = matrix(KG, [[1, 0], [0, -3]])
assert gM.is_hermitian() and gM.trace() < 0
print("正定値でないエルミート行列 diag(1,-3) ではトレースが負であることを確かめた")
print("RESULT: PASS")

# 対象ラベル: star_preserves_norm_and_limits
# (1) の第 2 式 (αA + βB)^* = conj(α)A^* + conj(β)B^* の成分の鎖を一行ずつ。α, β と A, B の成分を QQ 上の不定元の対に置く。
load("_prelude.sage")

for n in SIZES:
    P, (al, be), (A, B) = generic_pairs(n, ["A", "B"], scalars=["alpha", "beta"])
    aA, bB = body_scalar(al, A), body_scalar(be, B)
    S = body_sum(aA, bB)
    As, Bs = body_star(A), body_star(B)
    lhs_mat = body_star(S)
    rhs_mat = body_sum(body_scalar(cc_conj(al), As), body_scalar(cc_conj(be), Bs))
    for k in range(n):
        for l in range(n):
            lines = [
                lhs_mat[k][l],                                                         # ((αA+βB)^*)_kl
                cc_conj(S[l][k]),                                                      # conj((αA+βB)_lk)          (def_hermitian_positive_definite)
                cc_conj(cc_add(aA[l][k], bB[l][k])),                                   # conj((αA)_lk + (βB)_lk)  (def_matrix_sum)
                cc_conj(cc_add(cc_mul(al, A[l][k]), cc_mul(be, B[l][k]))),            # conj(α A_lk + β B_lk)    (def_matrix_scalar_multiple)
                cc_add(cc_conj(cc_mul(al, A[l][k])), cc_conj(cc_mul(be, B[l][k]))),   # conj(αA_lk) + conj(βB_lk) (complex_conjugate_of_sum)
                cc_add(cc_mul(cc_conj(al), cc_conj(A[l][k])),
                       cc_mul(cc_conj(be), cc_conj(B[l][k]))),                         # conjα conjA_lk + conjβ conjB_lk (complex_conjugate_of_product)
                cc_add(cc_mul(cc_conj(al), As[k][l]), cc_mul(cc_conj(be), Bs[k][l])),  # conjα (A^*)_kl + conjβ (B^*)_kl (def_hermitian_positive_definite)
                cc_add(body_scalar(cc_conj(al), As)[k][l],
                       body_scalar(cc_conj(be), Bs)[k][l]),                            # (conjα A^*)_kl + (conjβ B^*)_kl (def_matrix_scalar_multiple)
                rhs_mat[k][l],                                                         # (conjα A^* + conjβ B^*)_kl     (def_matrix_sum)
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], (n, k, l, t)
    PK = gauss_ring(P)
    ga, gb = to_gauss_scalar(al, PK), to_gauss_scalar(be, PK)
    gA, gB = to_gauss(A, PK), to_gauss(B, PK)
    cj = lambda p: p.map_coefficients(lambda c: c.conjugate())
    assert to_gauss(lhs_mat, PK) == sage_star(ga * gA + gb * gB)
    assert to_gauss(rhs_mat, PK) == cj(ga) * sage_star(gA) + cj(gb) * sage_star(gB)
    print(f"n = {n}: 全成分で鎖の 8 個の等号と、両端の Sage の共役転置・和・スカラー倍との一致を不定元で確かめた")

set_random_seed(23)
for n in SIZES:
    for _ in range(3):
        rnd = lambda: K(ZZ.random_element(-5, 6)) + i_K * K(ZZ.random_element(-5, 6))
        a, b = rnd(), rnd()
        gA = matrix(K, n, n, lambda r, s: rnd())
        gB = matrix(K, n, n, lambda r, s: rnd())
        assert (a * gA + b * gB).conjugate_transpose() == a.conjugate() * gA.conjugate_transpose() + b.conjugate() * gB.conjugate_transpose()
        # 複素共役の向きを取り違えると落ちることの確認（α が実数でないとき）
        if a.imag() != 0:
            assert (a * gA).conjugate_transpose() != a * gA.conjugate_transpose() or gA == 0
print("具体の QQ(i) の行列で、主張が Sage の conjugate_transpose で成り立つことを確かめた")
print("RESULT: PASS")

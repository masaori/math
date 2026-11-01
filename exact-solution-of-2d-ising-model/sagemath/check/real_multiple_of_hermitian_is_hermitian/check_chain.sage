# 対象ラベル: real_multiple_of_hermitian_is_hermitian
# ((α_C A)^*)_kl から (α_C A)_kl までの 7 行を、α を QQ 上の実の不定元、A をエルミートな不定元の表に置いて厳密に確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

for n in [1, 2, 3, 4]:
    P, (al,), _, (M,), _ = generic_ring(n, mats=["A"], real_scalars=["alpha"])
    A = hermitian_from_generic(M, P)
    assert body_star(A) == A                       # 仮定 A^* = A
    a = iota(al, P)
    aA = body_scalar(a, A)
    As = body_star(A)
    for k in range(n):
        for l in range(n):
            lines = [
                body_star(aA)[k][l],                      # ((α_C A)^*)_kl
                cc_conj(aA[l][k]),                        # conj((α_C A)_lk)        (def_hermitian_positive_definite)
                cc_conj(cc_mul(a, A[l][k])),              # conj(α_C A_lk)          (def_matrix_scalar_multiple)
                cc_mul(cc_conj(a), cc_conj(A[l][k])),     # conj(α_C) conj(A_lk)    (complex_conjugate_of_product)
                cc_mul(a, cc_conj(A[l][k])),              # α_C conj(A_lk)          (complex_conjugate_of_real_inclusion)
                cc_mul(a, As[k][l]),                      # α_C (A^*)_kl            (def_hermitian_positive_definite)
                cc_mul(a, A[k][l]),                       # α_C A_kl                (A^* = A)
                aA[k][l],                                 # (α_C A)_kl              (def_matrix_scalar_multiple)
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], (n, k, l, t)
    PK = gauss_ring(P)
    gA = to_g_mat(A, PK)
    assert to_g_mat(body_star(aA), PK) == sage_star(PK(al) * gA) == PK(al) * gA   # 比べる側: Sage の共役転置
    print(f"n = {n}: 全成分で 7 個の等号と、両端の Sage の共役転置との一致を確かめた")

# 仮定が要ることの確認: α が実数でない（α = i）か A がエルミートでないと成り立たない
set_random_seed(5)
for n in [2, 3]:
    gH = rand_hermitian(n)
    assert (i_K * gH).conjugate_transpose() != i_K * gH
    gC = rand_gauss_matrix(n)
    while gC.is_hermitian():
        gC = rand_gauss_matrix(n)
    assert (3 * gC).conjugate_transpose() != 3 * gC
print("α = i、または A がエルミートでないときは成り立たないことを確かめた")
print("RESULT: PASS")

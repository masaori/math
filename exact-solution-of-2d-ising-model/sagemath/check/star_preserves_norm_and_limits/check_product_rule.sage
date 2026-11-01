# 対象ラベル: star_preserves_norm_and_limits
# (1) の第 1 式 (AB)^* = B^*A^* の成分の鎖を一行ずつ。A, B の成分を QQ 上の不定元の対に置く。
load("_prelude.sage")

for n in SIZES:
    P, _, (A, B) = generic_pairs(n, ["A", "B"])
    As, Bs = body_star(A), body_star(B)
    AB = body_prod(A, B)
    lhs_mat = body_star(AB)
    rhs_mat = body_prod(Bs, As)
    for k in range(n):
        for l in range(n):
            lines = [
                lhs_mat[k][l],                                                        # ((AB)^*)_kl
                cc_conj(AB[l][k]),                                                    # conj((AB)_lk)          (def_hermitian_positive_definite)
                cc_conj(fsum([cc_mul(A[l][j], B[j][k]) for j in range(n)])),          # conj(Σ_j A_lj B_jk)    (mat_mult)
                fsum([cc_conj(cc_mul(A[l][j], B[j][k])) for j in range(n)]),          # Σ_j conj(A_lj B_jk)    (complex_conjugate_of_sum)
                fsum([cc_mul(cc_conj(A[l][j]), cc_conj(B[j][k])) for j in range(n)]), # Σ_j conj A_lj conj B_jk (complex_conjugate_of_product)
                fsum([cc_mul(cc_conj(B[j][k]), cc_conj(A[l][j])) for j in range(n)]), # Σ_j conj B_jk conj A_lj (積の可換性)
                fsum([cc_mul(Bs[k][j], As[j][l]) for j in range(n)]),                 # Σ_j (B^*)_kj (A^*)_jl  (def_hermitian_positive_definite)
                rhs_mat[k][l],                                                        # (B^*A^*)_kl            (mat_mult)
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], (n, k, l, t)
    PK = gauss_ring(P)
    gA, gB = to_gauss(A, PK), to_gauss(B, PK)
    assert to_gauss(lhs_mat, PK) == sage_star(gA * gB)
    assert to_gauss(rhs_mat, PK) == sage_star(gB) * sage_star(gA)
    if n >= 2:
        assert sage_star(gA * gB) != sage_star(gA) * sage_star(gB)   # 順序の入れ替えが要ることの確認
    print(f"n = {n}: 全成分で鎖の 7 個の等号と、両端の Sage の共役転置・積との一致を不定元で確かめた")

# 具体の QQ(i) の行列で Sage 組み込みの conjugate_transpose と比べる
set_random_seed(19)
for n in SIZES:
    for _ in range(3):
        gA = matrix(K, n, n, lambda r, s: K(ZZ.random_element(-5, 6)) + i_K * K(ZZ.random_element(-5, 6)))
        gB = matrix(K, n, n, lambda r, s: K(ZZ.random_element(-5, 6)) + i_K * K(ZZ.random_element(-5, 6)))
        A = [[(QQ(gA[r, s].real()), QQ(gA[r, s].imag())) for s in range(n)] for r in range(n)]
        B = [[(QQ(gB[r, s].real()), QQ(gB[r, s].imag())) for s in range(n)] for r in range(n)]
        lhs = to_gauss(body_star(body_prod(A, B)), K)
        assert lhs == (gA * gB).conjugate_transpose() == gB.conjugate_transpose() * gA.conjugate_transpose()
print("具体の QQ(i) の行列（n = 1,…,4、各 3 組）で、主張の両端が Sage の conjugate_transpose と一致した")
print("RESULT: PASS")

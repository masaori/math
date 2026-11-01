# 対象ラベル: congruence_preserves_positive_definite
# 準備の (B^*)^* = B（6 行）と B'0 = 0（5 行）、エルミート性の 5 行を不定元で厳密に確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

for n in [1, 2, 3, 4]:
    P, _, _, (M, B, Bp), _ = generic_ring(n, mats=["A", "B", "Bp"])
    A = hermitian_from_generic(M, P)          # 仮定: A は正定値なのでエルミート
    Bs = body_star(B)
    Bss = body_star(Bs)
    for k in range(n):
        for l in range(n):
            a, b = B[k][l]
            lines = [
                Bss[k][l],                       # ((B^*)^*)_kl
                cc_conj(Bs[l][k]),               # conj((B^*)_lk)          (def_hermitian_positive_definite)
                cc_conj(cc_conj(B[k][l])),       # conj(conj(B_kl))        (def_hermitian_positive_definite)
                cc_conj((a, -b)),                # conj((a,-b))            (def_complex_conjugate)
                (a, -(-b)),                      # (a, -(-b))              (def_complex_conjugate)
                (a, b),                          # (a, b)                  (ℝ)
                B[k][l],                         # B_kl
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], ("star-star", n, k, l, t)
    zero = [iota(0, P) for _ in range(n)]
    Bp0 = body_matvec(Bp, zero)
    for k in range(n):
        lines = [
            Bp0[k],                                              # (B'0)_k
            fsum([cc_mul(Bp[k][j], zero[j]) for j in range(n)]),     # Σ_j B'_kj 0_j   (mat_mult)
            fsum([cc_mul(Bp[k][j], iota(0, P)) for j in range(n)]),   # Σ_j B'_kj 0_C   (def_zero_matrix)
            fsum([iota(0, P) for j in range(n)]),                # Σ_j 0_C          (complex_times_zero_is_zero)
            iota(0, P),                                          # 0_C              (finite_sum_of_complex_zeros)
            zero[k],                                             # 0_k              (def_zero_matrix)
        ]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], ("B'0", n, k, t)
    # エルミート性: (B^*(AB))^* = (AB)^*(B^*)^* = (B^*A^*)(B^*)^* = (B^*A)(B^*)^* = (B^*A)B = B^*(AB)
    AB = body_prod(A, B)
    As = body_star(A)
    assert As == A
    lines = [
        body_star(body_prod(Bs, AB)),
        body_prod(body_star(AB), Bss),                   # (star_preserves_norm_and_limits (1) の第 1 式)
        body_prod(body_prod(Bs, As), Bss),               # (同上)
        body_prod(body_prod(Bs, A), Bss),                # (A^* = A)
        body_prod(body_prod(Bs, A), B),                  # ((B^*)^* = B)
        body_prod(Bs, AB),                               # (mat_mult_associative)
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], ("hermitian", n, t)
    PK = gauss_ring(P)
    gA, gB = to_g_mat(A, PK), to_g_mat(B, PK)
    assert to_g_mat(lines[0], PK) == sage_star(sage_star(gB) * (gA * gB)) == sage_star(gB) * (gA * gB)
    print(f"n = {n}: (B^*)^* = B の 6 行、B'0 = 0 の 5 行、エルミート性の 5 行を不定元で確かめ、両端を Sage と比べた")
print("RESULT: PASS")

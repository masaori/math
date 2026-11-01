# 対象ラベル: exp_of_hermitian_is_hermitian
# 部分和の成分の式と ((E_N)^*)_kl の 8 行を、S をエルミートな不定元の表に置き N = 0,…,5 で厳密に確かめる。
# 極限の段（E_N → exp(S)、E_N^* → exp(S)^*、極限の一意性）は ℝ への脱出なので、具体のエルミートな QQ(i) の行列で、
# 本文の部分和に尾の評価を足したボールの行列と、Sage 組み込みの ComplexBallField の exp で exp(S)^* と exp(S) が重なることを確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

for n in [1, 2, 3]:
    P, _, _, (M,), _ = generic_ring(n, mats=["S"])
    S = hermitian_from_generic(M, P)
    pw = [body_pow(S, m, P) for m in range(6)]
    c = [iota(1 / factorial(m), P) for m in range(6)]
    for N in range(6):
        E = body_partial_exp(S, N, P)
        Es = body_star(E)
        for k in range(n):
            for l in range(n):
                comp = lambda a, b: fsum([cc_mul(c[m], pw[m][a][b]) for m in range(N + 1)])
                assert E[k][l] == comp(k, l)                                        # 部分和の成分の式
                lines = [
                    Es[k][l],
                    cc_conj(E[l][k]),                                               # (def_hermitian_positive_definite)
                    cc_conj(comp(l, k)),                                            # (成分の式)
                    fsum([cc_conj(cc_mul(c[m], pw[m][l][k])) for m in range(N + 1)]),        # (complex_conjugate_of_sum)
                    fsum([cc_mul(cc_conj(c[m]), cc_conj(pw[m][l][k])) for m in range(N + 1)]),   # (complex_conjugate_of_product)
                    fsum([cc_mul(c[m], cc_conj(pw[m][l][k])) for m in range(N + 1)]),       # (complex_conjugate_of_real_inclusion)
                    fsum([cc_mul(c[m], body_star(pw[m])[k][l]) for m in range(N + 1)]),     # (def_hermitian_positive_definite)
                    fsum([cc_mul(c[m], pw[m][k][l]) for m in range(N + 1)]),                # ((S^m)^* = S^m)
                    E[k][l],                                                        # (成分の式)
                ]
                for t in range(len(lines) - 1):
                    assert lines[t] == lines[t + 1], (n, N, k, l, t)
    print(f"n = {n}: N = 0,…,5 の部分和で 8 個の等号を不定元で確かめた")

set_random_seed(23)
for n in [1, 2, 3, 4]:
    for _ in range(3):
        gS = rand_hermitian(n) / 3
        Eb = body_exp_ball(gS)
        Esb = Eb.conjugate_transpose()
        assert balls_overlap(Esb, Eb)                       # exp(S)^* と exp(S) が重なる
        assert balls_overlap(Eb, sage_exp_ball(gS))         # 本文の exp と Sage の exp
    # 仮定が要ることの確認: エルミートでない S では exp(S)^* と exp(S) は重ならない
    gC = rand_gauss_matrix(n) / 3
    while gC.is_hermitian():
        gC = rand_gauss_matrix(n) / 3
    Eb = body_exp_ball(gC)
    assert not balls_overlap(Eb.conjugate_transpose(), Eb)
    print(f"n = {n}: エルミートな 3 個の S で exp(S)^* と exp(S) が重なり、エルミートでない S では重ならないことを確かめた")
print("RESULT: PASS")

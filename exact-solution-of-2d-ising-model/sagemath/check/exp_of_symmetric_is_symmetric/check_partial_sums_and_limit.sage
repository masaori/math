# 対象ラベル: exp_of_symmetric_is_symmetric
# 部分和の成分の式と ((E_N)^⊤)_kl の 5 行を、S を転置で不変な不定元の表に置き N = 0,…,5 で厳密に確かめる。
# 極限の段（E_N → exp(S)、transpose_preserves_matrix_limits による E_N^⊤ → exp(S)^⊤、極限の一意性）は ℝ への脱出なので、
# 転置で不変な具体の QQ(i) の行列（実対称でないものを含む）で、本文の部分和に尾の評価を足したボールの行列と、
# Sage 組み込みの ComplexBallField の exp で exp(S)^⊤ と exp(S) が重なることを確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")


def body_transpose(A):
    n = len(A)
    return [[A[l][k] for l in range(n)] for k in range(n)]


def symmetric_from_generic(M):
    n = len(M)
    H = [[None] * n for _ in range(n)]
    for k in range(n):
        H[k][k] = M[k][k]
        for l in range(k + 1, n):
            H[k][l] = M[k][l]
            H[l][k] = M[k][l]
    return H


for n in [1, 2, 3]:
    P, _, _, (M,), _ = generic_ring(n, mats=["S"])
    S = symmetric_from_generic(M)
    pw = [body_pow(S, m, P) for m in range(6)]
    c = [iota(1 / factorial(m), P) for m in range(6)]
    for N in range(6):
        E = body_partial_exp(S, N, P)
        Et = body_transpose(E)
        for k in range(n):
            for l in range(n):
                comp = lambda a, b: fsum([cc_mul(c[m], pw[m][a][b]) for m in range(N + 1)])
                assert E[k][l] == comp(k, l)                                        # 部分和の成分の式
                lines = [
                    Et[k][l],
                    E[l][k],                                                        # (def_matrix_transpose)
                    comp(l, k),                                                     # (成分の式)
                    fsum([cc_mul(c[m], body_transpose(pw[m])[k][l]) for m in range(N + 1)]),  # (def_matrix_transpose を各項へ)
                    fsum([cc_mul(c[m], pw[m][k][l]) for m in range(N + 1)]),        # ((S^m)^⊤ = S^m)
                    E[k][l],                                                        # (成分の式)
                ]
                for t in range(len(lines) - 1):
                    assert lines[t] == lines[t + 1], (n, N, k, l, t)
    print(f"n = {n}: N = 0,…,5 の部分和で 5 個の等号を不定元で確かめた")


def rand_symmetric(n):
    C = rand_gauss_matrix(n)
    return C + C.transpose()


set_random_seed(29)
for n in [1, 2, 3, 4]:
    for _ in range(3):
        gS = rand_symmetric(n) / 3
        assert gS.transpose() == gS
        Eb = body_exp_ball(gS)
        assert balls_overlap(Eb.transpose(), Eb)            # exp(S)^⊤ と exp(S) が重なる
        assert balls_overlap(Eb, sage_exp_ball(gS))         # 本文の exp と Sage の exp
    if n >= 2:
        # 仮定が要ることの確認: 転置で不変でない S では exp(S)^⊤ と exp(S) は重ならない
        gC = rand_gauss_matrix(n) / 3
        while gC.transpose() == gC:
            gC = rand_gauss_matrix(n) / 3
        Eb = body_exp_ball(gC)
        assert not balls_overlap(Eb.transpose(), Eb)
    print(f"n = {n}: 転置で不変な 3 個の S で exp(S)^⊤ と exp(S) が重なることを確かめた")
print("RESULT: PASS")

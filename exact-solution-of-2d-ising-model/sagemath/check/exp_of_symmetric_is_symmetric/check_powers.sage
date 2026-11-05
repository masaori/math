# 対象ラベル: exp_of_symmetric_is_symmetric
# 証明冒頭の I^⊤ = I の成分の 4 行、準備の二つの帰納法の各段（S S^m = S^m S の m = 0 の 4 行と m → m+1 の 4 行、
# (S^m)^⊤ = S^m の m = 0 の 3 行と m → m+1 の 6 行）を、S を転置で不変な不定元の表（1 本目の帰納法は仮定を使わない一般の S）に置き、
# m = 0,…,4、n = 1, 2, 3 で厳密に確かめる。転置は def_matrix_transpose の (B^⊤)_{pq} := B_{qp} を成分から組む。
load("../../_shared/hermitian_forms_by_definition.sage")


def body_transpose(A):
    n = len(A)
    return [[A[l][k] for l in range(n)] for k in range(n)]


def symmetric_from_generic(M):
    """不定元の表 M の上三角と対角から、A_lk := A_kl の転置で不変な表を作る（仮定 S^⊤ = S の実現。共役は取らない）。"""
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
    I = body_identity(n, P)
    # 冒頭: (I^⊤)_kl = I_lk = δ_lk = δ_kl = I_kl
    It = body_transpose(I)
    for k in range(n):
        for l in range(n):
            lines = [It[k][l], I[l][k], body_delta(l, k, P), body_delta(k, l, P), I[k][l]]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], ("I^T", n, k, l, t)
    # S S^m = S^m S は仮定を使わないので一般の S で
    S = M
    lines0 = [body_prod(S, body_pow(S, 0, P)), body_prod(S, I), S, body_prod(I, S), body_prod(body_pow(S, 0, P), S)]
    for t in range(len(lines0) - 1):
        assert lines0[t] == lines0[t + 1], ("comm m=0", n, t)
    for m in range(0, 5):
        Sm = body_pow(S, m, P)
        assert body_prod(S, Sm) == body_prod(Sm, S)                         # 帰納法の仮定
        lines = [body_prod(S, body_pow(S, m + 1, P)), body_prod(S, body_prod(Sm, S)), body_prod(body_prod(S, Sm), S),
                 body_prod(body_prod(Sm, S), S), body_prod(body_pow(S, m + 1, P), S)]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], ("comm step", n, m, t)
    # (S^m)^⊤ = S^m は S^⊤ = S を使う
    S = symmetric_from_generic(M)
    assert body_transpose(S) == S
    lines0 = [body_transpose(body_pow(S, 0, P)), body_transpose(I), I, body_pow(S, 0, P)]
    for t in range(len(lines0) - 1):
        assert lines0[t] == lines0[t + 1], ("transpose m=0", n, t)
    for m in range(0, 5):
        Sm = body_pow(S, m, P)
        assert body_transpose(Sm) == Sm                                       # 帰納法の仮定
        lines = [
            body_transpose(body_pow(S, m + 1, P)),
            body_transpose(body_prod(Sm, S)),                # (def_exp (1))
            body_prod(body_transpose(S), body_transpose(Sm)),  # (transpose_of_matrix_product)
            body_prod(S, body_transpose(Sm)),                # (S^⊤ = S)
            body_prod(S, Sm),                                # (帰納法の仮定)
            body_prod(Sm, S),                                # (準備の S S^m = S^m S)
            body_pow(S, m + 1, P),                           # (def_exp (1))
        ]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], ("transpose step", n, m, t)
    PK = gauss_ring(P)
    gS = to_g_mat(S, PK)
    assert to_g_mat(body_pow(S, 6, P), PK) == gS^6 == (gS^6).transpose()     # 比べる側: Sage の冪と転置
    if n >= 2:
        # 仮定が要ることの確認: 一般の S では (S^2)^⊤ ≠ S^2
        assert body_transpose(body_pow(M, 2, P)) != body_pow(M, 2, P)
    print(f"n = {n}: I^⊤ = I の成分の鎖、二つの帰納法の各段を m = 0,…,4 で不定元で確かめ、S^6 を Sage と比べた")
print("RESULT: PASS")

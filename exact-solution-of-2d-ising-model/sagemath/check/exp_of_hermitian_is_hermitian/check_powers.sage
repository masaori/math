# 対象ラベル: exp_of_hermitian_is_hermitian
# 準備の二つの帰納法の各段（S S^m = S^m S の m = 0 の 4 行と m → m+1 の 4 行、(S^m)^* = S^m の m = 0 の 3 行と m → m+1 の 6 行）を、
# S をエルミートな不定元の表（2 本目は仮定を使わない一般の S）に置き、m = 0,…,4 で厳密に確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

for n in [1, 2, 3]:
    P, _, _, (M,), _ = generic_ring(n, mats=["S"])
    I = body_identity(n, P)
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
    # (S^m)^* = S^m は S^* = S を使う
    S = hermitian_from_generic(M, P)
    assert body_star(S) == S
    assert body_star(I) == I                                                  # identity_matrix_is_positive_definite のエルミート性
    lines0 = [body_star(body_pow(S, 0, P)), body_star(I), I, body_pow(S, 0, P)]
    for t in range(len(lines0) - 1):
        assert lines0[t] == lines0[t + 1], ("star m=0", n, t)
    for m in range(0, 5):
        Sm = body_pow(S, m, P)
        assert body_star(Sm) == Sm                                            # 帰納法の仮定
        lines = [
            body_star(body_pow(S, m + 1, P)),
            body_star(body_prod(Sm, S)),                 # (def_exp (1))
            body_prod(body_star(S), body_star(Sm)),      # (star_preserves_norm_and_limits (1))
            body_prod(S, body_star(Sm)),                 # (S^* = S)
            body_prod(S, Sm),                            # (帰納法の仮定)
            body_prod(Sm, S),                            # (準備の S S^m = S^m S)
            body_pow(S, m + 1, P),                       # (def_exp (1))
        ]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], ("star step", n, m, t)
    PK = gauss_ring(P)
    gS = to_g_mat(S, PK)
    assert to_g_mat(body_pow(S, 6, P), PK) == gS^6 == sage_star(gS^6)          # 比べる側: Sage の冪と共役転置
    print(f"n = {n}: 二つの帰納法の各段を m = 0,…,4 で不定元で確かめ、S^6 を Sage と比べた")
print("RESULT: PASS")

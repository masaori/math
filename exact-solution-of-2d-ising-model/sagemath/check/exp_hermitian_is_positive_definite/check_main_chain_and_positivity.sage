# 対象ラベル: exp_hermitian_is_positive_definite
# 主張の鎖 exp(S) = exp(H+H) = exp(H)exp(H) = TT = T^*T = T^*(IT) と、T'T = I、主張（exp(S) が正定値）を確かめる。
# (a) 形式冪級数: S を t S（t は実の不定元、S はエルミートな不定元の表）に置き、本文の部分和で各行が t の N 次まで一致することを厳密に。
# (b) ℝ への脱出を含む値: 具体のエルミートな QQ(i) の行列 S で、本文の部分和に尾の評価を足したボールの行列で各行を囲む。
#     正値性は、具体の x で x^*exp(S)x のボールの虚部が 0 を含み実部が正であることを、本文の exp と Sage の exp の両方で確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

N = 6
for n in [1, 2]:
    P, (tt,), _, (M,), _ = generic_ring(n, mats=["S"], real_scalars=["t"])
    S = body_scalar(iota(tt, P), hermitian_from_generic(M, P))
    assert body_star(S) == S
    H = body_scalar(iota(QQ(1) / 2, P), S)
    I = body_identity(n, P)
    ex = lambda X: trunc_mat(body_partial_exp(X, N, P), tt, N)
    T = ex(H)
    lines = [
        ex(S),
        ex(body_sum(H, H)),                     # (H + H = S)
        trunc_mat(body_prod(T, T), tt, N),      # (theorem_exp_product) — 形式冪級数としての exp(H)exp(H)
        trunc_mat(body_prod(T, T), tt, N),      # (T の定義)
        trunc_mat(body_prod(body_star(T), T), tt, N),            # (T^* = T)
        trunc_mat(body_prod(body_star(T), body_prod(I, T)), tt, N),   # (identity_matrix_is_left_unit_of_mat_mult)
    ]
    for q in range(len(lines) - 1):
        assert lines[q] == lines[q + 1], (n, q)
    assert trunc_mat(body_prod(ex(body_neg(H, P)), T), tt, N) == I       # T'T = I
    print(f"n = {n}: 形式冪級数として t の {N} 次まで主張の鎖の 5 個の等号と T'T = I を確かめた")

set_random_seed(29)
for n in [1, 2, 3, 4]:
    for _ in range(3):
        gS = rand_hermitian(n) / 3
        gH = gS / 2
        Eb = body_exp_ball(gS)
        Tb, Tpb = body_exp_ball(gH), body_exp_ball(-gH)
        Ib = identity_matrix(CB, n)
        chain = [Eb, body_exp_ball(gH + gH), Tb * Tb, Tb.conjugate_transpose() * Tb, Tb.conjugate_transpose() * (Ib * Tb)]
        for q in range(len(chain) - 1):
            assert balls_overlap(chain[q], chain[q + 1]), (n, q)
        assert ball_contains_exact(Tpb * Tb, identity_matrix(KG, n))          # T'T = I
        assert balls_overlap(Eb, sage_exp_ball(gS))
        assert balls_overlap(Eb.conjugate_transpose(), Eb)                     # エルミート
        for _ in range(8):
            gx = rand_nonzero_vector(n)
            xb = vector(CB, list(gx))
            v = (xb.conjugate() * Eb) * xb                                     # x^*exp(S)x
            assert v.imag().contains_zero() and v.real() > 0
            w = Tb * xb
            assert v.overlaps(sum(wi.conjugate() * wi for wi in w))            # = (Tx)^*I(Tx) = Σ|w_k|^2
            vs = (xb.conjugate() * sage_exp_ball(gS)) * xb                     # 比べる側: Sage の exp で同じ量
            assert vs.imag().contains_zero() and vs.real() > 0 and vs.overlaps(v)
    print(f"n = {n}: 具体の 3 個のエルミートな S で主張の鎖の各行のボールが重なり、各 8 本の x で x^*exp(S)x の囲みが正であることを確かめた")
print("RESULT: PASS")

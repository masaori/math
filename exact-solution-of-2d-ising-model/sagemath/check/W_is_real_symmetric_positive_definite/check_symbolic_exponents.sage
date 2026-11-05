# 対象ラベル: W_is_real_symmetric_positive_definite
# Step 1 と Step 2 のうち指数の肩についての行を、K_1・K_2^* を KG = QQ(i) 上の実の不定元にした多項式環で
# （任意の実数の K_1・K_2^* について成り立つ形で）厳密に確かめる。M_col = 2..5。
# - Step 1: σ_m^zσ_{m+1}^z（σ_{M+1}^z := σ_1^z）は成分が実で転置について対称、K_1D も実対称、
#   S_2 の表示の鎖 S_2 = iK_2^*H_2 = K_2^*Σ_m σ_m^x、S_2 は実対称。
# - Step 2: K_1D・S_2 はエルミート（real_symmetric_matrix_is_hermitian）、(1/2)K_1D もエルミート
#   （real_multiple_of_hermitian_is_hermitian）。(1/2)K_1D は実対称（成分が実と、転置の鎖 3 行）。
#   B = exp((1/2)K_1D)・A = exp(S_2) が実対称であること（exp_of_real_symmetric_is_real_symmetric）は、
#   check_exact_exponentials_and_W.sage が固有値の射影から作った B・A で見る。
load("_prelude.sage")

P.<K1, K2s> = PolynomialRing(KG)   # 実の不定元（係数の共役で複素共役を取る）
iP = P(i_K)


def partial_sum(X, N):
    """def_exp の部分和 Σ_{p=0}^{N} (1/p!) X^p（冪は X^0 := I、X^{p+1} := X^p X）。"""
    R = X.base_ring()
    n = X.nrows()
    out = body_identity(R, n)
    Xp = body_identity(R, n)
    for p in range(1, N + 1):
        Xp = body_product(Xp, X)
        out = body_sum(out, body_scalar(R(1) / factorial(p), Xp))
    return out


for M in range(2, 6):
    n = 2**M
    # Step 1: σ_m^zσ_{m+1}^z は成分が実で転置について対称
    bonds = [body_product(site(M, m, 'z'), site_periodic_z(M, m + 1)) for m in range(1, M + 1)]
    for m, Zb in enumerate(bonds, start=1):
        assert entries_are_real(Zb), (M, m)
        eq(body_transpose(Zb), Zb, f"M={M}, m={m}: (σ_m^zσ_{{m+1}}^z)^⊤")
    # K_1D（実係数 K_1 の有限和）は実対称
    D = bond_sum(M)
    eq(D, body_finite_sum(bonds), f"M={M}: D の有限和")
    K1D = body_scalar(K1, D.change_ring(P))
    assert entries_are_real(K1D)
    eq(body_transpose(K1D), K1D, f"M={M}: (K_1D)^⊤ = K_1D")
    # Step 1 の S_2 の表示の鎖: S_2 := iK_2^*H_2（定義） = K_2^*Σ_m σ_m^x（iH_is_real_symmetric の Step 1）
    S2 = body_scalar(iP * K2s, H2(M).change_ring(P))
    S2_x = body_scalar(K2s, body_finite_sum([site(M, m, 'x') for m in range(1, M + 1)]).change_ring(P))
    eq(S2, S2_x, f"M={M}: iK_2^*H_2 = K_2^*Σσ^x")
    assert entries_are_real(S2)
    eq(body_transpose(S2), S2, f"M={M}: S_2^⊤ = S_2")
    # 否定コントロール: i を掛けない K_2^*H_2 は成分が実でなく、エルミートでもない（H_2^* = −H_2）
    H2P = body_scalar(K2s, H2(M).change_ring(P))
    assert not entries_are_real(H2P)
    n_neg += 1
    neq(conj_transpose_exact(H2P), H2P, f"M={M}: K_2^*H_2 はエルミートでない")
    # 否定コントロール: 実だが対称でない σ_1^zσ_1^x（= iσ_1^y）では転置の検査が落ちる
    ZX = body_product(site(M, 1, 'z'), site(M, 1, 'x'))
    assert entries_are_real(ZX)
    neq(body_transpose(ZX), ZX, f"M={M}: σ_1^zσ_1^x は対称でない")
    # Step 2: K_1D・S_2 はエルミート、(1/2)K_1D もエルミート
    eq(conj_transpose_exact(K1D), K1D, f"M={M}: (K_1D)^* = K_1D")
    eq(conj_transpose_exact(S2), S2, f"M={M}: S_2^* = S_2")
    halfK1D = body_scalar(P(1) / 2, K1D)
    eq(conj_transpose_exact(halfK1D), halfK1D, f"M={M}: ((1/2)K_1D)^* = (1/2)K_1D")
    # Step 2: (1/2)K_1D は実対称。成分が実（real_scalar_multiple_of_real_entry_matrix_has_real_entries）と、転置の鎖 3 行
    #   ((1/2)K_1D)^⊤ = (1/2)_C (K_1D)^⊤（transpose_of_matrix_scalar_multiple） = (1/2)_C (K_1D)（Step 1） = (1/2)K_1D（略記）
    assert entries_are_real(halfK1D)
    half_lines = [
        body_transpose(halfK1D),
        body_scalar(P(1) / 2, body_transpose(K1D)),
        body_scalar(P(1) / 2, K1D),
        halfK1D,
    ]
    for t_ in range(1, len(half_lines)):
        eq(half_lines[t_ - 1], half_lines[t_], f"M={M}: ((1/2)K_1D)^⊤ の鎖 {t_} 行目")
    # 否定コントロール: (1/2)σ_1^zσ_1^x（成分は実だが対称でない）では鎖の 2 行目 → 3 行目が外れる
    halfZX = body_scalar(P(1) / 2, ZX.change_ring(P))
    neq(body_scalar(P(1) / 2, body_transpose(ZX.change_ring(P))), halfZX, f"M={M}: (1/2)σ_1^zσ_1^x の転置")
    print(f"M_col = {M}: Step 1 と Step 2 の肩の行を KG[K_1, K_2^*] で確かめた（累計の等号 {n_steps} 個）")
print(f"等号 {n_steps} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")

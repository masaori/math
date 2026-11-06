# 対象ラベル: c_plus_equals_Lambda_half_integer（準備 2〜4、Step 0 の二本の鎖、Step 1 の四本の鎖と「x は任意」の読み）
# 結合定数 K_1 := 2 log y、K_2 := log x、(x, y) ∈ COUPLINGS、M_col = 2, 3。等号は QQ・数体 E_1・QQbar、不等号は AA の厳密計算。
# 証明の記号: n := 2^{M_col}、ι^n := ι^n_{ℝ→ℂ}（def_real_vector_inclusion、ι^n(x) = ((x_k)_ℂ)_k）、W_ℝ（def_W_real、((W_ℝ)_kl)_ℂ = W_kl）、u := ι^n(x)、w_ε := Q̌_εu。
# - x は F^(+) ∩ ℚ^n の ‖x‖ = 1 の元（単位球面の有理点から作る）。x の成分は有理数なので、ι^n(x) の成分の複素共役は恒等写像で、
#   u^*Au は def_conjugate_bilinear_value の成分の式を共役を恒等写像として E_1 の中で組む（conj_bilinear）。
#   一般の u（複素の成分）の準備 3・準備 4 は、QQbar の本物の共役で別に確かめる。
# - x^⊤W_ℝx は def_real_bilinear_value の成分の式（real_bilinear）で W_ℝ（QQ）から組む。(·)_ℂ は QQ → E_1（または QQbar）の埋め込み。
# - Λ̌_ε を掛ける行は E_1 の元 lam[ε]（像が AA の Λ̌_ε に等しいことは CPlusSetting で確かめてある）で組み、
#   ‖w_ε‖^2 を含む行は QQbar へ移して AA で比べる。
load("_prelude.sage")

rep = Report("c_plus_equals_Lambda_half_integer: 準備・Step 0・Step 1")
T_LIST = {2: [[QQ(0)], [QQ(1) / 3], [QQ(-2)], [QQ(5) / 7]],
          3: [[QQ(0), QQ(0), QQ(0)], [QQ(1) / 2, QQ(-1) / 3, QQ(2)], [QQ(3), QQ(1) / 5, QQ(-4) / 7], [QQ(-1), QQ(1), QQ(1) / 9]]}
ident = lambda z: z            # 有理数の成分の複素共役（恒等写像）
cj = lambda z: z.conjugate()   # QQbar の複素共役

for s in c_plus_settings([2, 3]):
    M, n, F = s.M, s.N, s.F
    tag = s.tag
    iF = s.i_F()
    toq = s.to_qqbar
    # ---------------- 準備 1 ----------------
    WR = s.WQ                                            # W_ℝ（成分 (W_ℝ)_kl ∈ QQ ⊂ ℝ）
    rep.eq(s.W, WR.change_ring(F), f"{tag}: 準備 1 の ((W_ℝ)_kl)_ℂ = W_kl（def_W_real）")
    # ---------------- 準備 3・準備 4（一般の複素の u で、QQbar の本物の共役） ----------------
    VA = s.VQ.change_ring(QQbar)
    for useed in [[QQbar(1) + 2 * QQbar(I) * k - QQbar(k * k) / 3 for k in range(n)],
                  [QQbar(I) ** k * (k + 1) for k in range(n)]]:
        uq = col(QQbar, useed)
        for A in [VA, s.WQ.change_ring(QQbar)]:
            P1 = conj_bilinear(uq.list(), A, uq.list(), cj)
            P2 = ordered_sum([ordered_sum([cj(uq[k, 0]) * (A[k, l] * uq[l, 0]) for l in range(n)], 0) for k in range(n)], 0)
            P3 = ordered_sum([cj(uq[k, 0]) * ordered_sum([A[k, l] * uq[l, 0] for l in range(n)], 0) for k in range(n)], 0)
            Au = body_product(A, uq)
            P4 = ordered_sum([cj(uq[k, 0]) * Au[k, 0] for k in range(n)], 0)
            rep.chain([P1, P2, P3, P4], f"{tag}: 準備 3 の鎖")
        R1 = ordered_sum([cj(z) * z for z in uq.list()], 0)
        R2 = ordered_sum([QQbar(abs(z)**2) for z in uq.list()], 0)
        R3 = QQbar(AA(sum(abs(z)**2 for z in uq.list())))
        nrm = AA(sum(abs(z)**2 for z in uq.list())).sqrt()   # def_matrix_norm の ‖u‖
        R4 = QQbar(nrm**2)
        rep.chain([R1, R2, R3, R4], f"{tag}: 準備 4 の鎖")

    # ---------------- Step 0 ----------------
    coeff_sets = [[F(1)] * len(s.orbits),
                  [F(k + 1) + F(2 - k) * iF for k in range(len(s.orbits))],
                  [F(QQ(k) / 3) - iF * F(k * k) for k in range(len(s.orbits))]]
    half = F(1) / 2
    for cs in coeff_sets:
        ys = [F(0)] * n
        for (k, l), c in zip(s.orbits, cs):
            ys[k] = c
            ys[l] = c
        yv = col(F, ys)
        rep.eq(body_product(s.E, yv), yv, f"{tag}: y ∈ F^(+)（εy = y）")
        IpE = body_sum(s.Id, s.E)
        L1 = body_product(s.Pplus, yv)
        L2 = body_product(body_scalar(half, IpE), yv)
        L3 = body_scalar(half, body_product(IpE, yv))
        L4 = body_scalar(half, body_sum(body_product(s.Id, yv), body_product(s.E, yv)))
        L5 = body_scalar(half, body_sum(yv, body_product(s.E, yv)))
        L6 = body_scalar(half, body_sum(yv, yv))
        L7 = yv
        rep.chain([L1, L2, L3, L4, L5, L6, L7], f"{tag}: Step 0 の P^(+)y の鎖")
        W1 = body_product(s.W, yv)
        W2 = body_product(s.W, body_product(s.Pplus, yv))
        W3 = body_product(body_product(s.W, s.Pplus), yv)
        W4 = body_product(body_product(s.V, s.Pplus), yv)
        W5 = body_product(s.V, body_product(s.Pplus, yv))
        W6 = body_product(s.V, yv)
        rep.chain([W1, W2, W3, W4, W5, W6], f"{tag}: Step 0 の Wy の鎖")
    rep.eq(body_product(s.W, s.Pplus), body_product(s.V, s.Pplus), f"{tag}: WP^(+) = V^(+)P^(+)")
    xo = col(F, [F(z) for z in odd_real_vector(s.orbits, n, [QQ(j + 1) for j in range(len(s.orbits))])])
    rep.neg(body_product(s.Pplus, xo) != xo, f"{tag}: 奇の y で P^(+)y ≠ y")
    rep.neg(body_product(s.W, xo) != body_product(s.V, xo), f"{tag}: 奇の y で Wy ≠ V^(+)y")
    rep.neg(s.W != s.V, f"{tag}: W ≠ V^(+)（F^(+) の上でだけ一致する）")

    # ---------------- Step 1 ----------------
    Qsum = fsum_left([s.Q[w] for w in s.words])
    rep.eq(Qsum, s.Id, f"{tag}: Σ_εQ̌_ε = I（check_joint_eigenspace_decomposition (2)）")
    for w in s.words:
        rep.ineq(s.L[w] > 0 and s.L[w] <= s.Lmax, f"{tag}: 0 < Λ̌_ε ≤ Λ̌_max（eigenvalues_of_V_plus (2)）")
    for t in T_LIST[M]:
        xq = even_real_unit_vector(s.orbits, n, t)       # x ∈ ℚ^n ⊂ ℝ^n
        u = col(F, [F(z) for z in xq])                   # u := ι^n(x)
        rep.eq(body_product(s.E, u), u, f"{tag}: ι^n(x) ∈ F^(+)")
        rep.eq(sum(z * z for z in xq), 1, f"{tag}: ‖x‖^2 = 1")
        # 準備 2 の鎖（実の値は QQ、(·)_ℂ は QQ → E_1）
        B1 = F(real_bilinear(xq, WR, xq))
        B2 = ordered_sum([ordered_sum([F((xq[k] * WR[k, l]) * xq[l]) for l in range(n)], F(0)) for k in range(n)], F(0))
        B3 = ordered_sum([ordered_sum([(F(xq[k]) * F(WR[k, l])) * F(xq[l]) for l in range(n)], F(0)) for k in range(n)], F(0))
        B4 = ordered_sum([ordered_sum([(ident(F(xq[k])) * F(WR[k, l])) * F(xq[l]) for l in range(n)], F(0)) for k in range(n)], F(0))
        B5 = ordered_sum([ordered_sum([(ident(u[k, 0]) * F(WR[k, l])) * u[l, 0] for l in range(n)], F(0)) for k in range(n)], F(0))
        B6 = ordered_sum([ordered_sum([(ident(u[k, 0]) * s.W[k, l]) * u[l, 0] for l in range(n)], F(0)) for k in range(n)], F(0))
        B7 = conj_bilinear(u.list(), s.W, u.list(), ident)
        rep.chain([B1, B2, B3, B4, B5, B6, B7], f"{tag}: 準備 2 の鎖")
        # u = Σ_ε w_ε と V^(+)u = Σ_ε (Λ̌_ε)_ℂ w_ε
        ws = {w: body_product(s.Q[w], u) for w in s.words}
        U1 = u
        U2 = body_product(s.Id, u)
        U3 = body_product(Qsum, u)
        U4 = fsum_left([body_product(s.Q[w], u) for w in s.words])
        U5 = fsum_left([ws[w] for w in s.words])
        rep.chain([U1, U2, U3, U4, U5], f"{tag}: u = Σ_ε w_ε の鎖")
        V1 = body_product(s.V, u)
        V2 = body_product(s.V, fsum_left([body_product(s.Q[w], u) for w in s.words]))
        V3 = fsum_left([body_product(s.V, body_product(s.Q[w], u)) for w in s.words])
        V4 = fsum_left([body_product(body_product(s.V, s.Q[w]), u) for w in s.words])
        V5 = fsum_left([body_product(body_scalar(s.lam[w], s.Q[w]), u) for w in s.words])
        V6 = fsum_left([body_scalar(s.lam[w], ws[w]) for w in s.words])
        rep.chain([V1, V2, V3, V4, V5, V6], f"{tag}: V^(+)u = Σ_ε (Λ̌_ε)_ℂ w_ε の鎖")
        for k in range(n):
            rep.eq(u[k, 0], ordered_sum([ws[w][k, 0] for w in s.words], F(0)), f"{tag}: u_k = Σ_ε (w_ε)_k")
            rep.eq(V1[k, 0], ordered_sum([s.lam[w] * ws[w][k, 0] for w in s.words], F(0)), f"{tag}: (V^(+)u)_k の成分の式")
        # Step 1 の三本目の鎖（1〜8 行目は E_1）
        Wu = body_product(s.W, u)
        C1 = B1
        C2 = B7
        C3 = ordered_sum([ident(u[k, 0]) * Wu[k, 0] for k in range(n)], F(0))
        C4 = ordered_sum([ident(u[k, 0]) * V1[k, 0] for k in range(n)], F(0))
        C5 = ordered_sum([ident(u[k, 0]) * ordered_sum([s.lam[w] * ws[w][k, 0] for w in s.words], F(0)) for k in range(n)], F(0))
        C6 = ordered_sum([ordered_sum([s.lam[w] * (ident(u[k, 0]) * ws[w][k, 0]) for w in s.words], F(0)) for k in range(n)], F(0))
        C7 = ordered_sum([ordered_sum([s.lam[w] * (ident(u[k, 0]) * ws[w][k, 0]) for k in range(n)], F(0)) for w in s.words], F(0))
        C8 = ordered_sum([s.lam[w] * ordered_sum([ident(u[k, 0]) * ws[w][k, 0] for k in range(n)], F(0)) for w in s.words], F(0))
        C9 = ordered_sum([s.lam[w] * conj_bilinear(u.list(), s.Q[w], u.list(), ident) for w in s.words], F(0))
        rep.chain([C1, C2, C3, C4, C5, C6, C7, C8, C9], f"{tag}: Step 1 の (x^⊤W_ℝx)_ℂ の鎖の 1〜9 行目")
        nq = {}
        for w in s.words:
            nq[w] = norm2_AA(s.to_qqbar_mat(ws[w]))                      # ‖w_ε‖^2（AA）
            rep.eq(toq(conj_bilinear(u.list(), s.Q[w], u.list(), ident)), QQbar(nq[w]), f"{tag}: u^*Q̌_εu = (‖w_ε‖^2)_ℂ")
            rep.ineq(nq[w] >= 0, f"{tag}: ‖w_ε‖^2 ≥ 0")
        C10 = ordered_sum([QQbar(s.L[w]) * QQbar(nq[w]) for w in s.words], QQbar(0))
        C11 = ordered_sum([QQbar(s.L[w] * nq[w]) for w in s.words], QQbar(0))
        C12 = QQbar(ordered_sum([s.L[w] * nq[w] for w in s.words], AA(0)))
        rep.chain([toq(C9), C10, C11, C12], f"{tag}: Step 1 の (x^⊤W_ℝx)_ℂ の鎖の 9〜12 行目")
        # Σ‖w_ε‖^2 = ‖x‖^2 の鎖
        D1 = QQbar(ordered_sum([nq[w] for w in s.words], AA(0)))
        D2 = ordered_sum([QQbar(nq[w]) for w in s.words], QQbar(0))
        D3 = ordered_sum([toq(conj_bilinear(u.list(), s.Q[w], u.list(), ident)) for w in s.words], QQbar(0))
        D4 = toq(ordered_sum([ordered_sum([ident(u[k, 0]) * ws[w][k, 0] for k in range(n)], F(0)) for w in s.words], F(0)))
        D5 = toq(ordered_sum([ordered_sum([ident(u[k, 0]) * ws[w][k, 0] for w in s.words], F(0)) for k in range(n)], F(0)))
        D6 = toq(ordered_sum([ident(u[k, 0]) * ordered_sum([ws[w][k, 0] for w in s.words], F(0)) for k in range(n)], F(0)))
        D7 = toq(ordered_sum([ident(u[k, 0]) * u[k, 0] for k in range(n)], F(0)))
        D8 = QQbar(norm2_AA(s.to_qqbar_mat(u)))
        D9 = QQbar(AA(sum(z * z for z in xq)))
        rep.chain([D1, D2, D3, D4, D5, D6, D7, D8, D9], f"{tag}: Σ‖w_ε‖^2 = ‖x‖^2 の鎖")
        # inclusion_rr_to_cc_is_injective で ℝ へ戻した等式と、実数の鎖
        xR = AA(real_bilinear(xq, WR, xq))
        rep.eq(QQbar(xR), C12, f"{tag}: x^⊤W_ℝx = Σ_εΛ̌_ε‖w_ε‖^2（ℝ）")
        E1 = ordered_sum([s.L[w] * nq[w] for w in s.words], AA(0))
        E2 = ordered_sum([s.Lmax * nq[w] for w in s.words], AA(0))
        for w in s.words:
            rep.ineq(s.L[w] * nq[w] <= s.Lmax * nq[w], f"{tag}: 各項の Λ̌_ε‖w_ε‖^2 ≤ Λ̌_max‖w_ε‖^2")
        rep.eq(xR, E1, f"{tag}: 実数の鎖の 1 行目")
        rep.ineq(E1 <= E2, f"{tag}: 実数の鎖の 2 行目（≤）")
        E3 = s.Lmax * ordered_sum([nq[w] for w in s.words], AA(0))
        E4 = s.Lmax * AA(sum(z * z for z in xq))
        E5 = s.Lmax
        rep.chain([E2, E3, E4, E5], f"{tag}: 実数の鎖の 3〜5 行目")
        rep.neg(s.Lmax * AA(4 * sum(z * z for z in xq)) != E5, f"{tag}: ‖2x‖ ≠ 1 で最後の行が外れる")
    xo_l = [F(z) for z in odd_real_vector(s.orbits, n, [QQ(j + 1) for j in range(len(s.orbits))])]
    rep.neg(conj_bilinear(xo_l, s.W, xo_l, ident) != conj_bilinear(xo_l, s.V, xo_l, ident),
            f"{tag}: 奇の x で u^*Wu ≠ u^*V^(+)u（Step 1 の 3 行目は u ∈ F^(+) を使う）")
    print(f"  {tag}: Λ̌_max ≈ {RR(s.Lmax):.6f}（累計 等号 {rep.n_eq} 件）")

rep.finish()

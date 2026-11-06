# 対象ラベル: c_plus_equals_Lambda_half_integer（Step 2・Step 3・結びの鎖と、主張そのもの）
# 結合定数 K_1 := 2 log y、K_2 := log x、(x, y) ∈ COUPLINGS、M_col = 2, 3。全て E_1・QQbar・AA の厳密計算（複素共役は QQbar の conjugate）。
# Step 2:
#   im Q̌_{(1,…,1)} が 1 次元（rank 1）、生成元 q ≠ 0、V^(+)q = (Λ̌_max)_ℂ q、q ∈ F^(+)、Wq = V^(+)q、εq = q。
#   (Wq̄)_k の鎖 10 行（def_W_real の ((W_ℝ)_kl)_ℂ = W_kl を使う）と、同じ鎖の W → ε、W_ℝ → ε_ℝ（def_epsilon_real）、(Λ̌_max)_ℂ → 1_ℂ 版。
#   q̄ ∈ F^(+)、V^(+)q̄ = Wq̄ = (Λ̌_max)_ℂ q̄、q̄ = zq（max_eigenvalue_of_V_plus_simple (3) の固有空間が ℂq）、
#   conj(p_k) の鎖 4 行、conj(p'_k) の鎖 7 行、p の鎖 2 行、p' の鎖 3 行、1 + z と i(1 − z) は同時に 0 にならない、
#   v = cq ≠ 0、conj(v_k) = v_k、v_k = (a_k)_ℂ、r := (a_k) ≠ 0、‖r‖ > 0、x_0 := r/‖r‖ で ‖x_0‖ = 1、ι^n(x_0) = ((1/‖r‖)_ℂ c)q。
#   証明の q は im Q̌_(1,…,1) の任意の生成元なので、q に c_gen = 1, 1 + 2i, i を掛けた三つの生成元で行う
#   （c_gen = 1 は q̄ = q、1 + 2i は q が実でない場合、i は p = 0 で p' を使う場合）。
# Step 3: u_0 := ι^n(x_0) ∈ im Q̌、u_0 ∈ F^(+)、V^(+)u_0 = (Λ̌_max)_ℂ u_0、(x_0^⊤W_ℝx_0)_ℂ の鎖 8 行、x_0^⊤W_ℝx_0 = Λ̌_max。
# 結び: θ^{(1/2)}_{M,μ} = θ̃_μ、c_+ = Λ̌_max = Λ^{(1/2)}_{M_col} = (2 sinh 2K_2)^{M/2}exp(½Σγ(θ̃_μ))。
# 主張そのもの: c_+(M_col) = sup R_+ を、F^(+) ∩ ℝ^n の正規直交基底 b_j := (e_k + e_{π(k)})/√2 での W_ℝ の制限の
#   最大固有値として Λ̌ を経由せずに作り（rayleigh_sup_exact。上界と到達の両方を確かめる）、Λ̌_max と一致し、x_0 で達成されること。
load("_prelude.sage")

rep = Report("c_plus_equals_Lambda_half_integer: Step 2・Step 3・結び・主張")
n_nonreal_q = 0
n_p_zero = 0
cj = lambda z: z.conjugate()


def conj_vec(w):
    return matrix(QQbar, w.nrows(), 1, [cj(z) for z in w.list()])


for s in c_plus_settings([2, 3]):
    M, n = s.M, s.N
    tag = s.tag
    x, y = s.x, s.y
    Q1 = s.Q[s.ones]
    WA = s.WQ.change_ring(QQbar)                     # W（成分 ((W_ℝ)_kl)_ℂ、(W_ℝ)_kl ∈ QQ）
    VA = s.VQ.change_ring(QQbar)
    EA = s.to_qqbar_mat(s.E)
    Q1A = s.to_qqbar_mat(Q1)
    LmQ = QQbar(s.Lmax)
    one = QQbar(1)
    iQ = QQbar(I)
    rep.ineq(all(z.imag() == 0 for z in EA.list()), f"{tag}: ε の成分は実（epsilon_is_real_symmetric）")
    WR = s.WQ.change_ring(AA)                        # W_ℝ（def_W_real）
    ER = EA.apply_map(lambda z: AA(z.real()))        # ε_ℝ（def_epsilon_real）
    rep.eq(WR.change_ring(QQbar), WA, f"{tag}: ((W_ℝ)_kl)_ℂ = W_kl（def_W_real）")
    rep.eq(ER.change_ring(QQbar), EA, f"{tag}: ((ε_ℝ)_kl)_ℂ = ε_kl（def_epsilon_real）")
    # ---------------- Step 2 ----------------
    rep.eq(Q1.rank(), 1, f"{tag}: dim im Q̌_(1,…,1) = 1（check_joint_eigenspace_decomposition (4)）")
    _, qF = s.chosen_q(s.ones)
    q_base = s.to_qqbar_mat(qF)
    K = (VA - LmQ * identity_matrix(QQbar, n)).right_kernel()
    rep.eq(K.dimension(), 1, f"{tag}: 固有空間 {{x | V^(+)x = Λ̌_max x}} の次元は 1")
    for cgen in [one, one + 2 * iQ, iQ]:
        q = body_scalar(cgen, q_base)
        rep.ineq(q != 0, f"{tag}: q ≠ 0")
        rep.eq(body_product(Q1A, q), q, f"{tag}: q ∈ im Q̌_(1,…,1)")
        rep.eq(body_product(VA, q), LmQ * q, f"{tag}: V^(+)q = (Λ̌_max)_ℂ q")
        rep.eq(body_product(EA, q), q, f"{tag}: q ∈ F^(+)（max_eigenvector_in_even_sector (4)）")
        rep.chain([body_product(WA, q), body_product(VA, q), LmQ * q], f"{tag}: Wq = V^(+)q = (Λ̌_max)_ℂ q")
        if cgen.imag() != 0:
            rep.neg(not is_real_col(q), f"{tag}: 生成元 {cgen}·q は実でない（実ベクトルを作る段が要る）")
        qb = conj_vec(q)
        # (Wq̄)_k の鎖と、W → ε、(Λ̌_max)_ℂ → 1_ℂ の版
        for (A, AR, lam, nm) in [(WA, WR, LmQ, "W"), (EA, ER, one, "ε")]:
            Aq = body_product(A, q)
            Aqb = body_product(A, qb)
            for k in range(n):
                l1 = Aqb[k, 0]
                l2 = ordered_sum([A[k, l] * qb[l, 0] for l in range(n)], QQbar(0))
                l2a = ordered_sum([QQbar(AR[k, l]) * qb[l, 0] for l in range(n)], QQbar(0))
                l2b = ordered_sum([cj(QQbar(AR[k, l])) * qb[l, 0] for l in range(n)], QQbar(0))
                l3 = ordered_sum([cj(A[k, l]) * cj(q[l, 0]) for l in range(n)], QQbar(0))
                l4 = ordered_sum([cj(A[k, l] * q[l, 0]) for l in range(n)], QQbar(0))
                l5 = cj(ordered_sum([A[k, l] * q[l, 0] for l in range(n)], QQbar(0)))
                l6 = cj(Aq[k, 0])
                l7 = cj(lam * q[k, 0])
                l8 = cj(lam) * cj(q[k, 0])
                l9 = lam * cj(q[k, 0])
                rep.chain([l1, l2, l2a, l2b, l3, l4, l5, l6, l7, l8, l9], f"{tag}: ({nm}q̄)_k の鎖")
        rep.eq(body_product(EA, qb), qb, f"{tag}: q̄ ∈ F^(+)")
        rep.chain([body_product(VA, qb), body_product(WA, qb), LmQ * qb], f"{tag}: V^(+)q̄ = Wq̄ = (Λ̌_max)_ℂ q̄")
        rep.ineq(vector(QQbar, qb.list()) in K, f"{tag}: q̄ は固有空間（= im Q̌_(1,…,1) = ℂq）に入る")
        i0 = next(k for k in range(n) if q[k, 0] != 0)
        z = qb[i0, 0] / q[i0, 0]
        rep.eq(qb, z * q, f"{tag}: q̄ = zq")
        if qb != q:
            n_nonreal_q += 1
        # p, p'
        p = q + qb
        pp = body_scalar(iQ, q - qb)
        rep.eq(cj(iQ), -iQ, f"{tag}: conj(i) = −i")
        for k in range(n):
            rep.chain([cj(p[k, 0]), cj(q[k, 0] + cj(q[k, 0])), cj(q[k, 0]) + cj(cj(q[k, 0])), cj(q[k, 0]) + q[k, 0], p[k, 0]],
                      f"{tag}: conj(p_k) の鎖")
            rep.chain([cj(pp[k, 0]), cj(iQ * (q[k, 0] - cj(q[k, 0]))), cj(iQ) * cj(q[k, 0] - cj(q[k, 0])),
                       (-iQ) * cj(q[k, 0] - cj(q[k, 0])), (-iQ) * (cj(q[k, 0]) - cj(cj(q[k, 0]))),
                       (-iQ) * (cj(q[k, 0]) - q[k, 0]), iQ * (q[k, 0] - cj(q[k, 0])), pp[k, 0]], f"{tag}: conj(p'_k) の鎖")
        rep.chain([p, q + z * q, body_scalar(one + z, q)], f"{tag}: p = q + zq = (1 + z)q")
        rep.chain([pp, body_scalar(iQ, q - z * q), body_scalar(iQ, body_scalar(one - z, q)), body_scalar(iQ * (one - z), q)],
                  f"{tag}: p' = i(q − zq) = i((1 − z)q) = (i(1 − z))q")
        rep.ineq(not (one + z == 0 and iQ * (one - z) == 0), f"{tag}: 1 + z と i(1 − z) は同時に 0 にならない")
        c = (one + z) if (one + z) != 0 else iQ * (one - z)
        v = p if (one + z) != 0 else pp
        if (one + z) == 0:
            n_p_zero += 1
        rep.eq(v, body_scalar(c, q), f"{tag}: v = cq")
        k0 = next(k for k in range(n) if q[k, 0] != 0)
        rep.ineq(c != 0 and v[k0, 0] != 0, f"{tag}: c ≠ 0 なので v_{{k_0}} ≠ 0")
        rep.eq(c**(-1) * (c * q[k0, 0]), q[k0, 0], f"{tag}: c^{{-1}}(c q_{{k_0}}) = q_{{k_0}}")
        for k in range(n):
            rep.eq(cj(v[k, 0]), v[k, 0], f"{tag}: conj(v_k) = v_k")
            rep.eq(v[k, 0].imag(), 0, f"{tag}: v_k = (a_k, b_k) の b_k = 0")
        r = [AA(z0.real()) for z0 in v.list()]
        rep.eq(matrix(QQbar, n, 1, [QQbar(a) for a in r]), v, f"{tag}: ι^n(r) = v")
        nr2 = sum(a * a for a in r)
        rep.ineq(nr2 > 0, f"{tag}: ‖r‖^2 > 0")
        nr = nr2.sqrt()
        x0 = [a / nr for a in r]
        rep.eq(sum(a * a for a in x0), 1, f"{tag}: ‖x_0‖^2 = 1")
        u0 = matrix(QQbar, n, 1, [QQbar(a) for a in x0])
        rep.chain([u0, body_scalar(QQbar(1 / nr), v), body_scalar(QQbar(1 / nr) * c, q)], f"{tag}: ι^n(x_0) = (1/‖r‖)_ℂ v = ((1/‖r‖)_ℂ c)q")
        # ---------------- Step 3 ----------------
        rep.eq(body_product(Q1A, u0), u0, f"{tag}: u_0 ∈ im Q̌_(1,…,1)")
        rep.eq(body_product(EA, u0), u0, f"{tag}: u_0 ∈ F^(+)")
        Vu0 = body_product(VA, u0)
        rep.eq(Vu0, LmQ * u0, f"{tag}: V^(+)u_0 = (Λ̌_max)_ℂ u_0")
        Wu0 = body_product(WA, u0)
        WR_AA = s.WQ.change_ring(AA)
        S1 = QQbar(real_bilinear(x0, WR_AA, x0))
        S2 = conj_bilinear(u0.list(), WA, u0.list(), cj)
        S3 = ordered_sum([cj(u0[k, 0]) * Wu0[k, 0] for k in range(n)], QQbar(0))
        S4 = ordered_sum([cj(u0[k, 0]) * Vu0[k, 0] for k in range(n)], QQbar(0))
        S5 = ordered_sum([cj(u0[k, 0]) * (LmQ * u0[k, 0]) for k in range(n)], QQbar(0))
        S6 = LmQ * ordered_sum([cj(u0[k, 0]) * u0[k, 0] for k in range(n)], QQbar(0))
        S7 = LmQ * QQbar(sum(a * a for a in x0))
        S8 = QQbar(s.Lmax * sum(a * a for a in x0))
        S9 = LmQ
        rep.chain([S1, S2, S3, S4, S5, S6, S7, S8, S9], f"{tag}: Step 3 の (x_0^⊤W_ℝx_0)_ℂ の鎖")
        x0WR = real_bilinear(x0, WR_AA, x0)
        rep.eq(x0WR, s.Lmax, f"{tag}: x_0^⊤W_ℝx_0 = Λ̌_max（ℝ）")
    # ---------------- 結びと主張 ----------------
    for mu in range(1, M + 1):
        rep.eq(2 * (QQ(mu) - QQ(1) / 2) / M, QQ(2 * mu - 1) / M, f"{tag}: θ^(1/2)_{{M,μ}}/π = θ̃_μ/π = (2μ − 1)/M_col")
    egh = [gamma_exp_independent(x, y, QQ(2 * mu - 1) / M) for mu in range(1, M + 1)]   # 独立な経路の exp(γ(θ̃_μ))
    rep.eq(egh, s.eg, f"{tag}: 独立な経路の exp(γ(θ̃_μ)) が一致")
    two_sinh = x**2 - x**(-2)                                       # 2 sinh 2K_2 = exp(2K_2) − exp(−2K_2) = x^2 − x^{−2}
    rep.eq(AA(two_sinh).sqrt()**M, s.a, f"{tag}: (2 sinh 2K_2)^{{M_col/2}} = (2s_2)^{{M_col/2}}")
    Lhalf = AA(two_sinh).sqrt()**M * prod(e.sqrt() for e in egh)    # (2 sinh 2K_2)^{M/2} Π exp(γ(θ̃_μ)/2)
    Fm = matrix(QQ, n, len(s.orbits), lambda k, j: 1 if k in s.orbits[j] else 0)   # 列 f_j := e_k + e_{π(k)}
    G = (Fm.transpose() * s.WQ * Fm) / 2                           # (b_j^⊤W_ℝb_l)、b_j := f_j/√2
    cplus = rayleigh_sup_exact(G)                                  # sup{u^⊤Gu | ‖u‖ = 1} = sup R_+
    rep.chain([cplus, s.Lmax, Lhalf], f"{tag}: 結びの鎖 c_+ = Λ̌_max = Λ^(1/2) = 閉形式")
    rep.eq(x0WR, cplus, f"{tag}: 上限は x_0 で達成される")
    # 否定コントロール
    eg0 = [gamma_exp_independent(x, y, 2 * QQ(mu) / M) for mu in range(1, M + 1)]
    L0 = s.a * prod(e.sqrt() for e in eg0)
    rep.neg(L0 != cplus, f"{tag}: Λ^(0)_{{M_col}} ≠ c_+")
    cW = rayleigh_sup_exact(s.WQ)
    rep.ineq(cW >= cplus, f"{tag}: c(M_col) ≥ c_+(M_col)")
    Fo = matrix(QQ, n, len(s.orbits), lambda k, j: (1 if k == s.orbits[j][0] else (-1 if k == s.orbits[j][1] else 0)))
    Go = (Fo.transpose() * s.WQ * Fo) / 2
    rep.neg(rayleigh_sup_exact(Go) != cplus, f"{tag}: ε = −1 の側の上限は c_+ と違う")
    print(f"  {tag}: c_+ = Λ̌_max ≈ {RR(cplus):.6f}、c(M_col) ≈ {RR(cW):.6f}（累計 等号 {rep.n_eq} 件）")

print(f"q̄ ≠ q の生成元 {n_nonreal_q} 件、p = 0 で p' を使った生成元 {n_p_zero} 件")
rep.finish()

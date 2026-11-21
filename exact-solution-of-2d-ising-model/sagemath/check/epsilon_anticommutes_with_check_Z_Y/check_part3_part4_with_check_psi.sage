# 対象ラベル: epsilon_anticommutes_with_check_Z_Y（主張 (3)(4) と証明の (3)(4) の鎖を、本文の ψ̌ で）
# 結合定数を K_1 := 2 log y、K_2 := log x と選び、(x, y) ∈ {(2, 2), (3, 3/2), (5/4, 3)}、M_col = 2, 3 で、
# 本文の ψ̌（def_check_fermi の第二の式どおりの行列。../def_check_number_operator/_prelude.sage の NumberOperatorSetting）を使って次を確かめる。
#   (3) 各 μ について、(Ψ, p, q) = (ψ̌_μ^†, -r/(2√M_col b), 1/(2√M_col)) と (ψ̌_μ, +r/(2√M_col b), 1/(2√M_col)) の鎖の 9 個の等号と主張。
#       成分は数体 E_μ := F(r_μ)（r_μ := |γ_2(θ̃_μ)|）。
#   (4) 全ての μ を一つの数体 E_1 に移し（../check_joint_eigenspace_decomposition/_number_operators.sage の _check_psi_settings と同じ移し方）、
#       ň_μ の鎖の 3 個の等号とその仮定（(3) の 2 式）、εI = Iε の 2 個の等号、全ての ν について ε(I - ň_ν) = (I - ň_ν)ε の 1 式と、
#       εR_ν^{(ε(ν))} = R_ν^{(ε(ν))}ε の ε(ν) = 1・ε(ν) = 0 の両方の場合の 5 個ずつの等号（def_check_R_factor）、
#       全ての ε ∈ {0,1}^{M̌} について Q̌_ε の鎖の 5 個の等号と主張。Q̌_ε は Sage の `*`・`-` で組んだものと、本文の定め方で組んだ
#       Π_ν R_ν^{(ε(ν))}（def_check_Q_epsilon）の一致も確かめる。
# 等号は全て数体の中で厳密に判定する（浮動小数点は使わない）。ℝ への脱出は K_1・K_2 の選び方と r_μ・(√M_col)_C を代数的数として持つことだけである。
# 否定コントロール: ε の代わりに σ_1^z を入れると、ň_μ の鎖の仮定（(3) の 2 式）が外れ、σ_1^z ň_μ ≠ ň_μ σ_1^z となる μ がある。
#   ň_μ・Q̌_ε が単位行列のスカラー倍でないこと（可換性が自明でないこと）も見る。
load("../def_check_number_operator/_prelude.sage")
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("epsilon_anticommutes_with_check_Z_Y (3)(4): 本文の ψ̌ での鎖と主張（厳密）")

for (x, y) in COUPLINGS:
    for M in Ms:
        tag0 = f"(x,y)=({x},{y}) M={M}"
        f = Factors(M, x, y)
        st = NumberOperatorSetting(f)
        epsF = f.kg_to_F(epsilon(M))
        s1G = f.kg_to_F(site(M, 1, 'z'))
        # (3): μ ごとに E_μ の中で
        for m in st.J:
            s = st.S[m]
            Em = s.E
            E = epsF.change_ring(Em)
            pd, pp, qq = (-s.r) / (2 * s.sigma * s.b), s.r / (2 * s.sigma * s.b), 1 / (2 * s.sigma)
            for nm, Psi, p in (("ψ̌_μ^†", s.psid, pd), ("ψ̌_μ", s.psi, pp)):
                rep.check(Psi == body_sum(body_scalar(p, s.Z), body_scalar(qq, s.Y)), f"{tag0} μ={m}: {nm} は def_check_fermi の第二の式")
                rep.chain(chain_part3(E, s.Z, s.Y, p, qq, Psi), f"{tag0} μ={m} Ψ={nm}")
                rep.check(E * Psi == -(Psi * E), f"{tag0} μ={m}: 主張 (3) ε{nm} = -({nm}ε)（Sage の積）")
        # (4): E_1 に移して
        F1 = st.S[1].E
        maps = {}
        for m in st.J:
            s = st.S[m]
            if m == 1:
                maps[m] = lambda X: X
            elif s.E is st.f.F:
                maps[m] = lambda X, F1=F1: X.change_ring(F1)
            else:
                maps[m] = transport(s, st.S[1])
        E = epsF.change_ring(F1)
        G = s1G.change_ring(F1)
        Id = body_identity(F1, 2**M)
        Ds = [maps[m](st.dag[m]) for m in st.J]
        Ps = [maps[m](st.psi_sig[m]) for m in st.J]
        ns = [body_product(Ds[k], Ps[k]) for k in range(M)]
        g_breaks = False
        for k, m in enumerate(st.J):
            tag = f"{tag0} μ={m}"
            rep.check(body_product(E, Ds[k]) == body_negation(body_product(Ds[k], E)), f"{tag}: ň の鎖の仮定 εψ̌_μ^† = -(ψ̌_μ^†ε)")
            rep.check(body_product(E, Ps[k]) == body_negation(body_product(Ps[k], E)), f"{tag}: ň の鎖の仮定 εψ̌_σ(μ) = -(ψ̌_σ(μ)ε)")
            rep.chain(chain_part4_number(E, Ds[k], Ps[k], ns[k]), f"{tag} ň")
            rep.negative(ns[k] != ns[k][0, 0] * Id, f"{tag}: ň_μ は I のスカラー倍でない")
            hyp_G = body_product(G, Ds[k]) == body_negation(body_product(Ds[k], G)) and body_product(G, Ps[k]) == body_negation(body_product(Ps[k], G))
            rep.negative(not hyp_G, f"{tag}: σ_1^z では ň の鎖の仮定が外れる")
            g_breaks = g_breaks or (G * ns[k] != ns[k] * G)
        rep.negative(g_breaks, f"{tag0}: σ_1^z ň_μ ≠ ň_μ σ_1^z となる μ がある")
        rep.chain(chain_part4_identity(E, Id), f"{tag0} εI = Iε")
        for k in range(M):
            nm3, Lh, Rh = part4_difference_equation(E, ns[k], Id)
            rep.check(Lh == Rh, f"{tag0} ν={k+1}: {nm3}")
            for e in (1, 0):
                rep.chain(chain_part4_factor(E, e, ns[k], Id), f"{tag0} ν={k+1} ε(ν)={e} R_ν")
        for eps in cartesian_product([[0, 1]] * M):
            eps = tuple(eps)
            tag = f"{tag0} ε={eps}"
            Q = Q_check_by_definition(eps, ns, Id)
            rep.check(Q == body_finite_product([factor_R(eps[k], ns[k], Id) for k in range(M)]), f"{tag}: Q̌_ε（Sage の経路）= Π_ν R_ν^{{(ε(ν))}}（本文の定め方）")
            rep.negative(Q != Q[0, 0] * Id, f"{tag}: Q̌_ε は I のスカラー倍でない")
            rep.chain(chain_part4_Q(E, eps, ns, Id, Q), f"{tag} Q̌")
            rep.check(E * Q == Q * E, f"{tag}: 主張 (4) εQ̌_ε = Q̌_εε（Sage の積）")
        print(f"  {tag0}: 済（累計 {rep.n} 件、否定 {rep.neg} 件、失敗 {rep.fail} 件）", flush=True)

rep.finish()

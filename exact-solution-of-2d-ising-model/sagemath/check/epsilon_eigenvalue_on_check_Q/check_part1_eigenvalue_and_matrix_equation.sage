# 対象ラベル: epsilon_eigenvalue_on_check_Q（主張 (1) と証明の (1) の鎖を、本文の ψ̌ で）
# 各 ϵ ∈ {0,1}^{M̌} について、証明の (1) の鎖を行の括弧どおりに組んで隣どうし比べる:
#   仮定 rank Q̌_ϵ = 1（check_joint_eigenspace_decomposition (4)）・Q̌_ϵ^2 = Q̌_ϵ（同 (1)）・εQ̌_ϵ = Q̌_ϵε（epsilon_anticommutes_with_check_Z_Y (4)）・ε^2 = I、
#   Q̌_ϵq = q の鎖（4 行）、Q̌_ϵ(εq) = εq の鎖（5 行）、εq ∈ Cq と η、q = (ηη)q の鎖（8 行）、(ηη-1)q = O の鎖（5 行）、
#   ηη - 1 = 0、(η-1)(η+1) = 0 の鎖（5 行）、η ∈ {±1}、全ての e_k について (εQ̌_ϵ)x = (ηQ̌_ϵ)x の鎖（10 行）、
#   εQ̌_ϵ = ηQ̌_ϵ の列の鎖（8 行）、一意性の鎖（7 行、η' = η）、主張 (1)。
# 否定コントロール: η' = -η では εQ̌_ϵ ≠ η'Q̌_ϵ。ε を σ_1^z に替えると、σ_1^z q ∉ Cq となる ϵ がある（(1) の仮定 εQ̌_ϵ = Q̌_ϵε が要ること）。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("epsilon_eigenvalue_on_check_Q (1): 本文の ψ̌ での鎖と主張（厳密）")

for st in settings(Ms):
    E, Id, F, N = st.E, st.Id, st.F, st.N
    rep.check(P_(E, E) == Id, f"{st.tag}: ε^2 = I（epsilon_square_and_eigenvalues）")
    G_breaks = False
    for w in st.words:
        tag = f"{st.tag} ϵ={w}"
        Q = st.Q[w]
        rep.check(Q.rank() == 1, f"{tag}: 仮定 dim im Q̌_ϵ = 1")
        rep.check(P_(Q, Q) == Q, f"{tag}: 仮定 Q̌_ϵ^2 = Q̌_ϵ")
        rep.check(P_(E, Q) == P_(Q, E), f"{tag}: 仮定 εQ̌_ϵ = Q̌_ϵε")
        x, q = st.chosen_q(w)
        rep.check(q != 0, f"{tag}: q ≠ 0")
        rep.chain([("Q̌q", P_(Q, q)), ("Q̌(Q̌x)", P_(Q, P_(Q, x))), ("(Q̌Q̌)x", P_(P_(Q, Q), x)), ("Q̌x", P_(Q, x)), ("q", q)], f"{tag} Q̌q = q")
        Eq = P_(E, q)
        rep.chain([("Q̌(εq)", P_(Q, Eq)), ("(Q̌ε)q", P_(P_(Q, E), q)), ("(εQ̌)q", P_(P_(E, Q), q)), ("ε(Q̌q)", P_(E, P_(Q, q))), ("εq", Eq)], f"{tag} Q̌(εq) = εq")
        eta = coefficient_on(Eq, q)
        rep.check(eta is not None, f"{tag}: εq ∈ Cq")
        rep.chain([("q", q), ("Iq", P_(Id, q)), ("(εε)q", P_(P_(E, E), q)), ("ε(εq)", P_(E, Eq)), ("ε(ηq)", P_(E, S_(eta, q))),
                   ("η(εq)", S_(eta, Eq)), ("η(ηq)", S_(eta, S_(eta, q))), ("(ηη)q", S_(eta * eta, q))], f"{tag} q = (ηη)q")
        rep.chain([("(ηη-1)q", S_(eta * eta - 1, q)), ("(ηη)q - 1q", D_(S_(eta * eta, q), S_(1, q))), ("q - 1q", D_(q, S_(1, q))),
                   ("q - q", D_(q, q)), ("O", matrix(F, N, 1, 0))], f"{tag} (ηη-1)q = O")
        rep.check(eta * eta - 1 == 0, f"{tag}: ηη - 1 = 0")
        rep.chain([("(η-1)(η+1)", (eta - 1) * (eta + 1)), ("(η-1)η+(η-1)1", (eta - 1) * eta + (eta - 1) * 1), ("(ηη-η)+(η-1)", (eta * eta - eta) + (eta - 1)), ("ηη-1", eta * eta - 1), ("0", F(0))], f"{tag} (η-1)(η+1) = 0")
        rep.check(eta in (F(1), F(-1)), f"{tag}: η ∈ {{+1,-1}}")
        EQ, hQ = P_(E, Q), S_(eta, Q)
        cols_E, cols_h, es = [], [], []
        for k in range(N):
            xk = st.basis(k)
            Qx = P_(Q, xk)
            if Qx == 0:
                c = F(0)
            else:
                c = coefficient_on(Qx, q)
            rep.check(c is not None and Qx == S_(c, q), f"{tag} k={k}: Q̌e_k ∈ Cq")
            rep.chain([("(εQ̌)x", P_(EQ, xk)), ("ε(Q̌x)", P_(E, Qx)), ("ε(cq)", P_(E, S_(c, q))), ("c(εq)", S_(c, Eq)), ("c(ηq)", S_(c, S_(eta, q))),
                       ("(cη)q", S_(c * eta, q)), ("(ηc)q", S_(eta * c, q)), ("η(cq)", S_(eta, S_(c, q))), ("η(Q̌x)", S_(eta, Qx)), ("(ηQ̌)x", P_(hQ, xk))],
                      f"{tag} k={k} (εQ̌)x = (ηQ̌)x")
            es.append(xk); cols_E.append(P_(EQ, xk)); cols_h.append(P_(hQ, xk))
        Ecols = columns(es)
        rep.check(Ecols == Id, f"{tag}: I = [e_1 ⋯ e_N]")
        rep.chain([("εQ̌", EQ), ("(εQ̌)I", P_(EQ, Id)), ("(εQ̌)[e]", P_(EQ, Ecols)), ("[(εQ̌)e_k]", columns(cols_E)), ("[(ηQ̌)e_k]", columns(cols_h)),
                   ("(ηQ̌)[e]", P_(hQ, Ecols)), ("(ηQ̌)I", P_(hQ, Id)), ("ηQ̌", hQ)], f"{tag} εQ̌ = ηQ̌")
        etap = eta
        rep.chain([("η'q", S_(etap, q)), ("η'(Q̌q)", S_(etap, P_(Q, q))), ("(η'Q̌)q", P_(S_(etap, Q), q)), ("(εQ̌)q", P_(EQ, q)),
                   ("ε(Q̌q)", P_(E, P_(Q, q))), ("εq", Eq), ("ηq", S_(eta, q))], f"{tag} 一意性")
        rep.negative(EQ != S_(-eta, Q), f"{tag}: η' = -η では εQ̌ ≠ η'Q̌")
        rep.check(E * Q == eta * Q, f"{tag}: 主張 (1) εQ̌_ϵ = η_ϵQ̌_ϵ（Sage の積）")
        G_breaks = G_breaks or coefficient_on(P_(st.G, q), q) is None
    rep.negative(G_breaks, f"{st.tag}: ε を σ_1^z に替えると σ_1^z q ∉ Cq となる ϵ がある")
    print(f"  {st.tag}: 済（累計 {rep.n} 件、否定 {rep.neg} 件、失敗 {rep.fail} 件）", flush=True)

rep.finish()

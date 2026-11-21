# 対象ラベル: epsilon_eigenvalue_on_check_Q（主張 (2) と証明の (2) の鎖を、本文の ψ̌ で）
# ε(μ) = 0 となる全ての (ε, μ) について、証明の (2) の鎖を行の括弧どおりに組んで隣どうし比べる。q は (1) と同じ作り方の Q̌_ε の 0 でない列。
#   冒頭の εq = η_εq の鎖（6 行）、Step 1 の仮定 ň_μQ̌_ε = O（check_joint_eigenspace_decomposition (3) の ε(ν) = 0 の場合）と
#   ň_μq = 0 の鎖（5 行）、仮定 ψ̌_{σ(μ)}ψ̌_μ^† = I - ň_μ（check_number_operator_idempotent (2)）、
#   ψ̌_{σ(μ)}(ψ̌_μ^†q) = q の鎖（7 行）・ψ̌_{σ(μ)}0 = 0・ψ̌_μ^†q ≠ 0、Step 2 の仮定 (ψ̌_μ^†)^2 = O（同 (1)）と ň_μψ̌_μ^† = ψ̌_μ^† の鎖（14 行）、
#   Q̌_δ = Π_ν R_ν^{(δ(ν))}（def_check_Q_epsilon。Sage の `*`・`-` で組んだものと比べる）、
#   X(I - ň_ν) = (I - ň_ν)X と XR_ν^{(δ(ν))} = R_ν^{(δ(ν))}X の鎖（δ(ν) = 1・δ(ν) = 0 の場合の 6 行ずつ、X = ň_κ）と R_κ^{(δ(κ))}R_ν^{(δ(ν))} の可換性、
#   R_μ^{(ε(μ))} = R_μ^{(0)} = I - ň_μ・R_μ^{(ε'(μ))} = R_μ^{(1)} = ň_μ の鎖（3 行ずつ）、ν ≠ μ での ψ̌_μ^†ň_ν = ň_νψ̌_μ^†・
#   ψ̌_μ^†R_ν^{(ε(ν))} = R_ν^{(ε(ν))}ψ̌_μ^†・R_ν^{(ε'(ν))} = R_ν^{(ε(ν))}、ψ̌_μ^†Π' = Π'ψ̌_μ^†（行列の等式）、R_μ^{(ε(μ))}q = q の鎖（6 行）、
#   Π'q = q の鎖（7 行）、Q̌_{ε'}(ψ̌_μ^†q) = ψ̌_μ^†q の鎖（12 行）、
#   Step 3 の仮定 εψ̌_μ^† = -(ψ̌_μ^†ε)（epsilon_anticommutes_with_check_Z_Y (3)）と ε(ψ̌_μ^†q) = (-η_ε)(ψ̌_μ^†q) の鎖（10 行）、
#   η_{ε'}(ψ̌_μ^†q) = (-η_ε)(ψ̌_μ^†q) の鎖（7 行）、主張 (2) η_{ε'} = -η_ε。
# ε' := ε[μ→1]（def_binary_assignment_with_one_value_set_to_one）。Π' := Π_{ν≠μ} R_ν^{(ε(ν))} は
# def_finite_product_of_matrices_omitting_one_index の並び（ν の小さい順）で、左から掛けて組む。
# Π_{ν∈M̌} と Π_{ν=1}^{M_col} は def_product_over_check_index_set により同じ左から掛ける積なので、その行き来の行は同じ行列を並べる。
# 否定コントロール: 対を μ 自身に取り違えた ψ̌_μ（σ(μ) ≠ μ のとき）では Step 1 の仮定 ψ̌ψ̌_μ^† = I - ň_μ が外れる。
#   ε を σ_1^z に替えると Step 3 の仮定が外れる。ψ̌_μ^†q ≠ q（Step 2 の鎖が自明でないこと）。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("epsilon_eigenvalue_on_check_Q (2): 本文の ψ̌ での鎖と主張（厳密）")

for st in settings(Ms):
    E, Id, F, M = st.E, st.Id, st.F, st.M
    eta = {w: eta_of(st, w) for w in st.words}
    R = lambda d, nu: factor_R(d[nu], st.ns[nu], Id)        # R_ν^{(δ(ν))}（def_check_R_factor）
    for w in st.words:
        rep.check(st.Q[w] == Q_check_by_definition(w, st.ns, Id), f"{st.tag} ε={w}: Q̌_ε = Π_ν R_ν^(ε(ν))（def_check_Q_epsilon。Sage の経路と比べる）")
        for kap in range(M):
            X = st.ns[kap]
            for nu in range(M):
                n = st.ns[nu]
                Dn = D_(Id, n)
                rep.check(P_(X, Dn) == P_(Dn, X), f"{st.tag} X=ň_{kap+1} ν={nu+1}: X(I-ň_ν) = (I-ň_ν)X")
                Rn = R(w, nu)
                if w[nu] == 1:
                    R1 = factor_R(1, n, Id)
                    lines = [("XR_ν^(δ(ν))", P_(X, Rn)), ("XR_ν^(1)", P_(X, R1)), ("Xň_ν", P_(X, n)), ("ň_νX", P_(n, X)), ("R_ν^(1)X", P_(R1, X)), ("R_ν^(δ(ν))X", P_(Rn, X))]
                else:
                    R0 = factor_R(0, n, Id)
                    lines = [("XR_ν^(δ(ν))", P_(X, Rn)), ("XR_ν^(0)", P_(X, R0)), ("X(I-ň_ν)", P_(X, Dn)), ("(I-ň_ν)X", P_(Dn, X)), ("R_ν^(0)X", P_(R0, X)), ("R_ν^(δ(ν))X", P_(Rn, X))]
                rep.chain(lines, f"{st.tag} ε={w} X=ň_{kap+1} ν={nu+1} δ(ν)={w[nu]}: XR = RX")
                rep.check(P_(R(w, kap), Rn) == P_(Rn, R(w, kap)), f"{st.tag} ε={w}: R_{kap+1}R_{nu+1} = R_{nu+1}R_{kap+1}")
    for w in st.words:
        Q = st.Q[w]
        x, q = st.chosen_q(w)
        et = eta[w]
        for mu in range(M):
            if w[mu] != 0:
                continue
            tag = f"{st.tag} ε={w} μ={mu+1}"
            wp = tuple(1 if j == mu else w[j] for j in range(M))
            Qp, etp = st.Q[wp], eta[wp]
            Dm, Pm, nm = st.Ds[mu], st.Ps[mu], st.ns[mu]
            Z = matrix(F, st.N, 1, 0)
            rep.chain([("εq", P_(E, q)), ("ε(Q̌q)", P_(E, P_(Q, q))), ("(εQ̌)q", P_(P_(E, Q), q)), ("(ηQ̌)q", P_(S_(et, Q), q)),
                       ("η(Q̌q)", S_(et, P_(Q, q))), ("ηq", S_(et, q))], f"{tag} εq = ηq")
            rep.check(P_(nm, Q) == st.O and P_(Q, nm) == st.O, f"{tag}: 仮定 ň_μQ̌_ε = Q̌_εň_μ = O（check_joint_eigenspace_decomposition (3)、ε(μ) = 0）")
            rep.chain([("ň_μq", P_(nm, q)), ("ň_μ(Q̌q)", P_(nm, P_(Q, q))), ("(ň_μQ̌)q", P_(P_(nm, Q), q)), ("Oq", P_(st.O, q)), ("0", Z)], f"{tag} Step 1 ň_μq = 0")
            rep.check(P_(Pm, Dm) == D_(Id, nm), f"{tag}: 仮定 ψ̌_σ(μ)ψ̌_μ^† = I - ň_μ")
            Dq = P_(Dm, q)
            rep.chain([("ψ̌_σ(ψ̌^†q)", P_(Pm, Dq)), ("(ψ̌_σψ̌^†)q", P_(P_(Pm, Dm), q)), ("(I-ň)q", P_(D_(Id, nm), q)), ("Iq - ňq", D_(P_(Id, q), P_(nm, q))),
                       ("q - ňq", D_(q, P_(nm, q))), ("q - 0", D_(q, Z)), ("q", q)], f"{tag} Step 1 ψ̌_σ(ψ̌^†q) = q")
            rep.check(P_(Pm, Z) == Z, f"{tag}: ψ̌_σ(μ) 0 = 0")
            rep.check(Dq != 0, f"{tag}: ψ̌_μ^†q ≠ 0")
            rep.check(P_(Dm, Dm) == st.O, f"{tag}: 仮定 (ψ̌_μ^†)^2 = O")
            rep.chain([("ň_μψ̌^†", P_(nm, Dm)), ("(ψ̌^†ψ̌_σ)ψ̌^†", P_(P_(Dm, Pm), Dm)), ("ψ̌^†(ψ̌_σψ̌^†)", P_(Dm, P_(Pm, Dm))), ("ψ̌^†(I-ň)", P_(Dm, D_(Id, nm))),
                       ("ψ̌^†(I+(-ň))", P_(Dm, body_sum(Id, N_(nm)))), ("ψ̌^†I + ψ̌^†(-ň)", body_sum(P_(Dm, Id), P_(Dm, N_(nm)))),
                       ("ψ̌^†I + (-(ψ̌^†ň))", body_sum(P_(Dm, Id), N_(P_(Dm, nm)))), ("ψ̌^†I - ψ̌^†ň", D_(P_(Dm, Id), P_(Dm, nm))),
                       ("ψ̌^† - ψ̌^†ň", D_(Dm, P_(Dm, nm))), ("ψ̌^† - ψ̌^†(ψ̌^†ψ̌_σ)", D_(Dm, P_(Dm, P_(Dm, Pm)))),
                       ("ψ̌^† - (ψ̌^†ψ̌^†)ψ̌_σ", D_(Dm, P_(P_(Dm, Dm), Pm))), ("ψ̌^† - Oψ̌_σ", D_(Dm, P_(st.O, Pm))), ("ψ̌^† - O", D_(Dm, st.O)), ("ψ̌^†", Dm)],
                      f"{tag} Step 2 ň_μψ̌_μ^† = ψ̌_μ^†")
            # R_μ^(ε(μ)) = R_μ^(0) = I - ň_μ と R_μ^(ε'(μ)) = R_μ^(1) = ň_μ（ε(μ) = 0、ε'(μ) = 1）
            Dn = D_(Id, nm)
            rep.check(w[mu] == 0 and wp[mu] == 1, f"{tag}: ε(μ) = 0 と ε'(μ) = 1")
            rep.chain([("R_μ^(ε(μ))", R(w, mu)), ("R_μ^(0)", factor_R(0, nm, Id)), ("I-ň", Dn)], f"{tag} R_μ^(ε(μ)) = I - ň_μ")
            rep.chain([("R_μ^(ε'(μ))", R(wp, mu)), ("R_μ^(1)", factor_R(1, nm, Id)), ("ň", nm)], f"{tag} R_μ^(ε'(μ)) = ň_μ")
            others = [nu for nu in range(M) if nu != mu]
            for nu in others:
                rep.check(wp[nu] == w[nu], f"{tag} ν={nu+1}: ε'(ν) = ε(ν)")
                rep.check(P_(Dm, st.ns[nu]) == P_(st.ns[nu], Dm), f"{tag} ν={nu+1}: ψ̌_μ^†ň_ν = ň_νψ̌_μ^†")
                rep.check(P_(Dm, R(w, nu)) == P_(R(w, nu), Dm), f"{tag} ν={nu+1}: ψ̌_μ^†R_ν = R_νψ̌_μ^†")
                rep.check(R(wp, nu) == R(w, nu), f"{tag} ν={nu+1}: R_ν^(ε'(ν)) = R_ν^(ε(ν))")
            Pom = body_finite_product([R(w, nu) for nu in others])
            rep.check(P_(Dm, Pom) == P_(Pom, Dm), f"{tag}: ψ̌_μ^†Π' = Π'ψ̌_μ^†")
            Am = R(w, mu)
            PR = body_finite_product([R(w, nu) for nu in range(M)])
            PRp = body_finite_product([R(wp, nu) for nu in range(M)])
            rep.chain([("R_μq", P_(Am, q)), ("(I-ň)q", P_(Dn, q)), ("Iq - ňq", D_(P_(Id, q), P_(nm, q))), ("q - ňq", D_(q, P_(nm, q))),
                       ("q - 0", D_(q, Z)), ("q", q)], f"{tag} R_μ^(ε(μ))q = q")
            rep.chain([("Π'q", P_(Pom, q)), ("Π'(R_μq)", P_(Pom, P_(Am, q))), ("(Π'R_μ)q", P_(P_(Pom, Am), q)),
                       ("(Π_{ν=1}^M R_ν)q", P_(PR, q)), ("(Π_{ν∈M̌} R_ν)q", P_(PR, q)), ("Q̌q", P_(Q, q)), ("q", q)], f"{tag} Π'q = q")
            rep.chain([("Q̌'(ψ̌^†q)", P_(Qp, Dq)), ("(Π_{ν∈M̌} R_ν^(ε'))(ψ̌^†q)", P_(PRp, Dq)), ("(Π_{ν=1}^M R_ν^(ε'))(ψ̌^†q)", P_(PRp, Dq)),
                       ("(Π'R_μ^(ε'))(ψ̌^†q)", P_(P_(Pom, R(wp, mu)), Dq)), ("(Π'ň_μ)(ψ̌^†q)", P_(P_(Pom, nm), Dq)), ("Π'(ň_μ(ψ̌^†q))", P_(Pom, P_(nm, Dq))),
                       ("Π'((ň_μψ̌^†)q)", P_(Pom, P_(P_(nm, Dm), q))), ("Π'(ψ̌^†q)", P_(Pom, Dq)),
                       ("(Π'ψ̌^†)q", P_(P_(Pom, Dm), q)), ("(ψ̌^†Π')q", P_(P_(Dm, Pom), q)), ("ψ̌^†(Π'q)", P_(Dm, P_(Pom, q))), ("ψ̌^†q", Dq)],
                      f"{tag} Q̌_ε'(ψ̌^†q) = ψ̌^†q")
            rep.negative(Dq != q, f"{tag}: ψ̌_μ^†q ≠ q")
            rep.check(P_(E, Dm) == N_(P_(Dm, E)), f"{tag}: 仮定 εψ̌_μ^† = -(ψ̌_μ^†ε)")
            rep.chain([("ε(ψ̌^†q)", P_(E, Dq)), ("(εψ̌^†)q", P_(P_(E, Dm), q)), ("(-(ψ̌^†ε))q", P_(N_(P_(Dm, E)), q)), ("-((ψ̌^†ε)q)", N_(P_(P_(Dm, E), q))),
                       ("-(ψ̌^†(εq))", N_(P_(Dm, P_(E, q)))), ("-(ψ̌^†(ηq))", N_(P_(Dm, S_(et, q)))), ("-(η(ψ̌^†q))", N_(S_(et, Dq))),
                       ("(-1)(η(ψ̌^†q))", S_(-1, S_(et, Dq))), ("((-1)η)(ψ̌^†q)", S_(F(-1) * et, Dq)), ("(-η)(ψ̌^†q)", S_(-et, Dq))], f"{tag} Step 3 ε(ψ̌^†q)")
            rep.chain([("η'(ψ̌^†q)", S_(etp, Dq)), ("η'(Q̌'(ψ̌^†q))", S_(etp, P_(Qp, Dq))), ("(η'Q̌')(ψ̌^†q)", P_(S_(etp, Qp), Dq)), ("(εQ̌')(ψ̌^†q)", P_(P_(E, Qp), Dq)),
                       ("ε(Q̌'(ψ̌^†q))", P_(E, P_(Qp, Dq))), ("ε(ψ̌^†q)", P_(E, Dq)), ("(-η)(ψ̌^†q)", S_(-et, Dq))], f"{tag} Step 3 η'(ψ̌^†q)")
            rep.check(etp == -et, f"{tag}: 主張 (2) η_ε' = -η_ε")
            if st.M + 1 - (mu + 1) != mu + 1:
                rep.negative(P_(st.Pself[mu], Dm) != D_(Id, nm), f"{tag}: ψ̌_μ を対に取り違えると Step 1 の仮定が外れる")
            rep.negative(P_(st.G, Dm) != N_(P_(Dm, st.G)), f"{tag}: σ_1^z では Step 3 の仮定が外れる")
    print(f"  {st.tag}: 済（累計 {rep.n} 件、否定 {rep.neg} 件、失敗 {rep.fail} 件）", flush=True)

rep.finish()

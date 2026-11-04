# 対象ラベル: epsilon_eigenvalue_on_check_Q（主張 (2) と証明の (2) の鎖を、本文の ψ̌ で）
# ϵ_μ = 0 となる全ての (ϵ, μ) について、証明の (2) の鎖を行の括弧どおりに組んで隣どうし比べる。q は (1) と同じ作り方の Q̌_ϵ の 0 でない列。
#   冒頭の εq = η_ϵq の鎖（6 行）、Step 1 の ň_μq = 0 の鎖（7 行）と仮定 ψ̌_{σ(μ)}ψ̌_μ^† = I - ň_μ（check_number_operator_idempotent (2)）、
#   ψ̌_{σ(μ)}(ψ̌_μ^†q) = q の鎖（7 行）・ψ̌_{σ(μ)}0 = 0・ψ̌_μ^†q ≠ 0、Step 2 の仮定 (ψ̌_μ^†)^2 = O（同 (1)）と ň_μψ̌_μ^† = ψ̌_μ^† の鎖（14 行）、
#   Q̌_δ = Π_ν A_ν^δ（定義。A_ν^δ := δ_νň_ν + (1-δ_ν)(I-ň_ν)）、XA_ν^δ = A_ν^δX の鎖（6 行、X = ň_κ）と A_κ^δA_ν^δ = A_ν^δA_κ^δ、
#   A_μ^ϵ = I - ň_μ・A_μ^ϵ' = ň_μ の鎖（行列の行だけ。ℂ の計算の行は値が同じなので組まない）、ν ≠ μ での ψ̌_μ^†ň_ν = ň_νψ̌_μ^†・ψ̌_μ^†A_ν = A_νψ̌_μ^†・A_ν^ϵ' = A_ν^ϵ、
#   ψ̌_μ^†Π' = Π'ψ̌_μ^†（行列の等式）、A_μ^ϵq = q の鎖（6 行）、Π'q = q の鎖（6 行）、Q̌_{ϵ'}(ψ̌_μ^†q) = ψ̌_μ^†q の鎖（11 行）、
#   Step 3 の仮定 εψ̌_μ^† = -(ψ̌_μ^†ε)（epsilon_anticommutes_with_check_Z_Y (3)）と ε(ψ̌_μ^†q) = (-η_ϵ)(ψ̌_μ^†q) の鎖（10 行）、
#   η_{ϵ'}(ψ̌_μ^†q) = (-η_ϵ)(ψ̌_μ^†q) の鎖（7 行）、主張 (2) η_{ϵ'} = -η_ϵ。
# Π' := Π_{ν≠μ} A_ν は def_finite_product_of_matrices_omitting_one_index の並び（ν の小さい順）で、左から掛けて組む。
# 否定コントロール: 対を μ 自身に取り違えた ψ̌_μ（σ(μ) ≠ μ のとき）では Step 1 の仮定 ψ̌ψ̌_μ^† = I - ň_μ が外れる。
#   ε を σ_1^z に替えると Step 3 の仮定が外れる。ψ̌_μ^†q ≠ q（Step 2 の鎖が自明でないこと）。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("epsilon_eigenvalue_on_check_Q (2): 本文の ψ̌ での鎖と主張（厳密）")

for st in settings(Ms):
    E, Id, F, M = st.E, st.Id, st.F, st.M
    eta = {w: eta_of(st, w) for w in st.words}
    A = lambda d, nu: factor_A(d[nu], st.ns[nu], Id)        # A_ν^δ := δ_νň_ν + (1-δ_ν)(I-ň_ν)
    for w in st.words:
        rep.check(st.Q[w] == body_finite_product([A(w, nu) for nu in range(M)]), f"{st.tag} ϵ={w}: Q̌_ϵ = Π_ν A_ν^ϵ（定義）")
        for kap in range(M):
            for nu in range(M):
                X, An = st.ns[kap], A(w, nu)
                d = w[nu]
                T1, T2 = S_(d, st.ns[nu]), S_(1 - d, D_(Id, st.ns[nu]))
                rep.chain([("XA_ν", P_(X, An)), ("X(δň+(1-δ)(I-ň))", P_(X, body_sum(T1, T2))), ("X(δň)+X((1-δ)(I-ň))", body_sum(P_(X, T1), P_(X, T2))),
                           ("(δň)X+((1-δ)(I-ň))X", body_sum(P_(T1, X), P_(T2, X))), ("(δň+(1-δ)(I-ň))X", P_(body_sum(T1, T2), X)), ("A_νX", P_(An, X))], f"{st.tag} ϵ={w} X=ň_{kap+1} ν={nu+1}: XA = AX")
                rep.check(P_(A(w, kap), An) == P_(An, A(w, kap)), f"{st.tag} ϵ={w}: A_{kap+1}A_{nu+1} = A_{nu+1}A_{kap+1}")
    for w in st.words:
        Q = st.Q[w]
        x, q = st.chosen_q(w)
        et = eta[w]
        for mu in range(M):
            if w[mu] != 0:
                continue
            tag = f"{st.tag} ϵ={w} μ={mu+1}"
            wp = tuple(1 if j == mu else w[j] for j in range(M))
            Qp, etp = st.Q[wp], eta[wp]
            Dm, Pm, nm = st.Ds[mu], st.Ps[mu], st.ns[mu]
            Z = matrix(F, st.N, 1, 0)
            rep.chain([("εq", P_(E, q)), ("ε(Q̌q)", P_(E, P_(Q, q))), ("(εQ̌)q", P_(P_(E, Q), q)), ("(ηQ̌)q", P_(S_(et, Q), q)),
                       ("η(Q̌q)", S_(et, P_(Q, q))), ("ηq", S_(et, q))], f"{tag} εq = ηq")
            rep.chain([("ň_μq", P_(nm, q)), ("ň_μ(Q̌q)", P_(nm, P_(Q, q))), ("(ň_μQ̌)q", P_(P_(nm, Q), q)), ("(ϵ_μQ̌)q", P_(S_(w[mu], Q), q)),
                       ("(0Q̌)q", P_(S_(0, Q), q)), ("Oq", P_(st.O, q)), ("0", Z)], f"{tag} Step 1 ň_μq = 0")
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
            # A_μ^ϵ = I - ň_μ と A_μ^ϵ' = ň_μ（ℂ の計算の行は値が同じなので行列の行だけを組む）
            Dn = D_(Id, nm)
            rep.chain([("A_μ^ϵ", A(w, mu)), ("0ň + (1-0)(I-ň)", body_sum(S_(0, nm), S_(1 - 0, Dn))), ("O + 1(I-ň)", body_sum(st.O, S_(1, Dn))),
                       ("O + (I-ň)", body_sum(st.O, Dn)), ("I-ň", Dn)], f"{tag} A_μ^ϵ = I - ň_μ")
            rep.chain([("A_μ^ϵ'", A(wp, mu)), ("1ň + (1-1)(I-ň)", body_sum(S_(1, nm), S_(1 - 1, Dn))), ("ň + 0(I-ň)", body_sum(nm, S_(0, Dn))),
                       ("ň + O", body_sum(nm, st.O)), ("ň", nm)], f"{tag} A_μ^ϵ' = ň_μ")
            others = [nu for nu in range(M) if nu != mu]
            for nu in others:
                rep.check(P_(Dm, st.ns[nu]) == P_(st.ns[nu], Dm), f"{tag} ν={nu+1}: ψ̌_μ^†ň_ν = ň_νψ̌_μ^†")
                rep.check(P_(Dm, A(w, nu)) == P_(A(w, nu), Dm), f"{tag} ν={nu+1}: ψ̌_μ^†A_ν = A_νψ̌_μ^†")
                rep.check(A(wp, nu) == A(w, nu), f"{tag} ν={nu+1}: A_ν^ϵ' = A_ν^ϵ")
            Pom = body_finite_product([A(w, nu) for nu in others])
            rep.check(P_(Dm, Pom) == P_(Pom, Dm), f"{tag}: ψ̌_μ^†Π' = Π'ψ̌_μ^†")
            Am = A(w, mu)
            rep.chain([("A_μ^ϵq", P_(Am, q)), ("(I-ň)q", P_(Dn, q)), ("Iq - ňq", D_(P_(Id, q), P_(nm, q))), ("q - ňq", D_(q, P_(nm, q))),
                       ("q - 0", D_(q, Z)), ("q", q)], f"{tag} A_μ^ϵq = q")
            rep.chain([("Π'q", P_(Pom, q)), ("Π'(A_μq)", P_(Pom, P_(Am, q))), ("(Π'A_μ)q", P_(P_(Pom, Am), q)),
                       ("(Π_ν A_ν^ϵ)q", P_(body_finite_product([A(w, nu) for nu in range(M)]), q)), ("Q̌q", P_(Q, q)), ("q", q)], f"{tag} Π'q = q")
            rep.chain([("Q̌'(ψ̌^†q)", P_(Qp, Dq)), ("(Π_ν A_ν^ϵ')(ψ̌^†q)", P_(body_finite_product([A(wp, nu) for nu in range(M)]), Dq)),
                       ("(Π'A_μ^ϵ')(ψ̌^†q)", P_(P_(Pom, A(wp, mu)), Dq)), ("(Π'ň_μ)(ψ̌^†q)", P_(P_(Pom, nm), Dq)), ("Π'(ň_μ(ψ̌^†q))", P_(Pom, P_(nm, Dq))),
                       ("Π'((ň_μψ̌^†)q)", P_(Pom, P_(P_(nm, Dm), q))), ("Π'(ψ̌^†q)", P_(Pom, Dq)),
                       ("(Π'ψ̌^†)q", P_(P_(Pom, Dm), q)), ("(ψ̌^†Π')q", P_(P_(Dm, Pom), q)), ("ψ̌^†(Π'q)", P_(Dm, P_(Pom, q))), ("ψ̌^†q", Dq)],
                      f"{tag} Q̌_ϵ'(ψ̌^†q) = ψ̌^†q")
            rep.negative(Dq != q, f"{tag}: ψ̌_μ^†q ≠ q")
            rep.check(P_(E, Dm) == N_(P_(Dm, E)), f"{tag}: 仮定 εψ̌_μ^† = -(ψ̌_μ^†ε)")
            rep.chain([("ε(ψ̌^†q)", P_(E, Dq)), ("(εψ̌^†)q", P_(P_(E, Dm), q)), ("(-(ψ̌^†ε))q", P_(N_(P_(Dm, E)), q)), ("-((ψ̌^†ε)q)", N_(P_(P_(Dm, E), q))),
                       ("-(ψ̌^†(εq))", N_(P_(Dm, P_(E, q)))), ("-(ψ̌^†(ηq))", N_(P_(Dm, S_(et, q)))), ("-(η(ψ̌^†q))", N_(S_(et, Dq))),
                       ("(-1)(η(ψ̌^†q))", S_(-1, S_(et, Dq))), ("((-1)η)(ψ̌^†q)", S_(F(-1) * et, Dq)), ("(-η)(ψ̌^†q)", S_(-et, Dq))], f"{tag} Step 3 ε(ψ̌^†q)")
            rep.chain([("η'(ψ̌^†q)", S_(etp, Dq)), ("η'(Q̌'(ψ̌^†q))", S_(etp, P_(Qp, Dq))), ("(η'Q̌')(ψ̌^†q)", P_(S_(etp, Qp), Dq)), ("(εQ̌')(ψ̌^†q)", P_(P_(E, Qp), Dq)),
                       ("ε(Q̌'(ψ̌^†q))", P_(E, P_(Qp, Dq))), ("ε(ψ̌^†q)", P_(E, Dq)), ("(-η)(ψ̌^†q)", S_(-et, Dq))], f"{tag} Step 3 η'(ψ̌^†q)")
            rep.check(etp == -et, f"{tag}: 主張 (2) η_ϵ' = -η_ϵ")
            if st.M + 1 - (mu + 1) != mu + 1:
                rep.negative(P_(st.Pself[mu], Dm) != D_(Id, nm), f"{tag}: ψ̌_μ を対に取り違えると Step 1 の仮定が外れる")
            rep.negative(P_(st.G, Dm) != N_(P_(Dm, st.G)), f"{tag}: σ_1^z では Step 3 の仮定が外れる")
    print(f"  {st.tag}: 済（累計 {rep.n} 件、否定 {rep.neg} 件、失敗 {rep.fail} 件）", flush=True)

rep.finish()

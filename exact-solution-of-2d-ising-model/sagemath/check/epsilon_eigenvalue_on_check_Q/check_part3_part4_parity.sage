# 対象ラベル: epsilon_eigenvalue_on_check_Q（主張 (3)(4) と証明の (3)(4) の鎖を、本文の ψ̌ で）
# η_ϵ は (1) と同じ作り方（εq = η_ϵq）で全ての ϵ について求める。
#   (3): 帰納法の基底 η_{(1,…,1)} = η_{(1,…,1)}(-1)^0、k ≥ 1 の全ての ϵ と ϵ_μ = 0 となる全ての μ（「取れ」のどれを取っても）について
#        η_ϵ = -η_ϵ' と帰納法の段の鎖（8 行。帰納法の仮定の行は、ϵ' での主張 (3) を別に確かめたものを使う）、主張 (3)。
#   (4): 各 (ϵ, μ) の (I - 2ň_μ)Q̌_ϵ = (1 - 2ϵ_μ)Q̌_ϵ の鎖（11 行）、P_1Q̌_ϵ = p_1Q̌_ϵ、P_{k+1}Q̌_ϵ = p_{k+1}Q̌_ϵ の帰納法の段の鎖（9 行）、
#        p_{M_col} = (-1)^{|ϵ|}、εQ̌_ϵ = c(PQ̌_ϵ) の鎖（8 行）、ε = cP の鎖（10 行。和は def_sum_over_binary_words の辞書式の並び）、主張 (4)。
#        P・Π_μ(I - 2ň_μ) は本文の定め方（左から掛ける有限積）で組み、主張 (4) の右辺は Sage の `*`・`-` で独立に組んで比べる。
# 否定コントロール: 主張 (4) の符号を -η_{(1,…,1)} に替えると外れる。σ_1^z は ±Π_μ(I - 2ň_μ) のどちらでもない。
#   各 μ で ň_μ は I のスカラー倍でなく、I - 2ň_μ ≠ ±I。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("epsilon_eigenvalue_on_check_Q (3)(4): 本文の ψ̌ での鎖と主張（厳密）")

for st in settings(Ms):
    E, Id, F, M = st.E, st.Id, st.F, st.M
    eta = {w: eta_of(st, w) for w in st.words}
    ones = tuple([1] * M)
    e1 = eta[ones]
    print(f"  {st.tag}: η_(1,…,1) = {e1}", flush=True)
    m1 = F(-1)
    claim3 = lambda w: eta[w] == e1 * m1**(M - popcount(w))
    rep.check(eta[ones] == e1 * m1**0, f"{st.tag}: (3) の基底")
    for w in st.words:
        tag = f"{st.tag} ϵ={w}"
        rep.check(claim3(w), f"{tag}: 主張 (3) η_ϵ = η_(1,…,1)(-1)^(M-|ϵ|)")
        for mu in range(M):
            if w[mu] != 0:
                continue
            wp = tuple(1 if j == mu else w[j] for j in range(M))
            rep.check(popcount(wp) == popcount(w) + 1, f"{tag} μ={mu+1}: |ϵ'| = |ϵ| + 1")
            rep.check(claim3(wp), f"{tag} μ={mu+1}: 帰納法の仮定（ϵ' での (3)）")
            k = M - popcount(w)
            rep.chain([("η_ϵ", eta[w]), ("-η_ϵ'", -eta[wp]), ("-(η_1(-1)^(M-|ϵ'|))", -(e1 * m1**(M - popcount(wp)))),
                       ("-(η_1(-1)^(M-|ϵ|-1))", -(e1 * m1**(k - 1))), ("(-1)(η_1(-1)^(M-|ϵ|-1))", m1 * (e1 * m1**(k - 1))),
                       ("(η_1(-1)^(M-|ϵ|-1))(-1)", (e1 * m1**(k - 1)) * m1), ("η_1((-1)^(M-|ϵ|-1)(-1))", e1 * (m1**(k - 1) * m1)),
                       ("η_1(-1)^(M-|ϵ|)", e1 * m1**k)], f"{tag} μ={mu+1} (3) の帰納法の段")
    # (4)
    T = [D_(Id, S_(2, st.ns[mu])) for mu in range(M)]          # I - 2ň_μ
    for mu in range(M):
        rep.negative(st.ns[mu] != st.ns[mu][0, 0] * Id, f"{st.tag} μ={mu+1}: ň_μ は I のスカラー倍でない")
        rep.negative(T[mu] != Id and T[mu] != -Id, f"{st.tag} μ={mu+1}: I - 2ň_μ ≠ ±I")
    Pk = [body_finite_product(T[:k]) for k in range(1, M + 1)]  # Pk[k-1] = P_k
    P = Pk[-1]
    c = e1 * m1**M
    for w in st.words:
        tag = f"{st.tag} ϵ={w}"
        Q = st.Q[w]
        a = [F(1 - 2 * w[mu]) for mu in range(M)]
        for mu in range(M):
            two_n = S_(2, st.ns[mu])
            rep.chain([("(I-2ň)Q̌", P_(T[mu], Q)), ("(I+(-(2ň)))Q̌", P_(body_sum(Id, N_(two_n)), Q)), ("IQ̌ + (-(2ň))Q̌", body_sum(P_(Id, Q), P_(N_(two_n), Q))),
                       ("IQ̌ + (-((2ň)Q̌))", body_sum(P_(Id, Q), N_(P_(two_n, Q)))), ("IQ̌ - (2ň)Q̌", D_(P_(Id, Q), P_(two_n, Q))), ("Q̌ - (2ň)Q̌", D_(Q, P_(two_n, Q))), ("Q̌ - 2(ňQ̌)", D_(Q, S_(2, P_(st.ns[mu], Q)))),
                       ("Q̌ - 2(ϵ_μQ̌)", D_(Q, S_(2, S_(w[mu], Q)))), ("1Q̌ - 2(ϵ_μQ̌)", D_(S_(1, Q), S_(2, S_(w[mu], Q)))), ("1Q̌ - (2ϵ_μ)Q̌", D_(S_(1, Q), S_(2 * w[mu], Q))), ("(1-2ϵ_μ)Q̌", S_(a[mu], Q))],
                      f"{tag} μ={mu+1} (I-2ň_μ)Q̌ = (1-2ϵ_μ)Q̌")
        pk = [prod(a[:k]) for k in range(1, M + 1)]               # def_finite_product_of_complex_numbers（左から掛ける）
        rep.check(P_(Pk[0], Q) == S_(pk[0], Q), f"{tag}: P_1Q̌ = p_1Q̌")
        for k in range(1, M):
            rep.chain([("P_{k+1}Q̌", P_(Pk[k], Q)), ("(P_k(I-2ň_{k+1}))Q̌", P_(P_(Pk[k - 1], T[k]), Q)), ("P_k((I-2ň_{k+1})Q̌)", P_(Pk[k - 1], P_(T[k], Q))),
                       ("P_k((1-2ϵ)Q̌)", P_(Pk[k - 1], S_(a[k], Q))), ("(1-2ϵ)(P_kQ̌)", S_(a[k], P_(Pk[k - 1], Q))), ("(1-2ϵ)(p_kQ̌)", S_(a[k], S_(pk[k - 1], Q))),
                       ("((1-2ϵ)p_k)Q̌", S_(a[k] * pk[k - 1], Q)), ("(p_k(1-2ϵ))Q̌", S_(pk[k - 1] * a[k], Q)), ("p_{k+1}Q̌", S_(pk[k], Q))], f"{tag} k={k} P_kQ̌ の帰納法の段")
        rep.check(pk[-1] == m1**popcount(w), f"{tag}: p_M = (-1)^|ϵ|")
        rep.chain([("εQ̌", P_(E, Q)), ("η_ϵQ̌", S_(eta[w], Q)), ("(η_1(-1)^(M-|ϵ|))Q̌", S_(e1 * m1**(M - popcount(w)), Q)),
                   ("(η_1(-1)^(M-|ϵ|)((-1)^|ϵ|(-1)^|ϵ|))Q̌", S_(e1 * m1**(M - popcount(w)) * (m1**popcount(w) * m1**popcount(w)), Q)),
                   ("(η_1((-1)^(M-|ϵ|)(-1)^|ϵ|)(-1)^|ϵ|)Q̌", S_(e1 * (m1**(M - popcount(w)) * m1**popcount(w)) * m1**popcount(w), Q)),
                   ("(η_1(-1)^M(-1)^|ϵ|)Q̌", S_(e1 * m1**M * m1**popcount(w), Q)), ("c((-1)^|ϵ|Q̌)", S_(c, S_(m1**popcount(w), Q))), ("c(PQ̌)", S_(c, P_(P, Q)))],
                  f"{tag} εQ̌ = c(PQ̌)")
    Qs = [st.Q[w] for w in st.words]
    Rhs = e1 * m1**M * prod([Id - 2 * st.ns[mu] for mu in range(M)])   # 主張 (4) の右辺（Sage の経路）
    rep.check(body_finite_sum(Qs) == Id, f"{st.tag}: 仮定 Σ_ϵ Q̌_ϵ = I")
    rep.chain([("ε", E), ("εI", P_(E, Id)), ("ε Σ Q̌", P_(E, body_finite_sum(Qs))), ("Σ εQ̌", body_finite_sum([P_(E, X) for X in Qs])),
               ("Σ c(PQ̌)", body_finite_sum([S_(c, P_(P, X)) for X in Qs])), ("Σ (cP)Q̌", body_finite_sum([P_(S_(c, P), X) for X in Qs])),
               ("(cP) Σ Q̌", P_(S_(c, P), body_finite_sum(Qs))), ("(cP)I", P_(S_(c, P), Id)), ("cP", S_(c, P)), ("η_1(-1)^M Π(I-2ň)", Rhs)], f"{st.tag} (4) ε = cP")
    rep.check(E == Rhs, f"{st.tag}: 主張 (4)（Sage の積）")
    rep.negative(E != -Rhs, f"{st.tag}: 符号を -η_(1,…,1) に替えると (4) が外れる")
    rep.negative(st.G != Rhs and st.G != -Rhs, f"{st.tag}: σ_1^z は ±Π(I-2ň) でない")
    print(f"  {st.tag}: 済（累計 {rep.n} 件、否定 {rep.neg} 件、失敗 {rep.fail} 件）", flush=True)

rep.finish()

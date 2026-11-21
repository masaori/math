# 対象ラベル: epsilon_eigenvalue_on_check_Q（主張 (3)(4) と証明の (3)(4) の鎖を、本文の ψ̌ で）
# η_ε は (1) と同じ作り方（εq = η_εq）で全ての ε について求める。|ε| は def_number_of_ones_of_binary_assignment、
# |ε|_k は def_number_of_ones_of_binary_assignment_among_first_indices、ε' := ε[μ→1] は def_binary_assignment_with_one_value_set_to_one。
#   (3): 帰納法の基底 η_{(1,…,1)} = η_{(1,…,1)}(-1)^0、k ≥ 1 の全ての ε と ε(μ) = 0 となる全ての μ（「取れ」のどれを取っても）について
#        |ε'| = |ε| + 1、η_ε = -η_ε' と帰納法の段の鎖（8 行。帰納法の仮定の行は、ε' での主張 (3) を別に確かめたものを使う）、主張 (3)。
#   (4): 各 (ε, μ) の (I - 2ň_μ)Q̌_ε = Q̌_ε - 2(ň_μQ̌_ε) の共通の鎖（7 行）と、ε(μ) = 1 で (-1)Q̌_ε に着く鎖（5 行）・
#        ε(μ) = 0 で Q̌_ε に着く鎖（4 行）。それぞれの仮定 ň_μQ̌_ε = Q̌_ε・ň_μQ̌_ε = O（check_joint_eigenspace_decomposition (3)）。
#        |ε|_1 と |ε|_{k+1} の場合分けの値、P_kQ̌_ε = (-1)^{|ε|_k}Q̌_ε の帰納法（k = 1 の ε(1) = 1 の 7 行・ε(1) = 0 の 6 行、
#        k → k+1 の ε(k+1) = 1 の 10 行・ε(k+1) = 0 の 6 行）、|ε|_{M_col} = |ε|、εQ̌_ε = c(PQ̌_ε) の鎖（8 行）、
#        ε = cP の鎖（10 行。和は def_sum_over_binary_words の辞書式の並び）、主張 (4)。
#        P・Π_μ(I - 2ň_μ) は本文の定め方（左から掛ける有限積）で組み、主張 (4) の右辺は Sage の `*`・`-` で独立に組んで比べる。
# ε の値 ε(μ) には算術をしない（== 1 / == 0 の場合分けだけ）。
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
        tag = f"{st.tag} ε={w}"
        rep.check(claim3(w), f"{tag}: 主張 (3) η_ε = η_(1,…,1)(-1)^(M-|ε|)")
        for mu in range(M):
            if w[mu] != 0:
                continue
            wp = tuple(1 if j == mu else w[j] for j in range(M))
            rep.check(popcount(wp) == popcount(w) + 1, f"{tag} μ={mu+1}: |ε'| = |ε| + 1")
            rep.check(claim3(wp), f"{tag} μ={mu+1}: 帰納法の仮定（ε' での (3)）")
            k = M - popcount(w)
            rep.chain([("η_ε", eta[w]), ("-η_ε'", -eta[wp]), ("-(η_1(-1)^(M-|ε'|))", -(e1 * m1**(M - popcount(wp)))),
                       ("-(η_1(-1)^(M-|ε|-1))", -(e1 * m1**(k - 1))), ("(-1)(η_1(-1)^(M-|ε|-1))", m1 * (e1 * m1**(k - 1))),
                       ("(η_1(-1)^(M-|ε|-1))(-1)", (e1 * m1**(k - 1)) * m1), ("η_1((-1)^(M-|ε|-1)(-1))", e1 * (m1**(k - 1) * m1)),
                       ("η_1(-1)^(M-|ε|)", e1 * m1**k)], f"{tag} μ={mu+1} (3) の帰納法の段")
    # (4)
    T = [D_(Id, S_(2, st.ns[mu])) for mu in range(M)]          # I - 2ň_μ
    for mu in range(M):
        rep.negative(st.ns[mu] != st.ns[mu][0, 0] * Id, f"{st.tag} μ={mu+1}: ň_μ は I のスカラー倍でない")
        rep.negative(T[mu] != Id and T[mu] != -Id, f"{st.tag} μ={mu+1}: I - 2ň_μ ≠ ±I")
    Pk = [body_finite_product(T[:k]) for k in range(1, M + 1)]  # Pk[k-1] = P_k
    P = Pk[-1]
    c = e1 * m1**M
    for w in st.words:
        tag = f"{st.tag} ε={w}"
        Q = st.Q[w]
        after = {}                                                 # μ ごとの (I - 2ň_μ)Q̌_ε の値（場合分けの鎖の終わり）
        for mu in range(M):
            two_n = S_(2, st.ns[mu])
            rep.chain([("(I-2ň)Q̌", P_(T[mu], Q)), ("(I+(-(2ň)))Q̌", P_(body_sum(Id, N_(two_n)), Q)), ("IQ̌ + (-(2ň))Q̌", body_sum(P_(Id, Q), P_(N_(two_n), Q))),
                       ("IQ̌ + (-((2ň)Q̌))", body_sum(P_(Id, Q), N_(P_(two_n, Q)))), ("IQ̌ - (2ň)Q̌", D_(P_(Id, Q), P_(two_n, Q))), ("Q̌ - (2ň)Q̌", D_(Q, P_(two_n, Q))), ("Q̌ - 2(ňQ̌)", D_(Q, S_(2, P_(st.ns[mu], Q))))],
                      f"{tag} μ={mu+1} (I-2ň_μ)Q̌ の共通の鎖")
            if w[mu] == 1:
                rep.check(P_(st.ns[mu], Q) == Q and P_(Q, st.ns[mu]) == Q, f"{tag} μ={mu+1}: 仮定 ň_μQ̌ = Q̌ň_μ = Q̌（ε(μ) = 1）")
                rep.chain([("Q̌ - 2(ňQ̌)", D_(Q, S_(2, P_(st.ns[mu], Q)))), ("Q̌ - 2Q̌", D_(Q, S_(2, Q))), ("1Q̌ - 2Q̌", D_(S_(1, Q), S_(2, Q))),
                           ("(1-2)Q̌", S_(F(1) - F(2), Q)), ("(-1)Q̌", S_(m1, Q))], f"{tag} μ={mu+1} ε(μ)=1")
                after[mu] = S_(m1, Q)
            else:
                rep.check(P_(st.ns[mu], Q) == st.O and P_(Q, st.ns[mu]) == st.O, f"{tag} μ={mu+1}: 仮定 ň_μQ̌ = Q̌ň_μ = O（ε(μ) = 0）")
                rep.chain([("Q̌ - 2(ňQ̌)", D_(Q, S_(2, P_(st.ns[mu], Q)))), ("Q̌ - 2O", D_(Q, S_(2, st.O))), ("Q̌ - O", D_(Q, st.O)), ("Q̌", Q)],
                          f"{tag} μ={mu+1} ε(μ)=0")
                after[mu] = Q
            rep.check(P_(T[mu], Q) == after[mu], f"{tag} μ={mu+1}: (I-2ň_μ)Q̌ の鎖の両端")
        cnt = [count_first(w, k) for k in range(M + 1)]            # cnt[k] = |ε|_k
        rep.check(cnt[1] == (1 if w[0] == 1 else 0), f"{tag}: |ε|_1 の場合分け")
        if w[0] == 1:
            rep.chain([("P_1Q̌", P_(Pk[0], Q)), ("(I-2ň_1)Q̌", P_(T[0], Q)), ("(-1)Q̌", S_(m1, Q)), ("(1(-1))Q̌", S_(F(1) * m1, Q)),
                       ("((-1)^0(-1))Q̌", S_(m1**0 * m1, Q)), ("(-1)^1Q̌", S_(m1**1, Q)), ("(-1)^|ε|_1Q̌", S_(m1**cnt[1], Q))], f"{tag} k=1 ε(1)=1")
        else:
            rep.chain([("P_1Q̌", P_(Pk[0], Q)), ("(I-2ň_1)Q̌", P_(T[0], Q)), ("Q̌", Q), ("1Q̌", S_(1, Q)),
                       ("(-1)^0Q̌", S_(m1**0, Q)), ("(-1)^|ε|_1Q̌", S_(m1**cnt[1], Q))], f"{tag} k=1 ε(1)=0")
        for k in range(1, M):
            rep.check(cnt[k + 1] == (cnt[k] + 1 if w[k] == 1 else cnt[k]), f"{tag}: |ε|_(k+1) の場合分け（k={k}）")
            if w[k] == 1:
                rep.chain([("P_{k+1}Q̌", P_(Pk[k], Q)), ("(P_k(I-2ň_{k+1}))Q̌", P_(P_(Pk[k - 1], T[k]), Q)), ("P_k((I-2ň_{k+1})Q̌)", P_(Pk[k - 1], P_(T[k], Q))),
                           ("P_k((-1)Q̌)", P_(Pk[k - 1], S_(m1, Q))), ("(-1)(P_kQ̌)", S_(m1, P_(Pk[k - 1], Q))), ("(-1)((-1)^|ε|_kQ̌)", S_(m1, S_(m1**cnt[k], Q))),
                           ("((-1)(-1)^|ε|_k)Q̌", S_(m1 * m1**cnt[k], Q)), ("((-1)^|ε|_k(-1))Q̌", S_(m1**cnt[k] * m1, Q)), ("(-1)^(|ε|_k+1)Q̌", S_(m1**(cnt[k] + 1), Q)),
                           ("(-1)^|ε|_{k+1}Q̌", S_(m1**cnt[k + 1], Q))], f"{tag} k={k} ε(k+1)=1 の帰納法の段")
            else:
                rep.chain([("P_{k+1}Q̌", P_(Pk[k], Q)), ("(P_k(I-2ň_{k+1}))Q̌", P_(P_(Pk[k - 1], T[k]), Q)), ("P_k((I-2ň_{k+1})Q̌)", P_(Pk[k - 1], P_(T[k], Q))),
                           ("P_kQ̌", P_(Pk[k - 1], Q)), ("(-1)^|ε|_kQ̌", S_(m1**cnt[k], Q)), ("(-1)^|ε|_{k+1}Q̌", S_(m1**cnt[k + 1], Q))], f"{tag} k={k} ε(k+1)=0 の帰納法の段")
        rep.check(cnt[M] == popcount(w), f"{tag}: |ε|_M = |ε|")
        rep.check(P_(P, Q) == S_(m1**popcount(w), Q), f"{tag}: PQ̌ = (-1)^|ε|Q̌")
        rep.chain([("εQ̌", P_(E, Q)), ("η_εQ̌", S_(eta[w], Q)), ("(η_1(-1)^(M-|ε|))Q̌", S_(e1 * m1**(M - popcount(w)), Q)),
                   ("(η_1(-1)^(M-|ε|)((-1)^|ε|(-1)^|ε|))Q̌", S_(e1 * m1**(M - popcount(w)) * (m1**popcount(w) * m1**popcount(w)), Q)),
                   ("(η_1((-1)^(M-|ε|)(-1)^|ε|)(-1)^|ε|)Q̌", S_(e1 * (m1**(M - popcount(w)) * m1**popcount(w)) * m1**popcount(w), Q)),
                   ("(η_1(-1)^M(-1)^|ε|)Q̌", S_(e1 * m1**M * m1**popcount(w), Q)), ("c((-1)^|ε|Q̌)", S_(c, S_(m1**popcount(w), Q))), ("c(PQ̌)", S_(c, P_(P, Q)))],
                  f"{tag} εQ̌ = c(PQ̌)")
    Qs = [st.Q[w] for w in st.words]
    Rhs = e1 * m1**M * prod([Id - 2 * st.ns[mu] for mu in range(M)])   # 主張 (4) の右辺（Sage の経路）
    rep.check(body_finite_sum(Qs) == Id, f"{st.tag}: 仮定 Σ_ε Q̌_ε = I")
    rep.chain([("ε", E), ("εI", P_(E, Id)), ("ε Σ Q̌", P_(E, body_finite_sum(Qs))), ("Σ εQ̌", body_finite_sum([P_(E, X) for X in Qs])),
               ("Σ c(PQ̌)", body_finite_sum([S_(c, P_(P, X)) for X in Qs])), ("Σ (cP)Q̌", body_finite_sum([P_(S_(c, P), X) for X in Qs])),
               ("(cP) Σ Q̌", P_(S_(c, P), body_finite_sum(Qs))), ("(cP)I", P_(S_(c, P), Id)), ("cP", S_(c, P)), ("η_1(-1)^M Π(I-2ň)", Rhs)], f"{st.tag} (4) ε = cP")
    rep.check(E == Rhs, f"{st.tag}: 主張 (4)（Sage の積）")
    rep.negative(E != -Rhs, f"{st.tag}: 符号を -η_(1,…,1) に替えると (4) が外れる")
    rep.negative(st.G != Rhs and st.G != -Rhs, f"{st.tag}: σ_1^z は ±Π(I-2ň) でない")
    print(f"  {st.tag}: 済（累計 {rep.n} 件、否定 {rep.neg} 件、失敗 {rep.fail} 件）", flush=True)

rep.finish()

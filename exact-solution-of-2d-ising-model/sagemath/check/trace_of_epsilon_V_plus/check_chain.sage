# 対象ラベル: trace_of_epsilon_V_plus
# 準備 (P1)〜(P5)、Step 1〜6 の全ての鎖の行を、各行に書かれた式のとおりに組み、隣どうしを QQ(i) で厳密に比べる。
# 結合定数は K_1 = 2 log p、K_2 = log q（_prelude.sage）。M_col = 2..5、(p, q) は COUPLINGS の 3 組。
load("_prelude.sage")

rep = Report("trace_of_epsilon_V_plus: 準備と Step 1〜6 の鎖（厳密）")

for M in M_RANGE:
    for (p, q) in COUPLINGS:
        T = Setting(M, p, q)
        eps, B, V1, V2, D0, G, I, epsG = T.eps, T.B, T.V1, T.V2, T.D0, T.G, T.I, T.epsG
        tag = f"M={M}, p={p}, q={q}"
        # κ は実数 K_1 の像。行列 κX は exp の中身として現れるだけなので、exp(κX) はスペクトル射影で組む（T.expD0 など）。
        # 行列の等号のうち κ を不定元にしてよいものは check_symbolic_and_balls.sage で見る。

        # ---- 根拠に引いた主張の個々の場合 ----
        rep.check(P_(eps, B) == P_(B, eps), f"{tag}: εB = Bε（epsilon_commutes_with_V1_plus_square_root）")
        rep.check(P_(B, B) == V1, f"{tag}: BB = V_1^{{(+)}}（V1_plus_square_root_property）")
        rep.check(P_(eps, V1) == P_(V1, eps), f"{tag}: εV_1^{{(+)}} = V_1^{{(+)}}ε（epsilon_commutes_with_V1_plus）")
        rep.check(P_(eps, D0) == P_(D0, eps) and P_(D0, G) == P_(G, D0) and P_(eps, G) == P_(G, eps),
                  f"{tag}: epsilon_D0_G_pairwise_commute")
        rep.check(P_(epsG, epsG) == I, f"{tag}: (εG)^2 = I（epsilon_G_is_involution）")
        rep.check(P_(eps, eps) == I, f"{tag}: ε^2 = I（epsilon_square_and_eigenvalues）")
        rep.check(T.iH1 == A_(D0, epsG), f"{tag}: iH_1^{{(+)}} = D_0 + εG（H1_plus_in_sigma_z_form）")

        # ---- Step 1 ----
        rep.chain([
            ("tr(εV^{(+)})", tr(P_(eps, T.V))),
            ("tr(εBV_2B)", tr(P_(P_(P_(eps, B), V2), B))),
            ("tr(BεV_2B)", tr(P_(P_(P_(B, eps), V2), B))),
            ("tr(εV_2BB)", tr(P_(P_(P_(eps, V2), B), B))),
            ("tr(εV_2V_1)", tr(P_(P_(eps, V2), V1))),
            ("tr(V_1εV_2)", tr(P_(P_(V1, eps), V2))),
            ("tr(εV_1V_2)", tr(P_(P_(eps, V1), V2))),
        ], f"{tag}: Step 1")
        # 巡回性の当て方の個々の場合: tr(B(εV_2B)) = tr((εV_2B)B)、tr((εV_2)V_1) = tr(V_1(εV_2))
        X = P_(P_(eps, V2), B)
        rep.check(tr(P_(B, X)) == tr(P_(X, B)), f"{tag}: trace_basic_properties (2) を A = B, B' = εV_2B に")
        X = P_(eps, V2)
        rep.check(tr(P_(X, V1)) == tr(P_(V1, X)), f"{tag}: trace_basic_properties (2) を A = εV_2, B' = V_1 に")

        # ---- Step 2: V_1^{(+)} = exp(κD_0 + κ(εG)) = exp(κD_0)exp(κ(εG)) ----
        expSum = spectral_exp(A_(D0, epsG), lambda lam: p**(2 * lam))   # exp(κD_0 + κ(εG)) = exp(K_1(D_0 + εG))
        rep.chain([
            ("V_1^{(+)}", V1),
            ("exp(κD_0 + κ(εG))", expSum),
            ("exp(κD_0)exp(κ(εG))", P_(T.expD0, T.expEG)),
        ], f"{tag}: Step 2 の V_1^{{(+)}} の鎖")
        # exp(κ(εG)) = (cosh K_1)_ℂ I + (sinh K_1)_ℂ(εG)
        ch, sh = incl(T.ch), incl(T.sh)
        rep.chain([
            ("exp(κ(εG))", T.expEG),
            ("(cosh K_1)_ℂI + (1_ℂ(sinh K_1)_ℂ)(εG)", A_(S_(ch, I), S_(KG(1) * sh, epsG))),
            ("(cosh K_1)_ℂI + (sinh K_1)_ℂ(εG)", A_(S_(ch, I), S_(sh, epsG))),
        ], f"{tag}: Step 2 の exp(κ(εG)) の鎖")
        E2 = T.expEG
        lines = [
            ("εV_1^{(+)}", P_(eps, V1)),
            ("ε(exp(κD_0)exp(κ(εG)))", P_(eps, P_(T.expD0, E2))),
            ("(ε exp(κD_0))exp(κ(εG))", P_(P_(eps, T.expD0), E2)),
            ("(exp(κD_0)ε)exp(κ(εG))", P_(P_(T.expD0, eps), E2)),
            ("exp(κD_0)(ε exp(κ(εG)))", P_(T.expD0, P_(eps, E2))),
            ("exp(κD_0)(ε(chI + sh(εG)))", P_(T.expD0, P_(eps, A_(S_(ch, I), S_(sh, epsG))))),
            ("exp(κD_0)(ε(chI) + ε(sh(εG)))", P_(T.expD0, A_(P_(eps, S_(ch, I)), P_(eps, S_(sh, epsG))))),
            ("exp(κD_0)(ch(εI) + sh(ε(εG)))", P_(T.expD0, A_(S_(ch, P_(eps, I)), S_(sh, P_(eps, epsG))))),
            ("exp(κD_0)(chε + sh(ε(εG)))", P_(T.expD0, A_(S_(ch, eps), S_(sh, P_(eps, epsG))))),
            ("exp(κD_0)(chε + sh((εε)G))", P_(T.expD0, A_(S_(ch, eps), S_(sh, P_(P_(eps, eps), G))))),
            ("exp(κD_0)(chε + sh(IG))", P_(T.expD0, A_(S_(ch, eps), S_(sh, P_(I, G))))),
            ("exp(κD_0)(chε + shG)", P_(T.expD0, A_(S_(ch, eps), S_(sh, G)))),
        ]
        rep.chain(lines, f"{tag}: Step 2 の εV_1^{{(+)}} の鎖")
        rep.check(P_(eps, T.expD0) == P_(T.expD0, eps), f"{tag}: εexp(κD_0) = exp(κD_0)ε（commuting_matrix_commutes_with_exp）")

        # ---- Step 3 と (P5) ----
        ok_P5 = ok_a = ok_b = ok_c = ok_diag = True
        cols = {}
        for s in configs(M):
            f = f_basis(iota(s))
            cols[s] = f
            assert f.column(0)[ord_(s) - 1] == 1
        for s in configs(M):
            f = cols[s]
            for sp in configs(M):
                d = KG(1) if s == sp else KG(0)
                # (P5): (f_{ι(s)})_{ord(s')} = (f_{ι(s)})_{ν(ι(s'))} = Π_m (e_{ι(s)_m})_{ι(s')_m} = δ_{s=s'}
                e = {1: (1, 0), 2: (0, 1)}
                l1 = f[ord_(sp) - 1, 0]
                l2 = f[nu(iota(sp)) - 1, 0]
                l3 = prod(KG(e[iota(s)[m]][iota(sp)[m] - 1]) for m in range(M))
                ok_P5 &= (l1 == l2 == l3 == d)
                # 列の読み取りの 4 行: (Xf)_{ord(s')} = Σ_l X_{ord(s'),l}f_l = X_{ord(s'),ord(s)}f_{ord(s)} = X_{ord(s'),ord(s)}1_ℂ = X_{ord(s'),ord(s)}
                for X in (D0, G, eps):
                    r, c = ord_(sp) - 1, ord_(s) - 1
                    c1 = P_(X, f)[r, 0]
                    terms = [X[r, l] * f[l, 0] for l in range(T.n)]
                    c2 = sum(terms[1:], terms[0])
                    c3 = X[r, c] * f[c, 0]
                    c4 = X[r, c] * KG(1)
                    ok_P5 &= (c1 == c2 == c3 == c4 == X[r, c])
                    ok_P5 &= all(terms[l] == 0 for l in range(T.n) if l != c)   # finite_sum_with_single_nonzero_term の仮定
                # (a) D_0 の 4 行
                a1 = D0[ord_(sp) - 1, ord_(s) - 1]
                a2 = P_(D0, f)[ord_(sp) - 1, 0]
                a3 = S_(incl(energy(s)), f)[ord_(sp) - 1, 0]
                a4 = incl(energy(s)) * f[ord_(sp) - 1, 0]
                a5 = incl(energy(s)) * d
                ok_a &= (a1 == a2 == a3 == a4 == a5)
                # (a) G の 4 行
                g1 = G[ord_(sp) - 1, ord_(s) - 1]
                g2 = P_(G, f)[ord_(sp) - 1, 0]
                g3 = S_(incl(s[M - 1] * s[0]), f)[ord_(sp) - 1, 0]
                g4 = incl(s[M - 1] * s[0]) * f[ord_(sp) - 1, 0]
                g5 = incl(s[M - 1] * s[0]) * d
                ok_a &= (g1 == g2 == g3 == g4 == g5)
                # (b) ε の 3 行
                b1 = eps[ord_(sp) - 1, ord_(s) - 1]
                b2 = P_(eps, f)[ord_(sp) - 1, 0]
                b3 = cols[neg(s)][ord_(sp) - 1, 0]
                b4 = KG(1) if neg(s) == sp else KG(0)
                ok_b &= (b1 == b2 == b3 == b4)
                # (c) V_2 の成分（def_transfer_matrix）
                ok_c &= (V2[ord_(s) - 1, ord_(sp) - 1] == incl(q**sum(s[m] * sp[m] for m in range(M))))
            ok_b &= (P_(eps, f) == cols[neg(s)])          # (b) εf_{ι(s)} = f_{ι(−s)}
            ok_c &= (V2[ord_(s) - 1, ord_(s) - 1] == incl(T.k2exp(M)))
            ok_c &= (V2[ord_(neg(s)) - 1, ord_(s) - 1] == incl(T.k2exp(-M)))
            # κD_0 の対角成分 κ(E(s))_ℂ = (K_1E(s))_ℂ と exp(κD_0) の対角成分 = (exp(K_1E(s)))_ℂ
            ok_diag &= (T.expD0[ord_(s) - 1, ord_(s) - 1] == incl(T.kappa_exp(energy(s))))
        # exp(κD_0) が対角行列であること
        ok_diag &= all(T.expD0[r, c] == 0 for r in range(T.n) for c in range(T.n) if r != c)
        rep.check(ok_P5, f"{tag}: (P5) の鎖と列の読み取り")
        rep.check(ok_a, f"{tag}: Step 3 (a) の D_0・G の鎖")
        rep.check(ok_b, f"{tag}: Step 3 (b) の鎖と εf_ι(s) = f_ι(−s)")
        rep.check(ok_c, f"{tag}: Step 3 (c)")
        rep.check(ok_diag, f"{tag}: Step 3 (a) の exp(κD_0) の対角性と対角成分")

        # ---- Step 4: 対角成分の鎖 ----
        epsV2, GV2 = P_(eps, V2), P_(G, V2)
        X1, X2 = P_(T.expD0, epsV2), P_(T.expD0, GV2)
        for s in configs(M):
            k, km = ord_(s) - 1, ord_(neg(s)) - 1
            Es = energy(s)
            rep.chain([
                ("(exp(κD_0)(εV_2))_{ss}", X1[k, k]),
                ("exp(κD_0)_{ss}(εV_2)_{ss}", T.expD0[k, k] * epsV2[k, k]),
                ("exp(κD_0)_{ss}(ε_{s,−s}(V_2)_{−s,s})", T.expD0[k, k] * (eps[k, km] * V2[km, k])),
                ("exp(κD_0)_{ss}(1_ℂ(V_2)_{−s,s})", T.expD0[k, k] * (KG(1) * V2[km, k])),
                ("exp(κD_0)_{ss}(V_2)_{−s,s}", T.expD0[k, k] * V2[km, k]),
                ("(exp(K_1E(s)))_ℂ(V_2)_{−s,s}", incl(T.kappa_exp(Es)) * V2[km, k]),
                ("(exp(K_1E(s)))_ℂ(exp(−K_2M))_ℂ", incl(T.kappa_exp(Es)) * incl(T.k2exp(-M))),
                ("(exp(−K_2M)exp(K_1E(s)))_ℂ", incl(T.k2exp(-M) * T.kappa_exp(Es))),
            ], f"{tag}, s={s}: Step 4 の第 1 項の対角成分")
            # 第 2 行の根拠: (εV_2)_{ss} の和で k ≠ ord(−s) の項は 0
            rep.check(all(eps[k, j] == 0 for j in range(T.n) if j != km), f"{tag}, s={s}: ε の第 ord(s) 行は ord(−s) 以外 0")
            sg = s[M - 1] * s[0]
            rep.chain([
                ("(exp(κD_0)(GV_2))_{ss}", X2[k, k]),
                ("exp(κD_0)_{ss}(GV_2)_{ss}", T.expD0[k, k] * GV2[k, k]),
                ("exp(κD_0)_{ss}(G_{ss}(V_2)_{ss})", T.expD0[k, k] * (G[k, k] * V2[k, k])),
                ("(exp(K_1E(s)))_ℂ((s_Ms_1)_ℂ(V_2)_{ss})", incl(T.kappa_exp(Es)) * (incl(sg) * V2[k, k])),
                ("(exp(K_1E(s)))_ℂ((s_Ms_1)_ℂ(exp(K_2M))_ℂ)", incl(T.kappa_exp(Es)) * (incl(sg) * incl(T.k2exp(M)))),
                ("(exp(K_1E(s)))_ℂ(s_Ms_1exp(K_2M))_ℂ", incl(T.kappa_exp(Es)) * incl(sg * T.k2exp(M))),
                ("(exp(K_1E(s))s_Ms_1exp(K_2M))_ℂ", incl(T.kappa_exp(Es) * sg * T.k2exp(M))),
                ("(exp(K_2M)(s_Ms_1exp(K_1E(s))))_ℂ", incl(T.k2exp(M) * (sg * T.kappa_exp(Es)))),
            ], f"{tag}, s={s}: Step 4 の第 2 項の対角成分")
            rep.check(all(G[k, j] == 0 for j in range(T.n) if j != k), f"{tag}, s={s}: G の第 ord(s) 行は対角以外 0")

        # ---- Step 5 ----
        Sc = sum_over_configs(M, lambda s: T.kappa_exp(energy(s)))
        Ss = sum_over_configs(M, lambda s: s[M - 1] * s[0] * T.kappa_exp(energy(s)))
        e_m, e_p = T.k2exp(-M), T.k2exp(M)
        rep.check(tr(X1) == sum_over_configs(M, lambda s: X1[ord_(s) - 1, ord_(s) - 1]), f"{tag}: tr(X) = Σ_s X_ss（def_trace と和の定め方）")
        rep.chain([
            ("tr(exp(κD_0)(εV_2))", tr(X1)),
            ("Σ_s (exp(κD_0)(εV_2))_ss", sum_over_configs(M, lambda s: X1[ord_(s) - 1, ord_(s) - 1])),
            ("Σ_s (exp(−K_2M)exp(K_1E(s)))_ℂ", sum_over_configs(M, lambda s: incl(e_m * T.kappa_exp(energy(s))))),
            ("(Σ_s exp(−K_2M)exp(K_1E(s)))_ℂ", incl(sum_over_configs(M, lambda s: e_m * T.kappa_exp(energy(s))))),
            ("(exp(−K_2M)S_cosh)_ℂ", incl(e_m * Sc)),
        ], f"{tag}: Step 5 の第 1 項のトレース")
        rep.chain([
            ("tr(exp(κD_0)(GV_2))", tr(X2)),
            ("Σ_s (exp(κD_0)(GV_2))_ss", sum_over_configs(M, lambda s: X2[ord_(s) - 1, ord_(s) - 1])),
            ("Σ_s (exp(K_2M)(s_Ms_1exp(K_1E(s))))_ℂ", sum_over_configs(M, lambda s: incl(e_p * (s[M - 1] * s[0] * T.kappa_exp(energy(s)))))),
            ("(Σ_s exp(K_2M)(…))_ℂ", incl(sum_over_configs(M, lambda s: e_p * (s[M - 1] * s[0] * T.kappa_exp(energy(s)))))),
            ("(exp(K_2M)S_sinh)_ℂ", incl(e_p * Ss)),
        ], f"{tag}: Step 5 の第 2 項のトレース")
        C = A_(S_(ch, eps), S_(sh, G))
        rep.chain([
            ("tr(εV^{(+)})", tr(P_(eps, T.V))),
            ("tr(εV_1V_2)", tr(P_(P_(eps, V1), V2))),
            ("tr((exp(κD_0)(chε + shG))V_2)", tr(P_(P_(T.expD0, C), V2))),
            ("tr(exp(κD_0)((chε + shG)V_2))", tr(P_(T.expD0, P_(C, V2)))),
            ("tr(exp(κD_0)((chε)V_2 + (shG)V_2))", tr(P_(T.expD0, A_(P_(S_(ch, eps), V2), P_(S_(sh, G), V2))))),
            ("tr(exp(κD_0)(ch(εV_2) + sh(GV_2)))", tr(P_(T.expD0, A_(S_(ch, epsV2), S_(sh, GV2))))),
            ("tr(exp(κD_0)(ch(εV_2)) + exp(κD_0)(sh(GV_2)))", tr(A_(P_(T.expD0, S_(ch, epsV2)), P_(T.expD0, S_(sh, GV2))))),
            ("tr(ch(exp(κD_0)(εV_2)) + sh(exp(κD_0)(GV_2)))", tr(A_(S_(ch, X1), S_(sh, X2)))),
            ("ch tr(X_1) + sh tr(X_2)", ch * tr(X1) + sh * tr(X2)),
            ("ch(exp(−K_2M)S_cosh)_ℂ + sh(exp(K_2M)S_sinh)_ℂ", ch * incl(e_m * Sc) + sh * incl(e_p * Ss)),
            ("(ch(e_mS_cosh))_ℂ + (sh(e_pS_sinh))_ℂ", incl(T.ch * (e_m * Sc)) + incl(T.sh * (e_p * Ss))),
            ("(ch(e_mS_cosh) + sh(e_pS_sinh))_ℂ", incl(T.ch * (e_m * Sc) + T.sh * (e_p * Ss))),
        ], f"{tag}: Step 5 のトレースの鎖")
        # 実数の鎖（QQ で厳密）
        c2, s2 = 2 * T.ch, 2 * T.sh
        rep.check(Sc == 2 * rpow(c2, M - 1), f"{tag}: open_chain_partition_sum（K = K_1）")
        rep.check(Ss == 2 * rpow(s2, M - 1), f"{tag}: open_chain_endpoint_product_sum（K = K_1）")
        rep.chain([
            ("ch(e_mS_cosh) + sh(e_pS_sinh)", T.ch * (e_m * Sc) + T.sh * (e_p * Ss)),
            ("ch(e_m·2(2ch)^{M−1}) + sh(e_p·2(2sh)^{M−1})", T.ch * (e_m * (2 * rpow(c2, M - 1))) + T.sh * (e_p * (2 * rpow(s2, M - 1)))),
            ("e_m((2ch)^{M−1}(2ch)) + e_p((2sh)^{M−1}(2sh))", e_m * (rpow(c2, M - 1) * c2) + e_p * (rpow(s2, M - 1) * s2)),
            ("e_m(2ch)^M + e_p(2sh)^M", e_m * rpow(c2, M) + e_p * rpow(s2, M)),
            # exp(Σ_{j=1}^{M}(∓K_2)) = q^{Σ(∓1)}: 指数を和として組む
            ("exp(Σ(−K_2))(2ch)^M + exp(ΣK_2)(2sh)^M", T.k2exp(sum([-1] * M)) * rpow(c2, M) + T.k2exp(sum([1] * M)) * rpow(s2, M)),
            ("(Π exp(−K_2))(2ch)^M + (Π exp(K_2))(2sh)^M", real_prod([q**-1] * M) * rpow(c2, M) + real_prod([q] * M) * rpow(s2, M)),
            ("(Π exp(−K_2))(Π 2ch) + (Π exp(K_2))(Π 2sh)", real_prod([q**-1] * M) * real_prod([c2] * M) + real_prod([q] * M) * real_prod([s2] * M)),
            ("Π(exp(−K_2)·2ch) + Π(exp(K_2)·2sh)", real_prod([q**-1 * c2] * M) + real_prod([q * s2] * M)),
            ("(2exp(−K_2)ch)^M + (2exp(K_2)sh)^M", rpow(2 * q**-1 * T.ch, M) + rpow(2 * q * T.sh, M)),
        ], f"{tag}: Step 5 の実数の鎖")
        # 主張
        rep.check(tr(P_(eps, T.V)) == incl(T.closed_form()), f"{tag}: 主張 tr(εV^{{(+)}}) = (右辺)_ℂ")

        # ---- Step 6（正値性）----
        rep.check(Sc > 0 and Ss > 0, f"{tag}: open_chain_spin_sums_positive")
        rep.check(T.ch > 0 and T.sh > 0 and T.ch > T.sh, f"{tag}: cosh_sinh_basic_properties (3)")
        rep.check(e_m > 0 and e_p > 0, f"{tag}: real_exp_positive")
        rep.check(T.ch * (e_m * Sc) > 0 and T.sh * (e_p * Ss) > 0 and T.closed_form() > 0, f"{tag}: Step 6 の二項と和は正")

        # ---- 否定コントロール ----
        rep.negative(tr(T.V) != tr(P_(eps, T.V)), f"{tag}: ε を除いた tr(V^{{(+)}}) は値が違う")
        rep.negative(T.expEG != A_(S_(sh, I), S_(ch, epsG)), f"{tag}: exp(κ(εG)) で cosh と sinh を入れ替えると違う")
        rep.negative(all(V2[ord_(s) - 1, ord_(s) - 1] != V2[ord_(neg(s)) - 1, ord_(s) - 1] for s in configs(M)),
                     f"{tag}: Step 4 で (V_2)_{{−s,s}} を (V_2)_{{s,s}} に替えると違う")
        rep.negative(T.closed_form() != rpow(2 * q * T.ch, M) + rpow(2 * q**-1 * T.sh, M), f"{tag}: K_2 の符号を入れ替えた式とは違う")
        rep.negative(T.closed_form() != rpow(q**-1 * T.ch, M) + rpow(q * T.sh, M), f"{tag}: 因子 2 を落とした式とは違う")
        rep.negative(P_(T.expD0, T.expEG) != P_(T.expD0, spectral_exp(G, lambda lam: p**(2 * lam))), f"{tag}: exp(κ(εG)) を exp(κG) に替えると違う")
        rep.negative(Sc != 2 * rpow(s2, M - 1), f"{tag}: S_cosh は 2(2sinh K_1)^{{M−1}} ではない")

rep.finish()

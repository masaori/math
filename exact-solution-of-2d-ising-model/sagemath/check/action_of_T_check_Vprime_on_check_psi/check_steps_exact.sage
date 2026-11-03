# 対象ラベル: action_of_T_check_Vprime_on_check_psi
# 証明の準備 5、Step 1・1'・2・2'・3・4 と Step 5 の部分和の等式を、本物の ψ̌^†_λ, ψ̌_λ, X̌ で行ごとに厳密に確かめる。
# 行列は ExactSetting（_prelude.sage）の P = L[ρ, g] の成分で組む（r_λ・γ(θ~_λ) の全ての値について一度に）。
# 各行の行列を本文の式どおりに別々に組み、隣の行と比べる。積・和・差・スカラー倍・符号反転は本文の定義の成分の式
# （body_product・body_sum・body_difference・body_scalar・body_negation）で組む。
# ρ^2 = a_λ conj(a_λ) の関係を使うのは、反交換関係（anticommutator_of_check_psi）を当てる行と、その帰結を使う行だけで、
# それ以外の行は P の中でそのまま等しいことを見る（needs_rel = False）。
# 範囲: 結合定数 2 組（臨界点 (2,3) と (4,3)）× M_col = 2, 3。Step 1・1'・準備 5・Step 2・2' は全ての μ, ν ∈ M̌、
#   Step 3〜5 は全ての μ について n ≤ 4（M_col = 2）、n ≤ 3（M_col = 3）、部分和は N ≤ 同じ。
# 対照: Step 1 で ψ̌_{M+1-ν} を ψ̌_ν に取り違えると δ_{μ,ν} ψ̌^†_ν にならない。Step 3 で c の符号を逆にすると等式が崩れる。
#   Step 2' の第 8 行の根拠 γ_1(θ~_{M+1-μ}) = γ_1(θ~_μ) に対し、共役でない添字 λ では γ_1(θ~_λ) ≠ γ_1(θ~_μ)（M_col = 3）。
load("_prelude.sage")

rep = Report("action_of_T_check_Vprime_on_check_psi: 準備 5、Step 1〜5 の厳密な行")

# 共有ライブラリ（pauli_sites_exact.sage）の大域名を上書きしないよう、本体は関数の中に置く。
def main():
    CASES = [(2, 4), (3, 3)]
    for M, NPOW in CASES:
        S = Setting(M)
        J = S.J
        for kk in [COUPLINGS[0], COUPLINGS[2]]:
            k = couplings(*kk)
            for sym in [False, True]:
                ES = ExactSetting(S, k, sym)
                P = ES.P; I_ = ES.I; O = ES.O; U = ES.U; g = ES.g
                dag = ES.dag; psi = ES.psi; Pm = ES.Pm; X = ES.X
                tag = f"M={M} {kk} g{'対称' if sym else '独立'}"
                # 共役添字の閉性（def_check_index_set (2)）と M+1-(M+1-ν) = ν
                rep.check(all((M + 1 - l) in J and M + 1 - (M + 1 - l) == l for l in J), f"共役添字の閉性 {tag}", quiet=True)
                if not sym:
                    # ---- Step 1 / Step 1' ----
                    for mu in J:
                        for nv in J:
                            nb = M + 1 - nv
                            d_dag = dag[nv]; e_ = psi[nb]
                            # 準備の事実: ψ̌^†_μ ψ̌^†_ν + ψ̌^†_ν ψ̌^†_μ = O（ρ^2 の関係を使う）
                            rep.check(ES.red(acomm(dag[nv], dag[mu])) == O, f"anticommutator_of_check_psi 第 1 式の当てはめ [ψ̌^†_ν, ψ̌^†_μ]_+ = O μ={mu} ν={nv} {tag}", quiet=True)
                            rep.check(ES.red(acomm(psi[nb], psi[mu])) == O, f"anticommutator_of_check_psi 第 3 式の当てはめ [ψ̌_{{M+1-ν}}, ψ̌_μ]_+ = O μ={mu} ν={nv} {tag}", quiet=True)
                            rep.check(kdelta(nb, M + 1 - mu, ZZ) == kdelta(mu, nv, ZZ), f"Step 1 の δ_{{M+1-ν,M+1-μ}} = δ_{{μ,ν}} μ={mu} ν={nv}", quiet=True)
                            dmn = kdelta(mu, nv, P)
                            L1 = [
                                (comm(Pm[nv], dag[mu]), "", False),
                                (comm(body_product(d_dag, e_), dag[mu]), "P_ν の定め方", False),
                                (body_difference(body_product(d_dag, acomm(e_, dag[mu])), body_product(acomm(d_dag, dag[mu]), e_)), "commutator_via_anticommutators", False),
                                (body_difference(body_product(d_dag, body_sum(body_product(e_, dag[mu]), body_product(dag[mu], e_))), body_product(acomm(d_dag, dag[mu]), e_)), "def_matrix_anticommutator", False),
                                (body_difference(body_product(d_dag, body_sum(body_product(dag[mu], e_), body_product(e_, dag[mu]))), body_product(acomm(d_dag, dag[mu]), e_)), "matrix_sum_is_commutative", False),
                                (body_difference(body_product(d_dag, acomm(dag[mu], e_)), body_product(acomm(d_dag, dag[mu]), e_)), "def_matrix_anticommutator", False),
                                (body_difference(body_product(d_dag, body_scalar(kdelta(nb, M + 1 - mu, P), I_)), body_product(acomm(d_dag, dag[mu]), e_)), "anticommutator_of_check_psi 第 2 式", True),
                                (body_difference(body_product(d_dag, body_scalar(kdelta(nb, M + 1 - mu, P), I_)), body_product(O, e_)), "anticommutator_of_check_psi 第 1 式", True),
                                (body_difference(body_product(d_dag, body_scalar(kdelta(nb, M + 1 - mu, P), I_)), O), "zero_matrix_is_left_zero_of_mat_mult", False),
                                (body_product(d_dag, body_scalar(kdelta(nb, M + 1 - mu, P), I_)), "matrix_minus_zero_matrix", False),
                                (body_product(d_dag, body_scalar(dmn, I_)), "δ の読み替え", False),
                                (body_scalar(dmn, body_product(d_dag, I_)), "scalar_multiple_factors_out_of_right_factor", False),
                                (body_scalar(dmn, d_dag), "identity_matrix_is_right_unit_of_mat_mult", False),
                            ]
                            check_chain(rep, ES, L1, f"Step 1 μ={mu} ν={nv} {tag}")
                            # 対照: ψ̌_{M+1-ν} を ψ̌_ν に取り違える
                            if mu == nv and nv != nb:
                                rep.check(ES.red(comm(body_product(d_dag, psi[nv]), dag[mu]) - body_scalar(dmn, d_dag)) != 0,
                                          f"対照 Step 1 で添字を取り違えると δψ̌^† にならない μ={mu} {tag}", quiet=True)
                            dmnb = kdelta(mu, nb, P)
                            L1p = [
                                (comm(Pm[nv], psi[mu]), "", False),
                                (comm(body_product(d_dag, e_), psi[mu]), "P_ν の定め方", False),
                                (body_difference(body_product(d_dag, acomm(e_, psi[mu])), body_product(acomm(d_dag, psi[mu]), e_)), "commutator_via_anticommutators", False),
                                (body_difference(body_product(d_dag, O), body_product(acomm(d_dag, psi[mu]), e_)), "anticommutator_of_check_psi 第 3 式", True),
                                (body_difference(O, body_product(acomm(d_dag, psi[mu]), e_)), "zero_matrix_is_right_zero_of_mat_mult", False),
                                (body_difference(O, body_product(body_scalar(dmnb, I_), e_)), "anticommutator_of_check_psi 第 2 式", True),
                                (body_difference(O, body_scalar(dmnb, body_product(I_, e_))), "scalar_multiple_factors_out_of_left_factor", False),
                                (body_difference(O, body_scalar(dmnb, e_)), "identity_matrix_is_left_unit_of_mat_mult", False),
                                (body_sum(O, body_negation(body_scalar(dmnb, e_))), "matrix_difference_is_sum_with_negation", False),
                                (body_negation(body_scalar(dmnb, e_)), "zero_matrix_plus_matrix", False),
                            ]
                            check_chain(rep, ES, L1p, f"Step 1' μ={mu} ν={nv} {tag}")
                # ---- 準備 5（W = ψ̌^†_μ, ψ̌_μ） ----
                for mu in J:
                    for W, wn in [(dag[mu], "ψ̌^†"), (psi[mu], "ψ̌")]:
                        for nv in J:
                            Cn = ES.C[nv]; Pn = Pm[nv]
                            L5 = [
                                (comm(Cn, W), "", False),
                                (body_difference(body_product(body_scalar(g[nv], body_difference(Pn, U)), W), body_product(W, body_scalar(g[nv], body_difference(Pn, U)))), "def_ad_X_matrix", False),
                                (body_difference(body_scalar(g[nv], body_product(body_difference(Pn, U), W)), body_product(W, body_scalar(g[nv], body_difference(Pn, U)))), "scalar_multiple_factors_out_of_left_factor", False),
                                (body_difference(body_scalar(g[nv], body_product(body_difference(Pn, U), W)), body_scalar(g[nv], body_product(W, body_difference(Pn, U)))), "scalar_multiple_factors_out_of_right_factor", False),
                                (body_difference(body_scalar(g[nv], body_difference(body_product(Pn, W), body_product(U, W))), body_scalar(g[nv], body_product(W, body_difference(Pn, U)))), "準備 2 の第 1 式", False),
                                (body_difference(body_scalar(g[nv], body_difference(body_product(Pn, W), body_product(U, W))), body_scalar(g[nv], body_difference(body_product(W, Pn), body_product(W, U)))), "準備 2 の第 2 式", False),
                                (body_difference(body_scalar(g[nv], body_difference(body_product(Pn, W), body_product(U, W))), body_scalar(g[nv], body_difference(body_product(W, Pn), body_product(U, W)))), "準備 1", False),
                                (body_scalar(g[nv], body_difference(body_difference(body_product(Pn, W), body_product(U, W)), body_difference(body_product(W, Pn), body_product(U, W)))), "scalar_multiple_distributes_over_matrix_difference", False),
                                (body_scalar(g[nv], body_difference(body_product(Pn, W), body_product(W, Pn))), "準備 3", False),
                                (body_scalar(g[nv], comm(Pn, W)), "def_ad_X_matrix", False),
                            ]
                            check_chain(rep, ES, L5, f"準備 5 の [C_ν, W] W={wn}_{mu} ν={nv} {tag}")
                        Cs = [ES.C[nv] for nv in J]
                        L5b = [
                            (comm(X, W), "", False),
                            (body_difference(body_product(X, W), body_product(W, X)), "def_ad_X_matrix", False),
                            (body_difference(body_product(body_finite_sum(Cs), W), body_product(W, body_finite_sum(Cs))), "def_check_Vprime の X̌", False),
                            (body_difference(body_finite_sum([body_product(Cn, W) for Cn in Cs]), body_product(W, body_finite_sum(Cs))), "finite_sum_of_matrices_distributes_in_left_factor", False),
                            (body_difference(body_finite_sum([body_product(Cn, W) for Cn in Cs]), body_finite_sum([body_product(W, Cn) for Cn in Cs])), "finite_sum_of_matrices_distributes_in_right_factor", False),
                            (body_finite_sum([body_difference(body_product(Cn, W), body_product(W, Cn)) for Cn in Cs]), "準備 4", False),
                            (body_finite_sum([comm(Cn, W) for Cn in Cs]), "def_ad_X_matrix", False),
                            (body_finite_sum([body_scalar(g[nv], comm(Pm[nv], W)) for nv in J]), "[C_ν, W] の式", False),
                        ]
                        check_chain(rep, ES, L5b, f"準備 5 の [X̌, W] W={wn}_{mu} {tag}")
                # ---- Step 2 / Step 2' ----
                for mu in J:
                    mb = M + 1 - mu
                    for nv in J:
                        if nv != mu:
                            Lz = [(body_scalar(g[nv], body_scalar(kdelta(mu, nv, P), dag[nv])), "", False),
                                  (body_scalar(g[nv], body_scalar(P(0), dag[nv])), "def_kronecker_delta", False),
                                  (body_scalar(g[nv], O), "zero_scalar_multiple_is_zero_matrix", False),
                                  (O, "scalar_multiple_of_zero_matrix", False)]
                            check_chain(rep, ES, Lz, f"Step 2 の零の項 μ={mu} ν={nv} {tag}")
                        if M + 1 - nv != mu:
                            e_ = psi[M + 1 - nv]
                            Lz2 = [(body_scalar(g[nv], body_negation(body_scalar(kdelta(mu, M + 1 - nv, P), e_))), "", False),
                                   (body_scalar(g[nv], body_negation(body_scalar(P(0), e_))), "def_kronecker_delta", False),
                                   (body_scalar(g[nv], body_negation(O)), "zero_scalar_multiple_is_zero_matrix", False),
                                   (body_scalar(g[nv], body_scalar(P(-1), O)), "negation_is_scalar_multiple_by_minus_one", False),
                                   (body_scalar(g[nv], O), "scalar_multiple_of_zero_matrix", False),
                                   (O, "scalar_multiple_of_zero_matrix", False)]
                            check_chain(rep, ES, Lz2, f"Step 2' の零の項 μ={mu} ν={nv} {tag}")
                    L2 = [
                        (comm(X, dag[mu]), "", False),
                        (body_finite_sum([body_scalar(g[nv], comm(Pm[nv], dag[mu])) for nv in J]), "準備 5", False),
                        (body_finite_sum([body_scalar(g[nv], body_scalar(kdelta(mu, nv, P), dag[nv])) for nv in J]), "Step 1", True),
                        (body_scalar(g[mu], body_scalar(kdelta(mu, mu, P), dag[mu])), "finite_sum_of_matrices_with_single_nonzero_term", False),
                        (body_scalar(g[mu], body_scalar(P(1), dag[mu])), "def_kronecker_delta", False),
                        (body_scalar(g[mu], dag[mu]), "scalar_multiple_by_one", False),
                    ]
                    check_chain(rep, ES, L2, f"Step 2 μ={mu} {tag}")
                    L2p = [
                        (comm(X, psi[mu]), "", False),
                        (body_finite_sum([body_scalar(g[nv], comm(Pm[nv], psi[mu])) for nv in J]), "準備 5", False),
                        (body_finite_sum([body_scalar(g[nv], body_negation(body_scalar(kdelta(mu, M + 1 - nv, P), psi[M + 1 - nv]))) for nv in J]), "Step 1'", True),
                        (body_scalar(g[mb], body_negation(body_scalar(kdelta(mu, M + 1 - mb, P), psi[M + 1 - mb]))), "finite_sum_of_matrices_with_single_nonzero_term", False),
                        (body_scalar(g[mb], body_negation(body_scalar(kdelta(mu, mu, P), psi[mu]))), "ℤ で M+1-(M+1-μ) = μ", False),
                        (body_scalar(g[mb], body_negation(body_scalar(P(1), psi[mu]))), "def_kronecker_delta", False),
                        (body_scalar(g[mb], body_negation(psi[mu])), "scalar_multiple_by_one", False),
                        (body_negation(body_scalar(g[mb], psi[mu])), "scalar_multiple_of_negated_matrix", False),
                    ]
                    check_chain(rep, ES, L2p, f"Step 2' μ={mu} {tag}")
                    # 第 8 行（γ(θ~_{M+1-μ}) = γ(θ~_μ)）: γ = arccosh∘γ_1 なので γ_1 の一致を L で厳密に見る。
                    # g 対称の環では g_{M+1-μ} と g_μ が同じ不定元なので、行列としてそのまま等しい。g 独立の環では等しくない（対照）。
                    rep.check(S.gamma1(mb, k) == S.gamma1(mu, k), f"Step 2' 第 8 行の根拠 γ_1(θ~_{{M+1-μ}}) = γ_1(θ~_μ) μ={mu} {tag}", quiet=True)
                    A7 = body_negation(body_scalar(g[mb], psi[mu])); B7 = body_negation(body_scalar(g[mu], psi[mu]))
                    if sym:
                        rep.check(A7 == B7, f"Step 2' 第 8 行（g_ν の定め方と periodicity_of_check_fermi (3) で g を読み替え） μ={mu} {tag}", quiet=True)
                        L2q = [
                            (B7, "", False),
                            (body_scalar(P(-1), body_scalar(g[mu], psi[mu])), "negation_is_scalar_multiple_by_minus_one", False),
                            (body_scalar(P(-1) * g[mu], psi[mu]), "scalar_multiple_is_associative", False),
                            (body_scalar(-g[mu], psi[mu]), "multiply_by_minus_one", False),
                        ]
                        check_chain(rep, ES, L2q, f"Step 2' μ={mu} {tag}", offset=8)
                        rep.check(ES.red(comm(X, psi[mu]) - body_scalar(-g[mu], psi[mu])) == 0, f"Step 2' の結論 μ={mu} {tag}", quiet=True)
                    if M >= 3:
                        # 対照（値）: 共役でない添字では γ_1 は一致しない（第 8 行の根拠の検算が値を見ていること）
                        other = [l for l in J if l != mu and l != mb]
                        rep.check(all(S.gamma1(l, k) != S.gamma1(mu, k) for l in other), f"対照 γ_1(θ~_λ) ≠ γ_1(θ~_μ)（λ ≠ μ, M+1-μ） μ={mu} {tag}", quiet=True)
                # ---- Step 3〜5（g 対称の環で、[X̌, W] = cW を満たす W, c に） ----
                if sym:
                    for mu in J:
                        for W, c, wn in [(dag[mu], g[mu], "ψ̌^†"), (psi[mu], -g[mu], "ψ̌")]:
                            rep.check(ES.red(comm(X, W) - body_scalar(c, W)) == 0, f"Step 3〜6 の仮定 [X̌, W] = cW W={wn}_{mu} {tag}", quiet=True)
                            Xc = body_sum(X, body_scalar(c, I_))
                            L3 = [
                                (body_product(X, W), "", False),
                                (body_sum(body_product(W, X), body_difference(body_product(X, W), body_product(W, X))), "matrix_plus_difference_cancels", False),
                                (body_sum(body_product(W, X), comm(X, W)), "def_ad_X_matrix", False),
                                (body_sum(body_product(W, X), body_scalar(c, W)), "仮定 [X̌, W] = cW", True),
                                (body_sum(body_product(W, X), body_scalar(c, body_product(W, I_))), "identity_matrix_is_right_unit_of_mat_mult", False),
                                (body_sum(body_product(W, X), body_product(W, body_scalar(c, I_))), "scalar_multiple_factors_out_of_right_factor", False),
                                (body_product(W, Xc), "mat_mult_distributes_over_sum_in_right_factor", False),
                            ]
                            check_chain(rep, ES, L3, f"Step 3 W={wn}_{mu} {tag}")
                            # 対照: c の符号を逆にすると Step 3 の等式が崩れる
                            rep.check(ES.red(body_product(X, W) - body_product(W, body_sum(X, body_scalar(-c, I_)))) != 0,
                                      f"対照 c の符号を逆にすると X̌W = W(X̌ - cI) にならない W={wn}_{mu} {tag}", quiet=True)
                            # Step 4: 冪（def_exp (1) の A^0 := I, A^{m+1} := A^m A）
                            Xp = [I_]; Xcp = [I_]
                            for p in range(NPOW):
                                Xp.append(ES.red(body_product(Xp[-1], X)))
                                Xcp.append(ES.red(body_product(Xcp[-1], Xc)))
                            L40 = [(body_product(Xp[0], W), "", False), (body_product(I_, W), "A^0 := I", False), (W, "identity_matrix_is_left_unit_of_mat_mult", False),
                                   (body_product(W, I_), "identity_matrix_is_right_unit_of_mat_mult", False), (body_product(W, Xcp[0]), "A^0 := I", False)]
                            check_chain(rep, ES, L40, f"Step 4 の n = 0 W={wn}_{mu} {tag}")
                            for nn in range(NPOW):
                                L4 = [
                                    (body_product(Xp[nn + 1], W), "", True),
                                    (body_product(body_product(Xp[nn], X), W), "A^{m+1} := A^m A", True),
                                    (body_product(Xp[nn], body_product(X, W)), "mat_mult_associative", False),
                                    (body_product(Xp[nn], body_product(W, Xc)), "Step 3", True),
                                    (body_product(body_product(Xp[nn], W), Xc), "mat_mult_associative", False),
                                    (body_product(body_product(W, Xcp[nn]), Xc), "帰納法の仮定", True),
                                    (body_product(W, body_product(Xcp[nn], Xc)), "mat_mult_associative", False),
                                    (body_product(W, Xcp[nn + 1]), "A^{m+1} := A^m A", True),
                                ]
                                check_chain(rep, ES, L4, f"Step 4 の n = {nn}→{nn + 1} W={wn}_{mu} {tag}")
                            # Step 5 の部分和の等式（N ≤ NPOW）
                            cm = [P(QQ(1) / factorial(m)) for m in range(NPOW + 1)]
                            for N in range(NPOW + 1):
                                SX = body_finite_sum([body_scalar(cm[m], Xp[m]) for m in range(N + 1)])
                                SXc = body_finite_sum([body_scalar(cm[m], Xcp[m]) for m in range(N + 1)])
                                L5s = [
                                    (body_product(SX, W), "", False),
                                    (body_product(body_finite_sum([body_scalar(cm[m], Xp[m]) for m in range(N + 1)]), W), "S_N の定め方", False),
                                    (body_product(body_finite_sum([body_scalar(cm[jj - 1], Xp[jj - 1]) for jj in range(1, N + 2)]), W), "def_finite_sum_of_matrices_from_index_zero（添字 j = m + 1）", False),
                                    (body_finite_sum([body_product(body_scalar(cm[m], Xp[m]), W) for m in range(N + 1)]), "finite_sum_of_matrices_distributes_in_left_factor", False),
                                    (body_finite_sum([body_scalar(cm[m], body_product(Xp[m], W)) for m in range(N + 1)]), "scalar_multiple_factors_out_of_left_factor", False),
                                    (body_finite_sum([body_scalar(cm[m], body_product(W, Xcp[m])) for m in range(N + 1)]), "Step 4", True),
                                    (body_finite_sum([body_product(W, body_scalar(cm[m], Xcp[m])) for m in range(N + 1)]), "scalar_multiple_factors_out_of_right_factor", False),
                                    (body_product(W, SXc), "finite_sum_of_matrices_distributes_in_right_factor", False),
                                    (body_product(W, body_finite_sum([body_scalar(cm[m], Xcp[m]) for m in range(N + 1)])), "def_finite_sum_of_matrices_from_index_zero", False),
                                    (body_product(W, SXc), "S_N の定め方", False),
                                ]
                                check_chain(rep, ES, L5s, f"Step 5 の部分和 N={N} W={wn}_{mu} {tag}")
                print(f"{tag}: 済み")


main()
rep.finish()

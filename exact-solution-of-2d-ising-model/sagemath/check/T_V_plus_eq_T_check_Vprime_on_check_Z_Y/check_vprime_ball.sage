# 対象ラベル: T_V_plus_eq_T_check_Vprime_on_check_Z_Y
# 本体の鎖のうち T_{(V̌')} を含む第 5〜第 10 等号と主張を、ℝ への脱出を含む量（exp の値）をボールで囲んで確かめる。
# 数の値: check_main_chain_exact.sage と同じ数体 E の元（Ž_μ・Y̌_μ・ψ̌_λ・P̌_μ^{-1}・λ_{±,μ}・T_{(V^{(+)})}(X_l)）を、
#   prelude の to_cb（ζ ↦ exp(2πi/(4M))、σ > 0、R ↦ +r_λ の埋め込み）で ComplexBallField(512) へ移す。
# ℝ への脱出: γ(θ̃_λ) は def_gamma_theta・def_arccosh の log(g + √(g^2 - 1))（g = γ_1(θ̃_λ)、実対数）のボール、
#   (exp(±γ))_C は実数の exp のボール、V̌' := exp(X̌)・exp(-X̌) は def_exp の部分和（積は mat_mult の成分の式）に尾の上界を足したボール。
#   X̌ は def_check_Vprime の Σ_λ (γ(θ̃_λ))_C(ψ̌_λ^† ψ̌_{M+1-λ} - (1/2)_C I) を成分の式で組む。
#   (V̌')^{-1} は def_check_Vprime (2) の exp(-X̌) で、Sage の逆行列（独立な経路）と重なることを見る。
# 各行を別々に組み、隣り合う行のボールが重なることで等号を判定する。第 5 等号の左辺は check_main_chain_exact.sage の
#   λ_{±,μ} 版の厳密な値を移したもので、それと (exp(±γ))_C 版のボールが重なることも見る（λ_{±,μ} = exp(±γ(θ̃_μ))）。
# 主張: 厳密な T_{(V^{(+)})}(X_l) を移した値と、Sage の行列の exp・逆行列（独立な経路）で作った V̌'X_l(V̌')^{-1} が重なる。
# 範囲: 結合定数 3 組 × M_col = 2, 3, 4 × 全 μ × l = 1, 2。
# 対照: 逆向きの共役 (V̌')^{-1}X_l V̌'（γ の符号を逆にした exp(-X̌) による共役と同じ）とは重ならない。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
rep = Report("T_V_plus_eq_T_check_Vprime_on_check_Z_Y: 本体の第 5〜第 10 等号と主張（ボール）")


def main():
    for (x, y) in COUPLINGS:
        for M in Ms:
            f = Factors(M, x, y)
            J = list(range(1, M + 1))
            S = {l: PsiSetting(f, l) for l in J}
            tcb = {l: to_cb_factory(S[l]) for l in J}
            n = f.n
            Icb = body_identity(CB, n)
            dag = {l: mat_cb(S[l].psid, tcb[l]) for l in J}
            psi = {l: mat_cb(S[l].psi, tcb[l]) for l in J}
            gam = {}
            for l in J:
                g = RB(S[l].g1_AA)
                gam[l] = (g + (g**2 - 1).sqrt()).log()              # def_arccosh
            half = body_scalar(CB(1) / 2, Icb)
            X = body_finite_sum([body_scalar(CB(gam[l]), body_difference(body_product(dag[l], psi[M + 1 - l]), half)) for l in J])
            Vp = body_exp_ball(X)                                   # V̌' := exp(X̌)
            Vm = body_exp_ball(body_negation(X))                    # exp(-X̌) = (V̌')^{-1}（def_check_Vprime (2)）
            tag0 = f"(x,y)=({x},{y}) M={M}"
            rep.check(balls_overlap(Vp, X.exp()) and balls_overlap(Vm, (-X).exp()), f"{tag0}: exp の部分和のボールと Sage の exp が重なる", quiet=True)
            rep.check(balls_overlap(Vm, Vp.inverse()), f"{tag0}: (V̌')^-1 = exp(-X̌)（Sage の逆行列と重なる）", quiet=True)
            Tp = lambda W: body_product(body_product(Vp, W), Vm)       # T_{(V̌')}(W) := V̌'W(V̌')^{-1}（def_check_Vprime (2)）
            Tg = lambda W: body_product(body_product(Vp, W), Vm)       # T_{V̌'}（def_T_g の g h g^{-1}。準備 3 で同じ写像）
            Vs = X.exp(); Vsi = Vs.inverse()
            for mu in J:
                s = S[mu]; to = tcb[mu]
                E = s.E
                Q = s.P.inverse()
                Xs = [s.Z, s.Y]
                V, Vinv = s.Vplus()
                Pcb = [dag[mu], psi[mu]]
                ep, em = CB(gam[mu].exp()), CB((-gam[mu]).exp())    # (exp(±γ(θ̃_μ)))_C
                rep.check(ep.overlaps(to(s.lp)) and em.overlaps(to(s.lm)), f"{tag0} μ={mu}: (exp(±γ))_C は λ_± と重なる", quiet=True)
                for l in (1, 2):
                    L = l - 1
                    tag = f"{tag0} μ={mu} l={l}"
                    q1, q2 = to(Q[0, L]), to(Q[1, L])
                    exact5 = body_sum(body_scalar(Q[0, L], body_scalar(s.lp, s.psid)), body_scalar(Q[1, L], body_scalar(s.lm, s.psi)))
                    lhs = s.T_composite(Xs[L])                          # T_{(V^{(+)})}(X_l)（def_T_V_plus の三つの共役の合成、厳密）
                    assert lhs == conj_body(V, Xs[L], Vinv)             # = T_{V^{(+)}}(X_l)（T_V_plus_is_conjugation）
                    Xl = mat_cb(Xs[L], to)
                    comb = body_sum(body_scalar(q1, Pcb[0]), body_scalar(q2, Pcb[1]))
                    rows = [
                        mat_cb(exact5, to),                                                       # 第 5 等号の右辺（λ_± 版）
                        body_sum(body_scalar(q1, body_scalar(ep, Pcb[0])), body_scalar(q2, body_scalar(em, Pcb[1]))),  # (exp(±γ))_C 版
                        body_sum(body_scalar(q1, Tp(Pcb[0])), body_scalar(q2, Tp(Pcb[1]))),       # 第 6 等号の右辺
                        body_sum(body_scalar(q1, Tg(Pcb[0])), body_scalar(q2, Tg(Pcb[1]))),       # 第 7 等号の右辺
                        Tg(comb),                                                                 # 第 8 等号の右辺
                        Tp(comb),                                                                 # 第 9 等号の右辺
                        Tp(Xl),                                                                   # 第 10 等号の右辺
                    ]
                    names = ["λ_± = (exp(±γ))_C", "第 6 等号", "第 7 等号", "第 8 等号", "第 9 等号", "第 10 等号"]
                    for t in range(len(rows) - 1):
                        rep.check(balls_overlap(rows[t], rows[t + 1]), f"{tag}: {names[t]}", quiet=True)
                    rep.check(balls_overlap(comb, Xl), f"{tag}: 準備 2 の q_{{1l}}Ψ_1 + q_{{2l}}Ψ_2 = X_l（ボールでも）", quiet=True)
                    # 主張
                    rep.check(balls_overlap(mat_cb(lhs, to), Vs * Xl * Vsi), f"{tag}: 主張 T_(V^(+))(X_l) = T_(V̌')(X_l)（Sage の exp・逆行列）", quiet=True)
                    rep.check(balls_overlap(mat_cb(lhs, to), rows[-1]), f"{tag}: 主張（本文の部分和のボール）", quiet=True)
                    # 対照
                    rep.check(not balls_overlap(mat_cb(lhs, to), Vsi * Xl * Vs), f"対照 {tag}: 逆向きの共役とは重ならない", quiet=True)
                print(f"  {tag0} μ={mu}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件）")


main()
rep.finish()

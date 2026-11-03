# 対象ラベル: T_V_plus_eq_T_check_Vprime
# 証明のうち V̌' を含む行と主張を、ℝ への脱出を含む量（exp の値）をボールで囲んで確かめる。
#  - 準備 1 の第 2 の鎖 T_{(V̌')}(X) = (V̌'X)(V̌')^{-1} = T'_{V̌'}(X)（両辺は同じ式なので独立な確認ではない。Sage の exp・逆行列とも比べる）。
#  - Step 1 の鎖の第 6〜第 12 等号（c Σ a_{jμ} T_{(V^{(+)})}(W_μ) から T_{(V̌')}(U_j) まで）。第 6 等号の左辺は厳密な値を移したもの。
#  - Step 2 の四つの鎖のうち V̌' の側の行と、x, y ∈ E を使う中央の行。
#  - 主張: すべての行列単位 e_{rs}（2^M × 2^M 個）と標本 x で、厳密な T_{(V^{(+)})}(x) を移した値が T_{(V̌')}(x) のボールと重なる。
# ボールの作り方は T_V_plus_eq_T_check_Vprime_on_check_Z_Y の check_vprime_ball.sage と同じ: γ(θ̃_λ) は実対数の arccosh、
#   X̌ は def_check_Vprime の Σ_λ (γ(θ̃_λ))_C(ψ̌_λ^† ψ̌_{M+1-λ} - (1/2)_C I)、V̌' = exp(X̌)・(V̌')^{-1} = exp(-X̌) は def_exp の部分和に尾の上界を足したボール。
# F の元は embedding_to_qqbar の埋め込み（ζ ↦ exp(2πi/(4M))）で ComplexBallField(512) へ移す。
# 範囲: 結合定数 3 組 × M_col = 2, 3, 4。
# 対照: 逆向きの共役 (V̌')^{-1} x V̌' とは、標本 x で重ならない。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
rep = Report("T_V_plus_eq_T_check_Vprime: V̌' を含む行と主張（ボール）")


def main():
    for (x, y) in COUPLINGS:
        for M in Ms:
            f = Factors(M, x, y)
            rc = Recovery(f)
            J = rc.J
            n = f.n
            tcbF = lambda e: CB(rc.emb(e))
            mF = lambda A: mat_cb(A, tcbF)
            Sp = {l: PsiSetting(f, l) for l in J}
            tcb = {l: to_cb_factory(Sp[l]) for l in J}
            Icb = body_identity(CB, n)
            dag = {l: mat_cb(Sp[l].psid, tcb[l]) for l in J}
            psi = {l: mat_cb(Sp[l].psi, tcb[l]) for l in J}
            gam = {}
            for l in J:
                g = RB(Sp[l].g1_AA)
                gam[l] = (g + (g**2 - 1).sqrt()).log()              # def_arccosh
            half = body_scalar(CB(1) / 2, Icb)
            Xc = body_finite_sum([body_scalar(CB(gam[l]), body_difference(body_product(dag[l], psi[M + 1 - l]), half)) for l in J])
            Vp = body_exp_ball(Xc)
            Vm = body_exp_ball(body_negation(Xc))
            tag0 = f"(x,y)=({x},{y}) M={M}"
            Vs = Xc.exp(); Vsi = Vs.inverse()
            rep.check(balls_overlap(Vp, Vs) and balls_overlap(Vm, (-Xc).exp()) and balls_overlap(Vm, Vp.inverse()),
                      f"{tag0}: V̌' と (V̌')^-1 = exp(-X̌) のボールが Sage の exp・逆行列と重なる", quiet=True)
            Tv = lambda W: body_product(body_product(Vp, W), Vm)         # T_{(V̌')}(W) := (V̌'W)(V̌')^{-1}（def_check_Vprime (2)）
            Tpv = lambda W: body_product(body_product(Vp, W), Vm)        # T'_{V̌'}（mat_conj の T_B、B → V̌'）
            # 準備 1 の第 2 の鎖
            samples = sample_elements(rc)
            for k, X in enumerate([rc.Zr[1], rc.Yc[1]] + samples):
                Xb = mF(X)
                rep.check(balls_overlap(Tv(Xb), Tpv(Xb)) and balls_overlap(Tv(Xb), Vs * Xb * Vsi), f"{tag0}: 準備 1 の第 2 の鎖（X #{k}）", quiet=True)
            c = tcbF(rc.c)
            for (nm, W, U) in rc.pairs():
                Wb = {mu: mF(W[mu]) for mu in J}
                for j in J:
                    tag = f"{tag0} {nm} j={j}"
                    a = {mu: tcbF(rc.a[(j, mu)]) for mu in J}
                    row6 = mF(body_scalar(rc.c, body_finite_sum([body_scalar(rc.a[(j, mu)], rc.T_composite(W[mu])) for mu in J])))
                    recb = body_scalar(c, body_finite_sum([body_scalar(a[mu], Wb[mu]) for mu in J]))
                    rows = [
                        row6,                                                                                   # 第 6 等号の右辺（厳密な値を移したもの）
                        body_scalar(c, body_finite_sum([body_scalar(a[mu], Tv(Wb[mu])) for mu in J])),         # 第 7 等号
                        body_scalar(c, body_finite_sum([body_scalar(a[mu], Tpv(Wb[mu])) for mu in J])),        # 第 8 等号
                        body_scalar(c, body_finite_sum([Tpv(body_scalar(a[mu], Wb[mu])) for mu in J])),        # 第 9 等号
                        body_scalar(c, Tpv(body_finite_sum([body_scalar(a[mu], Wb[mu]) for mu in J]))),        # 第 10 等号
                        Tpv(recb),                                                                              # 第 11 等号
                        Tv(recb),                                                                               # 第 12 等号
                        Tv(mF(U[j])),                                                                           # 第 13 等号
                    ]
                    for t in range(len(rows) - 1):
                        rep.check(balls_overlap(rows[t], rows[t + 1]), f"{tag}: Step 1 の第 {t + 7} 等号", quiet=True)
                    rep.check(balls_overlap(mF(rc.T_composite(U[j])), rows[-1]), f"{tag}: Step 1 の両端", quiet=True)
            # Step 2 の V̌' の側と中央の行
            al = f.i * 2 - f.F(1) / 3
            alb = tcbF(al)
            for a_ in range(len(samples)):
                xx, yy = samples[a_], samples[(a_ + 1) % len(samples)]
                xb, yb = mF(xx), mF(yy)
                T = rc.T_composite
                s_rows = [mF(body_sum(T(xx), T(yy))), body_sum(Tv(xb), Tv(yb)), body_sum(Tpv(xb), Tpv(yb)), Tpv(body_sum(xb, yb)), Tv(body_sum(xb, yb))]
                m_rows = [mF(body_scalar(al, T(xx))), body_scalar(alb, Tv(xb)), body_scalar(alb, Tpv(xb)), Tpv(body_scalar(alb, xb)), Tv(body_scalar(alb, xb))]
                p_rows = [mF(body_product(T(xx), T(yy))), body_product(Tv(xb), Tv(yb)), body_product(Tpv(xb), Tpv(yb)), Tpv(body_product(xb, yb)), Tv(body_product(xb, yb))]
                for name, rows, first in (("和", s_rows, 4), ("スカラー倍", m_rows, 4), ("積", p_rows, 4)):
                    for t in range(len(rows) - 1):
                        rep.check(balls_overlap(rows[t], rows[t + 1]), f"{tag0} 標本 {a_}: Step 2 の{name}の鎖の第 {t + first} 等号", quiet=True)
            u_rows = [Icb, Tpv(Icb), Tv(Icb)]
            rep.check(balls_overlap(u_rows[0], u_rows[1]) and balls_overlap(u_rows[1], u_rows[2]), f"{tag0}: Step 2 の単位元の鎖の第 3・第 4 等号", quiet=True)
            # 主張: 行列単位すべてと標本
            for r_ in range(n):
                for s_ in range(n):
                    e = matrix(f.F, n, n, lambda p, q: f.F(1) if (p, q) == (r_, s_) else f.F(0))
                    rep.check(balls_overlap(mF(rc.T_composite(e)), Tv(mF(e))), f"{tag0}: 主張 e_({r_},{s_})", quiet=True)
            for k, X in enumerate(samples):
                lhs = mF(rc.T_composite(X)); Xb = mF(X)
                rep.check(balls_overlap(lhs, Tv(Xb)) and balls_overlap(lhs, Vs * Xb * Vsi), f"{tag0}: 主張 標本 {k}", quiet=True)
                rep.check(not balls_overlap(lhs, Vsi * Xb * Vs), f"対照 {tag0}: 標本 {k} は逆向きの共役とは重ならない", quiet=True)
            print(f"  {tag0}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件）")


main()
rep.finish()

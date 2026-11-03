# 対象ラベル: T_V_plus_eq_T_check_Vprime
# 証明のうち V̌' を含まない行を、数体 F の中で厳密に確かめる。
#  - 準備 2 の復元公式 c Σ_μ a_{jμ} W_μ = U_j（(W, U) = (Ž, Z), (Y̌, Y)）。
#  - 準備 1 の第 1 の鎖 T_{(V^{(+)})}(X) = T_{V^{(+)}}(X) = (V^{(+)}X)(V^{(+)})^{-1} = T'_{V^{(+)}}(X)。
#  - Step 1 の鎖の第 1〜第 6 等号（T_{(V^{(+)})}(U_j) から c Σ_μ a_{jμ} T_{(V^{(+)})}(W_μ) まで）。
#  - Step 2 の四つの鎖のうち V^{(+)} の側の行（和・スカラー倍・積・単位元）。
# T_{(V^{(+)})} は def_T_V_plus の三つの共役の合成で、T_{V^{(+)}}・T'_{V^{(+)}} は V^{(+)} = (SV_2)S による共役で作る。
# 範囲: 結合定数 3 組 × M_col = 2, 3, 4 × j ∈ {1..M_col} × (W, U) 二組。
# 対照: 復元公式の係数を exp(-i(j_R θ̃_μ)_C) にすると崩れる。c を掛け忘れると崩れる。逆向きの共役は第 2 等号を崩す。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
rep = Report("T_V_plus_eq_T_check_Vprime: V̌' を含まない行（数体の中で厳密）")


def main():
    for (x, y) in COUPLINGS:
        for M in Ms:
            f = Factors(M, x, y)
            rc = Recovery(f)
            J = rc.J
            tag0 = f"(x,y)=({x},{y}) M={M}"
            T, Tg, Tp = rc.T_composite, rc.T_g_Vplus, rc.Tprime_Vplus
            Vs, Vsi = rc.V, rc.V.inverse()
            # 準備 1 の第 1 の鎖（X は生成元と標本）
            tests = [rc.Zr[j] for j in J] + [rc.Yr[j] for j in J] + [rc.Zc[mu] for mu in J] + [rc.Yc[mu] for mu in J] + sample_elements(rc)
            for k, X in enumerate(tests):
                rows = [T(X), Tg(X), conj_body(rc.V, X, rc.Vinv), Tp(X)]
                ok = all(rows[t] == rows[t + 1] for t in range(len(rows) - 1))
                rep.check(ok and rows[0] == Vs * X * Vsi, f"{tag0}: 準備 1 の第 1 の鎖（X #{k}、Sage の積と逆行列とも一致）", quiet=True)
            rep.check(any(T(X) != Vsi * X * Vs for X in tests), f"対照 {tag0}: 逆向きの共役 (V^(+))^-1 X V^(+) とは一致しない", quiet=True)
            for (nm, W, U) in rc.pairs():
                # 対照: 係数を exp(-i(j_R θ̃_μ)_C) にすると、少なくとも一つの j で崩れる
                #（2jθ̃_μ が π の奇数倍になる j では exp(±ijθ̃_μ) が一致するので、j ごとには要求しない）
                bad = [body_scalar(rc.c, body_finite_sum([body_scalar(f.phase(mu, -j), W[mu]) for mu in J])) != U[j] for j in J]
                rep.check(any(bad), f"対照 {tag0} {nm}: 係数 exp(-i j θ̃) では崩れる j がある", quiet=True)
                for j in J:
                    tag = f"{tag0} {nm} j={j}"
                    rec = rc.recovered(W, j)
                    # 準備 2 の復元公式（Sage の和と積でも）
                    rep.check(rec == U[j], f"{tag}: 復元公式 c Σ a W_μ = U_j", quiet=True)
                    rep.check(sum((rc.c * rc.a[(j, mu)]) * W[mu] for mu in J) == U[j], f"{tag}: 復元公式（Sage の和・スカラー倍）", quiet=True)
                    rep.check(body_finite_sum([body_scalar(rc.a[(j, mu)], W[mu]) for mu in J]) != U[j], f"対照 {tag}: c を掛け忘れると崩れる", quiet=True)
                    inner = body_finite_sum([body_scalar(rc.a[(j, mu)], W[mu]) for mu in J])
                    rows = [
                        T(U[j]),                                                                            # 左辺
                        T(rec),                                                                             # 第 1 等号の右辺
                        Tp(rec),                                                                            # 第 2 等号
                        body_scalar(rc.c, Tp(inner)),                                                       # 第 3 等号
                        body_scalar(rc.c, body_finite_sum([Tp(body_scalar(rc.a[(j, mu)], W[mu])) for mu in J])),  # 第 4 等号
                        body_scalar(rc.c, body_finite_sum([body_scalar(rc.a[(j, mu)], Tp(W[mu])) for mu in J])),  # 第 5 等号
                        body_scalar(rc.c, body_finite_sum([body_scalar(rc.a[(j, mu)], T(W[mu])) for mu in J])),   # 第 6 等号
                    ]
                    for t in range(len(rows) - 1):
                        rep.check(rows[t] == rows[t + 1], f"{tag}: Step 1 の第 {t + 1} 等号", quiet=True)
            # Step 2 の V^{(+)} の側
            xs = sample_elements(rc)
            al = f.i * 2 - F_one(f) / 3
            for a_ in range(len(xs)):
                xx = xs[a_]
                yy = xs[(a_ + 1) % len(xs)]
                s_rows = [T(body_sum(xx, yy)), Tp(body_sum(xx, yy)), body_sum(Tp(xx), Tp(yy)), body_sum(T(xx), T(yy))]
                m_rows = [T(body_scalar(al, xx)), Tp(body_scalar(al, xx)), body_scalar(al, Tp(xx)), body_scalar(al, T(xx))]
                p_rows = [T(body_product(xx, yy)), Tp(body_product(xx, yy)), body_product(Tp(xx), Tp(yy)), body_product(T(xx), T(yy))]
                for name, rows in (("和", s_rows), ("スカラー倍", m_rows), ("積", p_rows)):
                    for t in range(len(rows) - 1):
                        rep.check(rows[t] == rows[t + 1], f"{tag0} 標本 {a_}: Step 2 の{name}の鎖の第 {t + 1} 等号", quiet=True)
            u_rows = [T(rc.I), Tp(rc.I), rc.I]
            rep.check(u_rows[0] == u_rows[1] and u_rows[1] == u_rows[2], f"{tag0}: Step 2 の単位元の鎖の第 1・第 2 等号", quiet=True)
            print(f"  {tag0}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件）")


def F_one(f):
    return f.F(1)


main()
rep.finish()

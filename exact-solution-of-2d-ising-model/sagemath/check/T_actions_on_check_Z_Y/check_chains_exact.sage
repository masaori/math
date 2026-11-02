# 対象ラベル: T_actions_on_check_Z_Y
# 証明の四本の鎖の全ての行と主張を、K_1 = 2 log y・K_2 = log x と選んで数体 F の中で厳密に確かめる（_prelude.sage）。
# 各行の値は本文の積（mat_mult）・スカラー倍・和の成分の式で組み、隣り合う行が等しいことを見る。
# 級数の行 Σ (1/n!)_C ad^n_G(W) だけは有限の計算で値を作れないので、その行の両隣（(exp(G)W)exp(-G) と主張の右辺）を
# 直接比べ、級数の行そのものは check_series_lines_by_partial_sums.sage が部分和で確かめる。
# 独立の経路として、T_g(W) を Sage の inverse で作った g^{-1} で組んだ値（def_T_g の文言どおり）が主張の右辺に等しいことも見る。
import sys
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
samples = [(2, 2), (3, QQ(3) / 2)]

for M in Ms:
    for (x, y) in samples:
        f = Factors(M, x, y)
        F, n = f.F, f.n
        Id = body_identity(F, n)
        tag = f"M={M} x={x} y={y}"
        # S と V_2 の逆元（比べる側: Sage の inverse）
        S = f.expX
        S_inv = S.inverse()
        V2_inv = f.V2.inverse()
        report(body_product(S, f.expmX) == Id == body_product(f.expmX, S), f"{tag}: exp(X)exp(-X) = exp(-X)exp(X) = I")
        report(S_inv == f.expmX, f"{tag}: matrix_exp_conjugation (3) の exp(X)^{{-1}} = exp(-X)（Sage の inverse と一致）")
        report(V2_inv == body_scalar(f.ainv, f.expmY), f"{tag}: V2_invertible の V_2^{{-1}} = (a^{{-1}})_C exp(-Y)（Sage の inverse と一致）")
        report(f.V2 == body_scalar(f.a, f.expY), f"{tag}: V2_exponential_representation の V_2 = a_C exp(Y)（成分の定義の V_2 と一致）")
        # 対照: 前因子を落とした exp(-Y) は V_2 の逆元ではない
        report(body_product(f.V2, f.expmY) != Id, f"{tag}: 対照 exp(-Y) だけでは V_2 の逆元にならない")
        for mu in range(1, M + 1):
            Zc, Yc = f.Zc[mu], f.Yc[mu]
            em, ep = f.phase(mu, -1), f.phase(mu, 1)
            i = f.i
            c1z, c1y = (i * em) * f.sh1, ((-i) * ep) * f.sh1
            c2z, c2y = (-i) * f.sh2, i * f.sh2
            cases = [
                ("T_S(Ž)", "S", Zc, body_sum(body_scalar(f.ch1, Zc), body_scalar(c1z, Yc)), pair_times_column(Zc, Yc, f.ch1, c1z),
                 body_sum(body_scalar(f.ch1, Zc), body_scalar(-c1z, Yc))),
                ("T_S(Y̌)", "S", Yc, body_sum(body_scalar(c1y, Zc), body_scalar(f.ch1, Yc)), pair_times_column(Zc, Yc, c1y, f.ch1),
                 body_sum(body_scalar(-c1y, Zc), body_scalar(f.ch1, Yc))),
                ("T_V2(Ž)", "V", Zc, body_sum(body_scalar(f.ch2, Zc), body_scalar(c2z, Yc)), pair_times_column(Zc, Yc, f.ch2, c2z),
                 body_sum(body_scalar(f.ch2, Zc), body_scalar(-c2z, Yc))),
                ("T_V2(Y̌)", "V", Yc, body_sum(body_scalar(c2y, Zc), body_scalar(f.ch2, Yc)), pair_times_column(Zc, Yc, c2y, f.ch2),
                 body_sum(body_scalar(-c2y, Zc), body_scalar(f.ch2, Yc))),
            ]
            for (name, kind, W, rhs, rhs_col, wrong) in cases:
                lab = f"{tag} mu={mu} {name}"
                if kind == "S":
                    lines = [
                        ("(SW)S^{-1}", body_product(body_product(S, W), S_inv)),
                        ("(exp((i/2)K_1H)W)(exp((i/2)K_1H))^{-1}", body_product(body_product(S, W), S_inv)),
                        ("(exp(X)W)(exp(X))^{-1}", body_product(body_product(f.expX, W), f.expX.inverse())),
                        ("(exp(X)W)exp(-X)", body_product(body_product(f.expX, W), f.expmX)),
                        ("(exp(G_1)W)exp(-G_1)", body_product(body_product(f.expX, W), f.expmX)),
                    ]
                else:
                    E, Em = f.expY, f.expmY
                    aC, aiC = f.a, f.ainv
                    VW = body_product(f.V2, W)
                    EW = body_product(E, W)
                    core = body_product(EW, Em)
                    lines = [
                        ("(V_2W)V_2^{-1}", body_product(VW, V2_inv)),
                        ("(V_2W)((a^{-1})_C exp(-Y))", body_product(VW, body_scalar(aiC, Em))),
                        ("(((2s_2)^{M/2}exp(iK_2^*H_2))W)(...)", body_product(body_product(body_scalar(aC, E), W), body_scalar(aiC, Em))),
                        ("((a_C exp(iK_2^*H_2))W)(...)", body_product(body_product(body_scalar(aC, E), W), body_scalar(aiC, Em))),
                        ("((a_C exp(Y))W)(...)", body_product(body_product(body_scalar(aC, E), W), body_scalar(aiC, Em))),
                        ("(a_C(exp(Y)W))(...)", body_product(body_scalar(aC, EW), body_scalar(aiC, Em))),
                        ("a_C((exp(Y)W)(...))", body_scalar(aC, body_product(EW, body_scalar(aiC, Em)))),
                        ("a_C((a^{-1})_C((exp(Y)W)exp(-Y)))", body_scalar(aC, body_scalar(aiC, core))),
                        ("(a_C(a^{-1})_C)(...)", body_scalar(aC * aiC, core)),
                        ("(aa^{-1})_C(...)", body_scalar(aC * aiC, core)),
                        ("(1)_C(...)", body_scalar(F(1), core)),
                        ("1_C(...)", body_scalar(F(1), core)),
                        ("(exp(Y)W)exp(-Y)", core),
                        ("(exp(G_2)W)exp(-G_2)", core),
                    ]
                lines.append(("右辺（extract_taylor の値）", rhs))
                lines.append(("(Ž, Y̌)(列)", rhs_col))
                for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
                    report(v0 == v1, f"{lab}: 「{n0}」=「{n1}」")
                # 独立の経路: def_T_g の g W g^{-1} を Sage の積と inverse で
                g = S if kind == "S" else f.V2
                report((g * W) * g.inverse() == rhs, f"{lab}: Sage の積と inverse で作った gWg^{{-1}} が主張の右辺に等しい")
                report(lines[0][1] != wrong, f"{lab}: 対照 sinh の側の係数の符号を逆にした式とは一致しない")
        print(f"{tag}: done")
print("RESULT: PASS")

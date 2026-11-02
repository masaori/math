# 対象ラベル: calc_of_TxT_check_Z_Y
# 証明の二本の鎖の全ての行と主張を、K_1 = 2 log y・K_2 = log x と選んで数体 F の中で厳密に確かめる（_prelude.sage）。
# 鎖の始点 (T_g(Ž_μ), T_g(Y̌_μ)) は、T_actions_on_check_Z_Y の主張を使わずに、def_T_g の (gW)g^{-1} を
# 本文の積の成分の式と Sage の inverse で作る。第 2 行は T_actions_on_check_Z_Y の四式の右の等号の値（行列の組と数の列の積）で、
# 第 3 行は証明に書かれた 2×2 行列と def_pair_of_matrices_times_two_by_two_matrix で、第 4 行は def_B1_theta_B2 の成分の式で作る。
import sys
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
samples = [(2, 2), (3, QQ(3) / 2)]

for M in Ms:
    for (x, y) in samples:
        f = Factors(M, x, y)
        F, i = f.F, f.i
        tag = f"M={M} x={x} y={y}"
        S, S_inv = f.expX, f.expX.inverse()
        V2, V2_inv = f.V2, f.V2.inverse()
        B2 = B2_by_definition(f)
        for mu in range(1, M + 1):
            Zc, Yc = f.Zc[mu], f.Yc[mu]
            ep, em = f.phase(mu, 1), f.phase(mu, -1)
            lab = f"{tag} mu={mu}"
            # (V_1) の鎖
            start = (body_product(body_product(S, Zc), S_inv), body_product(body_product(S, Yc), S_inv))
            c1z, c1y = (i * em) * f.sh1, ((-i) * ep) * f.sh1
            line2 = (pair_times_column(Zc, Yc, f.ch1, c1z), pair_times_column(Zc, Yc, c1y, f.ch1))
            P1 = matrix(F, 2, 2, [f.ch1, ((-i) * ep) * f.sh1, (i * em) * f.sh1, f.ch1])  # 証明の第 3 行の 2×2 行列
            line3 = pair_times_two_by_two(Zc, Yc, P1)
            B1 = B1_by_definition(f, ep, em)
            line4 = pair_times_two_by_two(Zc, Yc, B1)
            report(start == line2, f"{lab} (V_1): 第 1 行 (T_S(Ž), T_S(Y̌)) = 第 2 行（T_actions_on_check_Z_Y の第 1・2 式）")
            report(line2 == line3, f"{lab} (V_1): 第 2 行 = 第 3 行（def_pair_of_matrices_times_two_by_two_matrix）")
            report(P1 == B1, f"{lab} (V_1): 第 3 行の 2×2 行列 = def_B1_theta_B2 の B_1(θ̃_μ)")
            report(line3 == line4, f"{lab} (V_1): 第 3 行 = 第 4 行 (Ž, Y̌)B_1(θ̃)")
            # 主張: Sage の積と inverse で作った gWg^{-1} と、Sage のスカラー倍と和で作った (pA + rB, qA + sB)
            sage_lhs = ((S * Zc) * S.inverse(), (S * Yc) * S.inverse())
            sage_rhs = (B1[0, 0] * Zc + B1[1, 0] * Yc, B1[0, 1] * Zc + B1[1, 1] * Yc)
            report(sage_lhs == sage_rhs == line4, f"{lab} (V_1): 主張（Sage の積・inverse・aA + bB で組んだ両辺）")
            # 対照: 転置した B_1、θ̃ の符号を逆にした B_1 では一致しない
            # 対照: 非対角成分の符号を逆にした B_1（sinh の側の係数の符号の誤り）では一致しない。
            # B_1(θ̃) が対称でないとき（exp(iθ̃) ≠ ±i）は転置でも、exp(iθ̃) ≠ exp(-iθ̃) のときは B_1(-θ̃) でも一致しない。
            B1_wrong = matrix(F, 2, 2, [B1[0, 0], -B1[0, 1], -B1[1, 0], B1[1, 1]])
            report(pair_times_two_by_two(Zc, Yc, B1_wrong) != start, f"{lab} (V_1): 対照 非対角成分の符号を逆にした B_1 では一致しない")
            if B1 != B1.transpose():
                report(pair_times_two_by_two(Zc, Yc, B1.transpose()) != start, f"{lab} (V_1): 対照 B_1 の転置では一致しない")
            else:
                print(f"SKIP: {lab} (V_1): B_1(θ̃) が対称（exp(iθ̃) = ±i）なので転置の対照は意味を持たない")
            if ep != em:
                report(pair_times_two_by_two(Zc, Yc, B1_by_definition(f, em, ep)) != start, f"{lab} (V_1): 対照 B_1(-θ̃) では一致しない")
            else:
                print(f"SKIP: {lab} (V_1): exp(iθ̃) = exp(-iθ̃) なので B_1(-θ̃) の対照は意味を持たない")
            # (V_2) の鎖
            start = (body_product(body_product(V2, Zc), V2_inv), body_product(body_product(V2, Yc), V2_inv))
            c2z, c2y = (-i) * f.sh2, i * f.sh2
            line2 = (pair_times_column(Zc, Yc, f.ch2, c2z), pair_times_column(Zc, Yc, c2y, f.ch2))
            P2 = matrix(F, 2, 2, [f.ch2, i * f.sh2, (-i) * f.sh2, f.ch2])
            line3 = pair_times_two_by_two(Zc, Yc, P2)
            line4 = pair_times_two_by_two(Zc, Yc, B2)
            report(start == line2, f"{lab} (V_2): 第 1 行 (T_V2(Ž), T_V2(Y̌)) = 第 2 行（T_actions_on_check_Z_Y の第 3・4 式）")
            report(line2 == line3, f"{lab} (V_2): 第 2 行 = 第 3 行（def_pair_of_matrices_times_two_by_two_matrix）")
            report(P2 == B2, f"{lab} (V_2): 第 3 行の 2×2 行列 = def_B1_theta_B2 の B_2")
            report(line3 == line4, f"{lab} (V_2): 第 3 行 = 第 4 行 (Ž, Y̌)B_2")
            sage_lhs = ((V2 * Zc) * V2.inverse(), (V2 * Yc) * V2.inverse())
            sage_rhs = (B2[0, 0] * Zc + B2[1, 0] * Yc, B2[0, 1] * Zc + B2[1, 1] * Yc)
            report(sage_lhs == sage_rhs == line4, f"{lab} (V_2): 主張（Sage の積・inverse・aA + bB で組んだ両辺）")
            report(pair_times_two_by_two(Zc, Yc, B2.transpose()) != start, f"{lab} (V_2): 対照 B_2 の転置では一致しない")
        print(f"{tag}: done")
print("RESULT: PASS")

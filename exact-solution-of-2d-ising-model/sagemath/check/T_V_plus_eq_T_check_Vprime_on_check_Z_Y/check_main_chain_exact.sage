# 対象ラベル: T_V_plus_eq_T_check_Vprime_on_check_Z_Y
# 本物の Ž_μ・Y̌_μ・P̌_μ・ψ̌_μ で、準備 1・準備 2 の鎖と、本体の鎖のうち T_{(V̌')} を含まない第 1〜第 5 等号を数体の中で厳密に確かめる。
# 各行を別々に組む: T_{(V^{(+)})} は def_T_V_plus の三つの共役の合成、T_{V^{(+)}} は def_V_plus の V^{(+)} = (SV_2)S による
#   def_T_g の (V^{(+)}X)(V^{(+)})^{-1}（逆元は def_invertible_elements_of_R (ii) の (S^{-1}V_2^{-1})S^{-1}）、
#   組と 2×2 行列の積は def_pair_of_matrices_times_two_by_two_matrix・def_pair_of_matrices_times_column_of_numbers、
#   ψ̌_μ^†・ψ̌_μ は def_check_fermi の第二の式（P̌_μ との積を使わない形。第一の式との一致もここで確かめる）、
#   P̌_μ は diagonalization_check_P_D の式、λ_{±,μ} = γ_1 ± r_μ は eigenvector_of_A_theta_tilde の式、P̌_μ^{-1} は Sage の inverse
#   （P̌P̌^{-1} = P̌^{-1}P̌ = I を本文の積で確かめる）。行列の積・和・スカラー倍は本文の成分の式。
# 本体の第 5 等号の右辺 (exp(±γ(θ̃_μ)))_C は、commutation_V_plus_check_psi の証明の最終行（lambda_eq_exp_gamma_theta_tilde）と同じく
#   λ_{±,μ} と置いて厳密に比べ、λ_{±,μ} = exp(±γ(θ̃_μ)) は def_arccosh の arccosh(g) = log(g + √(g^2-1)) から
#   exp(±γ) = g ± √(g^2-1) を AA で比べる（ℝ への脱出: 実数の exp）。第 6 等号から先は check_vprime_ball.sage。
# 範囲: 結合定数 3 組 × M_col = 2, 3, 4 × 全 μ × l = 1, 2。数体 E の中で厳密（浮動小数点なし）。
# 独立な経路: 主張の左辺 T_{(V^{(+)})}(X_l) を Sage の `*`・inverse で作った V^{(+)}X_l(V^{(+)})^{-1} と比べる。
# 対照: 第 5 等号で λ_+ と λ_- を入れ替えた値とは異なる。T_{V^{(+)}} の代わりに逆向きの共役 (V^{(+)})^{-1}X V^{(+)} を使うと第 2 等号が崩れる。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
rep = Report("T_V_plus_eq_T_check_Vprime_on_check_Z_Y: 準備 1・準備 2・本体の第 1〜第 5 等号（厳密）")

def main():
    # 大域の I（虚数単位）を共有の準備が使うので、ここの名前は関数の中に閉じる。
    for (x, y) in COUPLINGS:
        for M in Ms:
            f = Factors(M, x, y)
            for mu in range(1, M + 1):
                s = PsiSetting(f, mu)
                E, n = s.E, s.n
                tag = f"(x,y)=({x},{y}) M={M} μ={mu}"
                Pm = s.P
                Q = Pm.inverse()
                I2 = body_identity(E, 2)
                rep.check(body_product(Pm, Q) == I2 and body_product(Q, Pm) == I2, f"{tag}: P̌P̌^-1 = P̌^-1P̌ = I", quiet=True)
                Xs = [s.Z, s.Y]
                pairP = pair_times_two_by_two((s.Z, s.Y), Pm)
                rep.check(pair_eq(pairP, (s.psid, s.psi)), f"{tag}: def_check_fermi の二つの式が一致", quiet=True)
                Psi = [s.psid, s.psi]
                O = matrix(E, n, n, 0)
                # 準備 1
                for k in (1, 2):
                    c = k - 1
                    rows = [
                        Psi[c],
                        pr(k, (Psi[0], Psi[1])),
                        pr(k, pairP),
                        pr(k, (pair_times_column(s.Z, s.Y, Pm[0, 0], Pm[1, 0]), pair_times_column(s.Z, s.Y, Pm[0, 1], Pm[1, 1]))),
                        pair_times_column(s.Z, s.Y, Pm[0, c], Pm[1, c]),
                        body_sum(body_scalar(Pm[0, c], s.Z), body_scalar(Pm[1, c], s.Y)),
                        body_sum(body_finite_sum([body_scalar(Pm[0, c], s.Z)]), body_scalar(Pm[1, c], s.Y)),
                        body_finite_sum([body_scalar(Pm[i, c], Xs[i]) for i in range(2)]),
                    ]
                    for t in range(len(rows) - 1):
                        rep.check(rows[t] == rows[t + 1], f"{tag}: 準備 1（k = {k}）第 {t+1} 等号", quiet=True)
                # 準備 2
                PQ = body_product(Pm, Q)
                prep2 = {}
                for l in (1, 2):
                    L = l - 1
                    i_other = 1 - L
                    drows = [body_scalar(body_delta(E, i_other, L), Xs[i_other]), body_scalar(E(0), Xs[i_other]), O]
                    for t in range(2):
                        rep.check(drows[t] == drows[t + 1], f"{tag}: 準備 2 の δ の鎖（l = {l}）第 {t+1} 等号", quiet=True)
                    rows = [
                        Xs[L],
                        body_scalar(E(1), Xs[L]),
                        body_scalar(body_delta(E, L, L), Xs[L]),
                        body_finite_sum([body_scalar(body_delta(E, i, L), Xs[i]) for i in range(2)]),
                        body_finite_sum([body_scalar(I2[i, L], Xs[i]) for i in range(2)]),
                        body_finite_sum([body_scalar(PQ[i, L], Xs[i]) for i in range(2)]),
                        body_finite_sum([body_scalar(Pm[i, 0] * Q[0, L] + Pm[i, 1] * Q[1, L], Xs[i]) for i in range(2)]),
                        body_finite_sum([body_scalar(Q[0, L] * Pm[i, 0] + Q[1, L] * Pm[i, 1], Xs[i]) for i in range(2)]),
                        body_finite_sum([body_finite_sum([body_scalar(Q[k, L] * Pm[i, k], Xs[i]) for k in range(2)]) for i in range(2)]),
                        body_finite_sum([body_finite_sum([body_scalar(Q[k, L], body_scalar(Pm[i, k], Xs[i])) for k in range(2)]) for i in range(2)]),
                        body_finite_sum([body_finite_sum([body_scalar(Q[k, L], body_scalar(Pm[i, k], Xs[i])) for i in range(2)]) for k in range(2)]),
                        body_finite_sum([body_scalar(Q[k, L], body_finite_sum([body_scalar(Pm[i, k], Xs[i]) for i in range(2)])) for k in range(2)]),
                        body_finite_sum([body_scalar(Q[k, L], Psi[k]) for k in range(2)]),
                        body_sum(body_finite_sum([body_scalar(Q[0, L], Psi[0])]), body_scalar(Q[1, L], Psi[1])),
                        body_sum(body_scalar(Q[0, L], Psi[0]), body_scalar(Q[1, L], Psi[1])),
                    ]
                    for t in range(len(rows) - 1):
                        rep.check(rows[t] == rows[t + 1], f"{tag}: 準備 2（l = {l}）第 {t+1} 等号", quiet=True)
                    prep2[l] = rows[-1]
                # 本体の第 1〜第 5 等号
                V, Vinv = s.Vplus()
                I = body_identity(E, n)
                rep.check(body_product(V, Vinv) == I and body_product(Vinv, V) == I, f"{tag}: V^(+)(V^(+))^-1 = (V^(+))^-1V^(+) = I", quiet=True)
                Tc = s.T_composite                                   # T_{(V^{(+)})}（def_T_V_plus）
                Tg = lambda W: conj_body(V, W, Vinv)                 # T_{V^{(+)}}（def_T_g）
                for l in (1, 2):
                    L = l - 1
                    q1, q2 = Q[0, L], Q[1, L]
                    rows = [
                        Tc(Xs[L]),
                        Tc(prep2[l]),
                        Tg(prep2[l]),
                        body_sum(body_scalar(q1, Tg(Psi[0])), body_scalar(q2, Tg(Psi[1]))),
                        body_sum(body_scalar(q1, Tc(Psi[0])), body_scalar(q2, Tc(Psi[1]))),
                        body_sum(body_scalar(q1, body_scalar(s.lp, Psi[0])), body_scalar(q2, body_scalar(s.lm, Psi[1]))),
                    ]
                    for t in range(len(rows) - 1):
                        rep.check(rows[t] == rows[t + 1], f"{tag}: 本体（l = {l}）第 {t+1} 等号", quiet=True)
                    rep.check(rows[0] == V * Xs[L] * V.inverse(), f"{tag}: 本体（l = {l}）の左辺 = Sage の V^(+)X_l(V^(+))^-1", quiet=True)
                    swapped = body_sum(body_scalar(q1, body_scalar(s.lm, Psi[0])), body_scalar(q2, body_scalar(s.lp, Psi[1])))
                    rep.check(rows[4] != swapped, f"対照 {tag}: 本体（l = {l}）第 5 等号で λ_± を入れ替えると崩れる", quiet=True)
                    rep.check(rows[2] != conj_body(Vinv, prep2[l], V), f"対照 {tag}: 本体（l = {l}）逆向きの共役では第 2 等号が崩れる", quiet=True)
                # λ_{±,μ} = exp(±γ(θ̃_μ))（r_μ > 0 の値で）
                g = s.g1_AA
                w = (g**2 - 1).sqrt()
                rep.check(g + s.r_AA == g + w and g - s.r_AA == g - w, f"{tag}: λ_± = γ_1 ± √(γ_1^2-1) = exp(±arccosh γ_1)（AA）", quiet=True)
                print(f"  {tag}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件）")


main()
rep.finish()

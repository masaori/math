# =========================================================================
# check_04: 016 章（structured-latex/content/016_even_sector_fermions.ts）の
#           **各段の等式そのもの**を、ラベル単位で検証する。
#
#  対象ラベル:
#    def_check_fermi
#    periodicity_of_check_fermi
#    anticommutator_of_check_psi
#    commutation_V_plus_check_psi
#    def_check_Vprime
#    action_of_T_check_Vprime_on_check_psi
#    T_V_plus_eq_T_check_Vprime_on_check_Z_Y
#    T_V_plus_eq_T_check_Vprime
#    V_plus_eq_c_check_Vprime
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_04: 016 章の各段の等式 ===")

S = Steps()
worst_scalar = None    # V_plus_eq_c_check_Vprime: W がスカラー行列からどれだけ離れるか

for M in STEP_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)

    for p in STEP_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        K1, K2 = P['K1'], P['K2']
        Vp, Vpi = V_plus(O, K1, K2)
        Vpr, Vpri, Xch = Vprime_check(O, P)

        # def_check_index_set: 主張の範囲は 𝓜̌ = {1,...,M} に絞る
        idx = list(range(1, M + 1))
        pairs = {mu: psi_pair(O, mu, P) for mu in set(idx + [M + 1 - m for m in idx] + [1 - m for m in idx])}

        for mu in idx:
            t = th_tilde(M, mu)
            a = g2(t, P); b = g2(-t, P); r = RDF(abs(a))
            pdag, psi = pairs[mu]
            Zc, Yc = checkZ(O, mu), checkY(O, mu)
            Pm = Pcheck(M, mu, P)
            cmu = CDF(1) / (2 * RDF(sqrt(RDF(M))) * b)

            # -------------------------------------------------------------
            # def_check_fermi
            # -------------------------------------------------------------
            S.add("def_check_fermi (psi^dagger) = P^ の第 1 列",
                  pdag, Pm[0, 0] * Zc + Pm[1, 0] * Yc)
            S.add("def_check_fermi (psi) = P^ の第 2 列",
                  psi, Pm[0, 1] * Zc + Pm[1, 1] * Yc)
            S.add("def_check_fermi 略記形 psi^dagger = c(-r checkZ + b checkY)",
                  pdag, cmu * (-r * Zc + b * Yc))
            S.add("def_check_fermi 略記形 psi = c(+r checkZ + b checkY)",
                  psi, cmu * (r * Zc + b * Yc))

            # -------------------------------------------------------------
            # periodicity_of_check_fermi (1)(2)(3)
            # -------------------------------------------------------------
            for k in (-1, 1, 2):
                # (1) theta in R についての 2pi 周期性（mu に依らない主張）
                S.add("periodicity (1) gamma_1(theta + 2k pi) = gamma_1(theta)",
                      g1(t + CDF(2 * k * pi), P), g1(t, P))
                S.add("periodicity (1) gamma_2(theta + 2k pi) = gamma_2(theta)",
                      g2(t + CDF(2 * k * pi), P), a)
                # (2) 添字の M 周期性（mu in Z。gamma / psi には言及しない）
                S.add("periodicity (2) theta~_{mu+kM} = theta~_mu + 2k pi",
                      th_tilde(M, mu + k * M), t + CDF(2 * k * pi))
                S.add("periodicity (2) gamma_1(theta~_{mu+kM}) = gamma_1(theta~_mu)",
                      g1(th_tilde(M, mu + k * M), P), g1(t, P))
                S.add("periodicity (2) gamma_2(+theta~_{mu+kM}) = gamma_2(+theta~_mu)",
                      g2(th_tilde(M, mu + k * M), P), a)
                S.add("periodicity (2) gamma_2(-theta~_{mu+kM}) = gamma_2(-theta~_mu)",
                      g2(-th_tilde(M, mu + k * M), P), b)
            # (3) 共役添字 M+1-mu（𝓜̌ の内側）
            S.add("periodicity (3) gamma_2(theta~_{M+1-mu}) = gamma_2(-theta~_mu)",
                  g2(th_tilde(M, M + 1 - mu), P), b)
            S.add("periodicity (3) gamma_2(-theta~_{M+1-mu}) = gamma_2(theta~_mu)",
                  g2(-th_tilde(M, M + 1 - mu), P), a)
            S.add("periodicity (3) gamma_1(theta~_{M+1-mu}) = gamma_1(theta~_mu)",
                  g1(th_tilde(M, M + 1 - mu), P), g1(t, P))
            S.add("periodicity (3) gamma(theta~_{M+1-mu}) = gamma(theta~_mu)",
                  gamma_tilde(M, M + 1 - mu, P), gamma_tilde(M, mu, P))
            # 書き換えの正当性: psi_{M+1-mu} = psi_{1-mu}（周期性による）
            _, ps_new = pairs[M + 1 - mu]
            _, ps_old = pairs[1 - mu]
            S.add("conjugate 書き換え psi_{M+1-mu} = psi_{1-mu}", ps_new, ps_old)

            # -------------------------------------------------------------
            # anticommutator_of_check_psi の Step 1 / Step 2 / Step 4 の各段
            # -------------------------------------------------------------
            for nu in idx:
                tn = th_tilde(M, nu)
                an = g2(tn, P); bn = g2(-tn, P); rn = RDF(abs(an))
                cnu = CDF(1) / (2 * RDF(sqrt(RDF(M))) * bn)
                pdn, psn = pairs[nu]
                Zn, Yn = checkZ(O, nu), checkY(O, nu)
                # def_check_index_set (5): mu, nu in 𝓜̌ では合同式が消える
                d = 1 if nu == M + 1 - mu else 0
                S.add("def_check_index_set (5) delta^M_{(mu+nu,1)} = delta_{nu,M+1-mu}",
                      CDF(delta_M(M, mu + nu, 1)), CDF(d))

                if d == 1:
                    # Step 1 の各段（nu = M+1-mu）
                    S.add("anticommutator Step1 a_nu = gamma_2(theta~_{M+1-mu}) = b_mu", an, b)
                    S.add("anticommutator Step1 b_nu = gamma_2(-theta~_{M+1-mu}) = a_mu", bn, a)
                    S.add("anticommutator Step1 r_nu = |b_mu| = |-conj(a_mu)|",
                          RDF(rn), RDF(abs(-CDF(a).conjugate())))
                    S.add("anticommutator Step1 r_nu = |a_mu| = r_mu", RDF(rn), RDF(r))
                    S.add("anticommutator Step1 b_mu b_nu = a_mu b_mu = -r^2",
                          b * bn, CDF(-r ** 2))
                    S.add("anticommutator Step1 c_mu c_nu = 1/(4M b_mu b_nu)",
                          cmu * cnu, CDF(1) / (4 * M * (b * bn)))
                    S.add("anticommutator Step1 c_mu c_nu = -1/(4Mr^2)",
                          cmu * cnu, CDF(-1) / (4 * M * r ** 2))

                # Step 2 の各段（4 項展開 -> 中間 2 項が消える -> まとまる）
                four = cmu * cnu * (
                    (-r) * (-rn) * (Zc * Zn + Zn * Zc)
                    + (-r) * bn * (Zc * Yn + Yn * Zc)
                    + b * (-rn) * (Yc * Zn + Zn * Yc)
                    + b * bn * (Yc * Yn + Yn * Yc))
                S.add("anticommutator Step2 (1) 双線型性で 4 項へ展開",
                      pdag * pdn + pdn * pdag, four)
                S.add("anticommutator Step2 (2) 中間 2 項は [checkZ,checkY]_+ = 0 で消える",
                      Zc * Yn + Yn * Zc, matrix(CDF, O.d, O.d, 0))
                S.add("anticommutator Step2 (3) = c_mu c_nu (r_mu r_nu + b_mu b_nu) 2M delta I",
                      four, cmu * cnu * (r * rn + b * bn) * 2 * M * d * Id)
                S.add("anticommutator Step2 (4) 第 1 式 = 0",
                      pdag * pdn + pdn * pdag, matrix(CDF, O.d, O.d, 0))
                S.add("anticommutator Step3 第 3 式 = 0",
                      psi * psn + psn * psi, matrix(CDF, O.d, O.d, 0))
                S.add("anticommutator Step4 (1) 第 2 式の 4 項展開",
                      pdag * psn + psn * pdag,
                      cmu * cnu * (-r * rn + b * bn) * 2 * M * d * Id)
                S.add("anticommutator Step4 (2) 第 2 式 = delta_{nu,M+1-mu} I",
                      pdag * psn + psn * pdag, d * Id)

            # -------------------------------------------------------------
            # commutation_V_plus_check_psi
            # -------------------------------------------------------------
            gam = gamma_tilde(M, mu, P)
            S.add("commutation_V_plus (行ベクトル×行列の結合律) ((A,B)G)H = (A,B)(GH)",
                  (Pm[0, 0] * Zc + Pm[1, 0] * Yc), pdag)
            S.add("commutation_V_plus T_{(V^{(+)})}(psi^dagger) = e^{+gamma} psi^dagger",
                  Vp * pdag * Vpi, CDF(exp(gam)) * pdag)
            S.add("commutation_V_plus T_{(V^{(+)})}(psi) = e^{-gamma} psi",
                  Vp * psi * Vpi, CDF(exp(-gam)) * psi)

            # -------------------------------------------------------------
            # action_of_T_check_Vprime_on_check_psi の各段
            # -------------------------------------------------------------
            for nu in range(1, M + 1):
                pdn, _ = pairs[nu]
                _, ps1n = pairs[M + 1 - nu]
                # 合同式なしのデルタ（def_check_index_set (5)）
                d0 = 1 if mu == nu else 0
                d1 = 1 if mu == M + 1 - nu else 0
                S.add("action_of_T Step1 delta_{M+1-nu,M+1-mu} = delta_{mu,nu}",
                      CDF(delta_M(M, mu - nu, 0)), CDF(d0))
                S.add("action_of_T Step1' delta_{mu,M+1-nu} = delta^M_{(mu+nu,1)}",
                      CDF(delta_M(M, mu + nu, 1)), CDF(d1))
                S.add("action_of_T_check_Vprime Step1 [psi^d_nu psi_{M+1-nu}, psi^d_mu] = delta_{mu,nu} psi^d_nu",
                      comm(pdn * ps1n, pdag), d0 * pdn)
                S.add("action_of_T_check_Vprime Step1' [psi^d_nu psi_{M+1-nu}, psi_mu] = -delta psi_{M+1-nu}",
                      comm(pdn * ps1n, psi), -d1 * ps1n)
            S.add("action_of_T_check_Vprime Step2 [X^, psi^dagger_mu] = gamma psi^dagger_mu",
                  comm(Xch, pdag), RDF(gam) * pdag)
            S.add("action_of_T_check_Vprime Step2 X^ psi^d = psi^d (X^ + gamma I)",
                  Xch * pdag, pdag * (Xch + RDF(gam) * Id))
            S.add("action_of_T_check_Vprime Step2' [X^, psi_mu] = -gamma psi_mu",
                  comm(Xch, psi), -RDF(gam) * psi)
            for n in (0, 1, 2, 3):
                S.add("action_of_T_check_Vprime Step3 X^n psi^d = psi^d (X^+gamma I)^n",
                      (Xch ** n) * pdag, pdag * ((Xch + RDF(gam) * Id) ** n))
            S.add("action_of_T_check_Vprime Step4 exp(X^) psi^d = psi^d exp(X^+gamma I)",
                  Vpr * pdag, pdag * matrix(CDF, (Xch + RDF(gam) * Id).exp()))
            S.add("action_of_T_check_Vprime Step5 T_{(V^')}(psi^d) = e^{+gamma} psi^d",
                  Vpr * pdag * Vpri, CDF(exp(gam)) * pdag)
            S.add("action_of_T_check_Vprime Steps5' T_{(V^')}(psi) = e^{-gamma} psi",
                  Vpr * psi * Vpri, CDF(exp(-gam)) * psi)

            # -------------------------------------------------------------
            # T_V_plus_eq_T_check_Vprime_on_check_Z_Y の各段
            # -------------------------------------------------------------
            Q = Pm.inverse()
            S.add("T_eq_on_check_Z_Y Step1 (checkZ,checkY) = (psi^d,psi) P^{-1} の第 1 列",
                  Zc, Q[0, 0] * pdag + Q[1, 0] * psi)
            S.add("T_eq_on_check_Z_Y Step1 第 2 列",
                  Yc, Q[0, 1] * pdag + Q[1, 1] * psi)
            S.add("T_eq_on_check_Z_Y Step2 psi^d 上で一致",
                  Vp * pdag * Vpi, Vpr * pdag * Vpri)
            S.add("T_eq_on_check_Z_Y Step2 psi 上で一致",
                  Vp * psi * Vpi, Vpr * psi * Vpri)
            S.add("T_eq_on_check_Z_Y Step3 checkZ 上で一致",
                  Vp * Zc * Vpi, Vpr * Zc * Vpri)
            S.add("T_eq_on_check_Z_Y Step3 checkY 上で一致",
                  Vp * Yc * Vpi, Vpr * Yc * Vpri)

        # -----------------------------------------------------------------
        # T_V_plus_eq_T_check_Vprime の各段（Z_m, Y_m 上 -> 行列単位上）
        # -----------------------------------------------------------------
        for m in range(1, M + 1):
            zm = sum([checkZ(O, mu) * eiph(m * th_tilde(M, mu)) for mu in range(1, M + 1)],
                     matrix(CDF, O.d, O.d, 0)) / M
            S.add("T_V_plus_eq Step2 recover_Z_Y_from_check_Z_Y で Z_m を復元", zm, O.Z[m])
            S.add("T_V_plus_eq Step2 T(Z_m) が一致", Vp * O.Z[m] * Vpi, Vpr * O.Z[m] * Vpri)
            S.add("T_V_plus_eq Step2 T(Y_m) が一致", Vp * O.Y[m] * Vpi, Vpr * O.Y[m] * Vpri)
        # Step 3-4: 単位元・積・線型結合で閉じることと、代数全体で一致すること
        S.add("T_V_plus_eq Step3 T(I) = I", Vp * Id * Vpi, Id)
        S.add("T_V_plus_eq Step3 乗法性 T(xy) = T(x)T(y)",
              Vp * (O.Z[1] * O.Y[1]) * Vpi, (Vp * O.Z[1] * Vpi) * (Vp * O.Y[1] * Vpi))
        for i0 in range(O.d):
            for j0 in range(O.d):
                E = matrix(CDF, O.d, O.d, 0); E[i0, j0] = CDF(1)
                S.add("T_V_plus_eq Step4 行列単位 e_{ij} 全体で一致（代数全体で一致）",
                      Vp * E * Vpi, Vpr * E * Vpri)

        # -----------------------------------------------------------------
        # V_plus_eq_c_check_Vprime の各段
        # -----------------------------------------------------------------
        W = Vpri * Vp
        S.add("V_plus_eq_c Step1 V^' W = V^{(+)}", Vpr * W, Vp)
        S.add("V_plus_eq_c Step1 V^'(V^'^{-1} V^{(+)}) = (V^' V^'^{-1}) V^{(+)}  [結合律]",
              Vpr * (Vpri * Vp), (Vpr * Vpri) * Vp)
        S.add("V_plus_eq_c Step1 V^' V^'^{-1} = I", Vpr * Vpri, Id)
        c = W[0, 0]
        dev = opnorm(W - c * Id)
        worst_scalar = dev if worst_scalar is None else max(worst_scalar, dev)
        S.add("V_plus_eq_c Step2 W はすべての元と可換（行列単位で検査）",
              W * O.Z[1], O.Z[1] * W)
        S.add("V_plus_eq_c Step3 W = cI （centralizer_is_scalar）", W, c * Id)
        S.add("V_plus_eq_c Step5 V^{(+)} = c V^'", Vp, c * Vpr)
        assert abs(c) > 1e-8, "Step4 の c != 0 が破れた"

ok_all = S.report_all(tol=1e-7)
print(f"  V_plus_eq_c: W = (V^')^{{-1}} V^{{(+)}} のスカラー行列からの最大ずれ = "
      f"{float(worst_scalar):.3e}")
print(f"  段数（区別された等式の種類）: {len(S.worst)}")
print("check_04:", "PASS" if ok_all else "FAIL")

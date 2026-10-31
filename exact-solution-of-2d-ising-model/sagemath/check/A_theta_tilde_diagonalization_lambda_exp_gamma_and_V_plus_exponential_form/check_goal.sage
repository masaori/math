# ---------------------------------------------------------
# SageMath: A(θ̃_μ) の対角化と V^{(+)} の指数表示の章の章末の主張
#   (1) A(theta~_mu) = P^_mu diag(lambda_{+,mu}, lambda_{-,mu}) P^_mu^{-1}、det P^_mu != 0  (diagonalization_check_P_D)
#   (2) lambda_{±,mu} = exp(±gamma(theta~_mu))、lambda_{±,mu} := gamma_1(theta~_mu) ± |gamma_2(theta~_mu)|
#                                                             (lambda_eq_exp_gamma_theta_tilde、eigenvector_of_A_theta_tilde)
#   (3) gamma(theta) = arccosh(cosh 2K_1 cosh 2K_2^* - sinh 2K_1 sinh 2K_2^* cos theta)  （θ は θ̃_μ 以外の実数も含める）
#       左辺は def_gamma_theta の arccosh(gamma_1(theta)) とし、gamma_1(theta) は右辺の式を使わずに
#       B_1(theta) B_2 B_1(theta)（def_B1_theta_B2、成分は cosh K_1, sinh K_1, cosh 2K_2^*, sinh 2K_2^* と exp(±iθ)）の
#       (1,1) 成分として作る（T_V_plus_check_Z_Y_via_B1_B2_B1 の A(θ) = B_1 B_2 B_1 と def_gamma1_gamma2_of_theta の
#       A(θ) の (1,1) 成分 = gamma_1(θ) による）。
#   (4) (psi^dagger_mu, psi_mu) = (checkZ_mu, checkY_mu) P^_mu、n^_mu = psi^dagger_mu psi_{M+1-mu}。
#       これは def_check_fermi・def_check_number_operator の定義の再掲であり、049 の psi_pair がこの一次結合そのものとして
#       定義されているので、残差は恒等的に 0 になる（定義どおりに作られていることの確認であって、独立な検査ではない）。
#   (5) V^{(+)} = c exp(sum gamma(theta~_mu)(n^_mu - I/2))、c := ((V^')^{-1} V^{(+)})_{11}
#   (1)(2)(3)(5) は主張の両辺を別の経路で作って比べる。各主張の式変形の一行ずつの検査は 048（(1)(2)）と
#   V_plus_eq_c_exp_sum_gamma_check_number_operator/（(5)）が持つ。
#   否定コントロール: (1) diag の並びを入れ替える、(2) 符号を入れ替える、(3) 第 2 項の符号を + にする（cos θ ≠ 0 の θ で一致しないので、θ についての最大値を見る）、
#   (5) n^_mu の対の添字を mu にする。いずれも一致しないことを要求する。
# 対象ラベル: A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form
# 対象: structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts
#       ブロック diagonalization_and_exponential_form_claim_A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form
# 帰属: K_2^* と cosh, sinh, cos, arccosh, exp の値は超越数を含み厳密計算できない（ℝ 脱出: 数値評価）。
#       倍精度 RDF/CDF で計算し、相対残差が 049 と同じ TOL = 1e-8 以下なら一致とみなす。否定コントロールは 1e-3 超を要求する。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
__file__ = os.path.join(_dir, "../049_claim_even_sector_fermions/_prelude.sage")
load(__file__)

NEG_MIN = 1e-3


def rel(A, B):
    return opnorm(A - B) / opnorm(A)


def B1(K1, t):
    """def_B1_theta_B2 の B_1(theta)"""
    a = CDF(cosh(RDF(K1))); b = CDF(sinh(RDF(K1)))
    return matrix(CDF, [[a, -CDF(I) * eiph(t) * b], [CDF(I) * eiph(-t) * b, a]])


def B2(K2s):
    """def_B1_theta_B2 の B_2（K2s = K_2^*）"""
    C = CDF(cosh(2 * RDF(K2s))); S = CDF(sinh(2 * RDF(K2s)))
    return matrix(CDF, [[C, CDF(I) * S], [-CDF(I) * S, C]])


def lam(t, P, sgn):
    return RDF(g1(t, P) + sgn * abs(g2(t, P)))


ok_all = True
for M in FERMI_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in FERMI_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        r1 = r2 = r3 = r4 = 0.0
        n1 = n2 = 1e9
        n3 = 0.0
        detmin = 1e9
        for mu in range(1, M + 1):
            t = th_tilde(M, mu)
            A = A_theta(t, P)
            Pm = Pcheck(M, mu, P)
            detmin = min(detmin, float(abs(Pm.det())))
            lp, lm = lam(t, P, +1), lam(t, P, -1)
            D = matrix(CDF, [[lp, 0], [0, lm]])
            Dw = matrix(CDF, [[lm, 0], [0, lp]])
            r1 = max(r1, rel(A, Pm * D * Pm.inverse()))
            n1 = min(n1, rel(A, Pm * Dw * Pm.inverse()))
            gm = gamma_tilde(M, mu, P)
            r2 = max(r2, abs(lp - exp(gm)) / abs(lp), abs(lm - exp(-gm)) / abs(lm))
            n2 = min(n2, abs(lp - exp(-gm)) / abs(lp))
            # (4) 定義の確認: psi_pair は (checkZ, checkY) P^ の列ごとの一次結合
            pdag, psi = psi_pair(O, mu, P)
            Zc, Yc = checkZ(O, mu), checkY(O, mu)
            r4 = max(r4, rel(pdag, Pm[0, 0] * Zc + Pm[1, 0] * Yc), rel(psi, Pm[0, 1] * Zc + Pm[1, 1] * Yc))
        # (3) θ は θ̃_μ と、それ以外の実数（1, π, -2.5）。θ = 0 は臨界点上で γ_1(0) = 1 となり、丸めで 1 を下回って arccosh が実数を返さないので外す
        for t in [th_tilde(M, mu) for mu in range(1, M + 1)] + [RDF(1), RDF(pi), RDF(-2.5)]:
            K1, K2s = P['K1'], P['K2s']
            g1_via_B = (B1(K1, t) * B2(K2s) * B1(K1, t))[0, 0]
            r3 = max(r3, abs(g1_via_B.imag()))   # γ_1(θ) は実数
            # 臨界点上の θ で γ_1 = 1 に一致しうるので、丸めで 1 を下回る分を 1 に切り上げる
            lhs = RDF(arccosh(max(RDF(g1_via_B.real()), RDF(1))))
            rhs = RDF(arccosh(max(RDF(cosh(2 * K1) * cosh(2 * K2s) - sinh(2 * K1) * sinh(2 * K2s) * cos(t)), RDF(1))))
            r3 = max(r3, abs(lhs - rhs) / max(abs(rhs), 1e-3))
            # 否定コントロールの引数は臨界点上の θ = θ̃_μ で 1 に一致しうるので、丸めで 1 を下回る分を 1 に切り上げる
            arg_w = RDF(cosh(2 * K1) * cosh(2 * K2s) + sinh(2 * K1) * sinh(2 * K2s) * cos(t))
            wrong3 = RDF(arccosh(max(arg_w, RDF(1))))
            n3 = max(n3, abs(lhs - wrong3) / max(abs(lhs), 1e-300))
        # (5)
        Vp, _ = V_plus(O, p['K1'], p['K2'])
        Vpr, Vpri, _ = Vprime_check(O, P)
        c = (Vpri * Vp)[0, 0]
        S = matrix(CDF, O.d, O.d, 0)
        Sw = matrix(CDF, O.d, O.d, 0)
        for mu in range(1, M + 1):
            gm = gamma_tilde(M, mu, P)
            pdag, _ = psi_pair(O, mu, P)
            _, psi_c = psi_pair(O, M + 1 - mu, P)
            _, psi_w = psi_pair(O, mu, P)
            S = S + gm * (pdag * psi_c - Id / 2)
            Sw = Sw + gm * (pdag * psi_w - Id / 2)
        r5 = rel(Vp, c * matrix(CDF, matrix(CDF, S).exp()))
        n5 = rel(Vp, c * matrix(CDF, matrix(CDF, Sw).exp()))
        ok = (max(r1, r2, r3, r4, r5) <= TOL and min(n1, n2, n3, n5) > NEG_MIN
              and detmin > 1e-12 and abs(c) > 1e-3)
        print(f"  M={M}, {param_label(p)}: 残差 (1) {r1:.2e} (2) {r2:.2e} (3) {r3:.2e} (4) {r4:.2e} (5) {r5:.2e}、"
              f"min|det P^| {detmin:.2e}、否定コントロール (1) {n1:.2e} (2) {n2:.2e} (3) {n3:.2e} (5) {n5:.2e} "
              f"-> {'PASS' if ok else 'FAIL'}")
        ok_all = ok and ok_all

print("RESULT: PASS" if ok_all else "RESULT: FAIL")

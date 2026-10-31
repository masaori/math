# ---------------------------------------------------------
# SageMath: 主張 V_plus_eigenvalues_with_c_value_and_strict_maximum の証明の式変形を、
#   各行の値を独立に作って隣どうしを比べる。
#   (1) 0 行目: V^{(+)} = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}                     （def_V_plus）
#       1 行目: (2 sinh 2K_2)^{M/2} V^'                                              （constant_c_value_even_sector）
#       2 行目: (2 sinh 2K_2)^{M/2} exp(X^)                                          （def_check_Vprime の V^' := exp(X^)）
#       3 行目: (2 sinh 2K_2)^{M/2} exp( sum gamma(t~_mu)(psi^dagger_mu psi_{M+1-mu} - I/2) )（def_check_Vprime の X^）
#       4 行目: (2 sinh 2K_2)^{M/2} exp( sum gamma(t~_mu)(n^_mu - I/2) )               （def_check_number_operator）
#   (2) V^{(+)} Q^_eps = Lambda^_eps Q^_eps（全 eps）                                  （eigenvalues_of_V_plus (1)）
#   (3) Lambda^{(1/2)}_M（def_Theta_delta_M・def_Lambda_delta_M の定義どおり、集合 Theta と gamma(theta) から作る）
#       = Lambda^_{(1,...,1)} = (2 sinh 2K_2)^{M/2} exp(sum gamma(t~_mu)(1 - 1/2))
#       = (2 sinh 2K_2)^{M/2} exp(sum gamma(t~_mu) * 1/2) = (2 sinh 2K_2)^{M/2} exp((1/2) sum gamma(t~_mu))
#   (4) eps != (1,...,1) なら Lambda^_eps < Lambda^_{(1,...,1)}、max_eps Lambda^_eps = Lambda^_{(1,...,1)}。
#       あわせて、V^{(+)} を数値対角化した最大固有値が Lambda^_{(1,...,1)} と一致することを独立に見る。
#   否定コントロール: (1) の前因子を (2 sinh 2K_2)^{M} にしたもの、(3) の delta を 0 にした Lambda^{(0)}_M は一致しない。
# 対象ラベル: V_plus_eigenvalues_with_c_value_and_strict_maximum
# 対象: structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts
#       ブロック eigenvalues_of_V_plus_claim_c_value_eigenvalues_and_strict_maximum
# 帰属: V^{(+)}・V^'・Q^_eps は行列の指数関数と、固有値が一般に無理数の作用素から作るので成分が超越数になり、
#       Lambda^_eps は実数の指数と arccosh の値なので、厳密計算できない（ℝ 脱出: 指数評価と実対数）。
#       倍精度（CDF・RDF）で計算し、相対残差が 050 と同じ TOL = 1e-8 以下なら一致とみなす。
#       否定コントロールは相対残差が一致の判定幅の 10 倍（1e-7）を超えることを要求する。高温側（K1=0.05, K2=0.1）では
#       Lambda^{(0)}_M と Lambda^{(1/2)}_M の相対差が M=5 で 7.5e-7 まで真に縮むので、1e-3 のような固定の幅は取れない。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
# 050 の共通定義は __file__ のディレクトリを基準に _shared を読み込むので、__file__ をその位置にして読み込む。
__file__ = os.path.join(_dir, "../050_claim_even_sector_eigenvalues/_prelude.sage")
load(__file__)

NEG_MIN = 10 * TOL


def rel(A, B):
    return opnorm(A - B) / opnorm(A)


def rrel(a, b):
    return abs(RDF(a) - RDF(b)) / abs(RDF(a))


def gamma_of_theta(t, P):
    """gamma1_lower_bound_all_theta の gamma(theta) = arccosh(gamma_1(theta))。
    gamma_1(theta) >= 1 は同じ主張が保証する。臨界点上の theta = 0（否定コントロールの delta = 0 でだけ現れる）では
    倍精度の丸めで gamma_1 が 1 をわずかに下回るので、1 で下から押さえてから arccosh を取る。"""
    x = RDF(g1(t, P))
    assert x > 1 - 1e-12, x
    return RDF(arccosh(max(x, RDF(1))))


def Lambda_delta_from_definition(M, delta, P):
    """def_Theta_delta_M と def_Lambda_delta_M を定義どおりに: Theta を集合として作り、その元で和を取る"""
    Theta = set(RDF(2 * pi * (mu - delta) / M) for mu in range(1, M + 1))
    pref = RDF((2 * P['s2']) ** (RDF(M) / 2))
    return RDF(pref * exp(RDF(1) / 2 * sum(gamma_of_theta(t, P) for t in Theta))), len(Theta)


ok_all = True
for M in EIG_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in EIG_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        pref = RDF((2 * P['s2']) ** (RDF(M) / 2))
        gam = [None] + [gamma_of_theta(th_tilde(M, mu), P) for mu in range(1, M + 1)]
        # (1)
        line0, _ = V_plus(O, p['K1'], p['K2'])
        Vpr, _, Xc = Vprime_check(O, P)
        line1 = CDF(pref) * Vpr
        line2 = CDF(pref) * matrix(CDF, Xc.exp())
        X3 = matrix(CDF, O.d, O.d, 0)
        for mu in range(1, M + 1):
            pdag, _ = psi_pair(O, mu, P)
            _, psi1m = psi_pair(O, M + 1 - mu, P)
            X3 = X3 + gamma_tilde(M, mu, P) * (pdag * psi1m - Id / 2)
        line3 = CDF(pref) * matrix(CDF, X3.exp())
        ns = n_check_all(O, P)
        X4 = matrix(CDF, O.d, O.d, 0)
        for mu in range(1, M + 1):
            X4 = X4 + gam[mu] * (ns[mu] - Id / 2)
        line4 = CDF(pref) * matrix(CDF, X4.exp())
        r1 = max(rel(line0, line1), rel(line1, line2), rel(line2, line3), rel(line3, line4))
        neg1 = rel(line0, CDF(pref ** 2) * matrix(CDF, X4.exp()))
        # (2)
        E = eps_list(M)
        r2 = 0
        Lams = {}
        for eps in E:
            Q = Q_check(O, eps, ns)
            L = RDF(pref * exp(sum(gam[mu] * (RDF(eps[mu - 1]) - RDF(1) / 2) for mu in range(1, M + 1))))
            Lams[eps] = L
            r2 = max(r2, opnorm(line0 * Q - CDF(L) * Q) / abs(L))
        # (3)
        ones = tuple([1] * M)
        L_half, nTheta = Lambda_delta_from_definition(M, RDF(1) / 2, P)
        a1 = Lams[ones]
        a2 = RDF(pref * exp(sum(gam[mu] * (1 - RDF(1) / 2) for mu in range(1, M + 1))))
        a3 = RDF(pref * exp(sum(gam[mu] * (RDF(1) / 2) for mu in range(1, M + 1))))
        a4 = RDF(pref * exp(RDF(1) / 2 * sum(gam[mu] for mu in range(1, M + 1))))
        r3 = max(rrel(L_half, a1), rrel(a1, a2), rrel(a2, a3), rrel(a3, a4))
        L_zero, _ = Lambda_delta_from_definition(M, RDF(0), P)
        neg3 = rrel(a1, L_zero)
        # (4)
        strict = all(Lams[e] < Lams[ones] for e in E if e != ones)
        gap = min((Lams[ones] - Lams[e]) / Lams[ones] for e in E if e != ones)
        is_max = max(Lams.values()) == Lams[ones]
        top = max(RDF(z.real()) for z in line0.eigenvalues())
        r4 = rrel(Lams[ones], top)
        ok = (r1 <= TOL and r2 <= TOL and r3 <= TOL and r4 <= TOL and strict and is_max
              and nTheta == M and neg1 > NEG_MIN and neg3 > NEG_MIN)
        print(f"  M={M}, {param_label(p)}: (1) {r1:.2e}, (2) {r2:.2e}, (3) {r3:.2e}, "
              f"(4) 狭義 {strict}・最大相対差の最小 {gap:.2e}・数値対角化との差 {r4:.2e}、"
              f"否定コントロール {neg1:.2e}, {neg3:.2e} -> {'PASS' if ok else 'FAIL'}")
        ok_all = ok and ok_all

print("RESULT: PASS" if ok_all else "RESULT: FAIL")

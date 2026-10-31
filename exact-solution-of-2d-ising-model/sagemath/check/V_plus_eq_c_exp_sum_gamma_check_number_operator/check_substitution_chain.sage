# ---------------------------------------------------------
# SageMath: 主張 V^{(+)} = c exp( sum_{mu in 𝓜̌} gamma(theta~_mu) (n^_mu - (1/2) I) )
#   の証明の式変形 4 行を、各行の値を独立に作って隣どうしを比べる。
#   0 行目: V^{(+)} = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}                            （def_V_plus）
#   1 行目: c V^'                                                                       (V_plus_eq_c_check_Vprime)
#   2 行目: c exp(X^)                                                                   (def_check_Vprime の V^' := exp(X^))
#   3 行目: c exp( sum gamma(theta~_mu) (psi^dagger_mu psi_{M+1-mu} - I/2) )             (def_check_Vprime の X^)
#   4 行目: c exp( sum gamma(theta~_mu) (n^_mu - I/2) )、n^_mu := psi^dagger_mu psi_{M+1-mu}  (def_check_number_operator)
#   c は主張では存在だけを言う。ここでは c := ((V^')^{-1} V^{(+)})_{11} と取る（V_plus_eq_c_check_Vprime の証明の W = c I）。
#   否定コントロール: n^_mu の対になる添字を M+1-mu ではなく mu にした右辺は、0 行目と一致しない。
# 対象ラベル: V_plus_eq_c_exp_sum_gamma_check_number_operator
# 対象: structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts
#       ブロック diagonalization_and_exponential_form_claim_V_plus_eq_c_exp_check_number_operators
# 帰属: V^{(+)} と V^' は行列の指数関数で作り、K_1, K_2^* が実数で H_1^{(+)}, H_2, X^ の固有値が一般に無理数なので
#       成分が超越数になり厳密計算できない（ℝ 脱出: 指数評価）。倍精度複素数 CDF で計算し、
#       作用素ノルムの相対残差が 049 と同じ TOL = 1e-8 以下なら一致とみなす。否定コントロールは相対残差が 1e-3 を超えることを要求する。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
# 049 の共通定義は __file__ のディレクトリを基準に _shared を読み込むので、__file__ をその位置にして読み込む。
__file__ = os.path.join(_dir, "../049_claim_even_sector_fermions/_prelude.sage")
load(__file__)

NEG_MIN = 1e-3


def number_op(O, mu, P, partner):
    """n^_mu := psi^dagger_mu psi_{partner(mu)}（正しい対は partner(mu) = M+1-mu）"""
    pdag, _ = psi_pair(O, mu, P)
    _, psi_p = psi_pair(O, partner(mu), P)
    return matrix(CDF, pdag * psi_p)


def rel(A, B):
    return opnorm(A - B) / opnorm(A)


ok_all = True
for M in FERMI_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in FERMI_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        line0, _ = V_plus(O, p['K1'], p['K2'])
        Vpr, Vpri, _ = Vprime_check(O, P)
        c = (Vpri * line0)[0, 0]
        line1 = c * Vpr
        # 2 行目: X^ をここで和として作り直し、exp を取る
        X = matrix(CDF, O.d, O.d, 0)
        for mu in range(1, M + 1):
            pdag, _ = psi_pair(O, mu, P)
            _, psi1m = psi_pair(O, M + 1 - mu, P)
            X = X + gamma_tilde(M, mu, P) * (pdag * psi1m - Id / 2)
        line2 = c * matrix(CDF, matrix(CDF, X).exp())
        line3 = line2  # 3 行目は X^ の定義の展開で、2 行目の X をその和で作ったので値は同じ
        # 4 行目: n^_mu を数演算子として作り、gamma は arccosh(gamma_1) を直接計算する
        S = matrix(CDF, O.d, O.d, 0)
        Sw = matrix(CDF, O.d, O.d, 0)
        for mu in range(1, M + 1):
            gm = RDF(arccosh(g1(th_tilde(M, mu), P)))
            S = S + gm * (number_op(O, mu, P, lambda m: M + 1 - m) - Id / 2)
            Sw = Sw + gm * (number_op(O, mu, P, lambda m: m) - Id / 2)
        line4 = c * matrix(CDF, matrix(CDF, S).exp())
        wrong = c * matrix(CDF, matrix(CDF, Sw).exp())
        r01, r12, r34 = rel(line0, line1), rel(line1, line2), rel(line3, line4)
        neg = rel(line0, wrong)
        ok = max(r01, r12, r34) <= TOL and neg > NEG_MIN and abs(c) > 1e-3
        print(f"  M={M}, {param_label(p)}: 隣接行の相対残差 {r01:.2e}, {r12:.2e}, {r34:.2e}、"
              f"|c| {float(abs(c)):.3e}、否定コントロール {neg:.2e} -> {'PASS' if ok else 'FAIL'}")
        ok_all = ok and ok_all

print("RESULT: PASS" if ok_all else "RESULT: FAIL")

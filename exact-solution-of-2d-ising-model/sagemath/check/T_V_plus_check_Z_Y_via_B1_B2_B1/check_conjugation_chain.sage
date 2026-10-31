# ---------------------------------------------------------
# SageMath: 主張の式変形の最初の 2 行
#   (V^{(+)} X (V^{(+)})^{-1}) = T_{V^{(+)}}(X) = T_{(V^{(+)})}(X)   （X = checkZ_mu, checkY_mu）
#   を確かめる。中の T_{V^{(+)}}(X) は def_T_g により左端 V^{(+)} X (V^{(+)})^{-1} と同じ式なので別に作らない。
#   右端 T_{(V^{(+)})}(X) = E1 (E2 (E1 X E1^{-1}) E2^{-1}) E1^{-1}（def_T_V_plus の三つの共役の合成）を作り、
#   それが左端と等しいこと（T_V_plus_is_conjugation）を、下に書く逆行列を作らない同値な形で判定する。
#   ここで E1 = (V_1^{(+)})^{1/2}, E2 = V_2、V^{(+)} = E1 E2 E1（def_V_plus）。X は checkZ_mu, checkY_mu（全 mu）と、追加の確認として成分の実部・虚部が -3 以上 3 以下の整数の乱択行列 3 個。
#   V^{(+)} は K_2 が小さいと条件数が大きく、(V^{(+)})^{-1} を数値で作ると丸め誤差が許容を超える。そこで 右端の値 L0 について、
#   V^{(+)} が可逆（V_plus_factors_invertible）なら L0 = V^{(+)} X (V^{(+)})^{-1} と L0 V^{(+)} = V^{(+)} X が同値であることを使い、
#   逆行列を作らずに後者の残差を opnorm(V^{(+)}) opnorm(X) で割った相対値で判定する。
#   否定コントロール: 共役の向きを逆にした L = (V^{(+)})^{-1} X V^{(+)}（同値な形 V^{(+)} L = X V^{(+)}）を満たす値として
#   E1^{-1} E2^{-1} E1^{-1} X E1 E2 E1 を作り、それが L V^{(+)} = V^{(+)} X を少なくとも一つの X で満たさないこと（相対残差の X についての最大値が NEG_MIN = 1e-3 を超える）。
# 対象ラベル: T_V_plus_check_Z_Y_via_B1_B2_B1
# 対象: structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts
#       ブロック reduction_to_A_theta_claim_T_V_plus_check_Z_Y_via_B1_B2_B1 の証明の 1・2 行目
# 帰属: V^{(+)} は行列の指数関数で作り成分が超越数になるので厳密計算できない（ℝ 脱出: 指数評価）。
#       倍精度複素数 CDF で計算し、上に書いた相対残差が 047 と同じ TOL = 1e-8 以下なら一致とみなす。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
__file__ = os.path.join(_dir, "../047_claim_even_sector_T_action/_prelude.sage")
load(__file__)

NEG_MIN = 1e-3
set_random_seed(20261031)

ok_all = True
for M in EVEN_M:
    O = SpinOps(M)
    n = 2 ** M
    randoms = [matrix(CDF, n, n, [CDF(ZZ.random_element(-3, 4), ZZ.random_element(-3, 4)) for _ in range(n * n)])
               for _ in range(3)]
    for params in EVEN_PARAMS:
        K1v = RDF(params['K1'])
        K2v = RDF(params['K2'])
        E1, E1inv = V1p_half(O, K1v)
        E2, E2inv = V2_mat(O, K2v)
        Vp = E1 * E2 * E1
        Vpinvf = E1inv * E2inv * E1inv
        sV = opnorm(Vp)
        Xs = [checkZ(O, mu) for mu in range(1, M + 1)] + [checkY(O, mu) for mu in range(1, M + 1)] + randoms
        w01 = 0.0
        neg = 0.0
        for X in Xs:
            sc = sV * opnorm(X)
            line0 = E1 * (E2 * (E1 * X * E1inv) * E2inv) * E1inv
            wrong = Vpinvf * X * Vp
            w01 = max(w01, opnorm(line0 * Vp - Vp * X) / sc)
            neg = max(neg, opnorm(wrong * Vp - Vp * X) / sc)
        ok = w01 <= TOL and neg > NEG_MIN
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: T(X) V^(+) - V^(+) X の相対残差 {w01:.2e}、"
              f"否定コントロール {neg:.2e} -> {'PASS' if ok else 'FAIL'}")
        ok_all = ok and ok_all

print("RESULT: PASS" if ok_all else "RESULT: FAIL")

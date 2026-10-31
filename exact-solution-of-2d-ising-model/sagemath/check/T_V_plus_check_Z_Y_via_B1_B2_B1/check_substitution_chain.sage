# ---------------------------------------------------------
# SageMath: 主張 (T_{(V^{(+)})}(checkZ_mu), T_{(V^{(+)})}(checkY_mu))
#               = (checkZ_mu, checkY_mu) A(theta~_mu)
#               = (checkZ_mu, checkY_mu) B_1(theta~_mu) B_2 B_1(theta~_mu)
#   の証明の式変形 2 行を、各行の値を独立に作って隣どうしを比べる。
#   0 行目: (V^{(+)} checkZ (V^{(+)})^{-1}, V^{(+)} checkY (V^{(+)})^{-1})   （def_T_V_plus の共役の合成）
#   1 行目: (checkZ, checkY) A(theta~_mu)                                    (T_V_plus_check_Z_Y)
#   2 行目: (checkZ, checkY) B_1(theta~_mu) B_2 B_1(theta~_mu)              (factorization_of_A_theta_general)
#   否定コントロール: 2 行目で積の順序を B_2 B_1 B_1 に替えた右辺は、少なくとも一つの mu で 0 行目と一致しない。
#   （M_col が奇数のとき mu = (M_col+1)/2 では theta~_mu = pi で、B_1(pi) と B_2 が可換になり一致する。
#    そこで mu についての残差の最大値で判定する。）
# 対象ラベル: T_V_plus_check_Z_Y_via_B1_B2_B1
# 対象: structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts
#       ブロック reduction_to_A_theta_claim_T_V_plus_check_Z_Y_via_B1_B2_B1
# 帰属: V^{(+)} は行列の指数関数で作り、K_1, K_2^* が実数で H_1^{(+)}, H_2 の固有値が一般に無理数なので
#       成分が超越数になり厳密計算できない（ℝ 脱出: 指数評価）。倍精度複素数 CDF で計算し、
#       作用素ノルムの残差が 047 と同じ TOL = 1e-8 以下なら一致とみなす。否定コントロールは残差が 1e-3 を超えることを要求する。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
# 047 の共通定義は __file__ のディレクトリを基準に _shared を読み込むので、__file__ をその位置にして読み込む。
__file__ = os.path.join(_dir, "../047_claim_even_sector_T_action/_prelude.sage")
load(__file__)

NEG_MIN = 1e-3


def row_times(Zc, Yc, Bm):
    """(checkZ, checkY) B = (B_{11} checkZ + B_{21} checkY, B_{12} checkZ + B_{22} checkY)"""
    return (combine(Zc, Yc, Bm.column(0)), combine(Zc, Yc, Bm.column(1)))


def pair_res(p, q):
    return max(opnorm(p[0] - q[0]), opnorm(p[1] - q[1]))


ok_all = True
for M in EVEN_M:
    O = SpinOps(M)
    for params in EVEN_PARAMS:
        K1v = RDF(params['K1'])
        K2v = RDF(params['K2'])
        K2s = K_star(K2v)
        E1, E1inv = V1p_half(O, K1v)
        E2, E2inv = V2_mat(O, K2v)
        w01 = w12 = 0.0
        neg = None
        for mu in range(1, M + 1):
            t = th_tilde(M, mu)
            Zc, Yc = checkZ(O, mu), checkY(O, mu)
            line0 = tuple(E1 * (E2 * (E1 * W * E1inv) * E2inv) * E1inv for W in (Zc, Yc))
            line1 = row_times(Zc, Yc, A_theta(K1v, K2v, t))
            line2 = row_times(Zc, Yc, B1(K1v, t) * B2(K2s) * B1(K1v, t))
            wrong = row_times(Zc, Yc, B2(K2s) * B1(K1v, t) * B1(K1v, t))
            w01 = max(w01, pair_res(line0, line1))
            w12 = max(w12, pair_res(line1, line2))
            r = pair_res(line0, wrong)
            neg = r if neg is None else max(neg, r)
        ok = w01 <= TOL and w12 <= TOL and neg > NEG_MIN
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: 隣接行の残差 {w01:.2e}, {w12:.2e}、"
              f"否定コントロール {neg:.2e} -> {'PASS' if ok else 'FAIL'}")
        ok_all = ok and ok_all

print("RESULT: PASS" if ok_all else "RESULT: FAIL")

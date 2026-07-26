# ---------------------------------------------------------
# B_1(theta_mu) B_2 B_1(theta_mu) を、作用素レベルから読み取った A(theta_mu) と比較する。
# 対象: structured-latex `factorization_of_A_theta`
#
# 右辺は 2x2 行列 B_1, B_2 の積。
# 左辺は 2^M x 2^M の行列 V = (V_1^{(-)})^{1/2} V_2 (V_1^{(-)})^{1/2} による共役
#   (T_V(hatZ_mu), T_V(hatY_mu)) = (hatZ_mu, hatY_mu) A(theta_mu)
# から最小二乗で取り出した係数行列（<T_V_hatZ_hatY>）。gamma_1, gamma_2 の閉じた式も
# B_1, B_2 も使っていないので、完全に独立な経路である。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

rep = CheckReport("factorization_of_A_theta: B_1 B_2 B_1 = 作用素から読み取った A(theta_mu)",
                  tol=1e-8)

for (K1, K2, tag) in param_sets():
    B2 = B2_of(K2)
    for M in [2, 3, 4]:
        for mu in mu_range(M):
            th = theta_mu_of(mu, M)
            A_op, resid = A_from_operators(mu, M, K1, K2)
            rep.truth(resid < 1e-8,
                      "[%s K1=%.6f K2=%.6f M=%d mu=%d] hatZ, hatY による展開の残差 %.2e"
                      % (tag, K1, K2, M, mu, resid))
            B1 = B1_of(th, K1)
            rep.close(A_op, B1 @ B2 @ B1,
                      "[%s K1=%.6f K2=%.6f M=%d mu=%d] A_op = B1 B2 B1" % (tag, K1, K2, M, mu))

rep.finish()

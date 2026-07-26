# ---------------------------------------------------------
# det A(theta_mu) = 1,  gamma_1(theta_mu)^2 + gamma_2(theta_mu) gamma_2(-theta_mu) = 1
# 対象: structured-latex `det_A_theta`
#
# 独立な 3 経路で det = 1 を確かめる。
#   (a) numpy の行列式（LU 分解）を、gamma_1, gamma_2 から組んだ A に適用
#   (b) numpy の行列式を、作用素レベルから読み取った A に適用（gamma を一切使わない）
#   (c) 因数分解 A = B_1 B_2 B_1（<factorization_of_A_theta>）から
#       det A = (det B_1)^2 det B_2 として計算
# さらに本文の書き換え gamma_1^2 + gamma_2(theta) gamma_2(-theta) = 1 を確かめる。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

rep = CheckReport("det_A_theta: det A(theta_mu) = 1 と gamma_1^2 + gamma_2(theta)gamma_2(-theta) = 1",
                  tol=1e-8)

for (K1, K2, tag) in param_sets():
    B2 = B2_of(K2)
    for M in [2, 3, 4]:
        for mu in mu_range(M):
            th = theta_mu_of(mu, M)
            tagstr = "[%s K1=%.6f K2=%.6f M=%d mu=%d]" % (tag, K1, K2, M, mu)

            A = A_of(th, K1, K2)
            rep.close(np.linalg.det(A), 1.0, tagstr + " (a) det A = 1")

            A_op, resid = A_from_operators(mu, M, K1, K2)
            rep.truth(resid < 1e-8, tagstr + " 作用素展開の残差 %.2e" % resid)
            rep.close(np.linalg.det(A_op), 1.0, tagstr + " (b) det(作用素から読んだ A) = 1")

            B1 = B1_of(th, K1)
            rep.close(np.linalg.det(B1) ** 2 * np.linalg.det(B2), 1.0,
                      tagstr + " (c) (det B_1)^2 det B_2 = 1")

            g1 = gamma1_of(th, K1, K2)
            g2p = gamma2_of(th, K1, K2)
            g2m = gamma2_of(-th, K1, K2)
            rep.close(g1 * g1 + g2p * g2m, 1.0,
                      tagstr + " gamma_1^2 + gamma_2(theta)gamma_2(-theta) = 1")

rep.finish()

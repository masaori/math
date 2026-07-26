# ---------------------------------------------------------
# lambda_{+,mu} lambda_{-,mu} = 1
# 対象: structured-latex `det_A_theta`
#
# 独立な 2 経路:
#   (a) 本文の閉じた式 lambda_pm = gamma_1 ± sqrt(-gamma_2(theta)gamma_2(-theta))
#       （_shared/operators.sage の lambda_pm_of）の積
#   (b) numpy の固有値ソルバ（QR 法）が返す A(theta_mu) の 2 固有値の積
# 加えて (a) と (b) の固有値そのものが集合として一致することも確かめる。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

rep = CheckReport("det_A_theta: lambda_+ lambda_- = 1（閉じた式 vs 数値固有値）", tol=1e-8)

for (K1, K2, tag) in param_sets():
    for M in [2, 3, 4, 5]:
        for mu in mu_range(M):
            th = theta_mu_of(mu, M)
            tagstr = "[%s K1=%.6f K2=%.6f M=%d mu=%d]" % (tag, K1, K2, M, mu)

            lp, lm = lambda_pm_of(mu, M, K1, K2)
            rep.close(lp * lm, 1.0, tagstr + " (a) lambda_+ lambda_- = 1")

            ev = np.linalg.eigvals(A_of(th, K1, K2))
            rep.close(ev[0] * ev[1], 1.0, tagstr + " (b) 数値固有値の積 = 1")

            # 集合としての一致（大きい方・小さい方で対応させる）
            ev_sorted = sorted(ev, key=lambda z: -abs(z))
            our_sorted = sorted([lp, lm], key=lambda z: -abs(z))
            rep.close(np.array(ev_sorted), np.array(our_sorted),
                      tagstr + " 閉じた式の lambda_pm = 数値固有値")

rep.finish()

# <eigenvector_of_A_theta>: 固有値 lambda_± と固有ベクトル v_±
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("eigenvector_of_A_theta")
ngz = 0; nz = 0
for M in [2,3,4,8]:
    for p in ALL_PARAMS:
        K1, K2 = p['K1'], p['K2']
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            A = A_of(th,K1,K2)
            g2p = gamma2_of(th,K1,K2); g2m = gamma2_of(-th,K1,K2)
            lp, lm = lambda_pm_of(mu,M,K1,K2)
            if abs(g2p) < 1e-10:
                nz += 1
                rep.close(A, np.eye(2), f"M={M} mu={mu}: gamma_2=0 なら A = I")
                # 任意のベクトルが固有ベクトル
                v = np.array([0.3+0.7j, -1.2+0.1j])
                rep.close(A @ v, lp*v, f"M={M} mu={mu}: gamma_2=0 で任意の v が固有ベクトル")
            else:
                ngz += 1
                r = sqrt_cc_np(g2p*g2m)
                for s, lam in [(+1, lp), (-1, lm)]:
                    v = np.array([s*1j*r, g2m])
                    rep.close(A @ v, lam*v, f"M={M} mu={mu} s={s}: A v = lambda v")
                    rep.truth(np.linalg.norm(v) > 1e-12, f"M={M} mu={mu} s={s}: v != 0")
print(f"  gamma_2 != 0 の事例 {ngz} 件、gamma_2 = 0 の事例 {nz} 件")
rep.finish()

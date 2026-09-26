# <det_A_theta>: det A = 1, gamma_1^2 + gamma_2(th)gamma_2(-th) = 1, lambda_+ lambda_- = 1
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("det_A_theta")
for M in [2,3,4,8,16]:
    for p in ALL_PARAMS:
        K1, K2 = p['K1'], p['K2']
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            A = A_of(th,K1,K2)
            rep.close(np.linalg.det(A), 1.0, f"M={M} mu={mu}: det A = 1")
            g1 = gamma1_of(th,K1,K2)
            rep.close(g1**2 + gamma2_of(th,K1,K2)*gamma2_of(-th,K1,K2), 1.0,
                      f"M={M} mu={mu}: gamma_1^2 + gamma_2(th)gamma_2(-th) = 1")
            lp, lm = lambda_pm_of(mu,M,K1,K2)
            rep.close(lp*lm, 1.0, f"M={M} mu={mu}: lambda_+ lambda_- = 1")
            rep.close(lp+lm, 2*g1, f"M={M} mu={mu}: lambda_+ + lambda_- = 2 gamma_1")
rep.finish()

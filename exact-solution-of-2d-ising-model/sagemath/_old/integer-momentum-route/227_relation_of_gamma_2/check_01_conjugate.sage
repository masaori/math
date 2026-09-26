# <relation_of_gamma_2>: gamma_2(-th) = -conj(gamma_2(th)), gamma_2(th)gamma_2(-th) = -|gamma_2(th)|^2
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("relation_of_gamma_2")
for M in [2,3,4,8,16]:
    for p in ALL_PARAMS:
        K1, K2 = p['K1'], p['K2']
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            g2p = gamma2_of(th,K1,K2); g2m = gamma2_of(-th,K1,K2)
            rep.close(g2m, -np.conj(g2p), f"M={M} mu={mu}: gamma_2(-th) = -conj(gamma_2(th))")
            rep.close(g2p*g2m, -abs(g2p)**2, f"M={M} mu={mu}: 積 = -|gamma_2|^2")
            rep.truth((abs(g2p) < 1e-9) == (abs(g2m) < 1e-9), f"M={M} mu={mu}: 零点が同時")
rep.finish()

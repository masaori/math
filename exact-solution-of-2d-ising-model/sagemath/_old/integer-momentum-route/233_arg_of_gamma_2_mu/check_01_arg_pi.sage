# <arg_of_gamma_2_mu>: arg^{[0,2pi)}(gamma_2(th)gamma_2(-th)) = pi
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("arg_of_gamma_2_mu")
for M in [2,3,4,8,16]:
    for p in ALL_PARAMS:
        K1, K2 = p['K1'], p['K2']
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            g2p = gamma2_of(th,K1,K2); g2m = gamma2_of(-th,K1,K2)
            if abs(g2p) < 1e-9:
                continue
            prod = g2p*g2m
            rep.close(arg02pi(prod), np.pi, f"M={M} mu={mu}: arg(積) = pi")
            rep.truth(np.real(prod) < 0 and abs(np.imag(prod)) < 1e-9*max(1,abs(prod)),
                      f"M={M} mu={mu}: 積は負の実数")
rep.finish()

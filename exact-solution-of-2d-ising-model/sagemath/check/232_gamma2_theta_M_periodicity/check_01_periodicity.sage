# <gamma2_theta_M_periodicity>: gamma_2(theta_M) = gamma_2(theta_{-M}) など
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("gamma2_theta_M_periodicity")
for M in [2,3,4,8,16]:
    for p in ALL_PARAMS:
        K1,K2 = p['K1'],p['K2']
        thM, thmM = theta_mu_of(M,M), theta_mu_of(-M,M)
        rep.close(gamma2_of(thM,K1,K2), gamma2_of(thmM,K1,K2), f"M={M}: gamma_2(theta_M) = gamma_2(theta_-M)")
        rep.close(gamma2_of(-thM,K1,K2), gamma2_of(-thmM,K1,K2), f"M={M}: gamma_2(-theta_M) = gamma_2(-theta_-M)")
        rep.close(gamma1_of(thM,K1,K2), gamma1_of(thmM,K1,K2), f"M={M}: gamma_1 も同様")
        # theta_M = 2pi, theta_{-M} = -2pi なので cos/sin が一致するのが根拠
        rep.close(np.cos(thM), np.cos(thmM), f"M={M}: cos(2pi) = cos(-2pi)")
        rep.close(np.sin(thM), np.sin(thmM), f"M={M}: sin(2pi) = sin(-2pi)")
rep.finish()

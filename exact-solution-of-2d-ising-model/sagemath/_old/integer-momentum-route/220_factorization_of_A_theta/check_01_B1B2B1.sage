# <factorization_of_A_theta>: A(theta_mu) = B_1(theta_mu) B_2 B_1(theta_mu)
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("factorization_of_A_theta")
for M in [2,3,4,8,16]:
    for p in ALL_PARAMS:
        K1, K2 = p['K1'], p['K2']
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            rep.close(B1_of(th,K1) @ B2_of(K2) @ B1_of(th,K1), A_of(th,K1,K2),
                      f"M={M} mu={mu} K1={K1:.4f} K2={K2}: B_1 B_2 B_1 = A")
            # 順序を変えると一致しない（積の順序が本質的であることの確認）
            if mu == 1 and M == 4:
                alt = B2_of(K2) @ B1_of(th,K1) @ B1_of(th,K1)
                rep.truth(np.max(np.abs(alt - A_of(th,K1,K2))) > 1e-6, f"M={M}: 順序を変えると不一致")
rep.finish()

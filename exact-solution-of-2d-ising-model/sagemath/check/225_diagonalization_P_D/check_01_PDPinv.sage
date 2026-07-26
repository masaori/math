# <diagonalization_P_D>: A(theta_mu) = P_mu D_mu P_mu^{-1}
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("diagonalization_P_D")
worst_cond = 0.0
for M in [2,3,4,8]:
    for p in ALL_PARAMS:
        K1, K2 = p['K1'], p['K2']
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            if abs(gamma2_of(th,K1,K2)) < 1e-10:
                continue           # P_mu が定義されない
            P = P_mu_of(mu,M,K1,K2)
            lp, lm = lambda_pm_of(mu,M,K1,K2)
            D = np.diag([lp, lm])
            rep.truth(abs(np.linalg.det(P)) > 1e-14, f"M={M} mu={mu}: P は可逆 (|det|={abs(np.linalg.det(P)):.3e})")
            worst_cond = max(worst_cond, float(np.linalg.cond(P)))
            rep.close(P @ D @ np.linalg.inv(P), A_of(th,K1,K2), f"M={M} mu={mu}: A = P D P^-1")
print(f"  P_mu の条件数の最大値: {worst_cond:.6e}")
rep.finish()

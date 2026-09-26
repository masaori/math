# <T_Vprime_fixes_hatZ_hatY_when_gamma2_zero>: gamma_2(theta_mu) = 0 のとき T_(V') は hatZ^{(-)}_mu, hatY_mu を固定する
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
def crit_K1(K2):
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)
rep = CheckReport("T_Vprime_fixes_hatZ_hatY_when_gamma2_zero")

def Vprime_op(K1, K2, M):
    n = 2**M
    S = np.zeros((n,n), dtype=complex)
    for mu in range(1, M+1):
        th = theta_mu_of(mu, M)
        if abs(gamma2_of(th, K1, K2)) < 1e-10:
            continue
        g1v = float(np.real(gamma1_of(th, K1, K2)))
        gam = float(np.arccosh(max(g1v, 1.0)))
        pd, _ = psi_ops(mu, M, K1, K2)
        _, pm = psi_ops(-mu, M, K1, K2)
        S = S + gam*(pd @ pm - 0.5*np.eye(n))
    return _expm(S)

found = 0
for M in [2,3,4]:
    for K2 in [0.3, 0.4407, 0.6, 1.1]:
        K1 = crit_K1(K2)              # 臨界点ちょうど（ここでのみ gamma_2 = 0 が起きる）
        Vp = Vprime_op(K1, K2, M)
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            if abs(gamma2_of(th,K1,K2)) >= 1e-10:
                continue
            found += 1
            Zm = hatZ_op(mu,M,'-'); Ym = hatY_op(mu,M)
            rep.close(T_conj(Vp, Zm), Zm, f"M={M} mu={mu} K2={K2}: T_(V')(hatZ^(-)) = hatZ^(-)")
            rep.close(T_conj(Vp, Ym), Ym, f"M={M} mu={mu} K2={K2}: T_(V')(hatY) = hatY")
            rep.close(A_of(th,K1,K2), np.eye(2), f"M={M} mu={mu}: そこで A(theta_mu) = I")
print(f"  gamma_2 = 0 を実際に踏んだ (M,mu,K2) の事例: {found} 件")
rep.truth(found > 0, "gamma_2 = 0 の事例を実際に踏んでいる")
rep.finish()

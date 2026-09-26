# <T_V_eq_T_Vprime_on_hatZ_hatY> と <T_Vprime_fixes_hatZ_hatY_when_gamma2_zero>
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import itertools
def crit_K1(K2):
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)
rep = CheckReport("T_V_eq_T_Vprime_on_hatZ_hatY")

def T_V_op(K1, K2, M, sgn='-'):
    g1 = principal_sqrt_of_V1pm(K1, M, sgn)
    g2 = V2_op(K2, M)
    return g1 @ g2 @ g1

def Vprime_op(K1, K2, M):
    """<def_Vprime>: exp(sum_{mu=1..M, gamma_2 != 0} gamma(theta_mu)(psi^dag_mu psi_{-mu} - 1/2))"""
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

for M in [2,3,4]:
    params = [{'K1':0.4,'K2':0.8}, {'K1':1.2,'K2':0.3}, {'K1':0.3,'K2':1.7},
              {'K1':crit_K1(0.6),'K2':0.6}, {'K1':crit_K1(0.4407),'K2':0.4407}]
    for p in params:
        K1, K2 = p['K1'], p['K2']
        V = T_V_op(K1, K2, M, '-')
        Vp = Vprime_op(K1, K2, M)
        nzero = 0
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            Zm = hatZ_op(mu,M,'-'); Ym = hatY_op(mu,M)
            rep.close(T_conj(V, Zm), T_conj(Vp, Zm), f"M={M} mu={mu} K1={K1:.4f}: T_(V) = T_(V') on hatZ^(-)")
            rep.close(T_conj(V, Ym), T_conj(Vp, Ym), f"M={M} mu={mu} K1={K1:.4f}: T_(V) = T_(V') on hatY")
            if abs(gamma2_of(th,K1,K2)) < 1e-10:
                nzero += 1
                rep.close(T_conj(Vp, Zm), Zm, f"M={M} mu={mu}: gamma_2=0 で T_(V') は hatZ^(-) を固定")
                rep.close(T_conj(Vp, Ym), Ym, f"M={M} mu={mu}: gamma_2=0 で T_(V') は hatY を固定")
        if nzero:
            print(f"  M={M} K1={K1:.6f} K2={K2}: gamma_2 = 0 の mu が {nzero} 個（臨界点）")
rep.finish()

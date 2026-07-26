# T_(V) の hatZ, hatY への作用が A(theta_mu) で与えられること（<T_V_hatZ_hatY> の作用素側での確認）
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import itertools
def crit_K1(K2):
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)
rep = CheckReport("T_(V) の作用 = A(theta_mu)（作用素レベル）")
for M in [2,3,4]:
    for p in [{'K1':0.4,'K2':0.8},{'K1':1.2,'K2':0.3},{'K1':crit_K1(0.6),'K2':0.6}]:
        K1, K2 = p['K1'], p['K2']
        g1 = principal_sqrt_of_V1pm(K1, M, '-')
        V = g1 @ V2_op(K2, M) @ g1
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            A = A_of(th, K1, K2)
            Zm = hatZ_op(mu,M,'-'); Ym = hatY_op(mu,M)
            rep.close(T_conj(V, Zm), A[0,0]*Zm + A[1,0]*Ym, f"M={M} mu={mu}: T_(V)(hatZ^(-)) = A の第1列")
            rep.close(T_conj(V, Ym), A[0,1]*Zm + A[1,1]*Ym, f"M={M} mu={mu}: T_(V)(hatY) = A の第2列")
rep.finish()

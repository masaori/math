# <arg_of_gamma2_quotient>: |商| = 1、arg^{[0,2pi)}(商) = s_{[0,2pi)}([2 phi_mu + pi])
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("arg_of_gamma2_quotient")
near_boundary = 0
for M in [2,3,4,8,16,32]:
    for p in ALL_PARAMS:
        K1, K2 = p['K1'], p['K2']
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            g2p = gamma2_of(th,K1,K2); g2m = gamma2_of(-th,K1,K2)
            if abs(g2p) < 1e-9:
                continue
            q = g2p/g2m
            rep.close(abs(q), 1.0, f"M={M} mu={mu}: |商| = 1")
            phi = arg02pi(g2p)
            expected = (2*phi + np.pi) % (2*np.pi)
            got = arg02pi(q)
            # 2pi の境界で 0 と 2pi が入れ替わりうるので、円周上の距離で比べる
            d = abs((got - expected + np.pi) % (2*np.pi) - np.pi)
            rep.truth(d < 1e-8, f"M={M} mu={mu}: arg(商) = (2 phi + pi) mod 2pi (差={d:.3e})")
            if min(abs(phi - np.pi/2), abs(phi - 3*np.pi/2)) < 0.05:
                near_boundary += 1
print(f"  mod 2pi 還元の境界（phi が pi/2 または 3pi/2 の近く）を踏んだ事例: {near_boundary} 件")
rep.truth(near_boundary > 0, "境界近傍のパラメータを実際に踏んでいる")
rep.finish()

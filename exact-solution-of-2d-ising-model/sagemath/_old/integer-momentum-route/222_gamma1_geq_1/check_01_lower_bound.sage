# <gamma1_geq_1>: gamma_1(theta_mu) >= 1。等号がどこで起きるかも調べる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("gamma1_geq_1")
worst = (None, 1e18)
for M in [2,3,4,8,16,32]:
    for p in ALL_PARAMS:
        K1, K2 = p['K1'], p['K2']
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            g1 = float(np.real(gamma1_of(th,K1,K2)))
            rep.truth(abs(np.imag(gamma1_of(th,K1,K2))) < 1e-12, f"M={M} mu={mu}: gamma_1 は実数")
            rep.truth(g1 >= 1.0 - 1e-12, f"M={M} mu={mu} K1={K1:.4f} K2={K2}: gamma_1 >= 1 (値={g1:.12f})")
            if g1 < worst[1]:
                worst = ((M,mu,K1,K2), g1)
            # gamma_1 > 0 は常に成立（arg(gamma_1) = pi の場合が空であることの根拠）
            rep.truth(g1 > 0, f"M={M} mu={mu}: gamma_1 > 0（arg = pi の場合は空）")
print(f"  gamma_1 の最小値: {worst[1]:.15f} at (M,mu,K1,K2)={worst[0]}")
# c_1 c_2^* / (s_1 s_2^*) > 1 であること（arg(gamma_1) の第2の場合が空であることの直接確認）
for p in ALL_PARAMS:
    K1, K2 = p['K1'], p['K2']; K2s = K_star(K2)
    ratio = (c_of(K1)*c_of(K2s))/(s_of(K1)*s_of(K2s))
    rep.truth(ratio > 1.0, f"K1={K1:.4f} K2={K2}: c_1c_2*/(s_1s_2*) = {ratio:.6f} > 1")
rep.finish()

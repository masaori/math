# <A_theta_is_identity_when_gamma2_zero>: gamma_2(theta_mu) = 0 ⟹ A(theta_mu) = I
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("A_theta_is_identity_when_gamma2_zero")
found = 0
for M in [2,3,4,8]:
    for p in CRIT_PARAMS:              # 臨界点ちょうどでのみ gamma_2 = 0 が起きる
        K1, K2 = p['K1'], p['K2']
        for mu in [M, -M]:
            th = theta_mu_of(mu, M)
            g2 = gamma2_of(th,K1,K2)
            rep.truth(abs(g2) < 1e-9, f"M={M} mu={mu} 臨界点: gamma_2 = 0 (|g2|={abs(g2):.3e})")
            if abs(g2) < 1e-9:
                found += 1
                rep.close(A_of(th,K1,K2), np.eye(2), f"M={M} mu={mu}: A = I")
                rep.close(gamma1_of(th,K1,K2), 1.0, f"M={M} mu={mu}: gamma_1 = 1")
# 臨界点でない場合は gamma_2 != 0 で A != I
for M in [4]:
    for p in OP_TEST_PARAMS:
        K1,K2 = p['K1'],p['K2']
        if abs(s_of(K1)*s_of(K2) - 1) < 1e-6: continue
        th = theta_mu_of(M, M)
        rep.truth(abs(gamma2_of(th,K1,K2)) > 1e-6, f"非臨界 K1={K1} K2={K2}: mu=M でも gamma_2 != 0")
print(f"  gamma_2 = 0 を実際に踏んだ事例: {found} 件")
rep.truth(found > 0, "gamma_2 = 0 の事例を実際に踏んでいる")
rep.finish()

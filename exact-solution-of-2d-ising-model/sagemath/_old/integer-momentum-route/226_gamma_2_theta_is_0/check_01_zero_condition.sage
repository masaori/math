# <gamma_2_theta_is_0>: gamma_2 = 0 ⟺ {sin th = 0 かつ c_2 s_1 = c_1 cos th} ⟺ mu = ±M かつ c_1 = s_1 c_2
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("gamma_2_theta_is_0")
n_even_half = 0
for M in [2,3,4,6,8]:
    for p in ALL_PARAMS:
        K1, K2 = p['K1'], p['K2']
        c1, s1, c2 = c_of(K1), s_of(K1), c_of(K2)
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            th = theta_mu_of(mu, M)
            g2 = gamma2_of(th,K1,K2)
            cond = (abs(np.sin(th)) < 1e-12) and (abs(c2*s1 - c1*np.cos(th)) < 1e-9)
            rep.truth((abs(g2) < 1e-9) == cond,
                      f"M={M} mu={mu} K1={K1:.4f} K2={K2}: gamma_2=0 ⟺ 連立条件 (|g2|={abs(g2):.3e})")
            # M が偶数で mu = ±M/2 のとき sin th = 0 だが gamma_2 != 0 であること
            if M % 2 == 0 and abs(mu) == M//2:
                n_even_half += 1
                rep.truth(abs(np.sin(th)) < 1e-12, f"M={M} mu={mu}: sin(theta_mu) = 0")
                rep.truth(abs(g2) > 1e-6,
                          f"M={M} mu={mu} K1={K1:.4f}: sin=0 でも gamma_2 != 0（|g2|={abs(g2):.4e}）")
                # 理由: cos th = -1 なので第2条件が c_2 s_1 = -c_1 < 0 を要求して正値性に反する
                rep.truth(c2*s1 > 0 and -c1 < 0, f"M={M} mu={mu}: c_2 s_1 > 0 > -c_1（矛盾の根拠）")
            # gamma_2 = 0 が起きるのは mu = ±M かつ c_1 = s_1 c_2 のときだけ
            if abs(g2) < 1e-9:
                rep.truth(abs(mu) == M, f"M={M} mu={mu}: gamma_2=0 ⟹ |mu| = M")
                rep.truth(abs(c1 - s1*c2) < 1e-8, f"M={M} mu={mu}: gamma_2=0 ⟹ c_1 = s_1 c_2")
print(f"  M 偶数・mu=±M/2（sin=0 だが gamma_2!=0）の事例: {n_even_half} 件")
rep.finish()

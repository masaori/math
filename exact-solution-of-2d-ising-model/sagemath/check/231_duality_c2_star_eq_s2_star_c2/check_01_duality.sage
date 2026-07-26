# <duality_c2_star_eq_s2_star_c2>: s_2^* = 1/s_2, c_2^* = c_2/s_2, c_2^* = s_2^* c_2
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("duality_c2_star_eq_s2_star_c2")
for K2 in [0.05,0.1,0.2,0.3,0.4407,0.6,0.9,1.3,2.0,3.0]:
    K2s = K_star(K2)
    c2,s2 = c_of(K2),s_of(K2)
    c2s,s2s = c_of(K2s),s_of(K2s)
    rep.close(s2s, 1.0/s2, f"K2={K2}: s_2^* = 1/s_2")
    rep.close(c2s, c2/s2, f"K2={K2}: c_2^* = c_2/s_2")
    rep.close(c2s, s2s*c2, f"K2={K2}: c_2^* = s_2^* c_2")
    rep.close(s2*s2s, 1.0, f"K2={K2}: sinh(2K_2) sinh(2K_2^*) = 1（双対の定義）")
    rep.close(K2s, -0.5*np.log(np.tanh(K2)), f"K2={K2}: K_2^* = -1/2 log(tanh K_2)")
rep.finish()

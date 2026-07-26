# <critical_condition_c1_eq_s1_c2>: c_1 = s_1 c_2 ⟺ s_1 s_2 = 1
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

CRIT_PARAMS = [{"K1": crit_K1(k2), "K2": k2} for k2 in [0.3, 0.4407, 0.6, 1.1]]
ALL_PARAMS = list(OP_TEST_PARAMS) + CRIT_PARAMS

rep = CheckReport("critical_condition_c1_eq_s1_c2")
# (⟸) s_1 s_2 = 1 の曲線上で c_1 = s_1 c_2
for k2 in [0.1,0.2,0.3,0.4407,0.6,0.9,1.3,2.0]:
    K2 = k2; K1 = crit_K1(K2)
    c1,s1,c2,s2 = c_of(K1),s_of(K1),c_of(K2),s_of(K2)
    rep.close(s1*s2, 1.0, f"K2={K2}: 構成した点で s_1 s_2 = 1")
    rep.close(c1, s1*c2, f"K2={K2}: そこで c_1 = s_1 c_2（⟸ 方向）")
# (⟹) c_1 = s_1 c_2 を数値的に解いて、その点で s_1 s_2 = 1
from scipy.optimize import brentq
for k2 in [0.1,0.3,0.5,0.8,1.2,2.0]:
    K2 = k2; c2 = c_of(K2)
    f = lambda x: c_of(x) - s_of(x)*c2
    a, b = 1e-6, 10.0
    if f(a)*f(b) < 0:
        K1 = brentq(f, a, b, xtol=1e-14)
        s1, s2 = s_of(K1), s_of(K2)
        rep.close(c_of(K1), s_of(K1)*c2, f"K2={K2}: 解 K1={K1:.12f} で c_1 = s_1 c_2")
        rep.close(s1*s2, 1.0, f"K2={K2}: その点で s_1 s_2 = 1（⟹ 方向）")
# 条件を満たさない点では両方とも成り立たない
for p in OP_TEST_PARAMS:
    K1,K2 = p['K1'],p['K2']
    c1,s1,c2,s2 = c_of(K1),s_of(K1),c_of(K2),s_of(K2)
    lhs_ok = abs(c1 - s1*c2) < 1e-9
    rhs_ok = abs(s1*s2 - 1.0) < 1e-9
    rep.truth(lhs_ok == rhs_ok, f"K1={K1} K2={K2}: 両条件の成否が一致 ({lhs_ok},{rhs_ok})")
rep.finish()

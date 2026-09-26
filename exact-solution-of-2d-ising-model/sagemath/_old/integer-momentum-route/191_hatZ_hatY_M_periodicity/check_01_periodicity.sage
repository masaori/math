# <hatZ_hatY_M_periodicity>: hatZ^{(-)}_M = hatZ^{(-)}_{-M}, hatY_M = hatY_{-M}
# 併せて、一般の mu in Z について M 周期であることも確認する（本文は特殊値のみ）。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("hatZ_hatY_M_periodicity")
for M in [2,3,4,5]:
    for sgn in ['+','-']:
        rep.close(hatZ_op(M,M,sgn), hatZ_op(-M,M,sgn), f"M={M} sgn={sgn}: hatZ_M = hatZ_{{-M}}")
    rep.close(hatY_op(M,M), hatY_op(-M,M), f"M={M}: hatY_M = hatY_{{-M}}")
    # 一般の周期性 hat X_{mu+M} = hat X_mu
    for mu in range(-2*M, 2*M+1):
        for sgn in ['+','-']:
            rep.close(hatZ_op(mu+M,M,sgn), hatZ_op(mu,M,sgn), f"M={M} mu={mu} sgn={sgn}: hatZ の M 周期性")
        rep.close(hatY_op(mu+M,M), hatY_op(mu,M), f"M={M} mu={mu}: hatY の M 周期性")
    # hatZ^{(+)} と hatZ^{(-)} の差は j=1 の項の符号だけ
    for mu in range(1, M+1):
        d = hatZ_op(mu,M,'-') - hatZ_op(mu,M,'+')
        rep.close(d, 2*Zop(1,M)*np.exp(-1j*2*np.pi*mu/M), f"M={M} mu={mu}: hatZ^(-) - hatZ^(+) = 2 Z_1 e^{{-i2pi mu/M}}")
rep.finish()

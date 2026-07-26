# <commutator_of_H_and_Z_Y> のうち、数値的に成り立つ 4 式
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("commutator_of_H_and_Z_Y: 成り立つ 4 式")
for M in [2,3,4,5]:
    for mu in list(range(-M,0)) + list(range(1,M+1)):
        e_m = np.exp(-1j*2*np.pi*mu/M); e_p = np.exp(+1j*2*np.pi*mu/M)
        for sgn in ['+','-']:
            H1 = H1_op(M, sgn)
            rep.close(comm(H1, hatZ_op(mu,M,sgn)), 2*e_m*hatY_op(mu,M),
                      f"M={M} sgn={sgn} mu={mu}: [H_1^(±), hatZ^(±)] = 2 e^-ith hatY")
            rep.close(comm(H1, hatY_op(mu,M)), -2*e_p*hatZ_op(mu,M,sgn),
                      f"M={M} sgn={sgn} mu={mu}: [H_1^(±), hatY] = -2 e^ith hatZ^(±)")
        H2 = H2_op(M)
        rep.close(comm(H2, hatZ_op(mu,M,'-')), -2*hatY_op(mu,M),
                  f"M={M} mu={mu}: [H_2, hatZ^(-)] = -2 hatY")
        rep.close(comm(H2, hatY_op(mu,M)), 2*hatZ_op(mu,M,'-'),
                  f"M={M} mu={mu}: [H_2, hatY] = 2 hatZ^(-)")
rep.finish()

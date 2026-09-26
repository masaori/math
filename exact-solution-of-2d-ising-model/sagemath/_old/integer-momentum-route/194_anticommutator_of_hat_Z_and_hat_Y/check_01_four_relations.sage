# <anticommutator_of_hat_Z_and_hat_Y>: hat の反交換関係 4 式
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("anticommutator_of_hat_Z_and_hat_Y")
for M in [2,3,4,5]:
    Id = eye_M(M)
    rng_mu = list(range(-M, 0)) + list(range(1, M+1))
    for mu in rng_mu:
        for nu in rng_mu:
            d = delta_M(mu+nu, 0, M)
            for sgn in ['+','-']:
                # (1) 同符号
                rep.close(acomm(hatZ_op(mu,M,sgn), hatZ_op(nu,M,sgn)), 2*M*d*Id,
                          f"M={M} ({sgn},{sgn}) mu={mu} nu={nu}: [hatZ,hatZ]+")
                # (2) 異符号（補正項つき）
                other = '-' if sgn=='+' else '+'
                corr = -2*np.exp(-1j*2*np.pi*(mu+nu)/M) * 2 * Id
                rep.close(acomm(hatZ_op(mu,M,sgn), hatZ_op(nu,M,other)), 2*M*d*Id + corr,
                          f"M={M} ({sgn},{other}) mu={mu} nu={nu}: [hatZ,hatZ]+ 補正項つき")
                # (3) hatZ と hatY
                rep.close(acomm(hatZ_op(mu,M,sgn), hatY_op(nu,M)), 0*Id,
                          f"M={M} sgn={sgn} mu={mu} nu={nu}: [hatZ,hatY]+ = 0")
            # (4) hatY どうし
            rep.close(acomm(hatY_op(mu,M), hatY_op(nu,M)), 2*M*d*Id,
                      f"M={M} mu={mu} nu={nu}: [hatY,hatY]+")
rep.finish()

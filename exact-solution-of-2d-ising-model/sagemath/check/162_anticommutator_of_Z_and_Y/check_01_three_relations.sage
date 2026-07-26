# <anticommutator_of_Z_and_Y>: [Z,Z]+, [Z,Y]+, [Y,Y]+ の 3 式
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("anticommutator_of_Z_and_Y: M=2..6 の全 (mu,nu)")
for M in [2,3,4,5,6]:
    Id = eye_M(M)
    Zs = [None] + [Zop(m,M) for m in range(1,M+1)]
    Ys = [None] + [Yop(m,M) for m in range(1,M+1)]
    for mu in range(1,M+1):
        for nu in range(1,M+1):
            d = delta_M(mu,nu,M)
            rep.close(acomm(Zs[mu],Zs[nu]), 2*d*Id, f"M={M} [Z_{mu},Z_{nu}]+")
            rep.close(acomm(Zs[mu],Ys[nu]), 0*Id,   f"M={M} [Z_{mu},Y_{nu}]+")
            rep.close(acomm(Ys[mu],Ys[nu]), 2*d*Id, f"M={M} [Y_{mu},Y_{nu}]+")
    # M 周期の添字（mu = M+1 は 1 と同じ）でも成り立つこと
    rep.close(Zop(M+1,M), Zop(1,M), f"M={M} Z_{{M+1}} = Z_1")
    rep.close(Yop(M+1,M), Yop(1,M), f"M={M} Y_{{M+1}} = Y_1")
rep.finish()

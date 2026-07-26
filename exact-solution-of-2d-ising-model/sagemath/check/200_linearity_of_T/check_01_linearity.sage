# <linearity_of_T>: T_g が C-線型
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(7))
rep = CheckReport("linearity_of_T")
for M in [2,3,4]:
    for p in OP_TEST_PARAMS[:3]:
        K1, K2 = p['K1'], p['K2']
        for g in [principal_sqrt_of_V1pm(K1,M,'-'), principal_sqrt_of_V1pm(K1,M,'+'), V2_op(K2,M)]:
            for _ in range(3):
                a = complex(rng.normal(), rng.normal()); b = complex(rng.normal(), rng.normal())
                n = 2**M
                Xr = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
                Yr = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
                rep.close(T_conj(g, a*Xr + b*Yr), a*T_conj(g,Xr) + b*T_conj(g,Yr), f"M={M}: T の線型性")
            # 乗法性・単位性・合成則（<conjugation_is_ring_homomorphism> の内容だが T の性質として）
            n = 2**M
            Xr = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
            Yr = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
            rep.close(T_conj(g, Xr @ Yr), T_conj(g,Xr) @ T_conj(g,Yr), f"M={M}: T の乗法性")
            rep.close(T_conj(g, eye_M(M)), eye_M(M), f"M={M}: T(I) = I")
rep.finish()

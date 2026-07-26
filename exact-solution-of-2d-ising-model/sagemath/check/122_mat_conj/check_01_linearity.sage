# <mat_conj>: T_B(A) := B A B^{-1} は線型写像
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(303))
rep = CheckReport("mat_conj")
for n in [1,2,3,5,8]:
    for _ in range(20):
        B = _expm(rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n)))
        rep.truth(abs(np.linalg.det(B)) > 1e-12, f"n={n}: B は正則")
        A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        C = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        la, lb = complex(rng.normal(),rng.normal()), complex(rng.normal(),rng.normal())
        rep.close(T_conj(B, la*A + lb*C), la*T_conj(B,A) + lb*T_conj(B,C), f"n={n}: 線型性")
        rep.close(T_conj(B, A + C), T_conj(B,A) + T_conj(B,C), f"n={n}: 加法性")
rep.finish()

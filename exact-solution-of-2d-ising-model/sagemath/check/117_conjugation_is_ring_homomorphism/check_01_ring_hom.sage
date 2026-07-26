# <conjugation_is_ring_homomorphism> と <mat_conj>: T_B(A) = B A B^{-1}
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(218))
rep = CheckReport("conjugation_is_ring_homomorphism / mat_conj")
for n in [1,2,3,5]:
    for _ in range(15):
        B = _expm(rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n)))
        A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        C = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        la, lb = complex(rng.normal(),rng.normal()), complex(rng.normal(),rng.normal())
        rep.close(T_conj(B, A@C), T_conj(B,A)@T_conj(B,C), f"n={n}: 乗法的")
        rep.close(T_conj(B, np.eye(n)), np.eye(n), f"n={n}: 単位的")
        rep.close(T_conj(B, la*A + lb*C), la*T_conj(B,A) + lb*T_conj(B,C), f"n={n}: 線型（<mat_conj>）")
        D = _expm(rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n)))
        rep.close(T_conj(B, T_conj(D, A)), T_conj(B@D, A), f"n={n}: 合成則 T_B o T_D = T_(BD)")
rep.finish()

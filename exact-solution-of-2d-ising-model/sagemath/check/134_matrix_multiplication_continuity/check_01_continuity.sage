# <matrix_multiplication_continuity>: ||A_N - A|| -> 0 ⟹ ||A_N B - A B|| -> 0
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(105))
rep = CheckReport("matrix_multiplication_continuity")
def nrm(A):
    return float(np.sqrt(np.sum(np.abs(A)**2)))
for n in [2,3,5]:
    A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
    B = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
    E = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
    E = E/nrm(E)
    prev = None
    for k in range(1, 16):
        eps = 2.0**(-k)
        AN = A + eps*E
        d_in, d_out = nrm(AN-A), nrm(AN@B - A@B)
        rep.truth(d_out <= d_in*nrm(B) + 1e-12, f"n={n} k={k}: ||A_N B - AB|| <= ||A_N-A|| ||B||")
        if prev is not None:
            rep.truth(d_out < prev, f"n={n} k={k}: 単調に 0 へ近づく")
        prev = d_out
    rep.truth(prev < 1e-4, f"n={n}: 最終的に十分小さい ({prev:.3e})")
rep.finish()

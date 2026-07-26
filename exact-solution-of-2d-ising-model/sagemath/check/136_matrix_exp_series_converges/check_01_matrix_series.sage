# <matrix_exp_series_converges>: S_N(A) の収束と ||S_N(A)|| <= ||I|| + E(||A||)
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(106))
rep = CheckReport("matrix_exp_series_converges")
def nrm(A):
    return float(np.sqrt(np.sum(np.abs(A)**2)))
for n in [2,3,5]:
    for scale in [0.2, 1.0, 3.0]:
        A = scale*(rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n)))
        bound = nrm(np.eye(n)) + math.exp(nrm(A))
        S = np.zeros((n,n), dtype=complex); P = np.eye(n, dtype=complex)
        for m in range(0, 90):
            S = S + P/math.factorial(m)
            P = P @ A
            rep.truth(nrm(S) <= bound + 1e-8, f"n={n} scale={scale} m={m}: ||S_N|| <= ||I|| + E(||A||)")
        rep.close(S, _expm(A), f"n={n} scale={scale}: 級数 = scipy の expm（独立2経路）")
        print(f"  n={n} scale={scale}: ||S|| = {nrm(S):.6e}, 上界 = {bound:.6e}, 比 = {nrm(S)/bound:.4f}")
rep.finish()

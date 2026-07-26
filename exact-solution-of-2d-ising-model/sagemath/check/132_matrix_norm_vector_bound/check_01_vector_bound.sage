# <matrix_norm_vector_bound>: ||Aw|| <= ||A|| ||w||
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(103))
rep = CheckReport("matrix_norm_vector_bound")
def nrm(A):
    return float(np.sqrt(np.sum(np.abs(A)**2)))
for n in [1,2,3,5,8]:
    for _ in range(30):
        A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        w = rng.normal(size=(n,)) + 1j*rng.normal(size=(n,))
        rep.truth(nrm(A@w) <= nrm(A)*nrm(w) + 1e-10, f"n={n}: ||Aw|| <= ||A|| ||w||")
    # 等号: A がランク1で w が A の行ベクトルに比例するとき
    v = rng.normal(size=(n,)) + 1j*rng.normal(size=(n,))
    u = rng.normal(size=(n,)) + 1j*rng.normal(size=(n,))
    A = np.outer(u, v.conj())
    w = v
    rep.close(nrm(A@w), nrm(A)*nrm(w), f"n={n}: ランク1で等号")
rep.finish()

# <end_is_algebra_isomorphism>: end が C-代数同型
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(11))
rep = CheckReport("end_is_algebra_isomorphism")

def rand2():
    return rng.normal(size=(2,2)) + 1j*rng.normal(size=(2,2))

for M in [1,2,3,4]:
    n = 2**M
    # (2) end(AB) = end(A) end(B): 行列表現では積がそのまま合成に対応する
    for _ in range(3):
        A = kron_list([rand2() for _ in range(M)])
        B = kron_list([rand2() for _ in range(M)])
        rep.close((A @ B), A @ B, f"M={M}: end(AB) = end(A)end(B)（行列表現では自明）")
    # (3) end(I) = id
    rep.close(eye_M(M), np.eye(n), f"M={M}: end(I) = id")
    # (1) 線型同型: 行列単位 E_{I,J} が 4^M 個の一次独立な元をなす
    units = []
    for I_ in range(n):
        for J_ in range(n):
            E = np.zeros((n,n), dtype=complex); E[I_,J_] = 1.0
            units.append(E.reshape(-1))
    rep.truth(np.linalg.matrix_rank(np.array(units), tol=1e-8) == n*n,
              f"M={M}: 行列単位が基底（次元 4^M = {n*n}）")
rep.finish()

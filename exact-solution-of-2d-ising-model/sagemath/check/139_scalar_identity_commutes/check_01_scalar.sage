# <scalar_identity_commutes>: [cI, A] = 0
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(108))
rep = CheckReport("scalar_identity_commutes")
for n in [1,2,3,5,8]:
    for _ in range(20):
        c = complex(rng.normal(), rng.normal())
        A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        rep.close(comm(c*np.eye(n), A), np.zeros((n,n)), f"n={n}: [cI, A] = 0")
    # 逆: スカラーでない行列は一般には可換でない
    if n >= 2:
        cnt = 0
        for _ in range(20):
            W = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
            A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
            if np.max(np.abs(comm(W,A))) > 1e-8:
                cnt += 1
        rep.truth(cnt > 0, f"n={n}: 一般の W では [W,A] != 0（主張が非自明）")
rep.finish()

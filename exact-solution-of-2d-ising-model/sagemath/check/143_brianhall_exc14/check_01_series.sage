# <brianhall_exc14>: e^{ad_X}(Y) の級数表示
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(112))
rep = CheckReport("brianhall_exc14")
NT = 60
for n in [2,3,4]:
    for trial in range(4):
        X = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        X = X/np.sqrt(np.sum(np.abs(X)**2))*1.0
        Y = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        L = np.kron(X, np.eye(n)) - np.kron(np.eye(n), X.T)
        lhs = (_expm(L) @ Y.reshape(-1)).reshape(n,n)
        rhs = np.zeros((n,n), dtype=complex); t = Y.copy()
        for m in range(NT+1):
            rhs = rhs + t/math.factorial(m); t = comm(X, t)
        rep.close(lhs, rhs, f"n={n} t={trial}: e^(ad_X)(Y) = sum (1/m!) ad_X^m(Y)")
        rep.close(lhs, _expm(X) @ Y @ _expm(-X), f"n={n} t={trial}: = exp(X) Y exp(-X)")
        # ad_X の行列表示が正しいこと
        rep.close((L @ Y.reshape(-1)).reshape(n,n), comm(X,Y), f"n={n} t={trial}: ad_X の行列表示")
rep.finish()

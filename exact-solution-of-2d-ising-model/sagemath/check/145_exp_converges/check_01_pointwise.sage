# <exp_converges>: 有限次元ノルム線型空間上の線型写像 X について
#   sum (1/n!) X^n が各点収束する
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(305))
rep = CheckReport("exp_converges")
def nrm(A):
    return float(np.sqrt(np.sum(np.abs(A)**2)))
for dim in [2,4,9,16]:
    for scale in [0.3, 1.0, 2.0]:
        X = scale*(rng.normal(size=(dim,dim)) + 1j*rng.normal(size=(dim,dim)))
        X = X/nrm(X)*scale*dim**0.5
        # 各点収束: 任意のベクトル v について sum (1/n!) X^n v が収束する
        for _ in range(3):
            v = rng.normal(size=(dim,)) + 1j*rng.normal(size=(dim,))
            s = np.zeros(dim, dtype=complex); w = v.copy()
            partials = []
            for n in range(0, 120):
                s = s + w/math.factorial(n); w = X @ w
                partials.append(s.copy())
            tail = max(nrm(partials[-1]-partials[k]) for k in range(90,119))
            rep.truth(tail < 1e-10*max(1.0,nrm(partials[-1])), f"dim={dim} scale={scale}: 部分和が Cauchy")
            rep.close(partials[-1], _expm(X) @ v, f"dim={dim} scale={scale}: 極限 = exp(X)v")
        # 極限写像が線型であること
        a, b = complex(0.4,-1.1), complex(-0.7,0.3)
        v1 = rng.normal(size=(dim,)) + 1j*rng.normal(size=(dim,))
        v2 = rng.normal(size=(dim,)) + 1j*rng.normal(size=(dim,))
        E = _expm(X)
        rep.close(E @ (a*v1 + b*v2), a*(E@v1) + b*(E@v2), f"dim={dim}: 極限は線型写像")
rep.finish()

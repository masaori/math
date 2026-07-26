# <def_kronecker>: 添字写像 nu(I) = 1 + sum (i_k - 1) 2^{M-k} が全単射で、
# クロネッカー積の成分の定義式が numpy の kron と一致すること
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
import itertools
rng = np.random.default_rng(int(308))
rep = CheckReport("def_kronecker")
for M in [1,2,3,4,5]:
    idxs = list(itertools.product([1,2], repeat=M))
    rep.truth(len(idxs) == 2**M, f"M={M}: #I_M = 2^M")
    nus = [1 + sum((I_[k]-1)*2**(M-1-k) for k in range(M)) for I_ in idxs]
    rep.truth(sorted(nus) == list(range(1, 2**M+1)), f"M={M}: nu は {{1,...,2^M}} への全単射")
    # ベクトルのクロネッカー積の成分
    vs = [rng.normal(size=(2,)) + 1j*rng.normal(size=(2,)) for _ in range(M)]
    kv = kron_list([v.reshape(2,1) for v in vs]).reshape(-1)
    for I_ in idxs:
        nu = 1 + sum((I_[k]-1)*2**(M-1-k) for k in range(M))
        prod = 1.0+0j
        for k in range(M):
            prod *= vs[k][I_[k]-1]
        rep.close(kv[nu-1], prod, f"M={M}: ベクトルの成分の定義式")
rep.finish()

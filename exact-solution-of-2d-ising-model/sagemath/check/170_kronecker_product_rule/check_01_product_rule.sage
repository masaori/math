# <kronecker_product_rule>: (1) 積の分解、(2) 単位行列、(3) ベクトルへの作用
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(306))
rep = CheckReport("kronecker_product_rule")
def r2(): return rng.normal(size=(2,2)) + 1j*rng.normal(size=(2,2))
def rv(): return rng.normal(size=(2,)) + 1j*rng.normal(size=(2,))
for M in [1,2,3,4,5]:
    for _ in range(5):
        As = [r2() for _ in range(M)]; Bs = [r2() for _ in range(M)]; vs = [rv() for _ in range(M)]
        rep.close(kron_list(As) @ kron_list(Bs), kron_list([As[k] @ Bs[k] for k in range(M)]),
                  f"M={M}: (1) 積の分解")
        rep.close(kron_list([I2]*M), np.eye(2**M), f"M={M}: (2) 単位行列")
        lv = kron_list([v.reshape(2,1) for v in vs]).reshape(-1)
        rv_ = kron_list([(As[k] @ vs[k]).reshape(2,1) for k in range(M)]).reshape(-1)
        rep.close(kron_list(As) @ lv, rv_, f"M={M}: (3) ベクトルへの作用")
    # 添字づけ nu(I) = 1 + sum (i_k-1) 2^{M-k} が numpy の kron と一致すること
    import itertools
    As = [r2() for _ in range(M)]
    K = kron_list(As)
    for I_ in itertools.product([1,2], repeat=M):
        for J_ in itertools.product([1,2], repeat=M):
            nu_i = sum((I_[k]-1)*2**(M-1-k) for k in range(M))
            nu_j = sum((J_[k]-1)*2**(M-1-k) for k in range(M))
            prod = 1.0+0j
            for k in range(M):
                prod *= As[k][I_[k]-1, J_[k]-1]
            rep.close(K[nu_i, nu_j], prod, f"M={M}: 成分の定義式（nu による添字づけ）")
rep.finish()

# <center_of_multiplicative_group_is_scalar>: Z(R^x) = {c I | c in C \ {0}}
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(309))
rep = CheckReport("center_of_multiplicative_group_is_scalar")
for M in [1,2,3]:
    n = 2**M
    gens = [Zop(m,M) for m in range(1,M+1)] + [Yop(m,M) for m in range(1,M+1)]
    blocks = [np.kron(g, np.eye(n)) - np.kron(np.eye(n), g.T) for g in gens]
    sv = np.linalg.svd(np.vstack(blocks), compute_uv=False)
    nullity = int(np.sum(sv < 1e-8)) + (n*n - len(sv))
    print(f"  M={M}: すべての生成元と可換な W の空間の次元 = {nullity}")
    rep.truth(nullity == 1, f"M={M}: 解空間はスカラーの 1 次元のみ")
    # スカラー行列は実際に中心に属する（正則性も込み）
    for _ in range(5):
        c = complex(rng.normal(), rng.normal())
        if abs(c) < 1e-6: continue
        W = c*np.eye(n)
        rep.truth(abs(np.linalg.det(W)) > 0, f"M={M}: cI は正則（R^x の元）")
        for g in gens:
            rep.close(W @ g, g @ W, f"M={M}: cI は生成元と可換")
    # 非スカラーは中心に属さない
    for _ in range(5):
        W = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        if np.max(np.abs(W - (np.trace(W)/n)*np.eye(n))) < 1e-6: continue
        if n == 1: continue
        rep.truth(any(np.max(np.abs(comm(W,g))) > 1e-9 for g in gens),
                  f"M={M}: 非スカラーの W は中心に属さない")
rep.finish()

# <centralizer_is_scalar>: すべての元と可換な W はスカラー行列
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("centralizer_is_scalar: 連立一次方程式 [W, g] = 0 の解空間")
for M in [1,2,3]:
    n = 2**M
    gens = [Zop(m,M) for m in range(1,M+1)] + [Yop(m,M) for m in range(1,M+1)]
    # W を n^2 次元ベクトルとみなし、W -> [W, g] を n^2 x n^2 行列で表す
    blocks = []
    for g in gens:
        # vec(gW - Wg) = (I ⊗ g - g^T ⊗ I) vec(W)   （行優先 vec の場合）
        L = np.kron(g, np.eye(n)) - np.kron(np.eye(n), g.T)
        blocks.append(L)
    Lall = np.vstack(blocks)
    sv = np.linalg.svd(Lall, compute_uv=False)
    nullity = int(np.sum(sv < 1e-8)) + (n*n - len(sv))
    print(f"  M={M}: 未知数={n*n}, 解空間の次元={nullity}")
    rep.truth(nullity == 1, f"M={M}: 中心化群の次元 = 1（スカラーのみ）")
    # 実際に単位行列が解であること
    for g in gens:
        rep.close(comm(eye_M(M), g), np.zeros((n,n)), f"M={M}: [I, g] = 0")
rep.finish()

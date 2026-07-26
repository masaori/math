# <injectivity_of_T_up_to_scalar>, <center_of_multiplicative_group_is_scalar>
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import itertools
rng = np.random.default_rng(int(3))
rep = CheckReport("injectivity_of_T_up_to_scalar")
for M in [1,2,3]:
    n = 2**M
    gens = [Zop(m,M) for m in range(1,M+1)] + [Yop(m,M) for m in range(1,M+1)]
    blocks = [np.kron(g, np.eye(n)) - np.kron(np.eye(n), g.T) for g in gens]
    sv = np.linalg.svd(np.vstack(blocks), compute_uv=False)
    nullity = int(np.sum(sv < 1e-8)) + (n*n - len(sv))
    print(f"  M={M}: [W,g]=0 の解空間の次元 = {nullity}")
    rep.truth(nullity == 1, f"M={M}: 乗法群の中心はスカラーのみ（次元 1）")
    for _ in range(3):
        g = _expm(rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n)))
        c = complex(rng.normal(), rng.normal())
        X = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        rep.close(T_conj(c*g, X), T_conj(g, X), f"M={M}: T_(cg) = T_g（⟸ 方向）")
        # ⟹ : T_g = T_{g'} ⟺ g^{-1}g' が中心 ⟺ スカラー。解空間が 1 次元であることが根拠。
        gp = c*g
        h = np.linalg.inv(g) @ gp
        rep.close(h, c*np.eye(n), f"M={M}: g^-1 g' はスカラー")
    # スカラーでない h では T が変わる
    for _ in range(3):
        g = _expm(rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n)))
        h = _expm(rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n)))
        if np.max(np.abs(h - (np.trace(h)/n)*np.eye(n))) < 1e-6:
            continue
        X = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        rep.truth(np.max(np.abs(T_conj(g@h, X) - T_conj(g, X))) > 1e-8,
                  f"M={M}: スカラーでない倍率では T が変わる")
rep.finish()

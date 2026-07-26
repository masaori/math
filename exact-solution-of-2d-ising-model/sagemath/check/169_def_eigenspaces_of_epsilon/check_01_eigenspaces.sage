# <def_eigenspaces_of_epsilon>: eps^2 = I、固有値 ±1、F^{(±)} は部分空間で次元 2^{M-1}
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("def_eigenspaces_of_epsilon")
for M in [1,2,3,4,5]:
    E = eps_op(M)
    rep.close(E @ E, eye_M(M), f"M={M}: eps^2 = I")
    w = np.linalg.eigvalsh(E)
    rep.truth(np.all(np.abs(np.abs(w) - 1) < 1e-10), f"M={M}: 固有値の絶対値が 1")
    rep.truth(np.all(np.isclose(np.abs(w - 1) * np.abs(w + 1), 0, atol=1e-10)),
              f"M={M}: 固有値は +1 か -1 のみ")
    npos = int(np.sum(w > 0)); nneg = int(np.sum(w < 0))
    print(f"  M={M}: dim F^(+)={npos}, dim F^(-)={nneg}, 2^(M-1)={2**(M-1)}")
    rep.truth(npos == 2**(M-1) and nneg == 2**(M-1), f"M={M}: 両固有空間の次元が 2^(M-1)")
    # eps = sigma^x_1 ... sigma^x_M
    prod = eye_M(M)
    for m in range(1,M+1):
        prod = prod @ sx(m,M)
    rep.close(E, prod, f"M={M}: eps = sigma^x_1 ... sigma^x_M")
rep.finish()

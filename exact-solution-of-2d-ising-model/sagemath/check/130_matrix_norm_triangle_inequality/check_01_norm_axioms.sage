# <def_matrix_norm> + <matrix_norm_triangle_inequality>: ノルムの公理
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(101))
rep = CheckReport("matrix_norm_triangle_inequality")
def nrm(A):
    return float(np.sqrt(np.sum(np.abs(A)**2)))
for n in [1,2,3,5,8]:
    for _ in range(20):
        A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        B = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        c = complex(rng.normal(), rng.normal())
        rep.truth(nrm(A) >= 0, f"n={n}: ノルムは非負")
        rep.close(nrm(c*A), abs(c)*nrm(A), f"n={n}: 斉次性")
        rep.truth(nrm(A+B) <= nrm(A)+nrm(B)+1e-12, f"n={n}: 三角不等式")
        # 定義（成分の平方和の平方根）どおりであること
        rep.close(nrm(A), np.sqrt(sum(abs(A[i,j])**2 for i in range(n) for j in range(n))), f"n={n}: 定義式")
    rep.truth(nrm(np.zeros((n,n))) == 0.0, f"n={n}: ||O|| = 0")
    A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
    rep.truth(nrm(A) > 0, f"n={n}: A != O なら ||A|| > 0")
    # 三角不等式の等号（B = tA, t>0）
    t = 2.5
    rep.close(nrm(A + t*A), nrm(A) + nrm(t*A), f"n={n}: B = tA で等号")
rep.finish()

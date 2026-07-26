# <matrix_norm_submultiplicativity>: ||AB|| <= ||A|| ||B||
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(102))
rep = CheckReport("matrix_norm_submultiplicativity")
def nrm(A):
    return float(np.sqrt(np.sum(np.abs(A)**2)))
tight = 0
for n in [1,2,3,5,8]:
    for _ in range(30):
        A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        B = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        rep.truth(nrm(A@B) <= nrm(A)*nrm(B) + 1e-10, f"n={n}: ||AB|| <= ||A|| ||B||")
    # ランク1どうしでは等号になる（評価が緩すぎないことの確認）
    for _ in range(10):
        u = rng.normal(size=(n,1)) + 1j*rng.normal(size=(n,1))
        v = rng.normal(size=(1,n)) + 1j*rng.normal(size=(1,n))
        w = rng.normal(size=(n,1)) + 1j*rng.normal(size=(1,n)).T
        A = u @ v
        B = (v.conj().T) @ (v.conj())          # 像と核が合うように
        r = nrm(A@B)/(nrm(A)*nrm(B))
        if r > 0.999:
            tight += 1
    # 逆向きの不等式は成り立たない
    A = np.zeros((n,n), dtype=complex); A[0,0] = 1.0
    B = np.zeros((n,n), dtype=complex); B[n-1,n-1] = 1.0
    rep.truth(nrm(A@B) < nrm(A)*nrm(B) - 1e-12 or n == 1,
              f"n={n}: 直交する像・核では真の不等号（||AB||=0 < 1）")
print(f"  等号に近い（比 > 0.999）事例: {tight} 件")
rep.finish()

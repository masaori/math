# <def_frobenius_inner_product> + <frobenius_inner_product_axioms>
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(109))
rep = CheckReport("frobenius_inner_product_axioms")
def ip(A,B):
    return np.trace(A.conj().T @ B)
for n in [1,2,3,5]:
    for _ in range(20):
        A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        B = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        C = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        lam = complex(rng.normal(), rng.normal())
        # (0) 成分表示
        rep.close(ip(A,B), sum(np.conj(A[i,j])*B[i,j] for i in range(n) for j in range(n)), f"n={n}: 成分表示")
        # (1) 共役対称性
        rep.close(ip(B,A), np.conj(ip(A,B)), f"n={n}: 共役対称性")
        # (2) 第2変数線型・第1変数共役線型
        rep.close(ip(A,B+C), ip(A,B)+ip(A,C), f"n={n}: 第2変数の加法性")
        rep.close(ip(A,lam*B), lam*ip(A,B), f"n={n}: 第2変数の斉次性")
        rep.close(ip(lam*A,B), np.conj(lam)*ip(A,B), f"n={n}: 第1変数の共役斉次性")
        # (3) 正定値性
        rep.truth(np.real(ip(A,A)) > 0 and abs(np.imag(ip(A,A))) < 1e-9, f"n={n}: <A,A> は正の実数")
        rep.close(np.real(ip(A,A)), float(np.sum(np.abs(A)**2)), f"n={n}: <A,A> = ノルムの2乗")
        # Cauchy-Schwarz
        rep.truth(abs(ip(A,B)) <= np.sqrt(np.real(ip(A,A))*np.real(ip(B,B))) + 1e-9, f"n={n}: Cauchy--Schwarz")
        # 三角不等式
        nA, nB, nAB = np.sqrt(np.real(ip(A,A))), np.sqrt(np.real(ip(B,B))), np.sqrt(np.real(ip(A+B,A+B)))
        rep.truth(nAB <= nA+nB+1e-9, f"n={n}: 三角不等式")
    rep.close(ip(np.zeros((n,n)), np.zeros((n,n))), 0.0, f"n={n}: <O,O> = 0")
    # Cauchy--Schwarz の等号（B = cA）
    A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
    c = complex(1.7, -0.4)
    rep.close(abs(ip(A,c*A)), np.sqrt(np.real(ip(A,A))*np.real(ip(c*A,c*A))), f"n={n}: B=cA で等号")
rep.finish()

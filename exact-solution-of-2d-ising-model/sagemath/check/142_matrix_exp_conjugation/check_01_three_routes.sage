# <matrix_exp_conjugation>: exp(X) Y exp(-X) = sum (1/m!) ad_X^m(Y) = exp(ad_X)(Y)
# 3 経路を独立に計算して突き合わせる。
#   経路A: 行列指数による共役 exp(X) Y exp(-X)
#   経路B: m 重交換子の級数
#   経路C: ad_X を n^2 x n^2 の線型写像として行列表示し、その指数を Y に作用
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(111))
rep = CheckReport("matrix_exp_conjugation: 3 経路の一致")
NT = 60
for n in [1,2,3,4]:
    for trial in range(4):
        X = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        X = X/np.sqrt(np.sum(np.abs(X)**2))*1.1
        Y = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        # A
        eX = _expm(X)
        A_ = eX @ Y @ _expm(-X)
        # B
        B_ = np.zeros((n,n), dtype=complex); t = Y.copy()
        for m in range(NT+1):
            B_ = B_ + t/math.factorial(m); t = comm(X, t)
        # C: vec(ad_X(Y)) = (X ⊗ I - I ⊗ X^T) vec(Y)（行優先 vec）
        L = np.kron(X, np.eye(n)) - np.kron(np.eye(n), X.T)
        C_ = (_expm(L) @ Y.reshape(-1)).reshape(n,n)
        rep.close(A_, B_, f"n={n} t={trial}: 共役 = 級数")
        rep.close(A_, C_, f"n={n} t={trial}: 共役 = exp(ad_X)(Y)")
        rep.close(B_, C_, f"n={n} t={trial}: 級数 = exp(ad_X)(Y)")
        # (3) exp(X)^{-1} = exp(-X)
        rep.close(np.linalg.inv(eX), _expm(-X), f"n={n} t={trial}: exp(X)^-1 = exp(-X)")
        rep.close(eX @ _expm(-X), np.eye(n), f"n={n} t={trial}: exp(X)exp(-X) = I")
rep.finish()

# <ad_binomial>: ad_X^m(Y) = sum_k C(m,k) X^k Y (-X)^{m-k}
# 左辺は再帰、右辺は二項和。完全に独立な 2 経路。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(110))
rep = CheckReport("ad_binomial")
for n in [1,2,3,4]:
    for trial in range(4):
        X = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        Y = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        X = X/np.sqrt(np.sum(np.abs(X)**2))*1.3     # 桁溢れを避けて正規化
        for m in range(0, 9):
            lhs = ad_pow(X, Y, m)
            rhs = np.zeros((n,n), dtype=complex)
            for k in range(0, m+1):
                rhs = rhs + math.comb(m,k) * np.linalg.matrix_power(X,k) @ Y @ np.linalg.matrix_power(-X, m-k)
            rep.close(lhs, rhs, f"n={n} t={trial} m={m}")
    # 実行列でも成り立つ（K = R の場合）
    for trial in range(2):
        X = rng.normal(size=(n,n)); Y = rng.normal(size=(n,n))
        for m in range(0, 6):
            rhs = sum(math.comb(m,k) * np.linalg.matrix_power(X,k) @ Y @ np.linalg.matrix_power(-X, m-k) for k in range(m+1))
            rep.close(ad_pow(X,Y,m), rhs, f"n={n} 実行列 m={m}")
rep.finish()

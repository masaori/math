# <exp_X_Y_exp_-X>: exp(X) Y exp(-X) = Ad_{exp X}(Y) = exp(ad_X)(Y) = sum (1/n!) [X,...[X,Y]...]
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(113))
rep = CheckReport("exp_X_Y_exp_-X")
NT = 60
for d in [1,2,3,4,8]:
    for trial in range(3):
        X = rng.normal(size=(d,d)) + 1j*rng.normal(size=(d,d))
        X = X/np.sqrt(np.sum(np.abs(X)**2))*0.9
        Y = rng.normal(size=(d,d)) + 1j*rng.normal(size=(d,d))
        eX = _expm(X)
        rep.truth(abs(np.linalg.det(eX)) > 1e-12, f"d={d} t={trial}: exp(X) は正則")
        lhs = eX @ Y @ np.linalg.inv(eX)
        rep.close(lhs, eX @ Y @ _expm(-X), f"d={d} t={trial}: Ad_(exp X)(Y) = exp(X)Y exp(-X)")
        s = np.zeros((d,d), dtype=complex); t = Y.copy()
        for m in range(NT+1):
            s = s + t/math.factorial(m); t = comm(X, t)
        rep.close(lhs, s, f"d={d} t={trial}: = sum (1/n!) [X,...[X,Y]...]")
# 実際に本文で使う場面（008 章）: X = i K_1 H_1^{(±)}/2 の共役
for M in [2,3]:
    for K1 in [0.4, 1.2]:
        X = 1j*(K1/2.0)*H1_op(M, '-')
        Y = hatZ_op(1, M, '-')
        s = np.zeros_like(Y); t = Y.copy()
        for m in range(NT+1):
            s = s + t/math.factorial(m); t = comm(X, t)
        rep.close(_expm(X) @ Y @ _expm(-X), s, f"M={M} K1={K1}: 本文の適用場面でも一致")
rep.finish()

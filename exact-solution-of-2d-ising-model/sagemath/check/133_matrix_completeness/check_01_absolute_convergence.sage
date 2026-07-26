# <matrix_completeness> (2): sum ||B_m|| が収束 ⟹ sum B_m が収束し ||sum B_m|| <= sum ||B_m||
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(104))
rep = CheckReport("matrix_completeness: 絶対収束判定")
def nrm(A):
    return float(np.sqrt(np.sum(np.abs(A)**2)))
for n in [2,3,5]:
    for trial in range(5):
        # ||B_m|| ~ r^m（r<1）となる列
        r = 0.3 + 0.5*rng.random()
        Bs = []
        for m in range(120):
            X = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
            X = X / nrm(X) * (r**m)
            Bs.append(X)
        norms = [nrm(B) for B in Bs]
        rep.truth(abs(sum(norms) - (1-r**120)/(1-r)) < 1e-8, f"n={n}: ノルムの和は等比和")
        # 部分和の Cauchy 性
        S = np.zeros((n,n), dtype=complex)
        partials = []
        for B in Bs:
            S = S + B
            partials.append(S.copy())
        tail = max(nrm(partials[-1]-partials[k]) for k in range(100,119))
        rep.truth(tail < 1e-10, f"n={n}: 部分和が Cauchy（末尾の振れ {tail:.3e}）")
        rep.truth(nrm(partials[-1]) <= sum(norms) + 1e-10, f"n={n}: ||sum B_m|| <= sum ||B_m||")
rep.finish()

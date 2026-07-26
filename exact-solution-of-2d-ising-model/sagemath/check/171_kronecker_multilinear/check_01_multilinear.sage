# <kronecker_multilinear>: 第 j 因子についての線型性
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(307))
rep = CheckReport("kronecker_multilinear")
def r2(): return rng.normal(size=(2,2)) + 1j*rng.normal(size=(2,2))
for M in [1,2,3,4]:
    for j in range(M):
        for r in [1,2,3]:
            As = [r2() for _ in range(M)]
            cs = [complex(rng.normal(), rng.normal()) for _ in range(r)]
            Bs = [r2() for _ in range(r)]
            As[j] = sum(cs[a]*Bs[a] for a in range(r))
            lhs = kron_list(As)
            rhs = np.zeros((2**M, 2**M), dtype=complex)
            for a in range(r):
                Cs = list(As); Cs[j] = Bs[a]
                rhs = rhs + cs[a]*kron_list(Cs)
            rep.close(lhs, rhs, f"M={M} j={j+1} r={r}: 第 j 因子についての線型性")
        # r=1 の特別な場合（スカラーが外へ出る）
        As = [r2() for _ in range(M)]
        c = complex(rng.normal(), rng.normal())
        Cs = list(As); Cs[j] = c*As[j]
        rep.close(kron_list(Cs), c*kron_list(As), f"M={M} j={j+1}: スカラーが外へ出る")
rep.finish()

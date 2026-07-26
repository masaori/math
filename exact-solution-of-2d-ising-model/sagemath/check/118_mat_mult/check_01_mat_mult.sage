# <mat_mult>: mat(Aa, Ab) = A mat(a,b)
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(219))
rep = CheckReport("mat_mult")
for n in [1,2,3,5,8]:
    for _ in range(25):
        A = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        a = rng.normal(size=(n,)) + 1j*rng.normal(size=(n,))
        b = rng.normal(size=(n,)) + 1j*rng.normal(size=(n,))
        lhs = np.column_stack([A@a, A@b])          # mat(Aa, Ab)
        rhs = A @ np.column_stack([a, b])          # A mat(a,b)
        rep.close(lhs, rhs, f"n={n}: mat(Aa,Ab) = A mat(a,b)")
rep.finish()

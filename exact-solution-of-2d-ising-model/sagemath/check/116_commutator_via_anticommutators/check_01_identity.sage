# <commutator_via_anticommutators>: [ab, c] = a[b,c]_+ - [a,c]_+ b
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(217))
rep = CheckReport("commutator_via_anticommutators")
for n in [1,2,3,4,8]:
    for _ in range(25):
        a = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        b = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        c = rng.normal(size=(n,n)) + 1j*rng.normal(size=(n,n))
        rep.close(comm(a@b, c), a@acomm(b,c) - acomm(a,c)@b, f"n={n}: [ab,c] = a[b,c]+ - [a,c]+ b")
    # 本文で実際に使う場面: Z, Y に適用
    if n in (2,4,8):
        M = int(round(math.log2(n)))
        for mu in range(1,M+1):
            for nu in range(1,M+1):
                A, B, C = Zop(mu,M), Yop(nu,M), Zop(nu,M)
                rep.close(comm(A@B, C), A@acomm(B,C) - acomm(A,C)@B, f"M={M} ({mu},{nu}): Z,Y への適用")
rep.finish()

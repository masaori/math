# <theorem_exp_zero>: exp(O) = I
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rep = CheckReport("theorem_exp_zero")
for n in [1,2,3,5,8,16]:
    O = np.zeros((n,n), dtype=complex)
    rep.close(_expm(O), np.eye(n), f"n={n}: expm(O) = I")
    # 級数を直接足しても I
    S = np.zeros((n,n), dtype=complex); P = np.eye(n, dtype=complex)
    for m in range(0, 20):
        S = S + P/math.factorial(m); P = P @ O
    rep.close(S, np.eye(n), f"n={n}: 級数（O^0 = I の規約）でも I")
rep.finish()

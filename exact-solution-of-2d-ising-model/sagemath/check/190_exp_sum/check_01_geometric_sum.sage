# <exp_sum>: sum_{j=1}^{M} exp(2 pi i j k / M) = M delta^M_{(k,0)}
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("exp_sum: 1 の M 乗根の和")
for M in range(1, 13):
    for k in range(-3*M, 3*M+1):
        lhs = sum(np.exp(2j*np.pi*j*k/M) for j in range(1, M+1))
        rhs = M * delta_M(k, 0, M)
        rep.close(lhs, rhs, f"M={M} k={k}")
    # 非自明性: k が M の倍数でないとき和は 0（M ではない）
    if M >= 2:
        s = sum(np.exp(2j*np.pi*j*1/M) for j in range(1, M+1))
        rep.truth(abs(s) < 1e-9 and abs(s - M) > 1.0, f"M={M}: k=1 で和は 0（M ではない）")
rep.finish()

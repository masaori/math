# <V1_in_Z_Y_epsilon>: 非境界項の Jordan--Wigner 恒等式
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))

rep = CheckReport("V1_in_Z_Y_epsilon: 非境界項の Jordan--Wigner 恒等式")
for M in [2, 3, 4, 5, 6]:
    for m in range(1, M):
        rep.close(
            sz(m, M) @ sz(m + 1, M),
            1j * (Yop(m, M) @ Zop(m + 1, M)),
            f"M={M} m={m}: sigma^z_m sigma^z_{{m+1}} = i Y_m Z_{{m+1}}",
        )
rep.finish()

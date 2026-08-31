# <V1_in_Z_Y_epsilon>: 周期境界項の Jordan--Wigner 恒等式
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))

rep = CheckReport("V1_in_Z_Y_epsilon: 周期境界項の Jordan--Wigner 恒等式")
for M in [2, 3, 4, 5, 6]:
    rep.close(
        sz(M, M) @ sz(1, M),
        -1j * (eps_op(M) @ Yop(M, M) @ Zop(1, M)),
        f"M={M}: sigma^z_M sigma^z_1 = -i eps Y_M Z_1",
    )
rep.finish()

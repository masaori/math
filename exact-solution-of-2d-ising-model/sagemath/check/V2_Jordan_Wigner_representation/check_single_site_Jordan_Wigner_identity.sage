# <V2_in_Z_Y>: 各サイトの Jordan--Wigner 恒等式
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))

rep = CheckReport("V2_in_Z_Y: 各サイトの Jordan--Wigner 恒等式")
for M in [2, 3, 4, 5, 6]:
    for m in range(1, M + 1):
        rep.close(
            Zop(m, M) @ Yop(m, M),
            -1j * sx(m, M),
            f"M={M} m={m}: Z_m Y_m = -i sigma^x_m",
        )
rep.finish()

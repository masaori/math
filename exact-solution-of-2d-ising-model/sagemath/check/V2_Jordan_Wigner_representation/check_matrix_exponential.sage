# <V2_in_Z_Y>: V_2 の行列指数表示
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))

import numpy as np

rep = CheckReport("V2_in_Z_Y: V_2 の行列指数表示")
for M in [2, 3, 4, 5]:
    for p in OP_TEST_PARAMS:
        K2 = p["K2"]
        K2s = K_star(K2)
        s2 = np.sinh(2 * K2)
        H2x = sum(Zop(m, M) @ Yop(m, M) for m in range(1, M + 1))
        rep.close(
            V2_op(K2, M),
            (2 * s2) ** (M / 2) * _expm(1j * K2s * H2x),
            f"M={M} K2={K2}: V_2",
        )
rep.finish()

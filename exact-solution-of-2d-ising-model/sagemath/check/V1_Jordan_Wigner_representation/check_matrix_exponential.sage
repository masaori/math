# <V1_in_Z_Y_epsilon>: V_1 の行列指数表示
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))

rep = CheckReport("V1_in_Z_Y_epsilon: V_1 の行列指数表示")
for M in [2, 3, 4, 5]:
    for p in OP_TEST_PARAMS:
        K1 = p["K1"]
        H1x = (
            sum(Yop(m, M) @ Zop(m + 1, M) for m in range(1, M))
            - eps_op(M) @ Yop(M, M) @ Zop(1, M)
        )
        rep.close(V1_op(K1, M), _expm(1j * K1 * H1x), f"M={M} K1={K1}: V_1")
rep.finish()

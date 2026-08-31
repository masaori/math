# <V1_in_Z_Y_epsilon>: V_1 の指数の肩の一致
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))

rep = CheckReport("V1_in_Z_Y_epsilon: V_1 の指数の肩の一致")
for M in [2, 3, 4, 5, 6]:
    lhs = sum(sz(m, M) @ sz(_wrap(m + 1, M), M) for m in range(1, M + 1))
    rhs = 1j * (
        sum(Yop(m, M) @ Zop(m + 1, M) for m in range(1, M))
        - eps_op(M) @ Yop(M, M) @ Zop(1, M)
    )
    rep.close(lhs, rhs, f"M={M}: V_1 の指数の肩")
rep.finish()

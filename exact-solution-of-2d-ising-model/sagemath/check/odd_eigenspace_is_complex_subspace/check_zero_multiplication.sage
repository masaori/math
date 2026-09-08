# 対象ラベル: odd_eigenspace_is_complex_subspace
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
for r in rows:
    pass_equal(sum((E[r, s] * zero[s] for s in range(E.ncols())), K(0)),
               sum((K(0) for _s in range(E.ncols())), K(0)),
               f"sum_s epsilon_rs 0 = sum_s 0, r={r}")

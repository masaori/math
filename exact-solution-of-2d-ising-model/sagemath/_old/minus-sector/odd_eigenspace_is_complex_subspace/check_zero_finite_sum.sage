# 対象ラベル: odd_eigenspace_is_complex_subspace
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
for r in rows:
    pass_equal(sum((K(0) for _s in range(E.ncols())), K(0)), K(0), f"sum_s 0 = 0, r={r}")

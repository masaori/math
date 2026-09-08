# 対象ラベル: odd_eigenspace_is_complex_subspace
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
for r in rows:
    pass_equal(a * sum((E[r, s] * f[s] for s in range(E.ncols())), K(0)),
               a * (E * f)[r], f"reassemble the matrix-vector product, r={r}")

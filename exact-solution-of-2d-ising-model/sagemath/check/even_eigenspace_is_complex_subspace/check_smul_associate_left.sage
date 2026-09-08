# 対象ラベル: even_eigenspace_is_complex_subspace
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
for r in rows:
    pass_equal(sum((E[r, s] * (a * f[s]) for s in range(E.ncols())), K(0)),
               sum(((E[r, s] * a) * f[s] for s in range(E.ncols())), K(0)),
               f"associate epsilon_rs(af_s), r={r}")

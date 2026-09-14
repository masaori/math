# 対象ラベル: odd_eigenspace_is_complex_subspace
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
for r in rows:
    pass_equal(sum((E[r, s] * (f[s] + g[s]) for s in range(E.ncols())), K(0)),
               sum((E[r, s] * f[s] + E[r, s] * g[s] for s in range(E.ncols())), K(0)),
               f"distribute epsilon_rs over f_s+g_s, r={r}")

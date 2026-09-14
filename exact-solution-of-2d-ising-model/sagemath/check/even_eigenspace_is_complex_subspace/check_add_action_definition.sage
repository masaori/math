# 対象ラベル: even_eigenspace_is_complex_subspace
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
for r in rows:
    pass_equal((E * (f + g))[r], sum((E[r, s] * (f[s] + g[s]) for s in range(E.ncols())), K(0)),
               f"[epsilon(f+g)]_r = sum_s epsilon_rs(f_s+g_s), r={r}")

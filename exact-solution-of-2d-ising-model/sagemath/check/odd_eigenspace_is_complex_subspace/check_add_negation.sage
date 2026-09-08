# 対象ラベル: odd_eigenspace_is_complex_subspace
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
for r in rows:
    pass_equal(-f[r] + (-g[r]), -(f[r] + g[r]), f"-f_r + (-g_r) = -(f_r+g_r), r={r}")

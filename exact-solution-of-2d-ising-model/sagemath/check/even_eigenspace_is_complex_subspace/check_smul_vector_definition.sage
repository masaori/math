# 対象ラベル: even_eigenspace_is_complex_subspace
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
for r in rows:
    pass_equal(a * f[r], (a * f)[r], f"componentwise complex scalar multiplication, r={r}")

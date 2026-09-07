# <def_even_eigenvectors_of_epsilon>: F^(+) = {f in C^(2^M) | epsilon f = f}
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

rep = CheckReport("def_even_eigenvectors_of_epsilon")
for M in [1, 2, 3, 4, 5]:
    E = eps_op(M)
    fixed_vector = np.ones(2**M, dtype=complex)
    rep.close(E @ fixed_vector, fixed_vector, f"M={M}: epsilon f = f")
rep.finish()

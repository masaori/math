# <def_odd_eigenvectors_of_epsilon>: F^(-) = {f in C^(2^M) | epsilon f = -f}
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

rep = CheckReport("def_odd_eigenvectors_of_epsilon")
for M in [1, 2, 3, 4, 5]:
    E = eps_op(M)
    sign_flipping_vector = np.zeros(2**M, dtype=complex)
    sign_flipping_vector[0] = 1
    sign_flipping_vector[-1] = -1
    rep.close(E @ sign_flipping_vector, -sign_flipping_vector, f"M={M}: epsilon f = -f")
rep.finish()

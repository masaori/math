import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in globals() else "."
load(os.path.join(_dir, "_prelude.sage"))

assert GF(2).one() + GF(2).one() == GF(2).zero()
check_pair(twice_initial_sum, zero_entry)
print("RESULT: PASS — two identical finite sums cancel in characteristic two")

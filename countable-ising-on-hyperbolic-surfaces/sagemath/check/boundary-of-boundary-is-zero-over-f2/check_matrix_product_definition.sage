import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in globals() else "."
load(os.path.join(_dir, "_prelude.sage"))

check_pair(matrix_product_entry, expanded_boundary_product)
print("RESULT: PASS — matrix multiplication equals the expanded product from the two boundary definitions")

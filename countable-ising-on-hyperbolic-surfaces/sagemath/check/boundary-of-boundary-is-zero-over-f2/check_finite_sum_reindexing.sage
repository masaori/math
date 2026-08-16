import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in globals() else "."
load(os.path.join(_dir, "_prelude.sage"))

check_pair(expanded_boundary_product, reindexed_endpoint_sum)
print("RESULT: PASS — finite distributivity and reindexing turn the edge sum into a position-and-end sum")

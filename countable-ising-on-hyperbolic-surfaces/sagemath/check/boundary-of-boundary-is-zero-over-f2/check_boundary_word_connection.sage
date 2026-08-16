import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in globals() else "."
load(os.path.join(_dir, "_prelude.sage"))

check_pair(selected_endpoint_sum, successor_initial_plus_initial)
print("RESULT: PASS — every terminal endpoint equals the successor position's initial endpoint")

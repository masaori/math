import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in globals() else "."
load(os.path.join(_dir, "_prelude.sage"))

for data in EXAMPLES:
    for face in data["faces"]:
        word = data["words"][face]
        assert set(word["successor"].values()) == set(word["positions"])
check_pair(successor_initial_plus_initial, twice_initial_sum)
print("RESULT: PASS — bijective successors preserve the finite initial-endpoint sum")

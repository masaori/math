import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in globals() else "."
load(os.path.join(_dir, "_prelude.sage"))

for orientation in (FORWARD, REVERSE):
    assert {INITIAL_END[orientation], TERMINAL_END[orientation]} == set(END_LABELS)
check_pair(reindexed_endpoint_sum, selected_endpoint_sum)
print("RESULT: PASS — each orientation selects every formal edge end exactly once")
